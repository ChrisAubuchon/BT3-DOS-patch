; Attributes: bp-based frame

brilhasti_checkQuest proc far

	slotNumber= word ptr	 6

	FUNC_ENTER

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	test	gs:(party.chronoQuest+1)[bx], 1
	jnz	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	short l_returnZero

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.level[bx], 35
	jnb	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
brilhasti_checkQuest endp
