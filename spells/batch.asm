; Attributes: bp-based frame

sp_batchspell proc far

	batchListIndex= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(2)

	mov	bx, [bp+spellIndexNumber]
	mov	al, g_spellEffectData[bx]
	sub	ah, ah
	mov	[bp+batchListIndex], ax
l_loopEnter:
	mov	bx, [bp+batchListIndex]
	inc	[bp+batchListIndex]
	mov	al, batchSpellList[bx]
	sub	ah, ah
	or	ax, ax
	jz	short l_return
	push	ax
	push	[bp+spellCaster]
	CALL(_batchSpellCast, near)
	jmp	short l_loopEnter
l_return:
	FUNC_EXIT
	retf
sp_batchspell endp
