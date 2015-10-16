#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <sstream>

#include "Window.h"

class MainWindow : public Window
{
public:
	MainWindow(HINSTANCE hInstance, std::string windowClassName, std::string windowTitle);
};
