; Attributes: bp-based frame

icon_draw proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= byte ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr iconDataList[bx]
	mov	dx, word ptr (iconDataList+2)[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_17B46:
	mov	al, [bp+arg_2]
	dec	[bp+arg_2]
	or	al, al
	jz	short loc_17B60
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	mov	ax, word_4470E[bx]
	add	[bp+var_4], ax
	jmp	short loc_17B46
loc_17B60:
	mov	al, [bp+arg_0]
	sub	ah, ah
	mov	si, ax
	mov	al, iconWidth[si]
	push	ax
	mov	al, iconHeight[si]
	push	ax
	mov	al, iconXOffset[si]
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	far ptr	sub_3E986
	add	sp, 0Ah
	pop	si
	mov	sp, bp
	pop	bp
locret_17B88:
	retf
icon_draw endp
