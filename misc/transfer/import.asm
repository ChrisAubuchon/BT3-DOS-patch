; Attributes: bp-based frame

importCharacter	proc far

	var_1F0= dword ptr -1F0h
	var_1EC= word ptr -1ECh
	var_1EA= word ptr -1EAh
	var_1E8= word ptr -1E8h
	var_1E6= word ptr -1E6h
	var_1E0= word ptr -1E0h
	var_1C2= word ptr -1C2h
	var_1AE= word ptr -1AEh
	var_17C= word ptr -17Ch
	var_178= word ptr -178h
	var_176= word ptr -176h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	arg_0= word ptr	 6

	FUNC_ENTER(1F0h)
	push	si

	mov	ax, 2BF2h
	push	ax
	CALL(_mallocMaybe)
	mov	[bp+var_1EC], ax
	mov	[bp+var_1EA], dx
	mov	word ptr [bp+var_1F0], ax
	mov	word ptr [bp+var_1F0+2], dx
loc_268AD:
	PUSH_OFFSET(s_diskToTransferFrom)
	PRINTSTRING(true)
	lea	ax, [bp+var_1AE]
	mov	[bp+var_24], ax
	mov	[bp+var_22], ss
	mov	ax, 18h
	push	ax
	PUSH_STACK_ADDRESS(var_1E)
	CALL(readString)
	or	ax, ax
	jz	short loc_268F2
	PUSH_STACK_ADDRESS(var_1E)
	push	[bp+var_22]
	push	[bp+var_24]
	CALL(strcat)
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
loc_268F2:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (oldCharFilters+2)[bx]
	push	word ptr oldCharFilters[bx]
	push	[bp+var_22]
	push	[bp+var_24]
	CALL(strcat)
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	PUSH_STACK_ADDRESS(var_1E0)
	PUSH_STACK_ADDRESS(var_1AE)
	CALL(findFirstFile)
	or	ax, ax
	jnz	short loc_26965

	PUSH_OFFSET(s_noCharactersFoundOn)
	PRINTSTRING(true)
	PUSH_STACK_ADDRESS(var_1AE)
	PRINTSTRING
	sub	ax, ax
	push	ax
	CALL(getKey)
	mov	[bp+var_20], ax
	cmp	ax, dosKeys_ESC
	jz	l_return
	jmp	loc_268AD

loc_26965:
	mov	[bp+var_1E8], 0
loc_2696B:
	PUSH_STACK_ADDRESS(var_1E)
	PUSH_STACK_ADDRESS(var_1AE)
	CALL(strcat)
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	PUSH_STACK_ADDRESS(var_1C2)
	push	dx
	push	[bp+var_24]
	CALL(strcat)
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	sub	ax, ax
	push	ax
	PUSH_STACK_ADDRESS(var_1AE)
	CALL(open)
	mov	[bp+var_17C], ax
	inc	ax
	jz	short loc_26A01
	mov	ax, 81h	
	push	ax
	push	word ptr [bp+var_1F0+2]
	push	word ptr [bp+var_1F0]
	push	[bp+var_17C]
	CALL(read)
	lfs	bx, [bp+var_1F0]
	cmp	byte ptr fs:[bx+10h], 1
	jnz	short loc_269F5
	mov	si, [bp+var_1E8]
	inc	[bp+var_1E8]
	shl	si, 1
	shl	si, 1
	mov	ax, bx
	mov	dx, fs
	mov	[bp+si+var_178], ax
	mov	[bp+si+var_176], dx
	add	word ptr [bp+var_1F0], 96h 
loc_269F5:
	push	[bp+var_17C]
	CALL(close)
loc_26A01:
	CALL(findNextFile)
	or	ax, ax
	jnz	loc_2696B

loc_26A0D:
	push	[bp+var_1E8]
	PUSH_STACK_ADDRESS(var_178)
	PUSH_OFFSET(s_whoShallTransfer)
	CALL(text_scrollingWindow)
	mov	[bp+var_1E6], ax
	or	ax, ax
	jge	short loc_26A3E
	push	[bp+var_1EA]
	push	[bp+var_1EC]
	CALL(_freeMaybe)
	jmp	short l_return
loc_26A3E:
	cmp	[bp+arg_0], 0
	jz	short loc_26A5D
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	push	cs
	CALL(transfer_bt2Character, near)
	add	sp, 4
	jmp	short loc_26A74
loc_26A5D:
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	CALL(transfer_bt1Character, near)
loc_26A74:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(transfer_bt3Character, near)
	jmp	short loc_26A0D
l_return:
	pop	si
	FUNC_EXIT
	retf
importCharacter	endp
