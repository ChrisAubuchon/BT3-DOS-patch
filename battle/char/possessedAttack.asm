; Attributes: bp-based frame

bat_charPossessedAttack proc far

	slotNumber= word ptr	 6

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:party.status[bx], stat_nuts
	jz	short l_checkHostile

	CALL(random)
	test	al, 1
	jnz	short l_partyTarget

l_checkHostile:
	CHARINDEX(ax, STACKVAR(slotNumber))
	mov	bx, ax
	cmp	gs:party.hostileFlag[bx], 0
	jz	short l_checkEnemyGroup

l_partyTarget:
	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar)
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], al
	jmp	short l_doAttack

l_checkEnemyGroup:
	cmp	byte ptr gs:g_monGroups._name, 0
	jz	short l_return

l_enemyTarget:
	mov	bx, [bp+slotNumber]
	mov	gs:g_batCharActionTarget[bx], 80h

l_doAttack:
	push	[bp+slotNumber]
	CALL(bat_charMelee, near)

l_return:
	FUNC_EXIT
	retf
bat_charPossessedAttack endp
