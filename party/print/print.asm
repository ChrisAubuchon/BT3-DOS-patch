; Attributes: bp-based frame

party_print proc far

	tmp= word ptr -32h
	counter= word ptr -30h
	slotNumber=	word ptr -2Eh
	partyLineP=	dword ptr -2Ch
	partyLine= word ptr -28h
	var_26=	byte ptr -26h
	var_24=	byte ptr -24h

	FUNC_ENTER(32h)
	push	si

	cmp	byte ptr g_printPartyFlag,	0
	jnz	l_return

	CALL(party_update)
	mov	byte ptr g_printPartyFlag,	1
	call	far ptr	gfx_disableMouseIcon

	mov	[bp+slotNumber], 0
l_charNumberLoopEntry:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_emptyPartySlot

	mov	[bp+counter], 0
l_copyCharName:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+counter]
	mov	al, byte ptr gs:party._name[bx]
	mov	si, [bp+counter]
	mov	byte ptr [bp+si+partyLine], al
	or	al, al
	jz	short l_printAc
	inc	[bp+counter]
	jmp	short l_copyCharName

l_printAc:
	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_clearAndPrintLine, near)

	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.ac[bx]
	cbw
	sub	ax, 10
	neg	ax
	cwd
	push	dx
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(itoa, near)
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2],	dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 10h
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.status[bx], 0
	jz	short l_printMaxHp

	mov	[bp+counter], 6
l_detectStatusLoop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.status[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, statusBitmaskList[bx]
	cbw
	test	cx, ax
	jnz	short l_hasStatus
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_detectStatusLoop
	jmp	l_printCurrentHp

l_hasStatus:
	mov	[bp+tmp], 0

l_strcpyStatusString:
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+tmp]
	mov	al, byte ptr s_statusAbbreviations[bx+si]
	mov	si, bx
	mov	byte ptr [bp+si+partyLine], al
	inc	[bp+tmp]
	cmp	[bp+tmp], 4
	jl	short l_strcpyStatusString

	mov	[bp+var_24], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 14h
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)
	jmp	short l_printCurrentHp

l_printMaxHp:
	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.maxHP[bx]
	PUSH_STACK_ADDRESS(partyLine)
	ITOA(partyLineP)
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 14h
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)

l_printCurrentHp:
	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.currentHP[bx]
	PUSH_STACK_ADDRESS(partyLine)
	ITOA(partyLineP)
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	mov	ax, 18h
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)

	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.maxSppt[bx]
	PUSH_STACK_ADDRESS(partyLine)
	ITOA(partyLineP)
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 1Ch
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)

	mov	ax, 3
	push	ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	ax, ax
	push	ax
	push	gs:party.currentSppt[bx]
	PUSH_STACK_ADDRESS(partyLine)
	ITOA(partyLineP)
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	mov	ax, 20h	
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.class[bx]
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	al, byte ptr s_classAbbreviations[si]
	mov	byte ptr [bp+partyLine], al
	mov	al, byte ptr (s_classAbbreviations+1)[si]
	mov	byte ptr [bp+partyLine+1], al
	mov	[bp+var_26], ah
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 24h	
	push	ax
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_printAt, near)
	jmp	short l_charNumberLoopIncrement

l_emptyPartySlot:
	mov	byte ptr [bp+partyLine], 0
	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(partyLine)
	CALL(party_clearAndPrintLine, near)

l_charNumberLoopIncrement:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	l_charNumberLoopEntry
	CALL(mouse_draw, near)

l_return:
	pop	si
	FUNC_EXIT
	retf
party_print endp
