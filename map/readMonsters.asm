; Attributes: bp-based frame

map_readMonsters	proc far

	var_A= word ptr	-0Ah
	_size= word ptr -8
	var_6= word ptr -6
	var_4= word ptr	-4
	_fd= word ptr	-2
	index= word ptr	 6

	FUNC_ENTER
	CHKSTK(0Ah)

	mov	ax, 480h
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	CALL(memset)
	mov	[bp+_size], 0

	; If the index is the last index in the file, read the full 0x480 bytes.
	; Otherwise, read the index, then read the next index, subtract to get the
	; length of the monster roster for the level.
	;
	cmp	[bp+index], 17
	jz	l_hardcode_size
	cmp	[bp+index], 40
	jnz	l_skip_hardcode

l_hardcode_size:
	mov	[bp+_size], 480h

l_skip_hardcode:
	cmp	[bp+index], 11h
	jge	short loc_17571
	sub	ax, ax
	jmp	short loc_17574
loc_17571:
	mov	ax, 1
loc_17574:
	mov	[bp+var_A], ax
loc_17577:
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (monsterFiles+2)[bx]
	push	word ptr monsterFiles[bx]
	CALL(openFile, 6)
	mov	[bp+_fd], ax
	inc	ax
	jnz	short loc_175C4
	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	mov	bx, [bp+var_A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (disk2+2)[bx]
	push	word ptr disk2[bx]
	PRINTSTRING
	IOWAIT
loc_175C4:
	cmp	[bp+_fd], 0FFFFh
	jz	short loc_17577
	cmp	[bp+var_A], 0
	jz	short loc_175D4
	sub	[bp+index], 11h
loc_175D4:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+index]
	shl	ax, 1
	cwd
	push	dx
	push	ax
	PUSH	[bp+_fd]
	CALL(lseek, 8)

	mov	ax, 2
	push	ax
	PUSH_STACK_ADDRESS(var_4)
	push	[bp+_fd]
	CALL(read)

	cmp	[bp+_size], 0
	jnz	l_read_data

	mov	ax, 2
	push	ax
	PUSH_STACK_ADDRESS(var_6)
	push	[bp+_fd]
	CALL(read)

	mov	ax, [bp+var_6]
	sub	ax, [bp+var_4]
	mov	[bp+_size], ax

l_read_data:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_4]
	cwd
	push	dx
	push	ax
	push	[bp+_fd]
	CALL(lseek, 8)

	push	[bp+_size]
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+_fd]
	CALL(read)

	push	[bp+_fd]
	CALL(close)

	FUNC_EXIT
	retf
map_readMonsters	endp
