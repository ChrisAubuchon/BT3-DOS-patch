; Attributes: bp-based frame

random_2d8	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	call	random
	and	ax, 7
	mov	si, ax
	call	random
	and	ax, 7
	add	ax, si
	add	ax, 2
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
random_2d8	endp
