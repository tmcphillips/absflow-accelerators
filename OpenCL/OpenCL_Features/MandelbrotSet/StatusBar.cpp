#include "StatusBar.h"

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include <sstream>

StatusBar::StatusBar(Window& parent, std::vector<int>& partWidths) 
	: Window{ parent.handle(), parent.instance() }
{
	// create the status bar
	hWnd = CreateWindowEx(
		0, 
		STATUSCLASSNAME, 
		NULL, 
		WS_CHILD | WS_VISIBLE | SBARS_SIZEGRIP, 
		0, 0, 0, 0,
		parent.handle(),
		NULL, 
		parent.instance(), 
		NULL
	);

	int* pWidths = new int[partWidths.size()];
	std::copy(begin(partWidths), end(partWidths), pWidths);
	SendMessage(hWnd, SB_SETPARTS, partWidths.size(), (LPARAM)pWidths);

	RECT statusRect;
	GetWindowRect(hWnd, &statusRect);
	windowHeight = statusRect.bottom - statusRect.top;
}

BOOL StatusBar::handleParentResize(LPRECT lpParentClientRect)
{
	MoveWindow(
		hWnd, 
		0, 
		lpParentClientRect->bottom - windowHeight, 
		lpParentClientRect->right, 
		windowHeight, 
		TRUE
	);

	ShowWindow(hWnd, SW_SHOW); 

	return TRUE;
}

void StatusBar::setPanelText(int panelIndex, std::string text) {
	SendMessage(hWnd, SB_SETTEXT, panelIndex, (LPARAM)(text.c_str()));
}


