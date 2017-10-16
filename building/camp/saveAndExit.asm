; Attributes: bp-based frame

camp_saveAndExit proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aPressReturnToS
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr roster_writeParty
	sub	ax, ax
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 0Dh
	jnz	short loc_13412
	mov	buildingRvalMaybe, 0FFh
	push	cs
	call	near ptr countSavedChars
	push	ax
	push	cs
	call	near ptr saveCharsInf
	add	sp, 2
	push	cs
	call	near ptr roster_countParties
	push	ax
	push	cs
	call	near ptr savePartiesInf
	add	sp, 2
loc_13412:
	call	clearTextWindow
	mov	sp, bp
	pop	bp
	retf
camp_saveAndExit endp
