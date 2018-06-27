; Attributes: bp-based frame

bat_partyDisbelieves proc far

	loopCounter= word ptr -2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 3
l_monsterGroupLoop:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short l_monsterGroupNext

	test	gs:monGroups.flags[si],	mon_isIllusion
	jz	short l_monsterGroupNext

	mov	gs:bat_curTarget, 0
	test	gs:g_disbelieveFlags, disb_disruptill OR disb_disbelieve
	jnz	short l_doDisbelieve

	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	CALL(savingThrowCheck)
	cmp	ax, 2
	jnz	short l_monsterGroupNext

l_doDisbelieve:
	mov	gs:specialAttackVal, specialAttack_stone
	MONINDEX(ax, STACKVAR(loopCounter), bx)
	mov	gs:monGroups.groupSize[bx], 1
	push	[bp+loopCounter]
	CALL(bat_monDamageHp)
	PRINTOFFSET(s_thePartyDisbelieves)
	DELAY

l_monsterGroupNext:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	short l_monsterGroupLoop

l_return:
	and	gs:g_disbelieveFlags, 0FEh
	pop	si
	FUNC_EXIT
	retf
bat_partyDisbelieves endp
