; Attributes: bp-based frame
map_moveOneSquare proc	far
	FUNC_ENTER
	push	si

	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	g_sqNorth, ax
	mov	ax, dirDeltaE[si]
	add	g_sqEast, ax

	pop	si
	FUNC_EXIT
	retf
map_moveOneSquare endp
