; Reset location variables to initial state (in camp)
;
map_resetLocation proc far
	FUNC_ENTER
	mov	g_sqNorth, 0Bh
	mov	g_sqEast, 0Fh
	mov	g_direction, 0
	mov	g_locationNumber, 0
	FUNC_EXIT
	retf
map_resetLocation endp
