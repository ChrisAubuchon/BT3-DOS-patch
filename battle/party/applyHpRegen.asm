; Attributes: bp-based frame

bat_partyApplyHpRegen proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	cmp	[bp+arg_0], 0
	jz	short loc_1EDC8
	mov	[bp+var_2], 0
	jmp	short loc_1ED81
loc_1ED7E:
	inc	[bp+var_2]
loc_1ED81:
	cmp	[bp+var_2], 7
	jge	short loc_1EDBE
	getCharP	[bp+var_2], si
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short loc_1EDA3
	mov	ax, [bp+arg_0]
	add	gs:party.currentHP[si], ax
loc_1EDA3:
	getCharP	[bp+var_2], si
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	jbe	short loc_1EDBC
	mov	gs:party.currentHP[si], ax
loc_1EDBC:
	jmp	short loc_1ED7E
loc_1EDBE:
	mov	byte ptr g_printPartyFlag,	0
loc_1EDC8:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_partyApplyHpRegen endp
