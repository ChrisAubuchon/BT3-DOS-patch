; Attributes: bp-based frame

bat_charDefendAction proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_charDefendAction endp
