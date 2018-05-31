; This function	copies the monster group to a
; different slot and zeroes the	vacated	slot.
; Attributes: bp-based frame

bat_monMoveGroup proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
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
	call	bat_monCopyBuffer
	add	sp, 8
	mov	ax, 40h	
	push	ax
	mov	bx, [bp+arg_0]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+arg_2]
	shl	bx, cl
	lea	ax, monHpList[bx]
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+arg_0]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
bat_monMoveGroup endp
