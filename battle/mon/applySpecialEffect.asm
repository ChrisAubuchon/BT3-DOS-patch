; Attributes: bp-based frame

bat_monApplySpecialEffect proc far

	var_4= dword ptr -4
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	and	gs:bat_monBeenHitList[bx], 0FEh
	cmp	gs:specialAttackVal, specialAttack_stone
	jz	short loc_1E495
	cmp	gs:specialAttackVal, specialAttack_critical
	jnz	short loc_1E4A7
loc_1E495:
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monKill
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4A7:
	mov	ax, [bp+groupNo]
	mov	cl, 6
	shl	ax, cl
	mov	cx, [bp+monNo]
	shl	cx, 1
	add	ax, cx
	add	ax, offset g_monHpList
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	mov	ax, gs:g_damageAmount
	lfs	bx, [bp+var_4]
	sub	fs:[bx], ax
	lfs	bx, [bp+var_4]
	cmp	word ptr fs:[bx], 0
	jg	short loc_1E4E9
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monKill
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4E9:
	sub	ax, ax
	jmp	short $+2
loc_1E4ED:
	mov	sp, bp
	pop	bp
	retf
bat_monApplySpecialEffect endp
