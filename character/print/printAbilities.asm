; Attributes: bp-based frame

character_printAbilities proc	far

	var_206= word ptr -204h
	var_204= word ptr -202h
	knownSpellCount= word ptr	-4
	currentSpellNumber= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(206h)
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:[bx+5Bh]
	sub	ah, ah

	cmp	ax, class_rogue
	jz	l_printRogue

	cmp	ax, class_bard
	jz	l_printBard

	cmp	ax, class_hunter
	jz	l_printHunter

	jmp	l_printSpells

l_printRogue:
	PRINTOFFSET(s_rogueAbilities)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_disarmTraps)
	CALL(printThiefAbilValues)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_identifyChest)
	CALL(printThiefAbilValues)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_identifyItem)
	CALL(printThiefAbilValues)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:(party.specAbil+2)[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_hideInShadows)
	CALL(printThiefAbilValues)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:(party.specAbil+2)[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_criticalHit)
	CALL(printThiefAbilValues)

	jmp	l_waitAndReturn

l_printBard:
	PRINTOFFSET(s_bardAbilities)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_tunesLeft)
	CALL(printStringAndThreeDigits)
	jmp	l_waitAndReturn

l_printHunter:
	PRINTOFFSET(s_hunterAbilities)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	push	ax
	PUSH_OFFSET(s_criticalHit)
	CALL(printThiefAbilValues)
	jmp	l_waitAndReturn

l_printSpells:
	mov	[bp+knownSpellCount], 0
	mov	[bp+currentSpellNumber], 0

l_loop:
	push	[bp+currentSpellNumber]
	push	[bp+slotNumber]
	CALL(character_learnedSpell, near)
	or	ax, ax
	jz	short l_loopNext
	mov	bx, [bp+currentSpellNumber]
	mov	cl, 3
	shl	bx, cl
	mov	ax, word ptr spellString.fullName[bx]
	mov	dx, word ptr (spellString.fullName+2)[bx]
	mov	si, [bp+knownSpellCount]
	inc	[bp+knownSpellCount]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_206], ax
	mov	[bp+si+var_204], dx

l_loopNext:
	inc	[bp+currentSpellNumber]
	cmp	[bp+currentSpellNumber], c_spellCount
	jl	short l_loop

loc_190A5:
	cmp	[bp+knownSpellCount], 0
	jz	short loc_190C6
	push	[bp+knownSpellCount]
	PUSH_STACK_ADDRESS(var_206)
	PUSH_OFFSET(s_knownSpells)
	CALL(text_scrollingWindow)
	jmp	l_return

loc_190C6:
	PRINTOFFSET(s_dontKnowAnySpells)

l_waitAndReturn:
	IOWAIT

l_return:
	pop	si
	FUNC_EXIT
	retf
character_printAbilities endp
