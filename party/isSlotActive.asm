; This function	returns	0 if the roster	slot at	slotNo
; is empty, field_67 !=	0, or field_2d & 1c
; Attributes: bp-based frame

party_isSlotActive proc	far

	slotNo=	word ptr  6

	FUNC_ENTER
	CHKSTK
	CHARINDEX(ax, STACKVAR(slotNo), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNo), bx)
	cmp	gs:(party.specAbil+3)[bx], 0
	jnz	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNo), bx)
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
party_isSlotActive endp
