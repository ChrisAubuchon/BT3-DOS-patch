; Attributes: bp-based frame

review_elderTarmitia proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 0Ah
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete, near)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 64h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasLearnedSpell)
	or	ax, ax
	jnz	short l_returnZero

	PUSH_OFFSET(s_tarmitiaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_tarmitiaSpellLocation)
	PRINTSTRING(wait)

	mov	ax, 64h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_learnSpell)

	mov	ax, 65h	
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
review_elderTarmitia endp
