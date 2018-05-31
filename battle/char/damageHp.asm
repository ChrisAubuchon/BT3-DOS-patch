; Attributes: bp-based frame

bat_charDamageHp proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1E5CC
	sub	ax, ax
	jmp	loc_1E66E
loc_1E5CC:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_dead
	jz	short loc_1E5FA
	cmp	gs:specialAttackVal, speAtt_possess
	jnz	short loc_1E5F6
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_charApplySpecialEffect
	add	sp, 2
	jmp	short loc_1E66E
	jmp	short loc_1E5FA
loc_1E5F6:
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E5FA:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_stoned
	jz	short loc_1E612
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E612:
	getCharP	[bp+arg_0], si
	mov	ax, gs:damageAmount
	cmp	gs:party.currentHP[si], ax
	jnb	short loc_1E647
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	short loc_1E66E
	jmp	short loc_1E662
loc_1E647:
	mov	ax, gs:damageAmount
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	sub	gs:party.currentHP[bx], cx
loc_1E662:
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_charApplySpecialEffect
	add	sp, 2
	jmp	short $+2
loc_1E66E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_charDamageHp endp
