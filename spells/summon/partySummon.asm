; Attributes: bp-based frame

summon_partySummon proc far

	skipNoRoomFlag= word ptr	-4
	emptySlot= word ptr	-2
	summonIndex= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+skipNoRoomFlag], 0
l_loop:
	CALL(party_findEmptySlot)
	mov	[bp+emptySlot], ax
	cmp	ax, 7
	jge	short l_noRoom
	mov	ax, [bp+summonIndex]
	and	ax, 1Fh
	MONINDEX(cx, cx)
	add	ax, offset summonData
	push	ds
	push	ax
	push	[bp+emptySlot]
	CALL(_sp_convertMonToSummon)
	test	byte ptr [bp+summonIndex], 80h
	jz	short loc_25EF8
	mov	al, class_illusion
	jmp	short loc_25EFA
loc_25EF8:
	mov	al, class_monster
loc_25EFA:
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(emptySlot), bx)
	mov	gs:party.class[bx], cl
	mov	byte ptr g_printPartyFlag, 0
	mov	[bp+skipNoRoomFlag], 1
	cmp	g_curSpellNumber, 77			; Kringle Bros spell
	jz	short l_loop

l_noRoom:
	push	[bp+skipNoRoomFlag]
	CALL(summon_printNoRoom, near)

l_return:
	FUNC_EXIT
	retf
summon_partySummon endp

