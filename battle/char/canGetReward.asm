; Attributes: bp-based frame
bat_charCanGetReward proc	far

	slotNumber= word ptr	 6

	FUNC_ENTER
	push	si

	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_returnZero

	cmp	gs:party.class[si], class_monster
	jnb	short l_returnZero

	mov	al, gs:party.status[si]
	and	al, stat_dead or stat_stoned or	stat_paralyzed
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charCanGetReward endp
