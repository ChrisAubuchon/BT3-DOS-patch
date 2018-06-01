; Attributes: bp-based frame
bat_charGetReward proc	far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1F58B
	sub	ax, ax
	jmp	short loc_1F5B9
loc_1F58B:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F59F
	sub	ax, ax
	jmp	short loc_1F5B9
loc_1F59F:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.status[bx]
	and	al, stat_dead or stat_stoned or	stat_paralyzed
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
loc_1F5B9:
	mov	sp, bp
	pop	bp
	retf
bat_charGetReward endp
