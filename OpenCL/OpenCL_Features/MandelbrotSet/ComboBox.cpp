#include "ComboBox.h"

using std::string;
using std::vector;

ComboBox::ComboBox(Window& parent, size_t x, size_t y, size_t width, size_t height, 
		vector<string> options) 
	: Window{ parent.handle(), parent.instance() } 
{

	// create the combo box with requested position and dimensions
	hComboBox = CreateWindow(
		"combobox",
		NULL,
		WS_CHILD | WS_VISIBLE | CBS_DROPDOWNLIST,
		x, y, width, height,
		parent.handle(), NULL, parent.instance(), NULL);

	// fill combo box with initial set of options
	for (auto option : options) {
		SendMessage(hComboBox, CB_ADDSTRING, 0, (LPARAM) (LPCTSTR) option.c_str());
	}

	// set the initial selection to the first option
	SendMessage(hComboBox, CB_SELECTSTRING, 0, (LPARAM) (LPCTSTR) options.front().c_str());
}

