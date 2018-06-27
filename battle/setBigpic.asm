; Attributes: bp-based frame

bat_setBigpic proc far

	monsterGroupSize=	word ptr -26h
	titleStringP=	dword ptr -24h
	unmaskedString=	word ptr -20h
	titleString=	word ptr -10h

	FUNC_ENTER(26h)

	mov	al, gs:monGroups.groupSize
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+monsterGroupSize], ax
	or	ax, ax
	jnz	short l_notPartyAttack

	mov	ax, bigpic_maleWarrior
	push	ax
	CALL(bigpic_drawPictureNumber)
	PUSH_OFFSET(s_party)
	CALL(setTitle)
	jmp	short l_return

l_notPartyAttack:
	PUSH_STACK_ADDRESS(unmaskedString)
	mov	ax, offset monGroups
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)

	mov	ax, [bp+monsterGroupSize]
	dec	ax
	push	ax
	PUSH_STACK_ADDRESS(titleString)
	PUSH_STACK_ADDRESS(unmaskedString)
	PLURALIZE(titleStringP)
	lfs	bx, [bp+titleStringP]
	mov	byte ptr fs:[bx], 0

	PUSH_STACK_ADDRESS(titleString)
	CALL(setTitle)

	mov	al, gs:monGroups.picIndex
	sub	ah, ah
	push	ax
	CALL(bigpic_drawPictureNumber)

l_return:
	FUNC_EXIT
	retf
bat_setBigpic endp
