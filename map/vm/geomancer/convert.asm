; Attributes: bp-based frame
geomancer_convert proc	far

	slotNumber=	word ptr  6

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	gs:party.class[si], class_geomancer
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	gs:party.level[si], 1
	mov	gs:party.maxLevel[si],	1
	mov	gs:party.currentSppt[si], 25
	mov	gs:party.maxSppt[si], 25
	mov	ax, 0Ch
	push	ax
	push	[bp+slotNumber]
	CALL(geomancer_convertEquipment, near)
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	gs:party.numAttacks[bx], 0
	mov	ax, 106
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	mov	ax, 107
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	mov	ax, 108
	push	ax
	push	[bp+slotNumber]
	CALL(character_learnSpell)
	mov	byte ptr g_printPartyFlag,	0

	pop	si
	FUNC_EXIT
	retf
geomancer_convert endp
