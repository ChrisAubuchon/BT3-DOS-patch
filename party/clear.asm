; Attributes: bp-based frame

party_clear proc far

	slotNo=	word ptr -2

	FUNC_ENTER(2)

	CALL(roster_writeParty)
	mov	[bp+slotNo], 0
l_loopEnter:
	CHARINDEX(ax, STACKVAR(slotNo), bx)
	mov	byte ptr gs:party._name[bx], 0
	inc	[bp+slotNo]
	cmp	[bp+slotNo], 7
	jl	short l_loopEnter

	FUNC_EXIT
	retf
party_clear endp
