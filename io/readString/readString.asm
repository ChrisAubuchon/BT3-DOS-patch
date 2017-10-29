; Attributes: bp-based frame

readString proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(6)
	push	si

	mov	[bp+var_6], 0
	NEAR_CALL(txt_newLine)
	NEAR_CALL(readString_insertCursor)
loc_15E2D:
	NEAR_CALL(readChNoMouse)
	mov	[bp+var_2], ax
	cmp	ax, 0Dh
	jz	loc_15F0D

	mov	[bp+var_4], ax
	push	ax
	NEAR_CALL(isAlphaNum, 2)
	or	ax, ax
	jnz	short loc_15E6F
	cmp	[bp+var_2], ' '
	jz	short loc_15E6F
	cmp	[bp+var_2], '-'
	jz	short loc_15E6F
	cmp	[bp+var_2], '.'
	jz	short loc_15E6F
	cmp	[bp+var_2], ','
	jz	short loc_15E6F
	cmp	[bp+var_2], ':'
	jz	short loc_15E6F
	cmp	[bp+var_2], '\'
	jnz	short loc_15EAC
loc_15E6F:
	mov	ax, [bp+arg_4]
	cmp	[bp+var_6], ax
	jge	short loc_15EAA
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, byte ptr [bp+var_2]
	mov	fs:[bx+si], al
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	NEAR_CALL(readString_echoChar, 4)
	mov	bx, [bp+var_6]
	inc	[bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	NEAR_CALL(readString_printChar, 2)
	NEAR_CALL(readString_insertCursor)
loc_15EAA:
	jmp	short loc_15F0A
loc_15EAC:
	cmp	[bp+var_2], 8
	jnz	short loc_15EDB
	cmp	[bp+var_6], 0
	jle	short loc_15EDB
	dec	[bp+var_6]
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	NEAR_CALL(txt_charSpacing), 2)
	push	ax
	NEAR_CALL(readString_overwriteCursor, 2)
	NEAR_CALL(readString_insertCursor)
	jmp	short loc_15F0A
loc_15EDB:
	cmp	[bp+var_2], 1Bh
	jnz	short loc_15F0A
loc_15EE1:
	cmp	[bp+var_6], 0
	jle	short loc_15F06
	dec	[bp+var_6]
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	NEAR_CALL(txt_charSpacing, 2)
	push	ax
	NEAR_CALL(readString_overwriteCursor, 2)
	jmp	short loc_15EE1
loc_15F06:
	NEAR_CALL(readString_insertCursor)
loc_15F0A:
	jmp	loc_15E2D

loc_15F0D:
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	byte ptr fs:[bx+si], 0
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	NEAR_CALL(readString_echoChar, 4)
	cmp	[bp+var_6], 0
	jz	short l_returnNull
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short l_return
l_returnNull:
	sub	ax, ax
	cwd
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
readString endp
