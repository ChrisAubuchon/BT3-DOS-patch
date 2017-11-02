; Attributes: bp-based frame

party_clearAndPrintLine proc far

	var_2= word ptr	-2
	inString= dword ptr	 6
	partySlotNumber= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(2)

	mov	ax, [bp+partySlotNumber]
	mov	cl, 3
	shl	ax, cl
	mov	[bp+var_2], ax
	mov	ax, 7
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 97h	
	push	ax
	mov	ax, 13Ah
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 90h	
	push	ax
	mov	ax, 0Bh
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	ax, 1
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 90h	
	push	ax
	mov	ax, 0Ch
	push	ax
	push	[bp+inString]
	CALL(writeStringAt, near)

	FUNC_EXIT
	retf
party_clearAndPrintLine endp
