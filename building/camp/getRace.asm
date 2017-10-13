; Attributes: bp-based frame

getCharacterRace proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
l_ioLoopEntry:
	mov	ax, offset aSelectARaceFor
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 1FCh
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 1Bh
	jnz	short l_checkMouse
	mov	ax, 0FFh
	jmp	short l_return
l_checkMouse:
	cmp	[bp+var_2], 10Fh
	jle	short l_checkKey
	cmp	[bp+var_2], 117h
	jge	short l_checkKey
	mov	ax, [bp+var_2]
	sub	ax, 110h
	jmp	short l_return
l_checkKey:
	cmp	[bp+var_2], 30h	
	jle	short l_ioLoopEntry
	cmp	[bp+var_2], 38h	
	jge	short l_ioLoopEntry
	mov	ax, [bp+var_2]
	sub	ax, 31h	
l_return:
	mov	sp, bp
	pop	bp
	retf
getCharacterRace endp
