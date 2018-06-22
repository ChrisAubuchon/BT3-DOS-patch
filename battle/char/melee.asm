; Attributes: bp-based frame

bat_charMelee proc far

	stringBufferP= dword ptr -10Ch
	var_108= word ptr -108h
	stringBuffer= word ptr -106h
	var_6= word ptr	-6
	var_4= dword ptr -4
	slotNumber= word ptr 6
	attackTarget= word ptr 8

	FUNC_ENTER(10Ch)
	push	si

	cmp	[bp+attackTarget], 80h
	jge	short l_enemyTarget

	CHARINDEX(ax, STACKVAR(attackTarget), si)
	cmp	gs:party.class[si], class_monster
	jnz	short l_targetMember
	mov	gs:party.hostileFlag[si], 1

l_targetMember:
	CHARINDEX(ax, STACKVAR(attackTarget), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned
	jnz	l_return
	jmp	short loc_1BF3E

l_enemyTarget:
	mov	ax, [bp+attackTarget]
	and	ax, 3
	MONINDEX(cx, cx)
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	l_return

loc_1BF3E:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	APPEND_CHAR(STACKVAR(stringBufferP), ' ')

	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	CALL(character_itemTypeCanBeUsed)

	or	ax, ax
	jz	short loc_1BF8B

	mov	[bp+var_6], 0
	jmp	short loc_1BFBF

loc_1BF8B:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jb	short loc_1BFBA
	add	ax, offset party

	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+(character_t.spells+0Ah)]
	sub	ah, ah
	shl	ax, 1
	mov	[bp+var_6], ax
	jmp	short loc_1BFBF
loc_1BFBA:
	mov	[bp+var_6], 2
loc_1BFBF:
	CALL(random)
	and	ax, 1
	add	[bp+var_6], ax
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	
	push	word ptr (monMeleeAttString+2)[bx]
	push	word ptr monMeleeAttString[bx]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	APPEND_CHAR(STACKVAR(stringBufferP), ' ')

	push	[bp+attackTarget]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_getAttackerName)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx

	push	[bp+attackTarget]
	push	[bp+slotNumber]
	CALL(bat_charExecuteMeleeAttack, near)
	mov	[bp+var_108], ax
	or	ax, ax
	jnz	short loc_1C04B

	PUSH_OFFSET(s_butMisses)
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)
	jmp	short loc_1C0B3

loc_1C04B:
	push	[bp+var_108]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_charPrintMeleeDamage, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx

	push	[bp+attackTarget]
	CALL(bat_damageHp, near)
	or	ax, ax
	jz	short loc_1C0A7

	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_appendSpecialAttackString, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx

	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	push	[bp+attackTarget]
	push	dx
	push	word ptr [bp+stringBufferP]
	CALL(printCharPronoun)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	jmp	short loc_1C0B3

loc_1C0A7:
	PUSH_OFFSET(s_periodNlNl)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

loc_1C0B3:
	APPEND_CHAR(STACKVAR(stringBufferP), 0)
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

	mov	bx, [bp+slotNumber]
	mov	gs:g_characterMeleeDistance[bx], 0
	mov	byte ptr g_printPartyFlag,	0

	DELAY

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charMelee endp

