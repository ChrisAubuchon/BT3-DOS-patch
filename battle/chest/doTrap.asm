; Attributes: bp-based frame
chest_doTrap proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1F88B
	test	gs:party.status[si], stat_dead
	jnz	short loc_1F88B
	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	bx, gs:trapIndex
	mov	al, trapFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	mov	gs:specialAttackVal, ax
	mov	ax, [bp+arg_2]
	mov	gs:damageAmount, ax
	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	call	savingThrowCheck
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_1F88B
	mov	ax, 1
	mov	[bp+var_2], ax
	sar	gs:damageAmount, 1
	push	[bp+arg_0]
	call	bat_damageHp
	add	sp, 2
loc_1F88B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_doTrap endp
