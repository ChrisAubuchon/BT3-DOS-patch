; Attributes: bp-based frame

bigpic_drawPictureNumber proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	fd= word ptr -4
	var_2= word ptr	-2
	indexNo= word ptr  6

	FUNC_ENTER(0Eh)
	push	si

	cmp	[bp+indexNo], 0FEh
	jnz	short loc_171CF
	mov	ax, 7
	push	ax
	mov	ax, 66h	
	push	ax
	mov	ax, 7Fh	
	push	ax
	mov	ax, 0Fh
	push	ax
	mov	ax, 11h
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	jmp	l_return
loc_171CF:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	mov	bx, [bp+indexNo]
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_171E7
	xor	byte ptr bigpicIndexMultiplier, 3
loc_171E7:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_17206
	PUSH_OFFSET(s_getPictureError)
	PRINTSTRING
	jmp	l_return

loc_17206:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	mov	bx, [bp+indexNo]
	mov	al, bigpicIndex[bx+si-58h]
	sub	ah, ah
	mov	[bp+var_2], ax

loc_1721B:
	sub	ax, ax
	push	ax
	mov	bx, bigpicIndexMultiplier
	shl	bx, 1
	shl	bx, 1
	push	word ptr lowPic[bx-2]
	push	word ptr lowPic[bx-4]
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_1726A
	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	mov	bx, bigpicIndexMultiplier
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	PRINTSTRING
	IOWAIT
loc_1726A:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1721B
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	shl	ax, 1
	shl	ax, 1
	sub	cx, cx
	push	cx
	push	ax
	push	[bp+fd]
	CALL(lseek)
	mov	ax, 4
	push	ax
	PUSH_STACK_ADDRESS(var_8)
	push	[bp+fd]
	CALL(read)
	mov	ax, 0FFFFh
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	[bp+fd]
	CALL(lseek)
	mov	ax, 19712
	push	ax
	CALL(_mallocMaybe)
	mov	[bp+var_E], ax
	mov	[bp+var_C], dx
	mov	ax, 19712
	push	ax
	push	dx
	push	[bp+var_E]
	push	[bp+fd]
	CALL(read)
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	push	[bp+var_C]
	push	[bp+var_E]
	CALL(d3cmp_flate)
	push	[bp+var_C]
	push	[bp+var_E]
	CALL(_freeMaybe)
	push	[bp+fd]
	CALL(close)
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	CALL(bigpic_configureCells, near)
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	call	far ptr	vid_drawBigpic
	add	sp, 8
	cmp	[bp+indexNo], 53
	jz	short loc_1734A
	mov	al, 1
	jmp	short loc_1734C
loc_1734A:
	sub	al, al
loc_1734C:
	mov	gs:byte_422A0, al
	mov	gs:bigpicCellNumber, 0
	sub	ax, ax
	jmp	short $+2
l_return:
	pop	si
	FUNC_EXIT
	retf
bigpic_drawPictureNumber endp
