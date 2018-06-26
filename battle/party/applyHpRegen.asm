; Attributes: bp-based frame

bat_partyApplyHpRegen proc far

	loopCounter= word ptr	-2
	regenAmount= word ptr	 6

	FUNC_ENTER(2)
	push	si

	cmp	[bp+regenAmount], 0
	jz	short l_return

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short l_checkMax
	mov	ax, [bp+regenAmount]
	add	gs:party.currentHP[si], ax

l_checkMax:
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	jbe	short l_next
	mov	gs:party.currentHP[si], ax
l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

	mov	byte ptr g_printPartyFlag,	0
l_return:
	pop	si
	FUNC_EXIT
	retf
bat_partyApplyHpRegen endp
