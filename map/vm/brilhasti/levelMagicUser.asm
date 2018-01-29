; Attributes: bp-based frame

brilhasti_levelMagicUser proc far

	spellIndex= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)
	push	si

	mov	[bp+spellIndex], 0
l_loop:
	push	[bp+spellIndex]
	push	[bp+slotNumber]
	CALL(mage_learnSpell)
	inc	[bp+spellIndex]
	cmp	[bp+spellIndex], 74
	jl	short l_loop

loc_254C9:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	gs:party.class[si], class_archmage
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	ax, 14h
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(brilhasti_setAttributes, near)

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.maxHP[bx], 375
	jnb	short l_setSppt
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	gs:party.maxHP[bx], 375

l_setSppt:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.maxSppt[bx], 350
	jnb	short l_return
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	gs:party.maxSppt[bx], 350

l_return:
	pop	si
	FUNC_EXIT
	retf
brilhasti_levelMagicUser endp
