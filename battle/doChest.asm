; Attributes: bp-based frame

bat_doChest proc far

	var_30=	word ptr -30h
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah

	push	bp
	mov	bp, sp
	mov	ax, 30h	
	call	someStackOperation
	push	si
	mov	ax, 35h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aChest
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	call	random
	and	ax, 3
	mov	cl, g_levelNumber
	sub	ch, ch
	shl	cx, 1
	shl	cx, 1
	add	cx, ax
	mov	gs:trapIndex, cx
	mov	gs:word_42298, 0
	mov	[bp+var_1A], 0
	jmp	short loc_1FBE6
loc_1FBE3:
	inc	[bp+var_1A]
loc_1FBE6:
	cmp	[bp+var_1A], 0Ah
	jge	short loc_1FBF5
	mov	si, [bp+var_1A]
	mov	byte ptr [bp+si+var_A],	1
	jmp	short loc_1FBE3
loc_1FBF5:
	call	text_clear
	lea	ax, [bp+var_30]
	push	ss
	push	ax
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	lea	ax, [bp+var_A]
	push	ss
	push	ax
	mov	ax, offset aThereIsAChestHere_Wil
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_18], ax
loc_1FC19:
	mov	[bp+var_1C], 1
	push	[bp+var_18]
	call	getKey
	add	sp, 2
	mov	[bp+var_C], ax
	mov	[bp+var_1A], 0
loc_1FC31:
	mov	si, [bp+var_1A]
	cmp	byte ptr [bp+si+var_16], 0
	jz	short loc_1FC7B
	mov	al, byte ptr [bp+si+var_16]
	cbw
	cmp	ax, [bp+var_C]
	jz	short loc_1FC4D
	shl	si, 1
	mov	ax, [bp+var_C]
	cmp	[bp+si+var_30],	ax
	jnz	short loc_1FC76
loc_1FC4D:
	mov	bx, [bp+var_1A]
	shl	bx, 1
	shl	bx, 1
	call	off_47A00[bx]
	or	ax, ax
	jz	short loc_1FC65
	call	text_clear
	jmp	short loc_1FC84
	jmp	short loc_1FC6A
loc_1FC65:
	mov	[bp+var_1C], 0
loc_1FC6A:
	delayNoTable	2
loc_1FC76:
	inc	[bp+var_1A]
	jmp	short loc_1FC31
loc_1FC7B:
	cmp	[bp+var_1C], 0
	jnz	short loc_1FC19
	jmp	loc_1FBF5
loc_1FC84:
	pop	si
	mov	sp, bp
	pop	bp
locret_1FC88:
	retf
bat_doChest endp
