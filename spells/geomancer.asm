sp_geomancerSpell proc far

	row= word ptr -8
	squareMaskIndex= word ptr	-6
	geoSpellNumber= word ptr	-4
	column=	word ptr -2
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(8)

	cmp	inDungeonMaybe, 0
	jz	short l_return
	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	sub	ah, ah
	mov	[bp+squareMaskIndex], ax
	sar	ax, 1
	mov	[bp+geoSpellNumber], ax
	mov	[bp+row], 0

l_rowLoop:
	mov	al, g_dunHeight
	sub	ah, ah
	cmp	ax, [bp+row]
	jbe	short l_return
	mov	[bp+column], 0

l_columnLoop:
	mov	al, g_dunWidth
	sub	ah, ah
	cmp	ax, [bp+column]
	jbe	short l_rowNext
	push	[bp+squareMaskIndex]
	push	[bp+column]
	push	[bp+row]
	mov	bx, [bp+geoSpellNumber]
	shl	bx, 1
	shl	bx, 1
	call	g_geomancerSpellList[bx]
	add	sp, 6
	inc	[bp+column]
	jmp	short l_columnLoop

l_rowNext:
	inc	[bp+row]
	jmp	short l_rowLoop

l_return:
	FUNC_EXIT
	retf
sp_geomancerSpell endp

