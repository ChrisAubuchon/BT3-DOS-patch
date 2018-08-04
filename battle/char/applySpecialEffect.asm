; Attributes: bp-based frame

bat_charApplySpecialEffect proc far

	loopCounter= word ptr	-2
	charNo=	word ptr  6

	FUNC_ENTER(2)
	push	si

	mov	ax, gs:g_specialAttackValue
	cmp	ax, 9
	ja	l_returnZero
	add	ax, ax
	xchg	ax, bx
	jmp	cs:l_offsetTable[bx]

l_offsetTable	dw offset l_returnZero
		dw offset l_poisonAttack
		dw offset l_levelDrainAttack
		dw offset l_nutsAttack
		dw offset l_ageAttack
		dw offset l_possessAttack
		dw offset l_stoneAttack
		dw offset l_criticalAttack
		dw offset l_unequipAttack
		dw offset consumeSppt

l_poisonAttack:
	CHARINDEX(ax, STACKVAR(charNo), bx)
	or	gs:party.status[bx], stat_poisoned
	jmp	l_returnOne

l_levelDrainAttack:
	CHARINDEX(ax, STACKVAR(charNo), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	l_returnZero

	CHARINDEX(ax, STACKVAR(charNo), bx)
	cmp	gs:party.level[bx], 1
	jbe	short l_setXp

	CHARINDEX(ax, STACKVAR(charNo), bx)
	dec	gs:party.level[bx]

l_setXp:
	CHARINDEX(ax, STACKVAR(charNo), si)
	mov	ax, gs:party.level[si]
	dec	ax
	push	ax
	push	[bp+charNo]
	CALL(getLevelXp)
	cwd
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	jmp	l_returnOne

l_nutsAttack:
	CHARINDEX(ax, STACKVAR(charNo), bx)
	or	gs:party.status[bx], stat_nuts
	jmp	l_returnOne

l_ageAttack:
	CHARINDEX(ax, STACKVAR(charNo), bx)
	cmp	gs:party.class[bx], class_monster
	jnb	l_returnZero

	CHARINDEX(ax, STACKVAR(charNo), bx)
	test	gs:party.status[bx], stat_old
	jnz	l_returnZero

	CHARINDEX(ax, STACKVAR(charNo), si)
	mov	ax, 5
	push	ax
	lea	ax, party.savedST[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.strength[si]
	push	dx
	push	ax
	CALL(character_applyAgeStatus, near)
	CHARINDEX(ax, STACKVAR(charNo), bx)
	or	gs:party.status[bx], stat_old
	jmp	l_returnOne

l_possessAttack:
	CHARINDEX(ax, STACKVAR(charNo), si)
	mov	gs:party.currentHP[si], 64h 
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	jmp	l_returnOne

l_stoneAttack:
	CHARINDEX(ax, STACKVAR(charNo), si)
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	or	gs:party.status[si], stat_stoned
	jmp	l_returnOne

l_criticalAttack:
	CHARINDEX(ax, STACKVAR(charNo), si)
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	jmp	l_returnOne

l_unequipAttack:
	mov	[bp+loopCounter], 0

l_unequipLoop:
	CHARINDEX(ax, STACKVAR(charNo), si)
	add	si, [bp+loopCounter]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	bx, ax
	cmp	itemTypeList[bx], 1
	jnz	short l_unequipLoopNext

	and	gs:party.inventory.itemFlags[si], 0FCh

l_unequipLoopNext:
	add	[bp+loopCounter], 3
	cmp	[bp+loopCounter], 24h	
	jl	short l_unequipLoop
	jmp	short l_returnOne

consumeSppt:
	CHARINDEX(ax, STACKVAR(charNo), bx)
	mov	gs:party.currentSppt[bx], 0

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charApplySpecialEffect endp
