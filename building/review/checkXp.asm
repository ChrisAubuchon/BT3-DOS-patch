; Attributes: bp-based frame
;

review_checkXp proc far

	stringBuffer= word ptr -10Ah
	xpDelta= word ptr	-0Ah
	slotNumber= word ptr	-6
	stringBufferP= dword ptr	-4

	FUNC_ENTER(10Ah)

l_loop:
	PUSH_OFFSET(s_elderWeighsMerits)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:party.status[bx], 0Ch
	jz	short l_ableMember

	PUSH_OFFSET(s_elderDeadCharacter)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	jmp	l_printBuffer

l_ableMember:
	PUSH_OFFSET(s_guildElderDeems)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnz	short l_notMonster

	PUSH_OFFSET(s_cannotBeRaised)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	jmp	l_printBuffer

l_notMonster:
	push	[bp+slotNumber]
	CALL(review_getXpDelta, near)
	SAVE_STACK_DWORD(dx,ax,xpDelta)
	or	dx, dx
	jg	short l_notYet
	jl	short l_earnedLevel
	or	ax, ax
	jnz	short l_notYet

l_earnedLevel:
	PUSH_OFFSET(s_hathEarnedLevel)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_DWORD(stringBufferP)
	push	[bp+slotNumber]
	CALL(review_advance, near)
	SAVE_STACK_DWORD(dx,ax,stringBufferP)
	jmp	short l_printBuffer

l_notYet:
	PUSH_OFFSET(s_stillNeedeth)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	sub	ax, ax
	push	ax
	PUSH_STACK_DWORD(xpDelta)
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	PUSH_OFFSET(s_experiencePoints)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

l_printBuffer:
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	byte ptr g_printPartyFlag,	0
	IOWAIT
	jmp	l_loop

l_return:
	FUNC_EXIT
	retf
review_checkXp endp
