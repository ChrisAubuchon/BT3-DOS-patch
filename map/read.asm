; Attributes: bp-based frame

map_read proc far

	var_E= word ptr	-0Eh
	memOffset= word	ptr -0Ch
	memSegment= word ptr -0Ah
	var_6= word ptr	-6
	fd= word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(0Eh)

	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	al, byte ptr levelPathTable.fileType[bx]
	sub	ah, ah
	mov	[bp+var_E], ax
loc_173AD:
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (disk3+2)[bx]
	push	word ptr disk3[bx]
	CALL(open)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_173FA
	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	PRINTSTRING
	IOWAIT
loc_173FA:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_173AD
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	al, levelPathTable.fileIndexMaybe[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	shl	ax, 1
	cwd
	push	dx
	push	ax
	push	[bp+fd]
	CALL(lseek)
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_6]
	push	ss
	push	ax
	push	[bp+fd]
	CALL(read)
	mov	ax, 0FFFFh
	push	ax
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+fd]
	CALL(lseek)
	mov	ax, 4000
	push	ax
	CALL(_mallocMaybe)
	mov	[bp+memOffset],	ax
	mov	[bp+memSegment], dx
	mov	ax, 4000
	push	ax
	push	dx
	push	[bp+memOffset]
	push	[bp+fd]
	CALL(read)

	push	[bp+arg_4]
	push	[bp+arg_2]
	push	[bp+memSegment]
	push	[bp+memOffset]
	CALL(d3comp)

	push	[bp+memSegment]
	push	[bp+memOffset]
	CALL(_freeMaybe)
	push	[bp+fd]
	CALL(close)

	FUNC_EXIT
	retf
map_read endp
