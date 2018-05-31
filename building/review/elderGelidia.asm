; Attributes: bp-based frame

review_elderGelidia proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 2
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete, near)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 54h	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnedSpell)
	or	ax, ax
	jnz	short l_returnZero

	PUSH_OFFSET(s_gelidiaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_gelidiaSpellLocation)
	PRINTSTRING(wait)
	mov	ax, 54h	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	mov	ax, 55h	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_elderGelidia endp
