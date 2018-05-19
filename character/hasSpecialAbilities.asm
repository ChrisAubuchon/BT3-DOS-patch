; This function	returns	one if the character class
; has special abilities	that need to be	printed
;
; Attributes: bp-based frame

character_hasSpecialAbilities proc far

	slotNumber= word ptr	 6

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.class[bx]
	sub	ah, ah

	or	ax, ax
	jz	short l_returnZero

	cmp	ax, class_paladin
	jz	short l_returnZero

	cmp	ax, class_monk
	jz	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
character_hasSpecialAbilities endp
