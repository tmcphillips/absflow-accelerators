#include "BitmapSection.h"

BitmapSection::BitmapSection() : hBitmap(0) {

	// fill in constant fields in bitmapinfo
	bitmapinfo.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
	bitmapinfo.bmiHeader.biPlanes = 1;
	bitmapinfo.bmiHeader.biBitCount = 24;
	bitmapinfo.bmiHeader.biCompression = BI_RGB;
	bitmapinfo.bmiHeader.biSizeImage = 0;
	bitmapinfo.bmiHeader.biXPelsPerMeter = 0;
	bitmapinfo.bmiHeader.biYPelsPerMeter = 0;
	bitmapinfo.bmiHeader.biClrUsed = 0;
	bitmapinfo.bmiHeader.biClrImportant = 0;
}

BitmapSection::~BitmapSection() 
{ 
	if (hBitmap != 0) DeleteObject(hBitmap); 
}

void BitmapSection::resize(int width, int height) 
{
	bitmapinfo.bmiHeader.biWidth = width;
	bitmapinfo.bmiHeader.biHeight = height;

	int rowPixelBytes = 3 * width;
	rowByteCount = 4 * ((rowPixelBytes/4) + (rowPixelBytes % 4 != 0));

	if (hBitmap != 0) DeleteObject(hBitmap);

	hBitmap = CreateDIBSection(0, &bitmapinfo, DIB_RGB_COLORS, (void**)&data, NULL, 0);
}

void BitmapSection::setPixel(int col, int row, bgr color) {
	int offset = row * rowByteCount + col * 3;
	*((bgr*)(data + offset)) = color;
}