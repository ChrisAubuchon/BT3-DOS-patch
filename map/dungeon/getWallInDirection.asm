; Attributes: bp-based frame

dungeon_getWallInDirection proc far

	walls= word ptr	 6
	direction= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, [bp+direction]
	and	al, 3
	mov	cl, 2
	shl	ax, cl
	mov	cl, al
	mov	ax, [bp+walls]
	rol	ax, cl
	xor	dx, dx
	pop	bp
	retf
dungeon_getWallInDirection endp

