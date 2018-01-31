; Attributes: bp-based frame

review_elderTenebrosia proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	mov	ax, 8
	push	ax
	push	[bp+slotNumber]
	CALL(review_isQuestComplete, near)
	or	ax, ax
	jz	short l_returnZero

	mov	ax, 60h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasLearnedSpell)
	or	ax, ax
	jnz	short l_returnZero

	PUSH_OFFSET(s_tenebrosiaSpellText)
	PRINTSTRING(wait)
	PUSH_OFFSET(s_tenebrosiaSpellLocation)
	PRINTSTRING(wait)

	mov	ax, 60h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_learnSpell)

	mov	ax, 61h	
	push	ax
	push	[bp+slotNumber]
	CALL(mage_learnSpell)

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	mov	ax, ax

l_return:
	FUNC_EXIT
	retf
review_elderTenebrosia endp
