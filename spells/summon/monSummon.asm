; Attributes: bp-based frame

summon_monSummon proc far

	groupNo= word ptr -6
	skipNoRoomFlag= word ptr	-4
	spellNumber= word ptr	 6

	FUNC_ENTER(6)

	mov	[bp+skipNoRoomFlag], 0

l_entry:
	mov	[bp+groupNo], 0

l_searchForEmptyGroup:
	MONINDEX(ax, STACKVAR(groupNo), bx)
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short l_makeNewMonsterGroup
	inc	[bp+groupNo]
	cmp	[bp+groupNo], 4
	jl	short l_searchForEmptyGroup

l_makeNewMonsterGroup:
	cmp	[bp+groupNo], 4				; If no empty groups,
	jge	short l_findMatchingGroup		;   Try to find a matching group
	push	[bp+groupNo]
	push	[bp+spellNumber]
	CALL(summon_newMonGroup, near)			; Create new group
	push	[bp+groupNo]
	push	[bp+spellNumber]
	CALL(summon_addMonToGroup, near)			; Add monster to group
	or	[bp+skipNoRoomFlag], ax
	jmp	short l_kringleBrosCheck

l_findMatchingGroup:
	cmp	g_curSpellNumber, 77			; Skip if kringle bros spell
	jz	l_printNoRoom

	push	[bp+spellNumber]
	CALL(summon_getMatchMonGroup, near)
	mov	[bp+groupNo], ax
	or	ax, ax
	jl	short l_kringleBrosCheck
	push	ax
	push	[bp+spellNumber]
	CALL(summon_addMonToGroup, near)
	or	[bp+skipNoRoomFlag], ax
	jmp	l_printNoRoom

l_kringleBrosCheck:
	cmp	g_curSpellNumber, 77			; Kringle Bros
	jnz	l_entry

l_printNoRoom:
	push	[bp+skipNoRoomFlag]
	CALL(summon_printNoRoom)
	
l_return:
	FUNC_EXIT
	retf
summon_monSummon endp
