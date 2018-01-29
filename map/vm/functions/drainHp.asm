; Attributes: bp-based frame

mfunc_drainHp proc far

	slotNumber= word ptr	-4
	drainAmount= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(4)
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+drainAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+drainAmount], ax
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, [bp+drainAmount]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.currentHP[bx], cx
	jbe	short l_killCharacter
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	gs:party.currentHP[bx], cx
	jmp	short l_next

l_killCharacter:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	gs:party.currentHP[si], 0
	or	gs:party.status[si], 4

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop
	CALL(party_getLastSlot)
	cmp	ax, 7
	jle	short l_return
	mov	buildingRvalMaybe, gameState_partyDied

l_return:
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	FUNC_EXIT
	retf
mfunc_drainHp endp
