; Attributes: bp-based frame

chest_trapStrcmp proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1FB2D
loc_1FB2A:
	inc	[bp+var_2]
loc_1FB2D:
	cmp	[bp+var_2], 28h	
	jge	short loc_1FB80
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	or	ax, cx
	jnz	short loc_1FB4F
	mov	ax, 1
	jmp	short loc_1FB85
loc_1FB4F:
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	call	toUpper
	add	sp, 2
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	push	ax
	mov	si, cx
	call	toUpper
	add	sp, 2
	cmp	ax, si
	jz	short loc_1FB7E
	sub	ax, ax
	jmp	short loc_1FB85
loc_1FB7E:
	jmp	short loc_1FB2A
loc_1FB80:
	mov	ax, 1
	jmp	short $+2
loc_1FB85:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_trapStrcmp endp

