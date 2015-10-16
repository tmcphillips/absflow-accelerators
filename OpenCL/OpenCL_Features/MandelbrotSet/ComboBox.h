#pragma once

#include "windows.h"
#include "windowsx.h"
#include "commctrl.h"
#include <string>
#include <sstream>
#include <vector>
#include "Window.h"

class ComboBox : public Window
{
public:
	
	ComboBox::ComboBox(Window& parent, size_t x, size_t y,
		size_t width, size_t height, std::vector<std::string> options);
	
	HWND hwnd() { return hComboBox; }

private:

	HWND hComboBox;
};

