; This function	prints a group that the	party faces
; in combat. The format	is:
; XX Name (YY')
; Where:
;   XX - Number	of monsters in the group
;   YY - Distance to the group
; Attributes: bp-based frame

bat_monPrintGroup proc far

	groupSize=	word ptr -16h
	unmaskedString=	word ptr -14h
	stringBufferP= dword ptr  6
	slotNumber= word ptr	 0Ah

	FUNC_ENTER(16h)

	MONINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize], ax
	mov	ax, 2
	push	ax
	mov	ax, [bp+groupSize]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	PUSH_STACK_ADDRESS(unmaskedString)
	MONINDEX(ax, STACKVAR(slotNumber), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(unmaskString)
	mov	ax, [bp+groupSize]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_STACK_ADDRESS(unmaskedString)
	PLURALIZE(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ' '
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], '('
	mov	ax, 2
	push	ax
	MONINDEX(ax, STACKVAR(slotNumber), bx)
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
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], 27h
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ')'
	mov	ax, word ptr [bp+stringBufferP]
	mov	dx, word ptr [bp+stringBufferP+2]

	FUNC_EXIT
	retf
bat_monPrintGroup endp
