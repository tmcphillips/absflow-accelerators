#include "ToolBar.h"

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include "ComboBox.h"
#include <string>
#include <sstream>
#include <vector>

#include "opencl_utilities.h"
#include "Window.h"
using std::string;
using std::vector;

ToolBar::ToolBar(Window& parent) : Window{ parent.handle(), parent.instance() }
{
	// create the toolbar window
	hWnd = CreateWindowEx(
		0, 
		TOOLBARCLASSNAME, 
		NULL, 
		WS_CHILD | TBSTYLE_WRAPABLE, 
		0, 0, 0, 0,
		parent.handle(),
		NULL, 
		parent.instance(),
		NULL
	);


    // Resize the toolbar, and then show it.
	ShowWindow(hWnd, TRUE);

	RECT toolbarRect;
	GetWindowRect(hWnd, &toolbarRect);
	windowHeight = toolbarRect.bottom - toolbarRect.top;
}


BOOL ToolBar::handleParentResize(LPRECT lpParentClientRect)
{
	MoveWindow(
		hWnd, 
		0, 
		0, 
		lpParentClientRect->right, 
		windowHeight, 
		TRUE
	);

	ShowWindow(hWnd, TRUE);

	return TRUE;
}

