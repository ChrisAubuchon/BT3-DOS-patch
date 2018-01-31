; Attributes: bp-based frame

review_resetAgeStatus proc far

	slotNumber=	word ptr  6

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	ax, 5
	push	ax
	lea	ax, party.savedST[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.strength[si]
	push	dx
	push	ax
	CALL(_doAgeStatus)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	or	gs:party.status[bx], stat_old
	pop	si
	FUNC_EXIT
	retf
review_resetAgeStatus endp
