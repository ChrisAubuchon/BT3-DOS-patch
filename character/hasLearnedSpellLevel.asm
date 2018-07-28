; Attributes: bp-spellLevelBased frame

character_learnedSpellLevel proc far

	spellCount= word ptr	-4
	baseSpellNumber= word ptr	-2
	slotNumber=	word ptr  6
	spellLevelOffset= word ptr  8
	spellLevelBase= word ptr	0Ah

	FUNC_ENTER(4)
	mov	ax, [bp+spellLevelOffset]
	shl	ax, 1
	add	ax, [bp+spellLevelBase]
	mov	bx, ax
	mov	al, byte ptr g_spellLevelData.levelBase[bx]
	sub	ah, ah
	mov	[bp+baseSpellNumber], ax
	mov	al, g_spellLevelData.numSpells[bx]
	mov	[bp+spellCount], ax

l_loop:
	mov	ax, [bp+spellCount]
	dec	[bp+spellCount]
	or	ax, ax
	jz	short l_returnOne
	push	[bp+baseSpellNumber]
	inc	[bp+baseSpellNumber]
	push	[bp+slotNumber]
	CALL(character_learnedSpell)
	or	ax, ax
	jnz	short l_loop
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
character_learnedSpellLevel endp
