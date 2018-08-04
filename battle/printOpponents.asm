; Attributes: bp-based frame
bat_printOpponents proc	far

	stringBuffer= word ptr -108h
	battleCryIndex= word ptr	-8h
	loopCounter= word ptr	-6
	stringBufferP= dword ptr	-4
	firstRoundFlag= word ptr	 6

	FUNC_ENTER(10Ch)

	cmp	gs:g_batNoCryFlag, 0
	jnz	short l_noBattleCry

	mov	gs:g_batNoCryFlag, 0

	cmp	[bp+firstRoundFlag], 0
	jnz	short l_notFirstRound

	CALL(bat_monGroupActive)
	or	ax, ax
	jz	short l_usePartyAttackBigpic

	mov	ax, 6
	push	ax
	mov	ax, 1
	push	ax
	CALL(randomBetweenXandY, near)
	jmp	short l_printBattlecry

l_usePartyAttackBigpic:
	sub	ax, ax

l_printBattlecry:
	mov	[bp+battleCryIndex], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_battleCryList+2)[bx]
	push	word ptr g_battleCryList[bx]
	PRINTSTRING(clear)
	cmp	[bp+battleCryIndex], 0
	jnz	short l_initStringBuffer
	DELAY(3)
	jmp	l_return

l_notFirstRound:
	PRINTOFFSET(s_youStillFace, clear)
	jmp	short l_initStringBuffer

l_noBattleCry:
	mov	gs:g_batNoCryFlag, 0

l_initStringBuffer:
	lea	ax, [bp+stringBuffer]
	SAVE_STACK_DWORD(ss, ax, stringBufferP)
	test	gs:g_monGroups.groupSize,	1Fh
	jnz	short l_printFirstMonsterGroup

	PRINTOFFSET(s_hostilePartyMembers)
	DELAY(3)
	jmp	l_return

l_printFirstMonsterGroup:
	sub	ax, ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	CALL(bat_monPrintGroup, near)
	SAVE_STACK_DWORD(dx, ax, stringBufferP)

	mov	[bp+loopCounter], 1

l_monGroupLoop:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:g_monGroups.groupSize[bx], 1Fh
	jz	short l_terminateString

	cmp	[bp+loopCounter], 4
	jnz	short l_checkNextGroup

l_terminateString:
	PUSH_OFFSET(s_periodNlNl)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	jmp	short l_return

l_checkNextGroup:
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	test	gs:g_monGroupsNext.groupSize[bx], 1Fh
	jz	short l_lastGroup

	cmp	[bp+loopCounter], 2
	jnz	short l_multipleGroupsLeft

l_lastGroup:
	mov	ax, offset s_and
	jmp	short l_appendSeparator

l_multipleGroupsLeft:
	mov	ax, offset s_comma

l_appendSeparator:
	push	ds
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	push	[bp+loopCounter]
	push	dx
	push	ax
	CALL(bat_monPrintGroup, near)
	SAVE_STACK_DWORD(dx, ax, stringBufferP)
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jle	l_monGroupLoop

l_return:
	FUNC_EXIT
	retf
bat_printOpponents endp
