; This function	returns	the difference between the
; players experience points and the requirements
; for the next level.
; Attributes: bp-based frame

review_getXpDelta proc far

	slotNumber= word ptr  6

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.maxLevel[bx]
	or	ax, ax
	jz	short l_levelZero
	dec	ax
	push	ax
	push	[bp+slotNumber]
	CALL(getLevelXp)
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	ax, cx
	mov	dx, bx
	sub	ax, word ptr gs:party.experience[si]
	sbb	dx, word ptr gs:(party.experience+2)[si]
	jmp	short l_return

l_levelZero:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, word ptr gs:party.experience[bx]
	mov	dx, word ptr gs:(party.experience+2)[bx]
	neg	ax
	adc	dx, 0
	neg	dx

l_return:
	pop	si
	FUNC_EXIT
	retf
review_getXpDelta endp
