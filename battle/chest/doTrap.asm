; Attributes: bp-based frame
chest_doTrap proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(arg_0), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_return

	test	gs:party.status[si], stat_dead
	jnz	short l_return

	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	bx, gs:trapIndex
	mov	al, g_chestTrapFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	mov	gs:specialAttackVal, ax
	mov	ax, [bp+arg_2]
	mov	gs:g_damageAmount, ax
	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	CALL(savingThrowCheck)
	or	ax, ax
	jz	short l_return

	mov	ax, 1
	sar	gs:g_damageAmount, 1
	push	[bp+arg_0]
	CALL(bat_damageHp)

l_return:
	pop	si
	FUNC_EXIT
	retf
chest_doTrap endp
