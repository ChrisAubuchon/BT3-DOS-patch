; Attributes: bp-based frame

savingThrow_calculate proc far

	saveHi= word ptr	-0Ah
	partySaveValue= word ptr	-8
	saveLo= word ptr	-6
	charP= dword ptr -4
	indexNo= word ptr  6
	savingThrowType= word ptr	 8

	FUNC_ENTER(0Ah)
	push	si

	cmp	[bp+indexNo], 80h
	jl	short l_isPartyMember
	and	[bp+indexNo], 7Fh

	; This block looks to be useless. g_debugSavingThrowValue doesnt have any
	; value besides 0 written to it. Might be a bug.
	cmp	gs:g_debugSavingThrowValue, 0
	jz	short l_enemySave
	mov	al, gs:g_debugSavingThrowValue
	sub	ah, ah
	jmp	l_return

l_enemySave:
	cmp	[bp+savingThrowType], 0

	; FIXED - This was "jz short l_monSpellSave". This matches behavior on the
	; Apple II. The function was using the wrong hi/lo values for spells.
	; This pretty much made the final battles with Rock Demons impossible.
	;
	jnz	short l_monSpellSave
	MONINDEX(ax, STACKVAR(indexNo), si)
	mov	al, gs:g_monGroups.breathSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:g_monGroups.breathSaveHi[si]
	mov	[bp+saveHi], ax
	jmp	short loc_20B8D
l_monSpellSave:
	MONINDEX(ax, STACKVAR(indexNo), si)
	mov	al, gs:g_monGroups.spellSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:g_monGroups.spellSaveHi[si]
	mov	[bp+saveHi], ax
loc_20B8D:
	push	[bp+saveHi]
	push	[bp+saveLo]
	CALL(randomBetweenXandY)
	jmp	l_return

	; This line is unreachable in the code. It might be correct
	; to check for an antimagic square. 
	; jmp	l_antiMagicCheck

l_isPartyMember:
	CHARINDEX(ax, STACKVAR(indexNo), si)
	cmp	gs:party.class[si], class_monster
	jb	short l_partyMemberNotMonster
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	cmp	[bp+savingThrowType], 0
	jnz	short l_partyMonSpellSave
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.breathSaveLo]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, fs:[bx+summonStat_t.breathSaveHi]
	mov	[bp+saveHi], ax
	jmp	short l_partyMonRandomSaveValue
l_partyMonSpellSave:
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.spellSaveLo]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, fs:[bx+summonStat_t.spellSaveHi]
	mov	[bp+saveHi], ax
l_partyMonRandomSaveValue:
	push	[bp+saveHi]
	push	[bp+saveLo]
	CALL(randomBetweenXandY)
	mov	[bp+partySaveValue], ax
	jmp	short l_antiMagicCheck
l_partyMemberNotMonster:
	CHARINDEX(ax, STACKVAR(indexNo), bx)
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	mov	[bp+partySaveValue], ax
	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+indexNo]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jnz	short l_noLuckBonus
	add	[bp+partySaveValue], 2
l_noLuckBonus:
	CHARINDEX(ax, STACKVAR(indexNo), si)
	mov	ax, 41h	
	push	ax
	CALL(randomYdX)
	mov	bl, gs:party.class[si]
	sub	bh, bh
	mov	cl, g_classSaveBonus[bx]
	sub	ch, ch
	mov	dl, gs:party.luck[si]
	sub	dh, dh
	add	cx, dx
	add	cx, ax
	add	[bp+partySaveValue], cx
l_antiMagicCheck:
	mov	al, gs:g_spellAntiMagicValue
	sub	ah, ah
	add	ax, [bp+partySaveValue]
	push	ax
	CALL(lib_maxFF, near)
l_return:
	pop	si
	FUNC_EXIT
	retf
savingThrow_calculate endp
