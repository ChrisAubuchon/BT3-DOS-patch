; Attributes: bp-based frame

setTitle proc far

	startingColumn= word ptr	-2
	inString= dword ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	sub	ax, ax
	push	ax
	mov	ax, 71h	
	push	ax
	mov	ax, 82h	
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, 12h
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah

	mov	ax, 70h	
	push	ax
	push	[bp+inString]
	NEAR_CALL(centerString, 6)
	mov	[bp+startingColumn], ax
	sub	ax, ax
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, [bp+startingColumn]
	add	ax, 12h
	push	ax
	push	[bp+inString]
	NEAR_CALL(sub_16F1E, 0Ah)

	mov	sp, bp
	pop	bp
	retf
setTitle endp
