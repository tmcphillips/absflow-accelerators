#pragma once
#include <Windows.h>

struct bgr { 
	unsigned char b, g, r; 
	bgr(unsigned char rr, unsigned char gg, unsigned char bb) : b(bb), g(gg), r(rr) {}
};


class BitmapSection {

public:

	BitmapSection();
	~BitmapSection();
	void setPixel(int col, int row, bgr color);
	void resize(int cols, int rows);
	HBITMAP& hbmp() { return hBitmap; }
	void * pixelData() { return data; }
	int getRowByteCount() { return rowByteCount; }

private:

	BITMAPINFO bitmapinfo;
	HBITMAP hBitmap;
	unsigned char * data;
	int rowByteCount;
};