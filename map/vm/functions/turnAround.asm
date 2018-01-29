; Attributes: bp-based frame

mfunc_turnAround proc far

	dataP= dword ptr	 6

	FUNC_ENTER
	CALL(map_turnAround, near)
	CALL(map_moveOneSquare, near)
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_turnAround endp
