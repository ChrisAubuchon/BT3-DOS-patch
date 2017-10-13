; Attributes: bp-based frame

; Returns:
;   0FFFFh if failed
;   spell targeting flag if successful

getSpellNumber proc far

	var_306= word ptr -306h
	var_304= word ptr -304h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 306h
	call	someStackOperation
	push	si
	getCharP	[bp+partySlotNumber], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_returnFailed

	mov	al, spell_mouseClicked
	sub	ah, ah
	or	ax, ax
	jnz	loc_mouse_spell_select

	push	[bp+partySlotNumber]
	std_call	txt_castSpell,2
	cmp	ax, 0FFFFh
	jz	l_return
	jmp	l_spellFound

loc_mouse_spell_select:
	mov	[bp+var_106], 0
	mov	[bp+var_104], 0
	jmp	short loc_1FDC6
loc_1FDC2:
	inc	[bp+var_104]
loc_1FDC6:
	cmp	[bp+var_104], 7Eh
	jge	short loc_1FE1A
	push	[bp+var_104]
	push	[bp+partySlotNumber]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_1FE18
	mov	si, [bp+var_106]
	shl	si, 1
	mov	ax, [bp+var_104]
	mov	[bp+si+var_100], ax
	mov	bx, [bp+var_104]
	mov	cl, 3
	shl	bx, cl
	mov	ax, word ptr spellString.fullName[bx]
	mov	dx, word ptr (spellString.fullName+2)[bx]
	mov	si, [bp+var_106]
	inc	[bp+var_106]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_306], ax
	mov	[bp+si+var_304], dx
loc_1FE18:
	jmp	short loc_1FDC2
loc_1FE1A:
	cmp	[bp+var_106], 0
	jz	short loc_1FE3E
	push	[bp+var_106]
	lea	ax, [bp+var_306]
	push	ss
	push	ax
	mov	ax, offset aSpellToCast
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_102], ax
	jmp	short loc_1FE5F
loc_1FE3E:
	mov	ax, offset aYouDonTKnowAny
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	short l_returnFailed
loc_1FE5F:
	cmp	[bp+var_102], 0
	jl	short l_returnFailed
	mov	si, [bp+var_102]
	shl	si, 1
	mov	ax, [bp+si+var_100]

l_spellFound:
	mov	g_curSpellNumber, ax
	push	ax
	push	[bp+partySlotNumber]
	near_call	getSpptRequired,4
	mov	cx, ax
	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.currentSppt[bx], cx
	jnb	short l_enoughSppt

	push_ds_string	aNotEnoughSpellPoint
	std_call	printStringWClear,4
	wait4IO
	jmp	short l_returnFailed

l_enoughSppt:
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	jmp	short l_return
l_returnFailed:
	mov	ax, 0FFFFh
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getSpellNumber endp
