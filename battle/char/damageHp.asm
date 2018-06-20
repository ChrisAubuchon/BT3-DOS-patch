; Attributes: bp-based frame

bat_charDamageHp proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	l_returnZero

	test	gs:party.status[si], stat_dead
	jz	short loc_1E5FA

	cmp	gs:specialAttackVal, speAtt_possess
	jnz	l_returnZero

	push	[bp+slotNumber]
	CALL(bat_charApplySpecialEffect, near)
	jmp	short l_return

loc_1E5FA:
	test	gs:party.status[si], stat_stoned
	jnz	l_returnZero

	mov	ax, gs:damageAmount
	cmp	gs:party.currentHP[si], ax
	jnb	short loc_1E647

	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	short l_return

loc_1E647:
	mov	ax, gs:damageAmount
	mov	cx, ax
	sub	gs:party.currentHP[si], cx
	push	[bp+slotNumber]
	CALL(bat_charApplySpecialEffect, near)
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charDamageHp endp
