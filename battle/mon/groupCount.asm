; Attributes: bp-based frame

bat_monGroupCount proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_1DDAD
loc_1DDAA:
	inc	[bp+var_2]
loc_1DDAD:
	cmp	[bp+var_2], 4
	jge	short loc_1DDCE
	getMonP	[bp+var_2], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1DDCC
	mov	ax, [bp+var_2]
	jmp	short loc_1DDD3
loc_1DDCC:
	jmp	short loc_1DDAA
loc_1DDCE:
	mov	ax, 4
	jmp	short $+2
loc_1DDD3:
	mov	sp, bp
	pop	bp
	retf
bat_monGroupCount endp
