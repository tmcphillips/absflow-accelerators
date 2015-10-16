#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include "opencl_utilities.h"
#include "CL/opencl.h"
#include "BitmapSection.h"
#include "StatusBar.h"
#include "MandelbrotKernel.h"

const double PIXEL_SIZE = 0.01f;

class MandelbrotDisplay : public Window
{
public:

	// constructor
	MandelbrotDisplay(Window parent, int marginLeft, int marginTop, int marginRight, int marginBottom);
	int margLeft, margTop, margRight, margBottom;
	void setZoom(double z) { zoom = z; scale = PIXEL_SIZE / zoom; invalid = true;}
	void zoomIn(double factor) { setZoom(zoom * factor);  invalid = true;}
	void setCenter(double x, double y) { center_x = x; center_y = y;  invalid = true;}
	void setMode(int m) { mode = m;  invalid = true; }
	void setPrecision(int p) {
		double_precision = p ? true : false;  
		invalid = true; 
		accelerator_valid = false; 
	}
	void compute();
	void draw();
	BOOL handleParentResize(LPRECT lpParentClientRect);
	HWND handle() { return hWnd; }
	double parentColToX(int col) { return colToX<double>(col); }
	double parentRowToY(int row) { return scale * (center_row - (row - margTop)) + center_y; };
	void invalidate() { invalid = true; }

private:

	// private methods
	template<typename T> size_t IteratePoint(T cReal, T cImaginary);
	COLORREF Color(int n);
	bgr getColor(size_t n);
	template<typename T> T colToX(int col) { return static_cast<T>(scale * (col - center_col) + center_x); }
	template<typename T> T rowToY(int row) { return static_cast<T>(scale * (row - center_row) + center_y); }
	template<typename T> void drawWithPrecision();
	template<typename T> void draw_SingleThreaded();
	template<typename T> void draw_ParallelFor();
	template<typename T> void draw_ParallelFor_Partitioned();
	void draw_OpenCL();
	void MandelbrotDisplay::initialize_OpenCL();
	void runOpenCLKernel(
		int columns,
		int rows,
		int center_col,
		int center_row,
		double center_x,
		double center_y,
		double scale,
		int rowByteCount,
		int maxIterations,
		void * h_bitmap
		);

	// private data
	HWND hWnd;
	HWND hParentWnd;
	BitmapSection bitmap;
	unsigned int maxIterations;
	bool invalid;
	double zoom;
	double scale;
	double center_x;
	double center_y;
	int width;
	int height;
	int center_col;
	int center_row;
	int mode;
	bool double_precision{ false };
	bool accelerator_valid{ false };
	MandelbrotKernel * pKernel{ nullptr };
};