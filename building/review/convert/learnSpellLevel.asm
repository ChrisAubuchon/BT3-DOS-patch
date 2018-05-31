; Attributes: bp-based frame

character_learnSpellLevel proc far

	spellCount= word ptr	-4
	spellNumber= word ptr	-2
	slotNumber=	word ptr  6
	spellLevelOffset= word ptr	 8
	spellLevelBase= word ptr	 0Ah

	FUNC_ENTER(4)
	mov	ax, [bp+spellLevelOffset]
	shl	ax, 1
	add	ax, [bp+spellLevelBase]
	mov	bx, ax
	mov	al, byte ptr g_spellLevelData.levelBase[bx]
	sub	ah, ah
	mov	[bp+spellNumber], ax
	mov	al, g_spellLevelData.numSpells[bx]
	mov	[bp+spellCount], ax

l_loop:
	mov	ax, [bp+spellCount]
	dec	[bp+spellCount]
	or	ax, ax
	jz	short l_return
	push	[bp+spellNumber]
	inc	[bp+spellNumber]
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	jmp	short l_loop

l_return:
	mov	sp, bp
	pop	bp
	retf
character_learnSpellLevel endp
