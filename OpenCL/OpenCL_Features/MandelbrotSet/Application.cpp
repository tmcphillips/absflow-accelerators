#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <sstream>
#include <iomanip>

#include "StatusBar.h"
#include "ToolBar.h"
#include "MainWindow.h"
#include "MandelbrotDisplay.h"
#include "HRTimer.h"
#include "ComboBox.h"
#include "Button.h"
#include <map>
#include <vector>

ToolBar* pToolBar;
StatusBar* pStatusBar;
MandelbrotDisplay* pMandelbrotDisplay;
Button* pZoomInButton;
Button* pZoomOutButton;
Button* pRefreshButton;
ComboBox* pDeviceComboBox;
ComboBox* pPrecisionComboBox;
ComboBox* pOpenCLPlatformComboBox;
ComboBox* pOpenCLDeviceComboBox;
HRTimer timer;
std::map<HWND, Window*> windows;

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)
{
	MainWindow mainWindow{ hInstance, "MandelBrotMainWindow", "Mandelbrot Set" };
	pToolBar = new ToolBar{ mainWindow };
	pStatusBar = new StatusBar{ mainWindow, std::vector<int> { 100, 400, -1 } };
	pMandelbrotDisplay = new MandelbrotDisplay{ mainWindow, 0, pToolBar->height(), 0, pStatusBar->height() };

	pZoomInButton = new Button{ *pToolBar, 4, 4, 20, 20, "+" };
	pZoomOutButton = new Button{ *pToolBar, 24, 4, 20, 20, "-" };
	pRefreshButton = new Button{ *pToolBar, 44, 4, 20, 20, "R" };

	pDeviceComboBox = new ComboBox(*pToolBar, 64, 4, 220, 100,
		{ "OpenCL", "CPU - Sequential", "CPU - Parallel-For", "CPU - Parallel-For Partitioned" }
	);

	pOpenCLPlatformComboBox = new ComboBox(*pToolBar, 304, 4, 180, 100, ocl::get_platform_names());
	pOpenCLDeviceComboBox = new ComboBox(*pToolBar, 504, 4, 180, 100, ocl::get_platform_names());
	pPrecisionComboBox = new ComboBox(*pToolBar, 704, 4, 80, 100, { "Single", "Double" });

	windows[mainWindow.handle()] = &mainWindow;
	windows[pMandelbrotDisplay->handle()] = pMandelbrotDisplay;
	windows[pToolBar->handle()] = pToolBar;
	windows[pStatusBar->handle()] = pStatusBar;

	// show the application on screen
	mainWindow.show(nCmdShow);

	// Handle queued messages for application
	MSG msg;
	while(GetMessage(&msg, 0, 0, 0) == TRUE)
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	// return to operating system
	return static_cast<int>(msg.wParam);
}

BOOL CALLBACK handleParentResize(HWND hChild, LPARAM lParam) {
	LPRECT lpParentClientRect = (LPRECT)lParam;
	Window* pWindow = windows[hChild];
	if (pWindow != nullptr) pWindow->handleParentResize(lpParentClientRect);
	return TRUE;
}

void updateTime(double time) {
	std::basic_stringstream<char> ss;
	ss << time * 1000 << " ms";
	pStatusBar->setPanelText(0, ss.str());
}

void updateCoordinates(double x, double y) {
	std::basic_stringstream<char> ss;
	ss << std::fixed << std::setprecision(17) << x << ", " << y;
	pStatusBar->setPanelText(1, ss.str());
}

void updateStatus(std::string text) {
	pStatusBar->setPanelText(2, text);
}


LRESULT CALLBACK WindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam) 
{
	switch(message) 
	{
	case WM_PAINT: {
			pStatusBar->setPanelText(0, "Calculating...");
			timer.start();
			pMandelbrotDisplay->compute();
			PAINTSTRUCT ps;
			HDC hDC = BeginPaint(hWnd, &ps);
			pMandelbrotDisplay->draw();
			EndPaint(hWnd, &ps);
			double time = timer.stop();
			updateTime(time);
 			return 0;
		}

	case WM_COMMAND: {
			HWND control = (HWND)lParam;
			if (control == pZoomInButton->hwnd()) {
				pMandelbrotDisplay->zoomIn(1.5);
			} 
			else if (control == pZoomOutButton->hwnd()) {
				pMandelbrotDisplay->zoomIn(2.0 / 3.0);
			} 
			else if (control == pRefreshButton->hwnd()) {
				pMandelbrotDisplay->invalidate();
			} 
			else if (control == pDeviceComboBox->hwnd()) {
				DWORD code = HIWORD(wParam);
				if (code != CBN_CLOSEUP) return 0;
				int selection = static_cast<int>(SendMessage(pDeviceComboBox->hwnd(), CB_GETCURSEL, 0, 0));
				pMandelbrotDisplay->setMode(selection);
			}
			else if (control == pPrecisionComboBox->hwnd()) {
				DWORD code = HIWORD(wParam);
				if (code != CBN_CLOSEUP) return 0;
				int selection = static_cast<int>(SendMessage(pPrecisionComboBox->hwnd(), CB_GETCURSEL, 0, 0));
				pMandelbrotDisplay->setPrecision(selection);
			}
			else {
				return 0;
			}
			InvalidateRect(hWnd, NULL, TRUE);
			UpdateWindow(hWnd);
			return 0;
		}

	case WM_MOUSEMOVE: {
			int col = GET_X_LPARAM(lParam); 
			int row = GET_Y_LPARAM(lParam);
			updateCoordinates(
				pMandelbrotDisplay->parentColToX(col),
				pMandelbrotDisplay->parentRowToY(row)
			);
			return 0;        
		}

	case WM_LBUTTONUP: {
			int col = GET_X_LPARAM(lParam); 
			int row = GET_Y_LPARAM(lParam);
			pMandelbrotDisplay->setCenter(
				pMandelbrotDisplay->parentColToX(col),
				pMandelbrotDisplay->parentRowToY(row)
			);
			InvalidateRect(hWnd, NULL, TRUE);
			UpdateWindow(hWnd);
			return 0;
		}

	case WM_RBUTTONUP: {
		int col = GET_X_LPARAM(lParam);
		int row = GET_Y_LPARAM(lParam);
		pMandelbrotDisplay->setCenter(
			-0.17589068230405872,
			 1.08662486955130280
			//mandelbrotDisplay.parentColToX(col),
			//mandelbrotDisplay.parentRowToY(row)
			);
		for (int i = 0; i < 10; ++i) {
			pMandelbrotDisplay->zoomIn(1.1);
			InvalidateRect(hWnd, NULL, TRUE);
			UpdateWindow(hWnd);
		}
		return 0;
	}

	case WM_SIZE: {
			RECT mainClientRect;
			GetClientRect(hWnd, &mainClientRect);
			EnumChildWindows(hWnd, handleParentResize, (LPARAM)&mainClientRect);
			return 0;
		}

	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;

	default:
		return DefWindowProc(hWnd, message, wParam, lParam);
	}
}

