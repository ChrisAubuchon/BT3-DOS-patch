; Attributes: bp-based frame

spellSavingThrowHelper proc far

        spellCaster= word ptr  6

	FUNC_ENTER

        cmp     [bp+spellCaster], 80h
        jl      short l_partyCaster

        mov     gs:bat_curTarget, 0		; Saving throw target is first party slot
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	CALL(savingThrowCheck, near)
        or      ax, ax
        jnz     short l_firstCharFailedSave
        sub     ax, ax
        jmp     short l_return
l_firstCharFailedSave:
        cmp     gs:partySecondSlot._name, 0
        jnz     short l_secondCharExists
        mov     ax, 1
        jmp     short l_return
l_secondCharExists:
        mov     gs:bat_curTarget, 1
l_partyCaster:
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	CALL(savingThrowCheck, near)
l_return:
	FUNC_EXIT
        retf
spellSavingThrowHelper endp

; Attributes: bp-based frame

; Returns:
;   0 - saving throw succeeded
;   1 - saving throw failed
;   2 - saving throw failed badly
;

savingThrowCheck proc far

	targetSaveValue= word ptr	-6
	sourceSaveValue= word ptr	-4
	saveDifference= word ptr	-2
	saveSource= word ptr	 6
	saveType= word ptr	 8

	FUNC_ENTER(6)

	sub	ax, ax
	push	ax
	push	[bp+saveSource]
	CALL(_savingThrowCheck, near)
	mov	[bp+sourceSaveValue], ax

	mov	gs:byte_4228E, 0			; Doesnt seem to do anything

	push	[bp+saveType]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	CALL(_savingThrowCheck, near)
	mov	[bp+targetSaveValue], ax

	; Always seems to be zero. byte_41E63 isnt set anywhere
	mov	al, gs:byte_41E63
	sub	ah, ah

	add	ax, [bp+targetSaveValue]
	push	ax
	CALL(lib_maxFF, near)
	mov	[bp+targetSaveValue], ax
	mov	gs:byte_41E63, 0
	mov	ax, [bp+sourceSaveValue]
	sub	ax, [bp+targetSaveValue]
	mov	[bp+saveDifference], ax
	or	ax, ax
	jge	short l_saveFailed
	sub	ax, ax
	jmp	short l_return
l_saveFailed:
	cmp	[bp+saveDifference], 4
	jle	short l_return_one
	mov	ax, 2
	jmp	short l_return
l_return_one:
	mov	ax, 1
l_return:
	FUNC_EXIT
	retf
savingThrowCheck endp

; Attributes: bp-based frame

_savingThrowCheck proc far

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

	; This block looks to be useless. byte_4228E doesnt have any
	; value besides 0 written to it. Might be a bug.
	cmp	gs:byte_4228E, 0
	jz	short l_enemySave
	mov	al, gs:byte_4228E
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
	mov	al, gs:monGroups.breathSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:monGroups.breathSaveHi[si]
	mov	[bp+saveHi], ax
	jmp	short loc_20B8D
l_monSpellSave:
	MONINDEX(ax, STACKVAR(indexNo), si)
	mov	al, gs:monGroups.spellSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:monGroups.spellSaveHi[si]
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
	mov	cl, classSavingBonus[bx]
	sub	ch, ch
	mov	dl, gs:party.luck[si]
	sub	dh, dh
	add	cx, dx
	add	cx, ax
	add	[bp+partySaveValue], cx
l_antiMagicCheck:
	mov	al, gs:antiMagicFlag
	sub	ah, ah
	add	ax, [bp+partySaveValue]
	push	ax
	CALL(lib_maxFF, near)
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_savingThrowCheck endp
