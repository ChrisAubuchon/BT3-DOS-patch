; Attributes: bp-based frame

bat_monApplySpecialEffect proc far

	var_4= dword ptr -4
	groupNumber= word ptr  6
	slotNumber= word ptr	 8

	FUNC_ENTER(4)

	mov	bx, [bp+groupNumber]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+slotNumber]
	shl	ax, 1
	add	bx, ax
	and	gs:bat_monBeenHitList[bx], 0FEh
	cmp	gs:specialAttackVal, specialAttack_stone
	jz	short l_killMonster

	cmp	gs:specialAttackVal, specialAttack_critical
	jnz	short l_damageMonster

l_killMonster:
	push	[bp+slotNumber]
	push	[bp+groupNumber]
	CALL(bat_monKill, near)
	jmp	short l_returnOne

l_damageMonster:
	mov	ax, [bp+groupNumber]
	mov	cl, 6
	shl	ax, cl
	mov	cx, [bp+slotNumber]
	shl	cx, 1
	add	ax, cx
	add	ax, offset g_monHpList
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	mov	ax, gs:g_damageAmount
	lfs	bx, [bp+var_4]
	sub	fs:[bx], ax
	lfs	bx, [bp+var_4]
	cmp	word ptr fs:[bx], 0
	jg	short l_returnZero

	push	[bp+slotNumber]
	push	[bp+groupNumber]
	CALL(bat_monKill, near)

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
bat_monApplySpecialEffect endp
