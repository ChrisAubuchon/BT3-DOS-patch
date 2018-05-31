; Attributes: bp-based frame

random_1d8	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	random
	and	ax, 7
	inc	ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
random_1d8	endp
