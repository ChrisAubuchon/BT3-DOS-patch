; Attributes: bp-based frame

review_elderLucencia proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 4
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete, near)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 58h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasLearnedSpell)
	or	ax, ax
	jnz	l_returnZero

	PUSH_OFFSET(s_lucenciaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_lucenciaSpellLocation)
	PRINTSTRING(wait)

	mov	ax, 58h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_learnSpell)

	mov	ax, 59h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_learnSpell)

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
review_elderLucencia endp
