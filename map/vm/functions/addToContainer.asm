; Attributes: bp-based frame

mfunc_addToContainer proc far

	var_4= word ptr	-4
	addAmount= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	push	si

	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	si, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	si, ax
	mov	al, gs:party.inventory.itemCount[si]
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+addAmount], ax
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_4], ax
	cmp	[bp+addAmount], 0FEh 
	jle	short loc_1A1FC
	mov	[bp+addAmount], 0FEh 
loc_1A1FC:
	mov	bx, [bp+var_4]
	mov	al, g_itemBaseCount[bx]
	sub	ah, ah
	sub	ax, [bp+addAmount]
	sbb	cx, cx
	and	ax, cx
	add	ax, [bp+addAmount]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	gs:party.inventory.itemCount[bx], cl
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	FUNC_EXIT
	retf
mfunc_addToContainer endp
