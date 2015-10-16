#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include "Window.h"

class ToolBar : public Window
{
public:
	ToolBar(Window& parent);
	BOOL handleParentResize (LPRECT lpParentClientRect);
};
