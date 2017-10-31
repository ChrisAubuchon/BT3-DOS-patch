; Attributes: bp-based frame

useItem	proc far

	var_FA=	word ptr -0F8h
	targetSlotNumber=	word ptr -38h
	itemSlotNumber=	word ptr -34h
	var_32=	word ptr -32h
	userSlotNumber= word ptr	-2

	FUNC_ENTER
	CHKSTK(0F8h)

	PUSH_OFFSET(s_whoUsesItem)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+userSlotNumber], ax
	or	ax, ax
	jl	l_return

	CHARINDEX(ax, STACKVAR(userSlotNumber), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_return

	CHARINDEX(ax, STACKVAR(userSlotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	l_return

	PUSH_STACK_ADDRESS(var_32)
	PUSH_STACK_ADDRESS(var_FA)
	push	[bp+userSlotNumber]
	CALL(sub_188E8, 0Ah)

	or	ax, ax
	jz	l_emptyPockets
loc_11D4B:
	push	ax
	PUSH_STACK_ADDRESS(var_32)
	PUSH_OFFSET(s_whichItem)
	CALL(text_scrollingWindow, 0Ah)

	mov	[bp+itemSlotNumber], ax
	or	ax, ax
	jl	l_return

	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	CALL(item_canBeUsed, 4)
	or	ax, ax
	jz	short l_powerless
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+targetSlotNumber], ax
	cmp	ax, 4
	jge	short l_doUse
	PUSH_OFFSET(s_UseOn)
	push	[bp+targetSlotNumber]
	CALL(getTarget, 6)
	mov	[bp+targetSlotNumber], ax
	or	ax, ax
	jl	short l_return

l_doUse:
	CALL(text_clear)
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+targetSlotNumber]
	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	NEAR_CALL(item_doSpell, 0Ah)
	jmp	short l_waitAndReturn

l_powerless:
	PUSH_OFFSET(s_powerless)
	PRINTSTRING(true)
	jmp	short l_waitAndReturn
l_emptyPockets:
	PUSH_OFFSET(s_pocketsAreEmpty)
	PRINTSTRING(true)
l_waitAndReturn:
	IOWAIT
l_return:
	mov	sp, bp
	pop	bp
	retf
useItem	endp
