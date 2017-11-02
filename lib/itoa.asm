; Attributes: bp-based frame

itoa proc far

	var_4= word ptr	-4
	var_2= byte ptr	-2
	stringP= dword ptr  6
	inString= dword ptr	 0Ah
	maxDigits= word ptr	 0Eh

	FUNC_ENTER
	CHKSTK(4)
	push	si

	mov	[bp+var_2], 20h	
	cmp	[bp+maxDigits], 0
	jnz	short loc_160A6

	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	NEAR_CALL(_itoa_countDigits, 4)
	mov	[bp+maxDigits], ax

loc_160A6:
	cmp	[bp+inString+2], 0
	jge	short loc_160C3

	mov	ax, word ptr [bp+inString]
	mov	dx, word ptr [bp+inString+2]
	neg	ax
	adc	dx, 0
	neg	dx
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	mov	[bp+var_2], 2Dh	
loc_160C3:
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	CALL(_32bitMod)
	add	al, 30h	
	mov	si, [bp+maxDigits]
	lfs	bx, [bp+stringP]
	mov	fs:[bx+si-1], al
	mov	ax, [bp+maxDigits]
	dec	ax
	mov	[bp+var_4], ax
	jmp	short loc_160EC
loc_160E9:
	dec	[bp+var_4]
loc_160EC:
	cmp	[bp+var_4], 0
	jle	short loc_1613B
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	lea	ax, [bp+inString]
	push	ax
	CALL(_32bitDivide)
	mov	ax, word ptr [bp+inString]
	or	ax, word ptr [bp+inString+2]
	jz	short loc_16128
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	call	_32bitMod
	add	al, 30h	
	mov	si, [bp+var_4]
	lfs	bx, [bp+stringP]
	mov	fs:[bx+si-1], al
	jmp	short loc_16139
loc_16128:
	mov	si, [bp+var_4]
	lfs	bx, [bp+stringP]
	mov	al, [bp+var_2]
	mov	fs:[bx+si-1], al
	mov	[bp+var_2], 20h	
loc_16139:
	jmp	short loc_160E9
loc_1613B:
	cmp	word ptr [bp+inString+2], 0
	jg	short loc_1614F
	jl	short loc_16149
	cmp	word ptr [bp+inString], 0Ah
	jnb	short loc_1614F
loc_16149:
	cmp	[bp+var_2], 2Dh	
	jnz	short loc_16175
loc_1614F:
	mov	[bp+var_4], 0
	jmp	short loc_16159
loc_16156:
	inc	[bp+var_4]
loc_16159:
	mov	ax, [bp+maxDigits]
	cmp	[bp+var_4], ax
	jge	short loc_1616D
	lfs	bx, [bp+stringP]
	inc	word ptr [bp+stringP]
	mov	byte ptr fs:[bx], 2Ah
	jmp	short loc_16156
loc_1616D:
	mov	ax, word ptr [bp+stringP]
	mov	dx, word ptr [bp+stringP+2]
	jmp	short l_return
loc_16175:
	mov	ax, [bp+maxDigits]
	add	ax, word ptr [bp+stringP]
	mov	dx, word ptr [bp+stringP+2]
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
itoa endp

