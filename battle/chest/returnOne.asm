; Attributes: bp-based frame

chest_returnOne	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
chest_returnOne	endp

