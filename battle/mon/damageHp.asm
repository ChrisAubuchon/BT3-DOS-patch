; Attributes: bp-based frame

bat_monDamageHp proc far

	monNo= word ptr	-4
	groupSize= word	ptr -2
	groupNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	or	ax, ax
	jnz	short loc_1E3E1
	sub	ax, ax
	jmp	short loc_1E459
loc_1E3E1:
	mov	[bp+monNo], 0
	jmp	short loc_1E3EB
loc_1E3E8:
	inc	[bp+monNo]
loc_1E3EB:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E41E
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	test	byte ptr gs:bat_monBeenHitList[bx], 1
	jz	short loc_1E41C
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monApplySpecialEffect
	add	sp, 4
	jmp	short loc_1E459
loc_1E41C:
	jmp	short loc_1E3E8
loc_1E41E:
	mov	[bp+monNo], 0
	jmp	short loc_1E428
loc_1E425:
	inc	[bp+monNo]
loc_1E428:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E44A
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	or	byte ptr gs:bat_monBeenHitList[bx], 1
	jmp	short loc_1E425
loc_1E44A:
	sub	ax, ax
	push	ax
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monApplySpecialEffect
	add	sp, 4
	jmp	short $+2
loc_1E459:
	mov	sp, bp
	pop	bp
	retf
bat_monDamageHp endp

