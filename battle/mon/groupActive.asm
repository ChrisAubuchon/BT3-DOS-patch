; Attributes: bp-based frame

bat_monGroupActive proc far

	groupNo= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+groupNo], 0
	jmp	short loc_1F13A
loc_1F137:
	inc	[bp+groupNo]
loc_1F13A:
	cmp	[bp+groupNo], 4
	jge	short loc_1F15B
	getMonP	[bp+groupNo], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1F159
	mov	ax, 1
	jmp	short loc_1F15F
loc_1F159:
	jmp	short loc_1F137
loc_1F15B:
	sub	ax, ax
	jmp	short $+2
loc_1F15F:
	mov	sp, bp
	pop	bp
	retf
bat_monGroupActive endp
