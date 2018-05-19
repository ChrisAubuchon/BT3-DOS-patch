; Reset location variables to initial state (in camp)
;
map_resetLocation proc far
	FUNC_ENTER
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	g_direction, 0
	mov	g_locationNumber, 0
	FUNC_EXIT
	retf
map_resetLocation endp
