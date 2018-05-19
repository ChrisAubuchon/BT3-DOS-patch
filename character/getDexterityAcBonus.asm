; Attributes: bp-based frame
character_getDexterityAcBonus proc	far

	slotNumber= word ptr	 6

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.dexterity[bx]
	sub	ah, ah
	sub	ax, 14
	or	ax, ax
	jle	short l_returnZero

	mov	bx, ax
	mov	al, g_acDexterityBonus[bx]
	sub	ah, ah
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
character_getDexterityAcBonus endp
