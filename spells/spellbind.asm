; Attributes: bp-based frame

sp_spellbind proc far

	partySlotNumber= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(2)
	push	si

	sub	ax, ax
	push	ax
	push	[bp+spellCaster]
	or	ax, ax
	jz	l_printNoEffect

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster

	; Set hostile flag to 0 when cast by party
	sub	al, al
	jmp	short l_setHostileFlag
l_monCaster:
	; Set hostfile flag to 1 when cast by enemy
	mov	al, 1
l_setHostileFlag:
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	gs:party.hostileFlag[bx], cl
	jmp	short l_return
l_monTarget:
	CALL(party_findEmptySlot)
	mov	[bp+partySlotNumber], ax
	cmp	ax, 7
	jge	short l_printNoEffect
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, 30h	
	mul	cx
	mov	si, ax
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short l_printNoEffect

	test	gs:monGroups.flags[si],	10h
	jz	short l_printNoEffect

	dec	gs:monGroups.groupSize[si]
	lea	ax, monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+partySlotNumber]
	CALL(_sp_convertMonToSummon, near)
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_return
l_printNoEffect:
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(printNoEffect, near)
l_return:
	pop	si
	FUNC_EXIT
	retf
sp_spellbind endp

; This function	takes the data from the	mon_t data
; type and converts it to the summonStat_t data	type.
; Attributes: bp-based frame

_sp_convertMonToSummon proc far

	partySlotP=	dword ptr -1Ah
	counter= word ptr -16h
	var_14=	word ptr -14h
	singularName= dword ptr -4
	partySlotNumber= word ptr	 6
	monBufferP= dword ptr  8

	FUNC_ENTER(1Ah)
	push	si

	CHARINDEX(ax, STACKVAR(partySlotNumber))
	add	ax, offset party
	mov	word ptr [bp+partySlotP], ax
	mov	word ptr [bp+partySlotP+2],	seg seg027
	mov	ax, charSize
	push	ax
	sub	ax, ax
	push	ax
	push	word ptr [bp+partySlotP+2]
	push	word ptr [bp+partySlotP]
	CALL(memset)
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	word ptr [bp+monBufferP+2]
	push	word ptr [bp+monBufferP]
	CALL(unmaskString)
	sub	ax, ax
	push	ax
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	PLURALIZE(singularName)
	lfs	bx, [bp+singularName]
	mov	byte ptr fs:[bx], 0
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathSaveLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathSaveLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathSaveHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathSaveHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.oppPriorityLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.priorityLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.oppPriorityHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.priorityHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.picIndex]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.picIndex], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathFlag]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathFlag], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathRange]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathRange], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.toHitLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.toHitLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.toHitHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.toHitHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.spellSaveLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.spellSaveLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.spellSaveHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.spellSaveHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.strongElement]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.strongElement], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.weakElement]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.weakElement], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.repelFlags]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.repelFlags], al
	mov	[bp+counter], 0
l_attackLoopEnter:
	mov	si, [bp+counter]
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+si+mon_t.attackType._type]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+si+summonStat_t.attacks._type], al
	inc	[bp+counter]
	cmp	[bp+counter], 8
	jl	short l_attackLoopExit
	jmp	short l_attackLoopEnter
l_attackLoopExit:
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.packedGenAc]
	and	al, 3Fh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.acBase], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.packedGenAc]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.pronoun], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	mov	cl, 5
	shr	ax, cl
	and	al, 7
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.numAttacks], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 0Fh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.field_5E], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.field_5F], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	inc	cx
	add	cl, 0Dh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.class], cl
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.hpDice]
	sub	ah, ah
	push	ax
	CALL(randomYdX)
	lfs	bx, [bp+monBufferP]
	mov	cx, fs:[bx+mon_t.hpBase]
	add	cx, ax
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.curHP], cx
	lfs	bx, [bp+partySlotP]
	mov	ax, fs:[bx+summonStat_t.curHP]
	mov	fs:[bx+summonStat_t.maxHP], ax
	mov	[bp+counter], 0
l_questFlagLoopEnter:
	mov	si, [bp+counter]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+si+summonStat_t.chronoQuest], 0FFh
	inc	[bp+counter]
	cmp	[bp+counter], 6
	jl	short l_questFlagLoopEnter

	pop	si
	FUNC_EXIT
	retf
_sp_convertMonToSummon endp

