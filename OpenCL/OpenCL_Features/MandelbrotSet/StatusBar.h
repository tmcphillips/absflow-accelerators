#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include "Window.h"
#include <vector>

class StatusBar : public Window
{
public:
	StatusBar(Window& parent, std::vector<int>& partWidths);
	BOOL handleParentResize (LPRECT lpParentClientRect);
	HWND handle() const { return hWnd; }
	int height() const { return windowHeight; }
	void setPanelText(int panel, std::string text);
private:
	HWND hWnd;
	int windowHeight;
};
