; Attributes: bp-based frame
map_moveOneSquare proc	far
	FUNC_ENTER
	push	si

	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	sq_north, ax
	mov	ax, dirDeltaE[si]
	add	sq_east, ax

	pop	si
	FUNC_EXIT
	retf
map_moveOneSquare endp
