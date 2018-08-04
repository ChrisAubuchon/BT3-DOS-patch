; Attributes: bp-based frame

sp_spellbind proc far

	partySlotNumber= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(2)
	push	si

	sub	ax, ax
	push	ax
	push	[bp+spellCaster]
	or	ax, ax
	jz	l_printNoEffect

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster

	; Set hostile flag to 0 when cast by party
	sub	al, al
	jmp	short l_setHostileFlag
l_monCaster:
	; Set hostfile flag to 1 when cast by enemy
	mov	al, 1
l_setHostileFlag:
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	gs:party.hostileFlag[bx], cl
	jmp	short l_return
l_monTarget:
	CALL(party_findEmptySlot)
	mov	[bp+partySlotNumber], ax
	cmp	ax, 7
	jge	short l_printNoEffect
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, 30h	
	mul	cx
	mov	si, ax
	test	gs:g_monGroups.groupSize[si], 1Fh
	jz	short l_printNoEffect

	test	gs:g_monGroups.flags[si],	10h
	jz	short l_printNoEffect

	dec	gs:g_monGroups.groupSize[si]
	lea	ax, g_monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+partySlotNumber]
	CALL(_sp_convertMonToSummon, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_return
l_printNoEffect:
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(printNoEffect, near)
l_return:
	pop	si
	FUNC_EXIT
	retf
sp_spellbind endp
