; Attributes: bp-based frame

temple_clearStatusAilment proc far

	targetSlotNumber= word ptr	 6
	ailmentIndex= word ptr	 8

	FUNC_ENTER
	CHKSTK

	CHARINDEX(ax, STACKVAR(targetSlotNumber), si)
	mov	bx, [bp+ailmentIndex]
	mov	al, statusHealMask[bx]
	and	gs:party.status[si], al
	mov	gs:party.hostileFlag[si], 0
	mov	ax, [bp+ailmentIndex]
	cmp	ax, 2
	jz	short l_revertAgeStatus

	cmp	ax, 6
	jz	short l_dispossess

	jmp	short l_revertDeath

l_revertAgeStatus:
	CHARINDEX(ax, STACKVAR(targetSlotNumber), si)
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
	jmp	short l_return

l_dispossess:
	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	mov	gs:party.currentHP[bx], 1

l_revertDeath:
	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	cmp	gs:party.currentHP[bx], 0
	jnz	short l_return

	CHARINDEX(ax, STACKVAR(targetSlotNumber), bx)
	mov	gs:party.currentHP[bx], 1

l_return:
	pop	si
	FUNC_EXIT
	retf
temple_clearStatusAilment endp
