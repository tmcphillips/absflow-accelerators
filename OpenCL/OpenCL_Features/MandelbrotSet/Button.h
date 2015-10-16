#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include <sstream>
#include <vector>
#include "Window.h"

class Button : public Window
{
public:
	Button::Button(Window& parent, size_t x, size_t y, 
		size_t width, size_t height, std::string text);
	HWND hwnd() { return hButton; }
private:
	HWND hButton;
};

