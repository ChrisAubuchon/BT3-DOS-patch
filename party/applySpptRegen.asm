; Attributes: bp-based frame

party_applySpptRegen proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1EDE3
loc_1EDE0:
	inc	[bp+var_2]
loc_1EDE3:
	cmp	[bp+var_2], 7
	jge	short loc_1EE1A
	getCharP	[bp+var_2], si
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short loc_1EE18
	mov	ax, gs:party.maxSppt[si]
	cmp	gs:party.currentSppt[si], ax
	jnb	short loc_1EE18
	inc	gs:party.currentSppt[si]
	mov	byte ptr g_printPartyFlag,	0
loc_1EE18:
	jmp	short loc_1EDE0
loc_1EE1A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_applySpptRegen endp
