; Attributes: bp-based frame

party_update proc far

	slotNumber=	word ptr -2

	FUNC_ENTER(2)

	mov	[bp+slotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_next
	push	[bp+slotNumber]
	CALL(character_update, near)

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	FUNC_EXIT
	retf
party_update endp
