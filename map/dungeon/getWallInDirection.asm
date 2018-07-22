; This function returns the value passed in the walls parameter
; rotated so that the wall in the direction to party is facing
; is in the high nibble of the low byte.
;
; The walls word is ordered S,W,N,E
;
dungeon_getWallInDirection proc far

	walls= word ptr	 6
	direction= word ptr  8

	FUNC_ENTER
	mov	ax, [bp+direction]
	and	al, 3
	mov	cl, 2
	shl	ax, cl
	mov	cl, al
	mov	ax, [bp+walls]
	rol	ax, cl
	xor	dx, dx
	FUNC_EXIT(false)
	retf
dungeon_getWallInDirection endp

