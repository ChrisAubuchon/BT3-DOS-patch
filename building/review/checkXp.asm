; Attributes: bp-based frame
;
; DWORD var_2 & var_4, var_8 & var_A

review_checkXp proc far

	stringBuffer= word ptr -10Ah
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	slotNumber= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

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
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	l_printBuffer

l_ableMember:
	PUSH_OFFSET(s_guildElderDeems)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnz	short l_notMonster

	PUSH_OFFSET(s_cannotBeRaised)
	push	[bp+var_2]
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	l_printBuffer

l_notMonster:
	push	[bp+slotNumber]
	CALL(review_getXpDelta, near)
	mov	[bp+var_A], ax
	mov	[bp+var_8], dx
	or	dx, dx
	jg	short l_notYet
	jl	short l_earnedLevel
	or	ax, ax
	jnz	short l_notYet

l_earnedLevel:
	PUSH_OFFSET(s_hathEarnedLevel)
	push	[bp+var_2]
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	push	dx
	push	ax
	push	[bp+slotNumber]
	CALL(review_advance, near)
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	short l_printBuffer

l_notYet:
	PUSH_OFFSET(s_stillNeedeth)
	push	[bp+var_2]
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	sub	ax, ax
	push	ax
	push	[bp+var_8]
	push	[bp+var_A]
	push	dx
	push	[bp+var_4]
	CALL(itoa)
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	PUSH_OFFSET(s_experiencePoints)
	push	dx
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx

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
