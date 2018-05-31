; Attributes: bp-based frame

bat_partyAdvanceAction proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1D387
loc_1D384:
	inc	[bp+var_2]
loc_1D387:
	cmp	[bp+var_2], 4
	jge	short loc_1D3A8
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1D3A6
	dec	gs:monGroups.distance[si]
loc_1D3A6:
	jmp	short loc_1D384
loc_1D3A8:
	mov	ax, offset aThePartyAdvances
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 0
	jmp	short loc_1D3BF
loc_1D3BC:
	inc	[bp+var_2]
loc_1D3BF:
	cmp	[bp+var_2], 7
	jge	short loc_1D3D4
	mov	bx, [bp+var_2]
	mov	gs:g_charActionList[bx], 2
	jmp	short loc_1D3BC
loc_1D3D4:
	mov	ax, 1
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_partyAdvanceAction endp
