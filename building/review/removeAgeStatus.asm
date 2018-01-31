; Attributes: bp-based frame

review_removeAgeStatus proc far

	savedStatus= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	al, gs:party.status[si]
	sub	ah, ah
	and	ax, 2
	mov	[bp+savedStatus], ax
	or	ax, ax
	jz	short l_return
	mov	ax, 5
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.savedST[si]
	push	dx
	push	ax
	CALL(_doAgeStatus)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	and	gs:party.status[bx], 0FDh

l_return:
	mov	ax, [bp+savedStatus]
	pop	si
	FUNC_EXIT
	retf
review_removeAgeStatus endp
