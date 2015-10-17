


struc vdisplay
    .width:     resd 1
    .height:    resd 1
    .sizeb:     resd 1
    .sized:     resd 1
    .array:     resd 1
endstruc

%define VirtDisplay_GetSize(columns, rows)     ((columns + 1) * rows + vdisplay_size)
