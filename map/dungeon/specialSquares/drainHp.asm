; Attributes: bp-based frame

dunsq_drainHp proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)
	push	di
	push	si

	mov	[bp+slotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short l_next
	mov	al, levelNoMaybe
	sub	ah, ah
	mov	di, ax
	cmp	gs:party.currentHP[si], di
	jbe	short l_killCharacter
	sub	gs:party.currentHP[si], di
	jmp	short l_next
l_killCharacter:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	gs:party.currentHP[si], 0
	or	gs:party.status[si], stat_dead
l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	CALL(party_getLastSlot)
	cmp	ax, 7
	jle	short l_return
	mov	buildingRvalMaybe, 5
l_return:
	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax

	pop	si
	pop	di
	FUNC_EXIT
	retf
dunsq_drainHp endp
