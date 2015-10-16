
#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <sstream>

#include "MainWindow.h"
#include "Application.h"

MainWindow::MainWindow(HINSTANCE hInstance, std::string windowClassName, std::string windowTitle) : Window{ nullptr, hInstance } {

	// create, fill out, and register the window class for the main window
	WNDCLASSEX WindowClass;
	WindowClass.cbSize = sizeof(WNDCLASSEX);
	WindowClass.style = CS_HREDRAW | CS_VREDRAW;
	WindowClass.lpfnWndProc = ::WindowProc;
	WindowClass.cbClsExtra = 0;
	WindowClass.cbWndExtra = 0;
	WindowClass.hInstance = hInstance;
	WindowClass.hIcon = LoadIcon(0, IDI_APPLICATION);
	WindowClass.hCursor = LoadCursor(0, IDC_ARROW);
	WindowClass.hbrBackground = nullptr;				// Null background brush to reduce flicker
	WindowClass.lpszMenuName = 0;
	WindowClass.lpszClassName = windowClassName.c_str();
	WindowClass.hIconSm = 0;
	RegisterClassEx(&WindowClass);
	
	// create the main window instance
	hWnd = CreateWindow(
		windowClassName.c_str(),
		windowTitle.c_str(),
		WS_OVERLAPPEDWINDOW,
		CW_USEDEFAULT,
		CW_USEDEFAULT,
		800,
		600,
		0,
		0,
		hInstance,
		0
	);
}


