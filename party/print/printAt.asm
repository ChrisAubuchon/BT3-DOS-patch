; Attributes: bp-based frame

party_printAt proc far

	inString= dword ptr	 6
	column= word ptr	 0Ah
	slotNumber= word ptr	 0Ch
	colorFlag= word ptr	 0Eh

	FUNC_ENTER
	CHKSTK

	cmp	[bp+colorFlag], 1
	sbb	ax, ax
	neg	ax
	push	ax
	mov	ax, [bp+slotNumber]
	mov	cl, 3
	shl	ax, cl
	add	ax, 90h	
	push	ax
	mov	ax, [bp+column]
	shl	ax, cl
	add	ax, 0Ch
	push	ax
	push	[bp+inString]
	CALL(printAt, near)

	FUNC_EXIT
	retf
party_printAt endp
