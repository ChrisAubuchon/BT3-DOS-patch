; This function	returns	1 if the mage has learned
; at least one level of	a certain mage class
; Attributes: bp-based frame

character_hasBeenClass proc far

	loopCounter= word ptr -2
	slotNumber=	word ptr  6
	spellBase= word	ptr  8

	FUNC_ENTER(2)
	mov	[bp+loopCounter], 6
l_loop:
	push	[bp+spellBase]
	push	[bp+loopCounter]
	push	[bp+slotNumber]
	CALL(character_learnedSpellLevel, near)
	or	ax, ax
	jz	short l_returnZero
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	short l_loop

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
character_hasBeenClass endp
