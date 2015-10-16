#include "Button.h"

using std::string;
using std::vector;

Button::Button(Window& parent, size_t x, size_t y, size_t width, size_t height, std::string text) 
	: Window{ parent.handle(), parent.instance() } 
{

	// create the combo box with requested position and dimensions
	hButton = CreateWindow(
		"BUTTON",		// Predefined class; Unicode assumed 
		text.c_str(),   // Button text 
		WS_TABSTOP |	// styles
		WS_VISIBLE | 
		WS_CHILD   | 
		BS_PUSHBUTTON,   
		x,					// x position in parent window 
		y,					// y position in parent window 
		width,				// button width
		height,				// button height
		parent.handle(),	// parent window
		NULL,				// no menu
		parent.instance(),	// application instance
		NULL				// pointer not needed
	);		
}

