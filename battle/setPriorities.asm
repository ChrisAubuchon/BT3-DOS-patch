; Attributes: bp-based frame

bat_setPriorities proc far

	monsterPriorityLo= word ptr	-0Eh
	loopCounter= word ptr	-0Ch
	currentMonster= word ptr	-0Ah
	monsterPriorityHi= word ptr	-8
	monsterGroupSize= word ptr	-6
	summonSlotP= dword ptr -4

	FUNC_ENTER(0Eh)
	push	si

	cmp	gs:partyFrozenFlag, 0
	jz	short l_getCharPriorities

	mov	[bp+loopCounter], 0
l_partyFrozenLoop:
	mov	bx, [bp+loopCounter]
	mov	gs:bat_charPriority[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_partyFrozenLoop
	mov	gs:partyFrozenFlag, 0
	jmp	l_getMonsterPriorities

l_getCharPriorities:
	mov	[bp+loopCounter], 0

l_characterLoop:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_getMonsterPriorities

	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	gs:party.class[si], class_monster
	jb	short l_notSummon
	add	ax, offset party
	mov	word ptr [bp+summonSlotP], ax
	mov	word ptr [bp+summonSlotP+2], seg seg027
	lfs	bx, [bp+summonSlotP]
	mov	al, fs:[bx+18h]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+17h]
	push	ax
	CALL(randomBetweenXandY, near)
	mov	bx, [bp+loopCounter]
	mov	fs:bat_charPriority[bx], al
	jmp	l_characterLoopNext

l_notSummon:
	mov	bx, [bp+loopCounter]
	cmp	gs:g_charActionList[bx], charAction_hide
	jnz	short loc_1C696

	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short l_characterLoopNext

loc_1C696:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	mov	bl, gs:party.class[si]
	sub	bh, bh
	mov	al, byte_475AE[bx]
	mov	bx, [bp+loopCounter]
	mov	gs:bat_charPriority[bx], al
	CALL(random_2d16)
	mov	cx, gs:party.level[si]
	shr	cx, 1
	mov	dl, gs:party.dexterity[si]
	shl	dl, 1
	add	cl, dl
	add	cl, al
	mov	bx, [bp+loopCounter]
	add	gs:bat_charPriority[bx], cl
	mov	bx, [bp+loopCounter]
	cmp	gs:bat_charPriority[bx], 0FFh
	jbe	short l_setMinimumPriority
	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short l_characterLoopNext

l_setMinimumPriority:
	mov	bx, [bp+loopCounter]
	cmp	gs:bat_charPriority[bx], 0
	jnz	short l_characterLoopNext
	mov	gs:bat_charPriority[bx], 1

l_characterLoopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_characterLoop

l_getMonsterPriorities:
	mov	[bp+loopCounter], 0

l_monsterGroupLoop:
	MONINDEX(ax, STACKVAR(loopCounter), si)
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+monsterGroupSize], ax
	or	ax, ax
	jz	short l_monsterGroupNext
	mov	al, gs:monGroups.oppPriorityLo[si]
	sub	ah, ah
	mov	[bp+monsterPriorityLo], ax
	mov	al, gs:monGroups.oppPriorityHi[si]
	mov	[bp+monsterPriorityHi], ax
	mov	[bp+currentMonster], 0

l_monsterLoop:
	push	[bp+monsterPriorityHi]
	push	[bp+monsterPriorityLo]
	CALL(randomBetweenXandY, near)
	mov	bx, [bp+loopCounter]
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+currentMonster]
	shl	cx, 1
	add	bx, cx
	mov	gs:bat_monPriorityList[bx], ax
	inc	[bp+currentMonster]
	mov	ax, [bp+monsterGroupSize]
	cmp	[bp+currentMonster], ax
	jl	short l_monsterLoop

l_monsterGroupNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_monsterGroupLoop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_setPriorities endp
