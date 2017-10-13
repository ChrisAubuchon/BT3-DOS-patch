; This function	prints a string	with a number in
; front	of it. e.g. 1) Wizard
; Attributes: bp-based frame

printListItem proc far

	stringBuf=	word ptr -2Ch
	stringBufP= dword ptr -4
	indexNumber= byte ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2Ch	
	call	someStackOperation
	lea	ax, [bp+stringBuf]
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], ss
	lfs	bx, [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	al, [bp+indexNumber]
	add	al, '1'
	mov	fs:[bx], al
	lfs	bx, [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	byte ptr fs:[bx], ')'
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	call	_strcat
	add	sp, 8
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printListItem endp
