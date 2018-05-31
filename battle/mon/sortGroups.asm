; Attributes: bp-based frame

bat_monSortGroups proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
loc_1C9E5:
	mov	[bp+var_4], 0
	mov	[bp+var_2], 3
	jmp	short loc_1C9F4
loc_1C9F1:
	dec	[bp+var_2]
loc_1C9F4:
	cmp	[bp+var_2], 0
	jle	short loc_1CA37
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1CA35
	mov	al, gs:monGroups.distance[si]-30h
	and	al, 0Fh
	mov	cl, gs:monGroups.distance[si]
	and	cl, 0Fh
	cmp	al, cl
	jbe	short loc_1CA35
	mov	[bp+var_4], 1
	mov	ax, [bp+var_2]
	dec	ax
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_monSwapGroups
	add	sp, 4
loc_1CA35:
	jmp	short loc_1C9F1
loc_1CA37:
	cmp	[bp+var_4], 0
	jnz	short loc_1C9E5
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monSortGroups endp
