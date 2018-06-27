; Attributes: bp-based frame
bat_charGetActionOptions proc	far

	arg_0= dword ptr  6
	slotNumber= word ptr	 0Ah

	FUNC_ENTER

	cmp	g_partyAttackFlag, 0
	jnz	short l_noMeleeAttack

	test	gs:monGroups.groupSize,	1Fh
	jz	short l_noMeleeAttack

	cmp	[bp+slotNumber], 4
	jl	short l_meleeOk

	mov	bx, [bp+slotNumber]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jz	short l_noMeleeAttack

l_meleeOk:
	mov	al, 1
	jmp	short l_setAttack

l_noMeleeAttack:
	sub	al, al

l_setAttack:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+characterAction_t.attackOpt], al
	mov	fs:[bx+characterAction_t.defendOpt], 1
	mov	fs:[bx+characterAction_t.partyAttackOpt], 1
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	ax, gs:party.currentSppt[bx]
	lfs	bx, [bp+arg_0]
	or	ax, ax
	jz	l_setCastOption
	mov	al, 1

l_setCastOption:
	mov	fs:[bx+characterAction_t.castOpt], al
	mov	fs:[bx+characterAction_t.useOpt], 1
	mov	bx, [bp+slotNumber]
	cmp	gs:g_characterMeleeDistance[bx], 9
	jnb	short l_noHideOption

	CHARINDEX(ax, bx, bx)
	cmp	gs:party.class[bx], class_rogue
	jnz	short l_noHideOption

	mov	al, 1
	jmp	short l_setHide

l_noHideOption:
	sub	al, al

l_setHide:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+characterAction_t.hideOpt], al
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	cmp	gs:party.class[bx], class_bard
	jnz	short l_noSongOption

	mov	ax, itType_instrument
	push	ax
	push	[bp+slotNumber]
	CALL(character_hasTypeEquipped)
	or	ax, ax
	jz	short l_noSongOption

	mov	al, 1
	jmp	short l_return

l_noSongOption:
	sub	al, al

l_return:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+characterAction_t.songOpt], al
	FUNC_EXIT
	retf
bat_charGetActionOptions endp
