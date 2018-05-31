; This function	prints a group that the	party faces
; in combat. The format	is:
; XX Name (YY')
; Where:
;   XX - Number	of monsters in the group
;   YY - Distance to the group
; Attributes: bp-based frame

bat_monPrintGroup proc far

	var_16=	word ptr -16h
	var_14=	word ptr -14h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 16h
	call	someStackOperation
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_16], ax
	mov	ax, 2
	push	ax
	mov	ax, [bp+var_16]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_16]
	dec	ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h ;	' '
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 28h
	mov	ax, 2
	push	ax
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	sub	dx, dx
	mov	cx, ax
	mov	bx, dx
	shl	ax, 1
	rcl	dx, 1
	shl	ax, 1
	rcl	dx, 1
	add	ax, cx
	adc	dx, bx
	shl	ax, 1
	rcl	dx, 1
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 27h
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 29h
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_monPrintGroup endp
