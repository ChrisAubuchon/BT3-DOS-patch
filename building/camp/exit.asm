; Attributes: bp-based frame

camp_exit	proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	cs
	call	near ptr roster_writeParty
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr saveCharsInf
	add	sp, 2
	push	cs
	call	near ptr roster_countParties
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr savePartiesInf
	add	sp, 2
	mov	byte_4EEBA, 6
	sub	al, al
	mov	levelNoMaybe, al
	mov	gs:isNight, al
	mov	buildingRvalMaybe, 2
	mov	sp, bp
	pop	bp
	retf
camp_exit	endp
