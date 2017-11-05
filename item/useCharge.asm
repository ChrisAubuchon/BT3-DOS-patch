; Attributes: bp-based frame

item_useCharge proc far

	var_4= dword ptr -4
	userSlotNumber= word ptr	 6
	itemSlotNumber= word ptr	 8

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(userSlotNumber))
	mov	bx, [bp+itemSlotNumber]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:party.inventory.itemCount[bx], 0FFh
	jz	l_returnOne
	CHARINDEX(ax, STACKVAR(userSlotNumber))
	mov	cx, [bp+itemSlotNumber]
	mov	dx, cx
	shl	cx, 1
	add	cx, dx
	add	cx, ax
	add	cx, 64h	
	mov	word ptr [bp+var_4], cx
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	dec	byte ptr fs:[bx]
	lfs	bx, [bp+var_4]
	cmp	byte ptr fs:[bx], 0
	jnz	l_returnOne
loc_11EBC:
	mov	ax, [bp+itemSlotNumber]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:word_42416, ax
	mov	ax, [bp+userSlotNumber]
	mov	gs:word_4244C, ax
	CALL(inven_pack)
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+userSlotNumber]
	jnz	short l_return

	; If the item used up belongs to the current singer and
	; the current singer no longer has an instrument equipped,
	; then the instrument is the item used up. Stop songs.
	mov	ax, itType_instrument
	push	ax
	push	[bp+userSlotNumber]
	CALL(inven_hasTypeEquipped)
	or	ax, ax
	jnz	short l_return
	cmp	gs:byte_422A4, 0
	jz	short loc_11F12
	CALL(bat_endCombatSong)
	jmp	short l_return
loc_11F12:
	CALL(endNoncombatSong)
	jmp	short l_return
l_returnOne:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
item_useCharge endp
