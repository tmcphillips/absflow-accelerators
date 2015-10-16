#pragma once

#include "windows.h"
#include "windowsx.h"

class Window
{
public:
	Window(HWND hParent, HINSTANCE hAppInstance) : hwndParent(hParent), hInst(hAppInstance) {}
	virtual BOOL handleParentResize(LPRECT lpParentClientRect) { 
		return true; 
	}
	HWND handle() const { return hWnd; }
	HINSTANCE instance() const { return hInst;  }
	int height() const { return windowHeight; }
	void show(int nCmdShow);

protected:
	HWND hWnd;
	int windowHeight;

private:
	HWND hwndParent;
	HINSTANCE hInst;
};
