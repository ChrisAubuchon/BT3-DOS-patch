; Attributes: bp-based frame

bat_setBigpic proc far

	var_26=	word ptr -26h
	var_24=	dword ptr -24h
	var_20=	word ptr -20h
	var_10=	word ptr -10h

	push	bp
	mov	bp, sp
	mov	ax, 26h	
	call	someStackOperation
	mov	al, gs:monGroups.groupSize
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_26], ax
	or	ax, ax
	jnz	short loc_1CDC3
	mov	ax, 21h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aParty
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_1CE1C
loc_1CDC3:
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	mov	ax, offset monGroups
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_26]
	dec	ax
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2],	dx
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	al, gs:monGroups.picIndex
	sub	ah, ah
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
loc_1CE1C:
	mov	sp, bp
	pop	bp
	retf
bat_setBigpic endp
