; Attributes: bp-based frame

bat_monCountGroups proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 3
	jmp	short loc_1EFCF
loc_1EFCC:
	dec	[bp+var_2]
loc_1EFCF:
	cmp	[bp+var_2], 0
	jl	short loc_1EFF0
	getMonP	[bp+var_2], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1EFEE
	mov	ax, [bp+var_2]
	jmp	short loc_1EFF5
loc_1EFEE:
	jmp	short loc_1EFCC
loc_1EFF0:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_1EFF5:
	mov	sp, bp
	pop	bp
	retf
bat_monCountGroups endp
