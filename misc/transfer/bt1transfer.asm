; Attributes: bp-based frame

transfer_bt1Character proc far

	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	FUNC_ENTER(8)
	push	si

	mov	ax, 78h	
	push	ax
	sub	ax, ax
	push	ax
	PUSH_OFFSET(newCharBuffer, SEGMENT(seg027))
	CALL(memset)
	mov	[bp+var_4], 0

l_copyName:
	mov	bx, [bp+var_4]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	mov	[bp+var_8], al
	or	al, al
	jz	short l_copyStats
	mov	byte ptr gs:newCharBuffer._name[bx], al
	inc	[bp+var_4]
	jmp	short l_copyName

l_copyStats:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.strength]
	mov	gs:newCharBuffer.strength, al
	mov	al, byte ptr fs:[bx+bi_char_t.intelligence]
	mov	gs:newCharBuffer.intelligence, al
	mov	al, byte ptr fs:[bx+bi_char_t.dexterity]
	mov	gs:newCharBuffer.dexterity, al
	mov	al, byte ptr fs:[bx+bi_char_t.constitution]
	mov	gs:newCharBuffer.constitution, al
	mov	al, byte ptr fs:[bx+bi_char_t.luck]
	mov	gs:newCharBuffer.luck, al
	mov	ax, word ptr fs:[bx+bi_char_t.experience]
	mov	dx, fs:[bx+47h]
	mov	word ptr gs:newCharBuffer.experience, ax
	mov	word ptr gs:newCharBuffer.experience+2,	dx
	mov	ax, word ptr fs:[bx+bi_char_t.gold]
	mov	dx, fs:[bx+4Bh]
	mov	word ptr gs:newCharBuffer.gold,	ax
	mov	word ptr gs:newCharBuffer.gold+2, dx
	mov	ax, fs:[bx+bi_char_t.level]
	RANGE_WITH_MAX(35, al, cl)
	mov	gs:newCharBuffer.level,	ax
	mov	gs:newCharBuffer.maxLevel, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.currentHP, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.maxHP,	ax
	mov	ax, fs:[bx+bi_char_t.currentSppt]
	mov	gs:newCharBuffer.currentSppt, ax
	mov	ax, fs:[bx+bi_char_t.maxSppt]
	mov	gs:newCharBuffer.maxSppt, ax
	mov	bx, fs:[bx+bi_char_t.class]
	mov	al, g_bt2ClassMap[bx]
	mov	gs:newCharBuffer.class,	al
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.race]
	mov	gs:newCharBuffer.race, al
	CALL(getCharacterGender)
	and	al, 1
	mov	gs:newCharBuffer.gender, al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	shl	bx, 1
	sub	ah, ah
	add	bx, ax
	mov	al, g_classPictureNumber[bx]
	mov	gs:newCharBuffer.picIndex, al
	mov	gs:newCharBuffer.status, ah
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
loc_26F52:
	mov	si, [bp+var_4]
	shl	si, 1
	lfs	bx, [bp+arg_0]
	mov	bl, byte ptr fs:[bx+si+bi_char_t.inventory]
	sub	bh, bh
	mov	al, g_bt1InventoryMap[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_26FD1
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemNo[bx], al
	mov	bx, [bp+var_2]
	mov	al, g_itemBaseCount[bx]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemCount[bx], al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_26FCD
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemFlags[bx], 2
loc_26FCD:
	add	[bp+var_6], 3
loc_26FD1:
	inc	[bp+var_4]
	cmp	[bp+var_4], 8
	jl	loc_26F52

	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	or	ax, ax
	jz	short loc_27010
	cmp	ax, class_rogue
	jz	short loc_26FE0
	cmp	ax, class_bard
	jz	short loc_26FF9
	cmp	ax, class_paladin
	jz	short loc_27010
	cmp	ax, class_hunter
	jz	short loc_27021
	cmp	ax, class_monk
	jz	short loc_27010
	jmp	short loc_27053

loc_26FE0:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_55]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, al
	mov	gs:newCharBuffer.specAbil+2, al
	jmp	short loc_27053

loc_26FF9:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.songsLeft]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, 0FCh
	jmp	short loc_27053

loc_27010:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.numAttacks]
	mov	gs:newCharBuffer.numAttacks, al
	jmp	short loc_27053

loc_27021:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_5B]
	mov	gs:newCharBuffer.specAbil, al

loc_27053:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.wizdLevel]
	sub	ah, ah
	push	ax
	mov	ax, 1
	push	ax
	CALL(convertSpellLevel, near)
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.sorcLevel]
	sub	ah, ah
	push	ax
	mov	ax, 2
	push	ax
	CALL(convertSpellLevel, near)
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.conjLevel]
	sub	ah, ah
	push	ax
	mov	ax, 3
	push	ax
	CALL(convertSpellLevel, near)
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.magiLevel]
	sub	ah, ah
	push	ax
	mov	ax, 4
	push	ax
	CALL(convertSpellLevel, near)

	pop	si
	FUNC_EXIT
	retf
transfer_bt1Character endp
