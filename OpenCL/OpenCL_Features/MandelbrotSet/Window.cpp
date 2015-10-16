#include "Window.h"

void Window::show(int nCmdShow)
{
	ShowWindow(hWnd, nCmdShow);
	UpdateWindow(hWnd);
}


