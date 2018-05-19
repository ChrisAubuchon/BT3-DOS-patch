; Attributes: bp-based frame

bat_monAction	proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	monsterNumber= word ptr	 6
	groupNumber= word ptr  8

	FUNC_ENTER(6)
	push	si

	mov	bx, [bp+monsterNumber]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupNumber]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	CALL(random)
	and	ax, 6
	mov	[bp+var_6], ax
	MONINDEX(ax, STACKVAR(monsterNumber), si)
	add	si, [bp+var_6]
	mov	al, gs:monGroups.attackType._type[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, gs:monGroups.attackType.damage[si]
	mov	[bp+var_4], ax
	cmp	[bp+var_2], 80h
	jge	short l_checkMelee

	push	[bp+var_2]
	push	[bp+groupNumber]
	push	[bp+monsterNumber]
	CALL(bat_monCast, near)
	jmp	short l_return

l_checkMelee:
	mov	ax, [bp+var_2]
	sub	ax, 0F0h
	and 	ax, 7Fh
	mov	[bp+var_6], ax
	cmp	[bp+var_6], 0Ah
	jge	short l_specialAttack

	push	[bp+var_4]
	push	[bp+var_6]
	push	[bp+groupNumber]
	push	[bp+monsterNumber]
	CALL(bat_monMelee, near)
	jmp	short l_return

l_specialAttack:
	mov	ax, [bp+var_6]
	cmp	ax, 0Ah
	jz	short l_summon
	cmp	ax, 10h
	jz	short l_breathAttack
	cmp	ax, 13h
	jz	short l_tarjanSpecial
	jmp	short l_return

l_summon:
	push	[bp+var_4]
	push	[bp+groupNumber]
	push	[bp+monsterNumber]
	CALL(bat_monSummonHelp, near)
	jmp	short l_return

l_breathAttack:
	push	[bp+var_4]
	push	[bp+groupNumber]
	push	[bp+monsterNumber]
	CALL(bat_monBreathe, near)
	jmp	short l_return

l_tarjanSpecial:
	CALL(bat_monTarjanSpecial, near)
	jmp	short l_return

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_monAction	endp
