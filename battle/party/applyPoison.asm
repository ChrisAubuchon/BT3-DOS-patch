; Attributes: bp-based frame
bat_partyApplyPoison proc	far

	slotNumber=	word ptr -4
	damageAmount= word ptr	-2

	FUNC_ENTER(4)
	push	si

	mov	bl, g_levelNumber
	sub	bh, bh
	mov	al, poisonDmg[bx]
	cbw
	mov	[bp+damageAmount], ax
	mov	[bp+slotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	test	gs:party.status[si], stat_poisoned
	jz	short l_next

	mov	ax, [bp+damageAmount]
	cmp	gs:party.currentHP[si], ax
	ja	short l_doDamage

	and	gs:party.status[si], 0FEh
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	jmp	short l_next

l_doDamage:
	mov	ax, [bp+damageAmount]
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	sub	gs:party.currentHP[bx], cx

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_partyApplyPoison endp
