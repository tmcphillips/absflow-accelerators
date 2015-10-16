#include "Application.h"
#include "MandelbrotDisplay.h"
#include "Utilities.h"
#include <ppl.h>
#include <concrtrm.h>

MandelbrotDisplay::MandelbrotDisplay(Window parent,
		int marginLeft, int marginTop, int marginRight, int marginBottom)
		:	Window{ parent.handle(), parent.instance() }, 
		maxIterations(10000), zoom(1.0), center_x(0.0), center_y(0.0), mode(0), invalid(true), pKernel{nullptr}
{

	// create the graphics window pane
	hWnd = CreateWindow( "static", "", WS_CHILD | BS_OWNERDRAW,
							0, 0, 0, 0, parent.handle(), 0, parent.instance(), 0);

	margLeft = marginLeft;
	margTop = marginTop;
	margRight = marginRight;
	margBottom = marginBottom;

	setZoom(1.0);
}

BOOL MandelbrotDisplay::handleParentResize(LPRECT lpParentClientRect)
{
	width = lpParentClientRect->right - margLeft - margRight;
	height = lpParentClientRect->bottom - margTop - margBottom;
	center_col = width / 2;
	center_row = height / 2;

	invalid = true;
	
	bitmap.resize(width, height);

	MoveWindow(
		hWnd, 
		margLeft, 
		margTop,
		width, 
		height, 
		TRUE
	);

	ShowWindow(hWnd, SW_SHOW); 

	return TRUE;
}

template<typename T>
void MandelbrotDisplay::drawWithPrecision() {
	switch (mode) {
	case 0:
		draw_OpenCL();
		break;
	case 1:
		draw_SingleThreaded<T>();
		break;
	case 2:
		draw_ParallelFor<T>();
		break;
	case 3:
		draw_ParallelFor_Partitioned<T>();
		break;
	}
}

void MandelbrotDisplay::compute() {
	if (invalid) {
		if (double_precision) {
			drawWithPrecision<double>();
		}
		else {
			drawWithPrecision<float>();
		}
	}
}


void MandelbrotDisplay::draw()
{
	HDC hdc(GetDC(hWnd));
	HDC memDC = CreateCompatibleDC(hdc);
	HGDIOBJ oldBmp = SelectObject(memDC, bitmap.hbmp());
	BitBlt(hdc, 0, 0, width, height, memDC, 0, 0, SRCCOPY);
	SelectObject(memDC, oldBmp);
	DeleteDC(memDC);
	ReleaseDC(hWnd, hdc);

	invalid = false;
}



template<typename T>
size_t MandelbrotDisplay::IteratePoint(T cReal, T cImaginary)
{
	T zReal(cReal);
	T zImaginary(cImaginary);
	T zReal2(0.0), zImaginary2(0.0);
	unsigned int n = 0;
	for( ; n < maxIterations; ++n) 
	{
		zReal2 = zReal * zReal;
		zImaginary2 = zImaginary * zImaginary;

		if (zReal2 + zImaginary2 > 4) break;

		zImaginary = 2 * zReal * zImaginary + cImaginary;
		zReal = zReal2 - zImaginary2 + cReal;
	}

	return n;
}

cl_uchar3 colors[16] = {
	{ 100, 100, 100 },
	{ 100, 0, 0 },
	{ 200, 0, 0 },
	{ 100, 100, 0 },
	{ 200, 100, 0 },
	{ 200, 200, 0 },
	{ 0, 200, 0 },
	{ 0, 100, 100 },
	{ 0, 200, 100 },
	{ 0, 100, 200 },
	{ 0, 200, 200 },
	{ 0, 0, 200 },
	{ 100, 0, 100 },
	{ 200, 0, 100 },
	{ 100, 0, 200 },
	{ 200, 0, 200 },
};

bgr MandelbrotDisplay::getColor(size_t n)
{
	if ( n == maxIterations) return bgr(0,0,0);

	const size_t nColors = 16;
	switch(n % nColors)
	{
	case 0: return bgr(100,100,100);	case 1: return bgr(100,0,0);
	case 2: return bgr(200,0,0);		case 3: return bgr(100,100,0);
	case 4: return bgr(200,100,0);		case 5: return bgr(200,200,0);
	case 6: return bgr(0,200,0);		case 7: return bgr(0,100,100);
	case 8: return bgr(0,200,100);		case 9: return bgr(0,100,200);
	case 10: return bgr(0,200,200);		case 11: return bgr(0,0,200);
	case 12: return bgr(100,0,100);		case 13: return bgr(200,0,100);
	case 14: return bgr(100,0,200);		case 15: return bgr(200,0,200);
	default: return bgr(200,200,200);
	}
}

template<typename T>
void MandelbrotDisplay::draw_SingleThreaded()
{
	T zReal, zImaginary, cReal, cImaginary;
	for (int row = 0; row < height; ++row) 
	{
		zImaginary = cImaginary = rowToY<T>(row);
		for (int col = 0; col < width; ++col)
		{
			zReal = cReal = colToX<T>(col);
			bgr color = getColor(IteratePoint(cReal, cImaginary));
			bitmap.setPixel(col, row, color);
		}
	}
}

template<typename T>
void MandelbrotDisplay::draw_ParallelFor()
{
	Concurrency::parallel_for(0, height - 1, [&] (int row)
	{
		T cReal, cImaginary;
		T zReal, zImaginary;
		zImaginary = cImaginary = rowToY<T>(row);
		for (int col = 0; col < width; ++col)
		{
			zReal = cReal = colToX<T>(col);
			bgr color = getColor(IteratePoint(cReal, cImaginary));
			bitmap.setPixel(col, row, color);
		}		
	}); 
}

template<typename T>
void MandelbrotDisplay::draw_ParallelFor_Partitioned()
{
	int row_count = height;
	int cores = concurrency::GetProcessorCount();
	int partitionSize = row_count / (cores * 10);

	Concurrency::parallel_for(0, height - 1, partitionSize, [&] (int rowStart)
	{
		int blockMax = (partitionSize + rowStart > height - 1) ? height - 1 - rowStart : partitionSize;

		T cReal, cImaginary;
		T zReal, zImaginary;

		for (int i = 0; i < blockMax; i++) {
			int row = rowStart + i;
			zImaginary = cImaginary = rowToY<T>(row);
			for (int col = 0; col < width - 1; ++col)
			{
				zReal = cReal = colToX<T>(col);
				bgr color = getColor(IteratePoint(cReal, cImaginary));
				bitmap.setPixel(col, row, color);
			}
		}
	});
}

void MandelbrotDisplay::initialize_OpenCL() {

	if (pKernel != nullptr) delete pKernel;

	try {
		pKernel = new MandelbrotKernel(ocl::DeviceTraits<ProjectDevice>::PlatformName.c_str(), ocl::DeviceTraits<ProjectDevice>::DeviceType, double_precision);
		std::stringstream label{};
		label << pKernel->platformName() << " | " << pKernel->deviceName();
		updateStatus(label.str());
		accelerator_valid = true;
	}
	catch (std::exception e) {
		updateStatus("OpenCL error initializing device:  " + std::string(e.what()));
	}
}

void MandelbrotDisplay::draw_OpenCL()
{
	if (!accelerator_valid) initialize_OpenCL();
	
	try {
		pKernel->compute(width, height, center_col, center_row, center_x, center_y, scale,
			bitmap.getRowByteCount(), maxIterations, bitmap.pixelData());
	}
	catch (std::exception e) {
		updateStatus("OpenCL error invoking kernel:  " + std::string(e.what()));
	}
}


