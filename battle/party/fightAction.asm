; Attributes: bp-based frame

bat_partyFightAction proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_partyFightAction endp
