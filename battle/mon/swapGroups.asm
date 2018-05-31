; Attributes: bp-based frame

bat_monSwapGroups proc far

	var_40=	word ptr -40h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 40h
	call	someStackOperation
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_0]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, cl
	lea	ax, monHpList[bx]
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_monSwapGroups endp
