; Attributes: bp-based frame

minimap_clearSquare proc far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	push	es
	push	di
	les	di, [bp+arg_0]
	xor	ax, ax
	mov	cx, 8
	rep stosb
	pop	di
	pop	es
	pop	bp
	retf
minimap_clearSquare endp
