; Attributes: bp-based frame
;
; DWORD var_104 & var_106

wizardHall_buySpell proc far

	var_10A= word ptr -10Ah
	payeeSlotNumber= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	slotNumber= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(10Ah)
	push	si

	PUSH_OFFSET(s_buySpellPrompt)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	l_return

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	cmp	g_classSpellIndex[bx], 0FFh
	jnz	short l_isSpellcaster
	PUSH_OFFSET(s_thouArtNotASpellcaster)
	PRINTSTRING(true)
	IOWAIT
	jmp	l_return

l_isSpellcaster:
	mov	ax, g_locationNumber
	cmp	ax, 3
	jz	short loc_24C1A
	cmp	ax, 6
	jz	short loc_24C22
	jmp	short loc_24C2A

loc_24C1A:
	mov	[bp+var_10A], 0
	jmp	short loc_24C3E

loc_24C22:
	mov	[bp+var_10A], 1
	jmp	short loc_24C3E

loc_24C2A:
	mov	[bp+var_10A], 2
	jmp	short loc_24C3E

loc_24C3E:
	PUSH_OFFSET(s_thouMayLearn)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_spellsForSaleList+2)[bx]
	push	word ptr g_spellsForSaleList[bx]
	push	dx
	push	ax
	STRCAT
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_spellsForSalePrice+2)[bx]
	push	word ptr g_spellsForSalePrice[bx]
	push	dx
	push	[bp+var_106]
	ITOA
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	PUSH_OFFSET(s_inGoldWhoWillPay)
	push	dx
	push	[bp+var_106]
	STRCAT
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	CALL(readSlotNumber)
	mov	[bp+payeeSlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_spellsForSalePrice[bx]
	mov	dx, word ptr (g_spellsForSalePrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(payeeSlotNumber), si)
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short l_pay
	jb	short l_notEnoughGold
	cmp	word ptr gs:party.gold[si], cx
	jnb	short l_pay

l_notEnoughGold:
	PUSH_OFFSET(s_notEnoughGoldNl)
	PRINTSTRING(true)
	IOWAIT
	jmp	short l_return

l_pay:
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr g_spellsForSalePrice[bx]
	mov	dx, word ptr (g_spellsForSalePrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(payeeSlotNumber), si)
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, [bp+var_10A]
	add	ax, 7Ah	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	PUSH_OFFSET(s_eldersTeachLore)
	PRINTSTRING(true)
	DELAY(5)

l_return:
	pop	si
	FUNC_EXIT
	retf
wizardHall_buySpell endp
