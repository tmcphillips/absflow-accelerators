#pragma once

#include <Windows.h>
#include <string>

LRESULT CALLBACK WindowProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam);
void updateStatus(std::string text);