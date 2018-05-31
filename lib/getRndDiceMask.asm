; Attributes: bp-based frame

getRndDiceMask proc far

	var_2= word ptr	-2
	arg_1= byte ptr	 7

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+arg_1], 0
	mov	[bp+var_2], 0
	jmp	short loc_1D2D2
loc_1D2CF:
	inc	[bp+var_2]
loc_1D2D2:
	cmp	[bp+var_2], 8
	jge	short loc_1D2F1
	mov	bx, [bp+var_2]
	mov	al, diceMaskList[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+6],	si
	ja	short loc_1D2EF
	jmp	short loc_1D2FE
loc_1D2EF:
	jmp	short loc_1D2CF
loc_1D2F1:
	mov	ax, offset aBadDiceMaskRange
	push	ds
	push	ax
	call	printMessageAndExit
	add	sp, 4
loc_1D2FE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getRndDiceMask endp
