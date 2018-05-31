; Attributes: bp-based frame

review_elderKinestia proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 6
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete, near)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 5Ch	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnedSpell)
	or	ax, ax
	jnz	l_returnZero

	PUSH_OFFSET(s_kinestiaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_kinestiaSpellLocation)
	PRINTSTRING(wait)

	mov	ax, 5Ch	
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)

	mov	ax, 5Dh	
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
review_elderKinestia endp
