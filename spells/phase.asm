; Attributes: bp-based frame
;
; XXX - Revisit

sp_phaseDoor proc far

	var_8= word ptr	-8
	var_6= dword ptr -6
	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(8)

	cmp	inDungeonMaybe, 0
	jz	loc_216E2
	push	g_sqNorth
	push	g_sqEast
	CALL(dun_getWalls)
	mov	[bp+var_2], ax
	mov	ax, g_direction
	dec	ax
	push	ax
	push	[bp+var_2]
	CALL(dungeon_getWallInDirection)
	mov	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	and	al, 0Fh
	cmp	al, 9
	jb	short loc_21671
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(printSpellFizzled, near)
	jmp	short l_return
loc_21671:
	mov	gs:g_wallPhasedFlag, 1
	mov	bx, [bp+spellIndexNumber]
	cmp	g_spellEffectData[bx], 80h
	jb	short loc_216E0
	mov	bx, g_sqNorth
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:g_rowOffset[bx]
	mov	dx, word ptr gs:(g_rowOffset+2)[bx]
	mov	cx, g_sqEast
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	test	byte ptr g_direction, 2
	jz	short loc_216C8
	inc	word ptr [bp+var_6]
loc_216C8:
	test	byte ptr g_direction, 1
	jz	short loc_216D9
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0F0h
	jmp	short loc_216E0
loc_216D9:
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0Fh
loc_216E0:
	jmp	short l_return
loc_216E2:
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(printSpellFizzled, near)
l_return:
	FUNC_EXIT
	retf
sp_phaseDoor endp

