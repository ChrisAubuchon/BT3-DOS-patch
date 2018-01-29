; Attributes: bp-based frame

mfunc_subtractFromContainer proc far

	itemCountP= dword ptr -0Ah
	var_4= word ptr	-4
	subtractAmount= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(0Ah)
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory.itemCount
	mov	word ptr [bp+itemCountP], ax
	mov	word ptr [bp+itemCountP+2], seg seg027
	lfs	bx, [bp+itemCountP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+subtractAmount], ax
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_4], ax
	cmp	[bp+subtractAmount], 0FEh 
	jz	short l_return
	cmp	[bp+subtractAmount], ax
	jl	short l_setToZero
	mov	al, byte ptr [bp+subtractAmount]
	sub	al, byte ptr [bp+var_4]
	jmp	short l_setCount
l_setToZero:
	sub	al, al
l_setCount:
	lfs	bx, [bp+itemCountP]
	mov	fs:[bx], al
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	FUNC_EXIT
	retf
mfunc_subtractFromContainer endp
