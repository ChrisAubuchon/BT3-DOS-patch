; Attributes: bp-based frame

bigpic_memcpy proc far

	arg_0= dword ptr  6
	skyColor= word ptr  0Ah
	grndColor= word	ptr  0Ch

	push	bp
	mov	bp, sp
	push	di
	push	es
	les	di, [bp+arg_0]
	mov	cx, 1288
	mov	ax, [bp+skyColor]
	mov	ah, al
	rep stosw
	mov	cx, 498h
	mov	ax, [bp+grndColor]
	mov	ah, al
	rep stosw
	pop	es
	pop	di
	pop	bp
	retf
bigpic_memcpy endp
