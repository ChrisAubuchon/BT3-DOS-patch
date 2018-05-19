; Attributes: bp-based frame

character_print proc far

	lineCount= word ptr	-8
	inKey= word ptr	-6
	mouseMask= word ptr	-4
	lastSlot= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(8)

	CALL(party_findEmptySlot)
	mov	[bp+lastSlot], ax
	cmp	[bp+slotNumber], ax
	jge	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.picIndex[bx]
	sub	ah, ah
	push	ax
	CALL(bigpic_drawPictureNumber)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(setTitle)

l_statLoop:
	push	[bp+lastSlot]
	push	[bp+slotNumber]
	CALL(character_printStats, near)

	mov	[bp+mouseMask], 0
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 2
	mov	[bp+lineCount], ax

l_setMouseMask:
	mov	al, gs:txt_numLines
	sub	ah, ah
	cmp	ax, [bp+lineCount]
	jb	short l_getKey

	mov	bx, [bp+lineCount]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+mouseMask], ax
	inc	[bp+lineCount]
	jmp	short l_setMouseMask

l_getKey:
	push	[bp+mouseMask]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, 'P'	
	jz	short l_poolGold
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Ch
	cmp	ax, [bp+inKey]
	jnz	short l_checkTradeGold

l_poolGold:
	push	[bp+lastSlot]
	push	[bp+slotNumber]
	CALL(doPoolGold)
	jmp	short l_checkEscape

l_checkTradeGold:
	cmp	[bp+inKey], 'T'
	jz	short l_tradeGold
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Dh
	cmp	ax, [bp+inKey]
	jnz	short l_checkEscape

l_tradeGold:
	push	[bp+lastSlot]
	push	[bp+slotNumber]
	CALL(character_getGoldTradee, near)

l_checkEscape:
	cmp	[bp+inKey], dosKeys_ESC
	jz	short l_printInventory
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Eh
	cmp	ax, [bp+inKey]
	jnz	l_statLoop

l_printInventory:
	CALL(text_clear)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_printSpecialAbilities

	push	[bp+slotNumber]
	CALL(inventory_print, near)

l_printSpecialAbilities:
	push	[bp+slotNumber]
	CALL(character_hasSpecialAbilities, near)
	or	ax, ax
	jz	short l_return

	push	[bp+slotNumber]
	CALL(character_printAbilities, near)

l_return:
	FUNC_EXIT
	retf
character_print endp
