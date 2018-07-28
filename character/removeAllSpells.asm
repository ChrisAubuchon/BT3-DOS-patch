; Attributes: bp-based frame

character_removeAllSpells proc far

	loopCounter= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)
	mov	[bp+loopCounter], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+loopCounter]
	mov	gs:party.spells[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Eh
	jl	short l_loop

	FUNC_EXIT
	retf
character_removeAllSpells endp
