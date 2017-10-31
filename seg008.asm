; Segment type:	Pure code
seg008 segment byte public 'CODE' use16
	assume cs:seg008
;org 0Ah
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Entry	point for a battle
; Attributes: bp-based frame

bat_init proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	al, gs:g_currentSongPlusOne
	mov	gs:bat_curSong,	al
	mov	al, gs:g_currentSong
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, gs:g_currentSinger
	mov	[bp+var_6], ax
	call	endNoncombatSong
	push	cs
	call	near ptr bat_getOpponents
	mov	[bp+var_8], 0
	sub	al, al
	mov	gs:partyFrozenFlag, al
	mov	gs:runAwayFlag,	al
loc_1B13D:
	push	cs
	call	near ptr bat_sortMonGroupByDist
	push	cs
	call	near ptr bat_setBigpic
	push	[bp+var_8]
	inc	[bp+var_8]
	push	cs
	call	near ptr bat_printOpponents
	add	sp, 2
	cmp	gs:partyFrozenFlag, 0
	jnz	short loc_1B18C
	push	cs
	call	near ptr bat_getPartyOptions
	cmp	gs:runAwayFlag,	0
	jz	short loc_1B18C
partyRan:
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	sub	ax, ax
	jmp	loc_1B291
loc_1B18C:
	mov	gs:txt_numLines, 0Bh
	call	bat_doCombatRound
	call	bat_partyDisbelieves
	cmp	gs:monDisbelieveFlag, 0
	jnz	short loc_1B1AF
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1B1AF
	call	bat_monDisbelieve
loc_1B1AF:
	call	bat_doPoisonEffect
	call	doEquipmentEffect
	mov	al, gs:songRegenHP
	sub	ah, ah
	push	ax
	call	bat_doHPRegen
	add	sp, 2
	mov	al, gs:monDisbelieveFlag
	sub	ah, ah
	push	ax
	call	bat_updatePartyAndMonG
	add	sp, 2
	push	cs
	call	near ptr bat_endCombatSong
	mov	byte ptr g_printPartyFlag,	0
	call	party_getLastSlot
	cmp	ax, 7
	jle	short loc_1B215
partyDied:
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	mov	ax, 1
	jmp	short loc_1B291
loc_1B215:
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1B227
	call	_return_zero
	or	ax, ax
	jz	short loc_1B28E
loc_1B227:
	cmp	partyAttackFlag, 0
	jz	short partyWon
	mov	ax, offset aDoYouWishToCon
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_1B266
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	sub	ax, ax
	jmp	short loc_1B291
loc_1B266:
	jmp	short loc_1B28E
partyWon:
	call	bat_getReward
	mov	[bp+var_4], ax
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	mov	ax, [bp+var_4]
	jmp	short loc_1B291
loc_1B28E:
	jmp	loc_1B13D
loc_1B291:
	mov	sp, bp
	pop	bp
	retf
bat_init endp

; Attributes: bp-based frame

bat_doCombatRound proc far

	charNo=	word ptr -0Ch
	charPri= word ptr -0Ah
	monPri=	word ptr -8
	groupNo= word ptr -4
	monNo= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	cs
	call	near ptr bat_getAttackPriority
loc_1B2A4:
	lea	ax, [bp+charNo]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getHighCharPrio
	add	sp, 4
	mov	[bp+charPri], ax
	lea	ax, [bp+groupNo]
	push	ss
	push	ax
	lea	ax, [bp+monNo]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getHighMonPriority
	add	sp, 8
	mov	[bp+monPri], ax

	cmp	[bp+charPri], 0
	jnz	short loc_comparePri
	cmp	[bp+monPri], 0
	jz	loc_doCombatRoundExit

loc_comparePri:
	cmp	[bp+charPri], ax
	jl	short loc_1B2DE
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharAttack
	add	sp, 2
	jmp	short loc_1B2EB
loc_1B2DE:
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_doMonAttack
	add	sp, 4
loc_1B2EB:
	cmp	gs:g_currentCharPosition, 0
	jz	short loc_1B2FC
	call	txt_newLine
loc_1B2FC:
	call	txt_newLine
	mov	byte ptr g_printPartyFlag,	0
	jmp	loc_1B2A4

loc_doCombatRoundExit:
	mov	sp, bp
	pop	bp
	retf
bat_doCombatRound endp

; Attributes: bp-based frame

bat_doCharAttack proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+charNo]
	mov	gs:bat_charPriority[bx], 0
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1B343
	jmp	loc_1B3FA
loc_1B343:
	getCharP	[bp+charNo], bx
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1B356
	jmp	loc_1B3FA
loc_1B356:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1B373
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doSummonAttack
	add	sp, 2
	jmp	loc_1B3FA
loc_1B373:
	mov	bx, [bp+charNo]
	mov	al, gs:charActionList[bx]
	sub	ah, ah
	jmp	short loc_1B3DA
loc_1B383:
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 4
	jmp	short loc_1B3FA
loc_1B39C:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharCastSpell
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3A8:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharUseItem
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3B4:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_hideInShadows
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3C0:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharSong
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3CC:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_charMeleeAttack
	add	sp, 2
loc_1B3D6:
	jmp	short loc_1B3FA
	jmp	short loc_1B3FA
loc_1B3DA:
	sub	ax, 1
	cmp	ax, 7
	ja	short loc_1B3D6
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1B3EA[bx]
off_1B3EA dw offset loc_1B383
	  dw offset loc_1B3FA
	  dw offset loc_1B383
	  dw offset loc_1B39C
	  dw offset loc_1B3A8
	  dw offset loc_1B3B4
	  dw offset loc_1B3C0
	  dw offset loc_1B3CC
loc_1B3FA:
	mov	sp, bp
	pop	bp
	retf
bat_doCharAttack endp

; Attributes: bp-based frame

bat_doMonAttack	proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	monNo= word ptr	 6
	groupNo= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	bx, [bp+monNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupNo]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	call	_random
	and	ax, 6
	mov	[bp+var_6], ax
	getMonP	[bp+monNo], si
	add	si, [bp+var_6]
	mov	al, gs:monGroups.attackType._type[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, gs:monGroups.attackType.damage[si]
	mov	[bp+var_4], ax

	; Jump to Tarjan's attack to test
	;jmp	loc_1B4BD

	cmp	[bp+var_2], 80h
	jge	short loc_1B468
	push	[bp+var_2]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monCastSpell
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B468:
	mov	ax, [bp+var_2]
	sub	ax, 0F0h
	and 	ax, 7Fh
	mov	[bp+var_6], ax
	cmp	[bp+var_6], 0Ah
	jge	short loc_1B494
	push	[bp+var_4]
	push	[bp+var_6]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_doMonMelee
	add	sp, 8
	jmp	short loc_1B4D6
loc_1B494:
	mov	ax, [bp+var_6]
	jmp	short loc_1B4C5
loc_1B499:
	push	[bp+var_4]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monSummonMon
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B4AB:
	push	[bp+var_4]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monBreathAttack
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B4BD:
	push	cs
	call	near ptr bat_doTarjanAttack
loc_1B4C1:
	jmp	short loc_1B4D6
	jmp	short loc_1B4D6
loc_1B4C5:
	cmp	ax, 0Ah
	jz	short loc_1B499
	cmp	ax, 10h
	jz	short loc_1B4AB
	cmp	ax, 13h
	jz	short loc_1B4BD
	jmp	short loc_1B4C1
loc_1B4D6:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_doMonAttack	endp

; Attributes: bp-based frame

bat_monCastSpell proc far

	arg_0= word ptr	 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+arg_4]
	mov	ax, [bp+arg_0]
	or	al, 80h
	push	ax
	call	doCastSpell
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
bat_monCastSpell endp

; Attributes: bp-based frame

bat_doTarjanAttack proc far

	counter =	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0

loc_tarLoopEntry:
	inc	[bp+counter]
	mov	ax, 15h
	push	ax
	mov	ax, 80h
	push	ax
	call	far ptr doSummon
	add	sp, 4

	cmp	[bp+counter], 0Ah
	jl	loc_tarLoopEntry

	mov	sp, bp
	pop	bp
	retf
bat_doTarjanAttack endp

; Attributes: bp-based frame

bat_monSummonMon proc far

	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 104h
	call	someStackOperation
	push	si
	push	[bp+arg_0]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	ax, offset aSummonsHelpAnd
	push	ds
	push	ax
	push	dx
	push	[bp+var_104]
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	call	_random
	sub	ah, ah
	cmp	ax, [bp+arg_4]
	jnb	short loc_1B590
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 1Fh
	jz	short loc_1B590
	test	gs:disbelieveFlags, disb_nohelp
	jz	short loc_1B5B0
loc_1B590:
	mov	ax, offset aNoneAppears___
	push	ds
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	jmp	loc_1B63E
loc_1B5B0:
	mov	ax, offset aAnotherJoinsTheFray
	push	ds
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	getMonP	[bp+arg_0], si
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bl, gs:monGroups.groupSize[si]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+arg_0]
	mov	dx, cx
	mov	cl, 6
	shl	ax, cl
	add	bx, ax
	mov	gs:monHpList[bx], dx
	getMonP	[bp+arg_0], bx
	mov	bl, gs:monGroups.groupSize[bx]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+arg_0]
	shl	ax, cl
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
loc_1B63E:
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monSummonMon endp

; Attributes: bp-based frame

bat_monBreathAttack proc far

	var_114= dword ptr -114h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= byte ptr -10Ch
	var_10A= byte ptr -10Ah
	target=	word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_4= byte ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 114h
	call	someStackOperation
	push	di
	push	si
	push	[bp+arg_0]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	[bp+target], ax
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_114], ax
	mov	word ptr [bp+var_114+2], ss
	mov	[bp+var_110], 0
	jmp	short loc_1B69D
loc_1B699:
	inc	[bp+var_110]
loc_1B69D:
	cmp	[bp+var_110], 7
	jge	short loc_1B6B5
	mov	bx, [bp+var_110]
	mov	al, byte ptr breathAttack.effectStrIndex[bx]
	lfs	si, [bp+var_114]
	mov	fs:[bx+si], al
	jmp	short loc_1B699
loc_1B6B5:
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.breathFlag[bx]
	mov	[bp+var_10C], al
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	mov	ax, offset aFirBreathEs
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	NULL_TERMINATE(STACKVAR(var_104))

	mov	al, [bp+arg_4]
	mov	[bp+var_10A], al
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.breathRange[bx]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+var_10E]
	mov	di, sp
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	push	[bp+arg_0]
	call	bat_doBreathAttack
	add	sp, 0Ch
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bat_monBreathAttack endp

; Attributes: bp-based frame

bat_doMonMelee proc far

	var_122= byte ptr -122h
	var_120= word ptr -120h
	var_11E= word ptr -11Eh
	var_11C= word ptr -11Ch
	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	var_116= word ptr -116h
	var_106= dword ptr -106h
	var_102= word ptr -102h
	var_100= word ptr -100h
	monNo= word ptr	 6
	arg_2= word ptr  8
	arg_4= word ptr  0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 122h
	call	someStackOperation
	push	si
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	getMonP	[bp+monNo], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	lea	ax, [bp+var_100]
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], ss
	getMonP	[bp+monNo], si
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short loc_1B792
	jmp	loc_1B8E8
loc_1B792:
	mov	al, gs:monGroups.packedGenAc[si]
	and	al, 0C0h
	cmp	al, 0C0h 
	jnz	short loc_1B7A5
	mov	[bp+var_11A], 0
	jmp	short loc_1B818
loc_1B7A5:
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 2
	jnb	short loc_1B7F5
	mov	[bp+var_11A], 0
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 'A'
	mov	al, byte ptr [bp+var_116]
	cbw
	push	ax
	push	cs
	call	near ptr str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short loc_1B7E7
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 'n'
loc_1B7E7:
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], ' '
	jmp	short loc_1B818
loc_1B7F5:
	mov	[bp+var_11A], 1
	mov	ax, offset s_the
	push	ds
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
loc_1B818:
	push	[bp+var_11A]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	push	[bp+var_11A]
	push	dx
	push	ax
	mov	ax, offset aAdvanceS
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.distance[bx]
	mov	[bp+var_122], al
	sub	ah, ah
	mov	si, ax
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_11E], ax
	mov	ax, si
	and	ax, 0Fh
	mov	[bp+var_102], ax
	mov	ax, [bp+var_11E]
	cmp	[bp+var_102], ax
	jle	short loc_1B893
	mov	ax, [bp+var_102]
	sub	ax, [bp+var_11E]
	jmp	short loc_1B896
loc_1B893:
	mov	ax, 1
loc_1B896:
	mov	[bp+var_120], ax
	mov	al, byte ptr [bp+var_120]
	mov	cl, [bp+var_122]
	and	cl, 0F0h
	add	al, cl
	mov	cx, ax
	getMonP	[bp+monNo], bx
	mov	gs:monGroups.distance[bx], cl
	mov	[bp+var_118], 0
	jmp	short loc_1B8C2
loc_1B8BE:
	inc	[bp+var_118]
loc_1B8C2:
	cmp	[bp+var_118], 20h 
	jge	short loc_1B8E5
	mov	bx, [bp+monNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+var_118]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	jmp	short loc_1B8BE
loc_1B8E5:
	jmp	loc_1BA3B
loc_1B8E8:
	push	[bp+monNo]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	call	_random
	and	ax, 1
	mov	cx, ax
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.flags[bx]
	sub	ah, ah
	and	ax, mon_attackStr
	shl	ax, 1
	add	ax, cx
	mov	[bp+var_11C], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (monMeleeAttString+2)[bx]
	push	word ptr monMeleeAttString[bx]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], ' '
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	gs:bat_curTarget, al
	sub	ah, ah
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getAttackerName
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx

	; Push the special attack value
	push	[bp+arg_4]

	push	[bp+arg_6]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monHitChar
	add	sp, 8
	or	ax, ax
	jnz	short loc_1B9C4
	mov	ax, offset aButMisses
	push	ds
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	jmp	loc_1BA3B
loc_1B9C4:
	sub	ax, ax
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_printHitDamage
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr bat_doHPDamage
	add	sp, 2
	or	ax, ax
	jz	short loc_1BA2F
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getKillString
	add	sp, 4
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+var_106]
	call	printCharPronoun
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	jmp	loc_1BA3B
loc_1BA2F:
	PUSH_OFFSET(s_period)
	PUSH_STACK_PTR(var_106)
	STRCAT(var_106)
loc_1BA3B:
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	delayWithTable
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_doMonMelee endp

; Attributes: bp-based frame

bat_getMonAttackerName proc far

	var_10=	word ptr -10h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 41h
	mov	al, byte ptr [bp+var_10]
	cbw
	push	ax
	push	cs
	call	near ptr str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short loc_1BABD
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'n'
loc_1BABD:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
	sub	ax, ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getMonAttackerName endp

; Attributes: bp-based frame

bat_getRandomChar proc far

	var_4= word ptr	-4
	counter= word ptr -2
	_mask= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1BB0E
loc_1BB0B:
	inc	[bp+counter]
loc_1BB0E:
	cmp	[bp+counter], 7
	jge	short loc_1BB32
	call	_random
	and	ax, [bp+_mask]
	mov	[bp+var_4], ax
	push	ax
	push	cs
	call	near ptr bat_charCanBeAttacked
	add	sp, 2
	or	ax, ax
	jz	short loc_1BB30
	mov	ax, [bp+var_4]
	jmp	short loc_1BB36
loc_1BB30:
	jmp	short loc_1BB0B
loc_1BB32:
	sub	ax, ax
	jmp	short $+2
loc_1BB36:
	mov	sp, bp
	pop	bp
	retf
bat_getRandomChar endp

; Attributes: bp-based frame

bat_monHitChar proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	monNo= word ptr	 6
	target=	word ptr  8
	field_17= word ptr  0Ah
	spAttack = word ptr 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	gs:specialAttackVal, 0
	mov	gs:damageAmount, 0
	mov	bx, [bp+target]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1BB70
	sub	ax, ax
	jmp	loc_1BC04
loc_1BB70:
	getCharP	bx, bx
	mov	al, gs:party.ac[bx]
	cbw
	mov	bx, [bp+monNo]
	mov	cl, gs:monSpellToHitPenalty[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	cmp	ax, 3Fh
	jle	short loc_1BB9E
	mov	[bp+var_2], 3Fh
loc_1BB9E:
	getMonP	bx, si
	mov	al, gs:monGroups.toHitHi[si]
	sub	ah, ah
	push	ax
	mov	al, gs:monGroups.toHitLo[si]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	[bp+var_4], cx
	mov	ax, [bp+var_2]
	cmp	cx, ax
	jge	short loc_1BBDC
	sub	ax, ax
	jmp	short loc_1BC04
loc_1BBDC:

	; Add monster special attack
	mov	ax, [bp+spAttack]
	mov	gs:specialAttackVal, ax

	push	[bp+field_17]
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	gs:damageAmount, cx
	mov	ax, 1
	jmp	short $+2
loc_1BC04:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monHitChar endp

; Attributes: bp-based frame

bat_charCanBeAttacked proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 7
	jnz	short loc_1BC1D
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC1D:
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1BC35
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC35:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_illusion
	jnz	short loc_1BC55
	cmp	gs:monDisbelieveFlag, 0
	jnz	short loc_1BC55
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC55:
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1BC68
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC68:
	getCharP	bx, bx
	mov	al, gs:party.status[bx]
	and	al, 0Ch
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
loc_1BC85:
	mov	sp, bp
	pop	bp
	retf
bat_charCanBeAttacked endp

; Attributes: bp-based frame
bat_doSummonAttack proc	far

	var_C= word ptr	-0Ch
	attDamage= word	ptr -0Ah
	var_8= word ptr	-8
	attType= word ptr -6
	var_4= dword ptr -4
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si

	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	cmp	fs:[bx+summonStat_t.class], class_illusion
	jnz	short loc_1BCBF
	cmp	gs:monDisbelieveFlag, 0
	jz	short loc_1BCBF
	jmp	loc_1BD50
loc_1BCBF:
	call	_random
	and	ax, 6
	mov	[bp+var_8], ax
	mov	si, ax
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+si+summonStat_t.attacks._type]
	sub	ah, ah
	mov	[bp+attType], ax
	mov	al, fs:[bx+si+summonStat_t.attacks.damage]
	mov	[bp+attDamage],	ax
	cmp	[bp+attType], 80h
	jge	short loc_1BCF6
	push	ax
	push	[bp+attType]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonCastSpell
	add	sp, 6
	jmp	short loc_1BD50
loc_1BCF6:
	mov	ax, [bp+attType]
	sub	ax, 0F0h
	and	ax, 7Fh
	mov	[bp+var_C], ax
	cmp	[bp+var_C], 0Ah
	jge	short loc_1BD1F
	push	[bp+attDamage]
	push	[bp+var_C]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonMeleeAttack
	add	sp, 6
	jmp	short loc_1BD50
loc_1BD1F:
	mov	ax, [bp+var_C]
	jmp	short loc_1BD44
loc_1BD24:
	push	[bp+attDamage]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonBreathAttack
	add	sp, 4
	jmp	short loc_1BD50
loc_1BD33:
	push	[bp+attDamage]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCombatSong
	add	sp, 4
loc_1BD40:
	jmp	short loc_1BD50
	jmp	short loc_1BD50
loc_1BD44:
	cmp	ax, 10h
	jz	short loc_1BD24
	cmp	ax, 11h
	jz	short loc_1BD33
	jmp	short loc_1BD40
loc_1BD50:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_doSummonAttack endp

; Attributes: bp-based frame

bat_summonCastSpell proc far

	target=	word ptr -6
	charP= dword ptr -4
	charNo=	word ptr  6
	spellNo= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], 20h
	jz	short loc_1BD90
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	[bp+target], ax
	jmp	short loc_1BDB7
loc_1BD90:
	lfs	bx, [bp+charP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BDA7
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BDAA
loc_1BDA7:
	mov	ax, 80h
loc_1BDAA:
	mov	[bp+target], ax
	mov	ax, [bp+charNo]
	cmp	[bp+target], ax
	jnz	short loc_1BDB7
	jmp	short loc_1BDD7
loc_1BDB7:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+spellNo]
	push	[bp+charNo]
	call	doCastSpell
	add	sp, 8
loc_1BDD7:
	mov	sp, bp
	pop	bp
	retf
bat_summonCastSpell endp

; Attributes: bp-based frame

bat_summonMeleeAttack proc far

	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	cmp	[bp+arg_0], 4
	jl	short loc_1BDEE
	jmp	short loc_1BE3F
loc_1BDEE:
	getCharIndex	ax, [bp+arg_0]
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BE16
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BE19
loc_1BE16:
	mov	ax, 80h
loc_1BE19:
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_4]
	mov	gs:summonMeleeDamage, ax
	mov	ax, [bp+arg_2]
	mov	gs:summonMeleeType, ax
	push	[bp+var_6]
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 4
loc_1BE3F:
	mov	sp, bp
	pop	bp
	retf
bat_summonMeleeAttack endp

; Attributes: bp-based frame

bat_summonBreathAttack proc far

	var_104 = word ptr -118h
	var_102 = word ptr -116h
	var_100 = word ptr -114h
	argP= dword ptr	-14h
	counter= word ptr -10h
	argList= byte ptr -0Ch
	var_A= byte ptr	-0Ah
	var_8= byte ptr	-8
	charP= dword ptr -4
	charNo=	word ptr  6
	damage=	byte ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 118h
	call	someStackOperation
	push	di
	push	si

	; Get the breather's name
	push	[bp+charNo]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	lfs	bx, [bp+charP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BE78
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BE7A
loc_1BE78:
	mov	al, 80h
loc_1BE7A:
	mov	gs:bat_curTarget, al
	lea	ax, [bp+argList]
	mov	word ptr [bp+argP], ax
	mov	word ptr [bp+argP+2], ss
	mov	[bp+counter], 0
	jmp	short loc_1BE95
loc_1BE92:
	inc	[bp+counter]
loc_1BE95:
	cmp	[bp+counter], 7
	jge	short loc_1BEAA
	mov	bx, [bp+counter]
	mov	al, byte ptr breathAttack.effectStrIndex[bx]
	lfs	si, [bp+argP]
	mov	fs:[bx+si], al
	jmp	short loc_1BE92
loc_1BEAA:
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.breathFlag]
	mov	[bp+var_A], al

	; Add the fire/breath string
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	mov	ax, offset aFirBreathEs
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	; NULL terminate the string
	NULL_TERMINATE(STACKVAR(var_104))

	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp,4
	
	mov	al, [bp+damage]
	mov	[bp+var_8], al

	lfs	bx, [bp+charP]

	mov	al, fs:[bx+summonStat_t.breathRange]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+argList]
	mov	di, sp
	push	ss
	pop	es
	movsw
	movsw
	movsw
	movsb
	push	[bp+charNo]
	call	bat_doBreathAttack
	add	sp, 0Ch
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bat_summonBreathAttack endp

; Attributes: bp-based frame

bat_doCharMeleeAttack proc far

	var_10C= dword ptr -10Ch
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr 6
	arg_2= word ptr 8

	func_enter
	_chkstk	10Ch

	push	si

	cmp	[bp+arg_2], 80h
	jge	short loc_1BF22

	getCharP	[bp+arg_2], si
	cmp	gs:party.class[si], class_monster
	jnz	short loc_1BF0D
	mov	gs:party.hostileFlag[si], 1

loc_1BF0D:
	getCharP	[bp+arg_2], bx
	test	gs:party.status[bx], stat_dead	or stat_stoned
	jz	short loc_1BF20
	jmp	loc_1C0F0

loc_1BF20:
	jmp	short loc_1BF3E

loc_1BF22:
	mov	ax, [bp+arg_2]
	and	ax, 3
	getMonIndex	cx, cx
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1BF3E
	jmp	loc_1C0F0

loc_1BF3E:
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	STRCAT(var_10C)
	APPEND_CHAR(STACKVAR(var_10C), ' ')

	push_imm	1
	push	[bp+arg_0]

	std_call	sub_18077, 4

	or	ax, ax
	jz	short loc_1BF8B
	mov	[bp+var_6], 0
	jmp	short loc_1BFBF
loc_1BF8B:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1BFBA
	add	ax, offset party

	save_ptr_stack	seg seg027, ax, var_4
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+(character_t.spells+0Ah)]
	sub	ah, ah
	shl	ax, 1
	mov	[bp+var_6], ax
	jmp	short loc_1BFBF
loc_1BFBA:
	mov	[bp+var_6], 2
loc_1BFBF:
	call	_random
	and	ax, 1
	add	[bp+var_6], ax
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	push_ptr_stringList	monMeleeAttString, bx
	push_ptr_stack		var_10C
	STRCAT(var_10C)
	APPEND_CHAR(STACKVAR(var_10C), ' ')

	push	[bp+arg_2]
	push_ptr_stack	var_10C
	near_call	bat_getAttackerName, 6
	save_ptr_stack	dx,ax,var_10C

	push	[bp+arg_2]
	push	[bp+arg_0]
	near_call	bat_getCharDamage, 4
	mov	[bp+var_108], ax
	or	ax, ax
	jnz	short loc_1C04B

	push_ds_string	aButMisses
	push_ptr_stack	var_10C
	std_call	_strcat, 8
	save_ptr_stack	dx,ax,var_10C

	jmp	short loc_1C0B3
loc_1C04B:
	push	[bp+var_108]
	push_ptr_stack	var_10C
	near_call	bat_printHitDamage, 6
	save_ptr_stack	dx,ax,var_10C

	push_var_stack	arg_2
	near_call	bat_doHPDamage, 2
	or	ax, ax
	jz	short loc_1C0A7

	push_ptr_stack	var_10C
	near_call	bat_getKillString,4
	save_ptr_stack	dx,ax,var_10C

	push_imm	1
	push_imm	3
	push_var_stack	arg_2
	push_reg	dx
	push	word ptr [bp+var_10C]
	std_call	printCharPronoun, 0Ah
	save_ptr_stack	dx,ax,var_10C
	jmp	short loc_1C0B3

loc_1C0A7:
	PUSH_OFFSET(s_period)
	PUSH_STACK_PTR(var_10C)
	STRCAT(var_10C)

loc_1C0B3:
	APPEND_CHAR(STACKVAR(var_10C), 0)
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	std_Call	printString, 4

	mov	bx, [bp+arg_0]
	mov	gs:byte_42280[bx], 0
	mov	byte ptr g_printPartyFlag,	0

	delayWithTable
loc_1C0F0:
	pop	si
	func_exit
	retf
bat_doCharMeleeAttack endp

; Attributes: bp-based frame

bat_getAttackerName proc far

	var_10=	word ptr -10h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	func_enter
	_chkstk	10h

	cmp	[bp+arg_4], 80h
	jge	short loc_1C12E
	getCharP	[bp+arg_4], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push_reg	dx
	push_reg	ax
	push_ptr_stack	arg_0
	STRCAT(arg_0)

	jmp	short loc_1C19A
loc_1C12E:
	and	[bp+arg_4], 3
	APPEND_CHAR(STACKVAR(arg_0), 'a')
	lea	ax, [bp+var_10]
	push_reg	ss
	push_reg	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push_reg	dx
	push_reg	ax
	std_call	unmaskString, 8
	mov	al, byte ptr [bp+var_10]
	cbw
	push_reg	ax
	near_call	str_startsWithVowel, 2
	or	ax, ax
	jz	short loc_1C174
	APPEND_CHAR(STACKVAR(arg_0), 'n')
loc_1C174:
	APPEND_CHAR(STACKVAR(arg_0), ' ')
	sub	ax, ax
	push	ax
	push_ptr_stack	arg_0
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	std_call	str_pluralize, 0Ah
	save_ptr_stack	dx,ax,arg_0
loc_1C19A:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getAttackerName endp

; This function	returns	1 if the passed	string starts
; with a vowel.	This is	for proper use of a/an in
; strings.
; Attributes: bp-based frame

str_startsWithVowel proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	[bp+arg_0]
	call	_str_capitalize
	add	sp, 2
	mov	[bp+arg_0], ax
	mov	[bp+var_2], 0
	jmp	short loc_1C1C9
loc_1C1C6:
	inc	[bp+var_2]
loc_1C1C9:
	cmp	[bp+var_2], 6
	jge	short loc_1C1E3
	mov	bx, [bp+var_2]
	mov	al, vowelList[bx]
	cbw
	cmp	ax, [bp+arg_0]
	jnz	short loc_1C1E1
	mov	ax, 1
	jmp	short loc_1C1E7
loc_1C1E1:
	jmp	short loc_1C1C6
loc_1C1E3:
	sub	ax, ax
	jmp	short $+2
loc_1C1E7:
	mov	sp, bp
	pop	bp
	retf
str_startsWithVowel endp

; Attributes: bp-based frame

bat_doCharCastSpell proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42276[bx]
	mov	gs:bat_curTarget, al
	mov	ax, 1
	push	ax
	push	ax
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	call	doCastSpell
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
bat_doCharCastSpell endp

; Attributes: bp-based frame

bat_doCharUseItem proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	push	ax
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	mov	al, gs:byte_42276[bx]
	push	ax
	mov	al, gs:byte_42334[bx]
	push	ax
	push	bx
	call	item_doSpell
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_doCharUseItem endp

; Attributes: bp-based frame

bat_hideInShadows proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, offset aJumpsIntoTheShadows
	push	ds
	push	ax
	push	dx
	push	[bp+var_108]
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+arg_0]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_1C2DE
	call	_random
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short loc_1C2F5
loc_1C2DE:
	mov	ax, offset aAndSucceeds
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	mov	bx, [bp+arg_0]
	inc	gs:byte_42280[bx]
	jmp	short loc_1C30B
loc_1C2F5:
	mov	ax, offset aButIsDiscovered
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	mov	bx, [bp+arg_0]
	mov	gs:byte_42280[bx], 0
loc_1C30B:
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+var_106]
	push	[bp+var_108]
	call	_strcat
	add	sp, 8
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
bat_hideInShadows endp

; Attributes: bp-based frame

bat_doCharSong proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_102= word ptr -102h
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	mov	[bp+var_2], 0
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+arg_0]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1C384
	mov	[bp+var_2], 1
	jmp	short loc_1C3AA
loc_1C384:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.specAbil[bx],	0
	jz	short loc_1C3AA
	mov	[bp+var_2], 1
	getCharP	[bp+arg_0], bx
	dec	gs:party.specAbil[bx]
loc_1C3AA:
	cmp	[bp+var_2], 0
	jz	short loc_1C3F4
	mov	ax, offset aPlays___
	push	ds
	push	ax
	push	[bp+var_106]
	push	[bp+var_108]
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+arg_0]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr bat_doCombatSong
	add	sp, 4
	jmp	short loc_1C455
loc_1C3F4:
	mov	ax, offset aLost
	push	ds
	push	ax
	push	[bp+var_106]
	push	[bp+var_108]
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, 0
	push	ax
	mov	ax, 6
	push	ax
	push	[bp+arg_0]
	push	dx
	push	[bp+var_108]
	call	printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, offset aVoice
	push	ds
	push	ax
	push	dx
	push	[bp+var_108]
	call	_strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	printString
	add	sp, 4
loc_1C455:
	mov	sp, bp
	pop	bp
	retf
bat_doCharSong endp

; Attributes: bp-based frame

bat_charMeleeAttack proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_nuts
	jz	short loc_1C480
	call	_random
	test	al, 1
	jnz	short loc_1C494
loc_1C480:
	getCharIndex	ax, [bp+arg_0]
	mov	bx, ax
	cmp	gs:party.hostileFlag[bx], 0
	jz	short loc_1C4AD
loc_1C494:
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	jmp	short loc_1C4C8
loc_1C4AD:
	cmp	byte ptr gs:monGroups._name, 0
	jnz	short loc_1C4BB
	jmp	short loc_1C4D2
loc_1C4BB:
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], 80h
loc_1C4C8:
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 2
loc_1C4D2:
	mov	sp, bp
	pop	bp
	retf
bat_charMeleeAttack endp

; This function	returns	the highest priority in	the
; party. The character number with the highest
; priority is returned via membuf.
; Attributes: bp-based frame

bat_getHighCharPrio proc far

	char= word ptr -6
	charNo=	word ptr -4
	highestPriority= word ptr -2
	membuf=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	[bp+highestPriority], 0
	mov	[bp+char], 0
	mov	[bp+charNo], 0
	jmp	short loc_1C4F6
loc_1C4F3:
	inc	[bp+charNo]
loc_1C4F6:
	cmp	[bp+charNo], 7
	jge	short loc_1C51B
	mov	bx, [bp+charNo]
	mov	al, gs:bat_charPriority[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+highestPriority], si
	jnb	short loc_1C519
	mov	[bp+highestPriority], si
	mov	ax, bx
	mov	[bp+char], ax
loc_1C519:
	jmp	short loc_1C4F3
loc_1C51B:
	lfs	bx, [bp+membuf]
	mov	ax, [bp+char]
	mov	fs:[bx], ax
	mov	ax, [bp+highestPriority]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getHighCharPrio endp

; This function	returns	the highest attack priority
; in the monster groups. The monster group and
; monster index	is returned in rGroup and rMon
; respectively.
; Attributes: bp-based frame

bat_getHighMonPriority proc far

	highMon= word ptr -0Ch
	monNo= word ptr	-0Ah
	groupNo= word ptr -8
	highPri= word ptr -6
	highGroup= word	ptr -4
	var_2= word ptr	-2
	rGroup=	dword ptr  6
	rMon= dword ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si
	sub	ax, ax
	mov	[bp+highMon], ax
	mov	[bp+highGroup],	ax
	mov	[bp+highPri], ax
	mov	[bp+groupNo], ax
	jmp	short loc_1C54D
loc_1C54A:
	inc	[bp+groupNo]
loc_1C54D:
	cmp	[bp+groupNo], 4
	jge	short loc_1C5B1
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_1C5AF
	mov	[bp+monNo], 0
	jmp	short loc_1C57A
loc_1C577:
	inc	[bp+monNo]
loc_1C57A:
	mov	ax, [bp+var_2]
	cmp	[bp+monNo], ax
	jge	short loc_1C5AF
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	mov	si, gs:bat_monPriorityList[bx]
	cmp	[bp+highPri], si
	jge	short loc_1C5AD
	mov	[bp+highPri], si
	mov	ax, [bp+groupNo]
	mov	[bp+highGroup],	ax
	mov	ax, [bp+monNo]
	mov	[bp+highMon], ax
loc_1C5AD:
	jmp	short loc_1C577
loc_1C5AF:
	jmp	short loc_1C54A
loc_1C5B1:
	lfs	bx, [bp+rGroup]
	mov	ax, [bp+highGroup]
	mov	fs:[bx], ax
	lfs	bx, [bp+rMon]
	mov	ax, [bp+highMon]
	mov	fs:[bx], ax
	mov	ax, [bp+highPri]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getHighMonPriority endp

; Attributes: bp-based frame

bat_getAttackPriority proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	cmp	gs:partyFrozenFlag, 0
	jz	short loc_1C611
	mov	[bp+var_C], 0
	jmp	short loc_1C5EF
loc_1C5EC:
	inc	[bp+var_C]
loc_1C5EF:
	cmp	[bp+var_C], 7
	jge	short loc_1C604
	mov	bx, [bp+var_C]
	mov	gs:bat_charPriority[bx], 0
	jmp	short loc_1C5EC
loc_1C604:
	mov	gs:partyFrozenFlag, 0
	jmp	loc_1C707
loc_1C611:
	mov	[bp+var_C], 0
	jmp	short loc_1C61B
loc_1C618:
	inc	[bp+var_C]
loc_1C61B:
	cmp	[bp+var_C], 7
	jl	short loc_1C624
	jmp	loc_1C707
loc_1C624:
	getCharP	[bp+var_C], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1C63B
	jmp	loc_1C707
loc_1C63B:
	getCharP	[bp+var_C], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1C67B
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+18h]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+17h]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+var_C]
	mov	fs:bat_charPriority[bx], al
	jmp	loc_1C704
loc_1C67B:
	mov	bx, [bp+var_C]
	cmp	gs:charActionList[bx], 6
	jnz	short loc_1C696
	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short loc_1C704
loc_1C696:
	getCharP	[bp+var_C], si
	mov	bl, gs:party.class[si]
	sub	bh, bh
	mov	al, byte_475AE[bx]
	mov	bx, [bp+var_C]
	mov	gs:bat_charPriority[bx], al
	call	rnd_2d16
	mov	cx, gs:party.level[si]
	shr	cx, 1
	mov	dl, gs:party.dexterity[si]
	shl	dl, 1
	add	cl, dl
	add	cl, al
	mov	bx, [bp+var_C]
	add	gs:bat_charPriority[bx], cl
	mov	bx, [bp+var_C]
	cmp	gs:bat_charPriority[bx], 0FFh
	jbe	short loc_1C6F3
	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short loc_1C704
loc_1C6F3:
	mov	bx, [bp+var_C]
	cmp	gs:bat_charPriority[bx], 0
	jnz	short loc_1C704
	mov	gs:bat_charPriority[bx], 1
loc_1C704:
	jmp	loc_1C618
loc_1C707:
	mov	[bp+var_C], 0
	jmp	short loc_1C711
loc_1C70E:
	inc	[bp+var_C]
loc_1C711:
	cmp	[bp+var_C], 4
	jge	short loc_1C780
	getMonP	[bp+var_C], si
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_6], ax
	or	ax, ax
	jz	short loc_1C77E
	mov	al, gs:monGroups.oppPriorityLo[si]
	sub	ah, ah
	mov	[bp+var_E], ax
	mov	al, gs:monGroups.oppPriorityHi[si]
	mov	[bp+var_8], ax
	mov	[bp+var_A], 0
	jmp	short loc_1C750
loc_1C74D:
	inc	[bp+var_A]
loc_1C750:
	mov	ax, [bp+var_6]
	cmp	[bp+var_A], ax
	jge	short loc_1C77E
	push	[bp+var_8]
	push	[bp+var_E]
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+var_C]
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+var_A]
	shl	cx, 1
	add	bx, cx
	mov	gs:bat_monPriorityList[bx], ax
	jmp	short loc_1C74D
loc_1C77E:
	jmp	short loc_1C70E
loc_1C780:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getAttackPriority endp

; Attributes: bp-based frame

bat_getOpponents proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= dword ptr -0Ah
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	push	cs
	call	near ptr bat_resetData
	mov	gs:byte_422A4, 1
	cmp	gs:bat_curSong,	0
	jz	short loc_1C7D3
	mov	al, gs:g_currentSong
	sub	ah, ah
	push	ax
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	push	gs:party.level[bx]
	push	cs
	call	near ptr bat_convertSongToCombat
	add	sp, 4
loc_1C7D3:
	cmp	partyAttackFlag, 0
	jz	short loc_1C7EC
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
	jmp	loc_1C992
loc_1C7EC:
	cmp	gs:byte_42458, 0
	jnz	short loc_1C81D
loc_1C7F8:
	call	_random
	and	al, 3
	mov	byte_4EEC9, al
	cmp	al, levelNoMaybe
	jbe	short loc_1C814
	jmp	short loc_1C7F8
loc_1C814:
	inc	byte_4EEC9
loc_1C81D:
	mov	[bp+var_4], 0
	jmp	short loc_1C827
loc_1C824:
	inc	[bp+var_4]
loc_1C827:
	mov	al, byte_4EEC9
	sub	ah, ah
	cmp	ax, [bp+var_4]
	ja	short loc_1C839
	jmp	loc_1C978
loc_1C839:
	cmp	gs:byte_42458, ah
	jz	short loc_1C889
	getMonP	[bp+var_4], si
	mov	al, byte ptr gs:monGroups._name[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_C], ax
	lfs	bx, [bp+var_A]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	jmp	short loc_1C8EB
loc_1C889:
	mov	ax, 23
	push	ax
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	lfs	bx, [bp+var_A]
	test	fs:[bx+mon_t.flags], mon_noSummon
	jnz	short loc_1C889
	cmp	byte ptr fs:[bx], 0
	jz	short loc_1C889
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	test	fs:[bx+mon_t.groupSize], 1Fh
	jz	short loc_1C8E5
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 1Fh
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1C8E8
loc_1C8E5:
	mov	ax, 1
loc_1C8E8:
	mov	[bp+var_C], ax
loc_1C8EB:
	getMonP	[bp+var_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+var_A+2]
	push	word ptr [bp+var_A]
	push	cs
	call	near ptr mon_copyBuffer
	add	sp, 8
	mov	al, byte ptr [bp+var_E]
	or	al, byte ptr [bp+var_C]
	mov	cx, ax
	getMonP	[bp+var_4], bx
	mov	gs:monGroups.groupSize[bx], cl
	mov	[bp+var_6], 0
	jmp	short loc_1C92C
loc_1C929:
	inc	[bp+var_6]
loc_1C92C:
	mov	ax, [bp+var_C]
	cmp	[bp+var_6], ax
	jge	short loc_1C975
	getMonP	[bp+var_4], si
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+var_4]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+var_6]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	jmp	short loc_1C929
loc_1C975:
	jmp	loc_1C824
loc_1C978:
	cmp	byte_4EEC9, 4
	jnb	short loc_1C992
	mov	al, byte_4EEC9
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
loc_1C992:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getOpponents endp

; Attributes: bp-based frame

bat_zeroMonGroups proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	[bp+var_2], ax
	jmp	short loc_1C9AD
loc_1C9AA:
	inc	[bp+var_2]
loc_1C9AD:
	cmp	[bp+var_2], 3
	jge	short loc_1C9D5
	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	getMonP	[bp+var_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	jmp	short loc_1C9AA
loc_1C9D5:
	mov	sp, bp
	pop	bp
	retf
bat_zeroMonGroups endp

; Attributes: bp-based frame

bat_sortMonGroupByDist proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
loc_1C9E5:
	mov	[bp+var_4], 0
	mov	[bp+var_2], 3
	jmp	short loc_1C9F4
loc_1C9F1:
	dec	[bp+var_2]
loc_1C9F4:
	cmp	[bp+var_2], 0
	jle	short loc_1CA37
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1CA35
	mov	al, gs:monGroups.distance[si]-30h
	and	al, 0Fh
	mov	cl, gs:monGroups.distance[si]
	and	cl, 0Fh
	cmp	al, cl
	jbe	short loc_1CA35
	mov	[bp+var_4], 1
	mov	ax, [bp+var_2]
	dec	ax
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_swapMonGroups
	add	sp, 4
loc_1CA35:
	jmp	short loc_1C9F1
loc_1CA37:
	cmp	[bp+var_4], 0
	jnz	short loc_1C9E5
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_sortMonGroupByDist endp

; Attributes: bp-based frame

bat_swapMonGroups proc far

	var_40=	word ptr -40h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 40h
	call	someStackOperation
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_0]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, cl
	lea	ax, monHpList[bx]
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_swapMonGroups endp

; Attributes: bp-based frame
bat_printOpponents proc	far

	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	cmp	gs:byte_4228B, 0
	jnz	short loc_1CB98
	mov	gs:byte_4228B, 0
	cmp	[bp+arg_0], 0
	jnz	short loc_1CB89
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1CB63
	mov	ax, 6
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1CB65
loc_1CB63:
	sub	ax, ax
loc_1CB65:
	mov	[bp+var_C], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (battleCryString+2)[bx]
	push	word ptr battleCryString[bx]
	call	printStringWClear
	add	sp, 4
	cmp	[bp+var_C], 0
	jnz	short loc_1CB87
	jmp	loc_1CC83
loc_1CB87:
	jmp	short loc_1CB96
loc_1CB89:
	mov	ax, offset aYouStillFace
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_1CB96:
	jmp	short loc_1CBA2
loc_1CB98:
	mov	gs:byte_4228B, 0
loc_1CBA2:
	lea	ax, [bp+var_10C]
	mov	[bp+var_8], ax
	mov	[bp+var_6], ss
	test	gs:monGroups.groupSize,	1Fh
	jnz	short loc_1CBCA
	mov	ax, offset aHostilePartyMembers
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1CC83
	jmp	short loc_1CBE0
loc_1CBCA:
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
loc_1CBE0:
	mov	[bp+var_A], 1
	jmp	short loc_1CBEA
loc_1CBE7:
	inc	[bp+var_A]
loc_1CBEA:
	cmp	[bp+var_A], 4
	jle	short loc_1CBF3
	jmp	loc_1CC83
loc_1CBF3:
	getMonP	[bp+var_A], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1CC0D
	cmp	[bp+var_A], 4
	jnz	short loc_1CC30
loc_1CC0D:
	mov	ax, offset a__1
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	_strcat
	add	sp, 8
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1CC83
loc_1CC30:
	getMonP	[bp+var_A], bx
	test	gs:stru_42372.groupSize[bx], 1Fh
	jz	short loc_1CC4A
	cmp	[bp+var_A], 2
	jnz	short loc_1CC4F
loc_1CC4A:
	mov	ax, offset aAnd_1
	jmp	short loc_1CC52
loc_1CC4F:
	mov	ax, offset asc_473AE
loc_1CC52:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	_strcat
	add	sp, 8
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	push	[bp+var_A]
	push	dx
	push	ax
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	jmp	loc_1CBE7
loc_1CC83:
	mov	sp, bp
	pop	bp
	retf
bat_printOpponents endp

; This function	prints a group that the	party faces
; in combat. The format	is:
; XX Name (YY')
; Where:
;   XX - Number	of monsters in the group
;   YY - Distance to the group
; Attributes: bp-based frame

bat_printOpponentGroup proc far

	var_16=	word ptr -16h
	var_14=	word ptr -14h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 16h
	call	someStackOperation
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_16], ax
	mov	ax, 2
	push	ax
	mov	ax, [bp+var_16]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_16]
	dec	ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h ;	' '
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 28h
	mov	ax, 2
	push	ax
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	sub	dx, dx
	mov	cx, ax
	mov	bx, dx
	shl	ax, 1
	rcl	dx, 1
	shl	ax, 1
	rcl	dx, 1
	add	ax, cx
	adc	dx, bx
	shl	ax, 1
	rcl	dx, 1
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 27h
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 29h
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_printOpponentGroup endp

; Attributes: bp-based frame

bat_setBigpic proc far

	var_26=	word ptr -26h
	var_24=	dword ptr -24h
	var_20=	word ptr -20h
	var_10=	word ptr -10h

	push	bp
	mov	bp, sp
	mov	ax, 26h	
	call	someStackOperation
	mov	al, gs:monGroups.groupSize
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_26], ax
	or	ax, ax
	jnz	short loc_1CDC3
	mov	ax, 21h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aParty
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_1CE1C
loc_1CDC3:
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	mov	ax, offset monGroups
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_26]
	dec	ax
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2],	dx
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	al, gs:monGroups.picIndex
	sub	ah, ah
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
loc_1CE1C:
	mov	sp, bp
	pop	bp
	retf
bat_setBigpic endp

; Attributes: bp-based frame

mon_copyBuffer proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, monStruSize
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	_memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
mon_copyBuffer endp

; Attributes: bp-based frame

bat_convertSongToCombat	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_2]
	jmp	short loc_1CEC0
loc_1CE55:
	mov	gs:songCanRun, 1
	or	gs:disbelieveFlags, disb_nohelp
	jmp	short loc_1CEDA
loc_1CE6B:
	cmp	[bp+arg_0], 60
	jle	short loc_1CE75
	mov	al, 0Fh
	jmp	short loc_1CE7C
loc_1CE75:
	mov	ax, [bp+arg_0]
	sar	ax, 1
	sar	ax, 1
loc_1CE7C:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short loc_1CE8D
	inc	gs:songACBonus
loc_1CE8D:
	jmp	short loc_1CEDA
loc_1CE8F:
	mov	ax, [bp+arg_0]
	cmp	ax, 0Fh
	jle	short loc_1CE9E
	mov	ax, 0Fh
loc_1CE9E:
	mov	gs:songRegenHP,	al
	jmp	short loc_1CEDA
loc_1CEA4:
	mov	gs:songExtraAttack, 1
	jmp	short loc_1CEDA
loc_1CEB0:
	mov	gs:songHalfDamage, 1
	jmp	short loc_1CEDA
loc_1CEBC:
	jmp	short loc_1CEDA
	jmp	short loc_1CEDA
loc_1CEC0:
	or	ax, ax
	jz	short loc_1CE55
	cmp	ax, song_sanctuary
	jz	short loc_1CE6B
	cmp	ax, song_bringaround
	jz	short loc_1CE8F
	cmp	ax, song_duotime
	jz	short loc_1CEA4
	cmp	ax, song_shield
	jz	short loc_1CEB0
	jmp	short loc_1CEBC
loc_1CEDA:
	mov	sp, bp
	pop	bp
	retf
bat_convertSongToCombat	endp

include(`battle/dosong.asm')
include(`battle/endsong.asm')

; Attributes: bp-based frame

bat_resetData proc far

	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1D0B8
loc_1D0B5:
	inc	[bp+counter]
loc_1D0B8:
	cmp	[bp+counter], 4
	jge	short loc_1D130
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, bat_monPriorityList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:g_monFreezeAcPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_41E50[bx], al
	mov	bx, [bp+counter]
	mov	gs:monSpellToHitPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:monAttackBonus[bx], al
	jmp	short loc_1D0B5
loc_1D130:
	mov	[bp+counter], 0
	jmp	short loc_1D13A
loc_1D137:
	inc	[bp+counter]
loc_1D13A:
	cmp	[bp+counter], 7
	jge	short loc_1D18D
	mov	bx, [bp+counter]
	mov	gs:charActionList[bx], 2
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:[bx+8], al
	mov	bx, [bp+counter]
	mov	gs:strengthBonus[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42280[bx], al
	mov	bx, [bp+counter]
	mov	gs:bat_charPriority[bx], al
	jmp	short loc_1D137
loc_1D18D:
	sub	al, al
	mov	gs:byte_42440, al
	mov	gs:byte_41E70, al
	mov	gs:g_charFreezeAcPenalty, al
	mov	gs:partySpellAcBonus, al
	mov	gs:byte_42567, al
	mov	gs:monFrozenFlag, al
	mov	gs:byte_422A4, al
	mov	gs:byte_41E63, al
	mov	gs:disbelieveFlags, al
	mov	gs:monDisbelieveFlag, al
	mov	gs:antiMagicFlag, al
	mov	gs:partyFrozenFlag, al
	mov	gs:songHalfDamage, al
	mov	gs:songCanRun, al
	mov	gs:songExtraAttack, al
	mov	gs:byte_4229A, al
	mov	gs:songRegenHP,	al
	sub	ax, ax
	mov	gs:batRewardHi,	ax
	mov	gs:batRewardLo,	ax
	mov	sp, bp
	pop	bp
	retf
bat_resetData endp

; This function	returns	a random number	between	the
; low and the high
;
; Attributes: bp-based frame
randomBetweenXandY proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	_mask= word ptr	-2
	_low= word ptr	6
	_high= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+_high]
	sub	ax, [bp+_low]
	mov	[bp+var_4], ax
	or	ax, ax
	jg	short loc_1D246
	mov	ax, [bp+_low]
	jmp	short loc_1D26E
loc_1D246:
	push	[bp+var_4]
	push	cs
	call	near ptr getRndDiceMask
	add	sp, 2
	mov	[bp+_mask], ax
loc_1D253:
	call	_random
	and	ax, [bp+_mask]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_4]
	cmp	[bp+var_6], ax
	jg	short loc_1D253
	mov	ax, [bp+var_6]
	add	ax, [bp+_low]
	jmp	short $+2
loc_1D26E:
	mov	sp, bp
	pop	bp
	retf
randomBetweenXandY endp

; Attributes: bp-based frame

getRndDiceMask proc far

	var_2= word ptr	-2
	arg_1= byte ptr	 7

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+arg_1], 0
	mov	[bp+var_2], 0
	jmp	short loc_1D2D2
loc_1D2CF:
	inc	[bp+var_2]
loc_1D2D2:
	cmp	[bp+var_2], 8
	jge	short loc_1D2F1
	mov	bx, [bp+var_2]
	mov	al, diceMaskList[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+6],	si
	ja	short loc_1D2EF
	jmp	short loc_1D2FE
loc_1D2EF:
	jmp	short loc_1D2CF
loc_1D2F1:
	mov	ax, offset aBadDiceMaskRange
	push	ds
	push	ax
	call	printMessageAndExit
	add	sp, 4
loc_1D2FE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getRndDiceMask endp

; This function	unpacks	a single byte into the number
; of dice to roll and the sides	of the dice. A random
; number between 1DX and YDX is	returned
; Attributes: bp-based frame
dice_doYDX proc	far

	rval= word ptr -8
	counter= word ptr -6
	ndice= word ptr	-4
	dieval=	word ptr -2
	die= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	[bp+rval], 0
	mov	ax, [bp+die]
	mov	cl, 5
	sar	ax, cl
	and	ax, 7
	mov	[bp+dieval], ax
	mov	ax, [bp+die]
	and	ax, 1Fh
	mov	[bp+ndice], ax
	mov	[bp+counter], 0
	jmp	short loc_1D333
loc_1D330:
	inc	[bp+counter]
loc_1D333:
	mov	ax, [bp+ndice]
	cmp	[bp+counter], ax
	jg	short loc_1D356
	call	_random
	mov	bx, [bp+dieval]
	mov	cl, diceMaskList[bx]
	sub	ch, ch
	and	cx, ax
	inc	cx
	add	[bp+rval], cx
	jmp	short loc_1D330
loc_1D356:
	mov	ax, [bp+rval]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dice_doYDX endp

; Attributes: bp-based frame

party_fight proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
party_fight endp

; Attributes: bp-based frame

party_advance proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1D387
loc_1D384:
	inc	[bp+var_2]
loc_1D387:
	cmp	[bp+var_2], 4
	jge	short loc_1D3A8
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1D3A6
	dec	gs:monGroups.distance[si]
loc_1D3A6:
	jmp	short loc_1D384
loc_1D3A8:
	mov	ax, offset aThePartyAdvances
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 0
	jmp	short loc_1D3BF
loc_1D3BC:
	inc	[bp+var_2]
loc_1D3BF:
	cmp	[bp+var_2], 7
	jge	short loc_1D3D4
	mov	bx, [bp+var_2]
	mov	gs:charActionList[bx], 2
	jmp	short loc_1D3BC
loc_1D3D4:
	mov	ax, 1
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_advance endp

; Attributes: bp-based frame

party_run proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	gs:songCanRun, 0
	jz	short loc_1D404
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D404:
	mov	[bp+var_2], 0
	jmp	short loc_1D40E
loc_1D40B:
	inc	[bp+var_2]
loc_1D40E:
	cmp	[bp+var_2], 7
	jge	short loc_1D44C
	getCharP	[bp+var_2], bx
	cmp	byte ptr gs:party._name[bx], 0
	jz	short loc_1D44A
	mov	ax, itemEff_alwaysRunAway
	push	ax
	push	[bp+var_2]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1D44A
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D44A:
	jmp	short loc_1D40B
loc_1D44C:
	call	_random
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0C0h 
	jg	short loc_1D45F
	mov	al, 1
	jmp	short loc_1D461
loc_1D45F:
	sub	al, al
loc_1D461:
	mov	gs:runAwayFlag,	al
	sub	ah, ah
	jmp	short $+2
loc_1D46D:
	mov	sp, bp
	pop	bp
	retf
party_run endp

; Attributes: bp-based frame

bat_attackOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aAttack
	push	ds
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D4A2
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D4A2:
	cmp	[bp+var_2], 0
	jl	short loc_1D4AD
	mov	ax, 1
	jmp	short loc_1D4AF
loc_1D4AD:
	sub	ax, ax
loc_1D4AF:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_attackOpt endp

; Attributes: bp-based frame

bat_defendOpt proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_defendOpt endp

; Attributes: bp-based frame

bat_castOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 1
	push	ax
	push	[bp+arg_0]
	call	getSpellNumber
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1D4ED
	sub	ax, ax
	jmp	short loc_1D541
loc_1D4ED:
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	cmp	[bp+var_2], 4
	jg	short loc_1D52D
	mov	ax, offset s_castAt
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr getTarget
	add	sp, 6
	or	ax,ax
	jge	l_bat_castOpt_gotTarget

	mov	ax, 0				; Return 0 if no target selected.
	jmp	loc_1D541

l_bat_castOpt_gotTarget:
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D541
loc_1D52D:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D53C:
	mov	ax, 1
	jmp	short $+2
loc_1D541:
	mov	sp, bp
	pop	bp
	retf
bat_castOpt endp

; Attributes: bp-based frame

bat_useItemOpt proc far

	var_F8=	word ptr -0F8h
	var_36=	word ptr -36h
	var_34=	word ptr -34h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F8h 
	call	someStackOperation
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	lea	ax, [bp+var_F8]
	push	ss
	push	ax
	push	[bp+arg_0]
	call	sub_188E8
	add	sp, 0Ah
	mov	[bp+var_36], ax
	or	ax, ax
	jnz	short loc_1D570
	jmp	loc_1D643
loc_1D570:
	push	ax
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	mov	ax, offset s_whichItem
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_1D58F
	sub	ax, ax
	jmp	loc_1D663
loc_1D58F:
	push	[bp+var_4]
	push	[bp+arg_0]
	call	item_canBeUsed
	add	sp, 4
	or	ax, ax
	jz	short loc_1D61F
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	mov	al, byte ptr [bp+var_4]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42334[bx], al
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_2], ax
	cmp	ax, 4
	jge	short loc_1D609
	mov	ax, offset s_nlUseOn
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr getTarget
	add	sp, 6

	or	ax, ax
	jl	l_bat_useItem_opt_return_zero

	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D605
	sub	ax, ax
loc_1D605:
	jmp	short loc_1D663
	jmp	short loc_1D618
loc_1D609:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D618:
	mov	ax, 1
	jmp	short loc_1D663
loc_1D61F:
	mov	ax, offset aYouCanTUseThatItem_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	call	text_clear
	sub	ax, ax
	jmp	short loc_1D663
loc_1D641:
	jmp	short loc_1D663
loc_1D643:
	mov	ax, offset s_pocketsAreEmpty
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
l_bat_useItem_opt_return_zero:
	sub	ax, ax
	jmp	short $+2
loc_1D663:
	mov	sp, bp
	pop	bp
	retf
bat_useItemOpt endp

; Attributes: bp-based frame

bat_hideOpt proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_hideOpt endp

; Attributes: bp-based frame

bat_songOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	text_clear
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	call	song_getSong
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D6AE
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D6AE:
	cmp	[bp+var_2], 0
	jl	short loc_1D6B9
	mov	ax, 1
	jmp	short loc_1D6BB
loc_1D6B9:
	sub	ax, ax
loc_1D6BB:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_songOpt endp

; Attributes: bp-based frame
bat_partyAttackOpt proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aAttack
	push	ds
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D6F2
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D6F2:
	cmp	[bp+var_2], 0
	jl	short loc_1D6FD
	mov	ax, 1
	jmp	short loc_1D6FF
loc_1D6FD:
	sub	ax, ax
loc_1D6FF:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_partyAttackOpt endp

; Attributes: bp-based frame

bat_getPartyOptions proc far

	charNo=	word ptr -138h
	var_136= word ptr -136h
	var_36=	word ptr -36h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 138h
	call	someStackOperation
	push	si
	cmp	partyAttackFlag, 0
	jz	short loc_1D720
	jmp	loc_1D7BE
loc_1D720:
	call	bat_isAMonGroupActive
	or	ax, ax
	jnz	short loc_1D72C
	jmp	loc_1D7BE
loc_1D72C:
	call	_return_zero
	or	ax, ax
	jz	short loc_1D738
	jmp	loc_1D7BE
loc_1D738:
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getFightRunOpt
	add	sp, 4
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	mov	ax, offset aWillYourGallantBand
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
loc_1D763:
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D77B:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D7B8
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D797
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D7B3
loc_1D797:
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475D0[bx]
	mov	[bp+var_12], ax
	or	ax, ax
	jz	short loc_1D7AE
	jmp	loc_1D996
	jmp	short loc_1D7B3
loc_1D7AE:
	mov	[bp+var_22], 0
loc_1D7B3:
	inc	[bp+var_16]
	jmp	short loc_1D77B
loc_1D7B8:
	cmp	[bp+var_22], 0
	jnz	short loc_1D763
loc_1D7BE:
	mov	[bp+charNo], 0
	jmp	short loc_1D7CA
loc_1D7C6:
	inc	[bp+charNo]
loc_1D7CA:
	cmp	[bp+charNo], 7
	jl	short loc_1D7D4
	jmp	loc_1D97D
loc_1D7D4:
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1D7EC
	jmp	loc_1D97D
loc_1D7EC:
	call	text_clear
	getCharP	[bp+charNo], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1D809
	jmp	loc_1D97A
loc_1D809:
	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1D814
	jmp	loc_1D97A
loc_1D814:
	test	gs:party.status[si], stat_possessed or	stat_nuts
	jz	short loc_1D827
	cmp	gs:(party.specAbil+3)[si], 0
	jz	short loc_1D827
	jmp	loc_1D96C
loc_1D827:
	call	text_clear
	getCharP	[bp+charNo], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	ax, offset aHasTheseOptionsThisBa
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	bx, [bp+charNo]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1D89A
	mov	al, gs:byte_42280[bx]
	add	al, '1'
	mov	byte_4724A, al
	mov	ax, offset byte_4724A
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
loc_1D89A:
	mov	ax, offset a@defend@partyAttack@c
	push	ds
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	byte ptr fs:[bx], 0
	push	[bp+charNo]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getCharOptions
	add	sp, 6
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
	mov	ax, offset aSelectAnOption_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D912:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D961
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D92E
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D95C
loc_1D92E:
	mov	al, byte ptr [bp+var_16]
	inc	al
	mov	bx, [bp+charNo]
	mov	gs:charActionList[bx], al
	push	[bp+charNo]
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475DC[bx]
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_22], cx
loc_1D95C:
	inc	[bp+var_16]
	jmp	short loc_1D912
loc_1D961:
	cmp	[bp+var_22], 0
	jz	short loc_1D96A
	jmp	loc_1D827
loc_1D96A:
	jmp	short loc_1D97A
loc_1D96C:
	mov	bx, [bp+charNo]
	mov	gs:charActionList[bx], 8
loc_1D97A:
	jmp	loc_1D7C6
loc_1D97D:
	mov	ax, offset s_useTheseCommands?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_1D996
	jmp	loc_1D7BE
loc_1D996:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getPartyOptions endp

; Attributes: bp-based frame
bat_getFightRunOpt proc	far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	push	cs
	call	near ptr bat_monInMeleeRange
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+1], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+2], 1
	mov	sp, bp
	pop	bp
	retf
bat_getFightRunOpt endp

; This function	returns	0 if there is a	monster
; group	in melee range.	1 otherwise. This is used
; to determine whether the party should	be given
; the "Advance"	option in battle.
; Attributes: bp-based frame

bat_monInMeleeRange proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 3
	jmp	short loc_1D9D9
loc_1D9D6:
	dec	[bp+var_2]
loc_1D9D9:
	cmp	[bp+var_2], 0
	jl	short loc_1DA04
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1DA02
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short loc_1DA02
	sub	ax, ax
	jmp	short loc_1DA09
loc_1DA02:
	jmp	short loc_1D9D6
loc_1DA04:
	mov	ax, 1
	jmp	short $+2
loc_1DA09:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monInMeleeRange endp

; Attributes: bp-based frame
bat_getCharOptions proc	far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	partyAttackFlag, 0
	jnz	short loc_1DA49
	test	gs:monGroups.groupSize,	1Fh
	jz	short loc_1DA49
	cmp	[bp+arg_4], 4
	jl	short loc_1DA45
	mov	bx, [bp+arg_4]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1DA49
loc_1DA45:
	mov	al, 1
	jmp	short loc_1DA4B
loc_1DA49:
	sub	al, al
loc_1DA4B:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+1], 1
	mov	byte ptr fs:[bx+2], 1
	getCharP	[bp+arg_4], bx
	mov	ax, gs:party.currentSppt[bx]
	lfs	bx, [bp+arg_0]
	or	ax, ax
	jz	l_bat_getCharOptions_sppts
	mov	al, 1

l_bat_getCharOptions_sppts:
	mov	fs:[bx+3], al
	mov	byte ptr fs:[bx+4], 1
	mov	bx, [bp+arg_4]
	cmp	gs:byte_42280[bx], 9
	jnb	short loc_1DAA7
	getCharP	bx, bx
	cmp	gs:party.class[bx], class_rogue
	jnz	short loc_1DAA7
	mov	al, 1
	jmp	short loc_1DAA9
loc_1DAA7:
	sub	al, al
loc_1DAA9:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+5], al
	getCharP	[bp+arg_4], bx
	cmp	gs:party.class[bx], class_bard
	jnz	short loc_1DADB
	mov	ax, itType_instrument
	push	ax
	push	[bp+arg_4]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_1DADB
	mov	al, 1
	jmp	short loc_1DADD
loc_1DADB:
	sub	al, al
loc_1DADD:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+6], al
	mov	sp, bp
	pop	bp
	retf
bat_getCharOptions endp

; Attributes: bp-based frame

getTarget proc far

	var_228= byte ptr -228h
	var_11E= byte ptr -11Eh
	var_11C= word ptr -11Ch
	var_11A= byte ptr -11Ah
	var_119= byte ptr -119h
	var_10E= word ptr -10Eh
	var_E= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	stringOff= word	ptr  8
	stringSeg= word	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 11Eh
	call	someStackOperation
	push	si
	mov	ax, 0FFFFh
	mov	[bp+var_8], ax
	mov	[bp+var_2], ax
	mov	[bp+var_6], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB0E
loc_1DB0A:
	inc	[bp+var_11C]
loc_1DB0E:
	cmp	[bp+var_11C], 0Ch
	jge	short loc_1DB20
	mov	si, [bp+var_11C]
	mov	[bp+si+var_11A], 20h 
	jmp	short loc_1DB0A
loc_1DB20:
	push	[bp+stringSeg]
	push	[bp+stringOff]
	call	printStringWClear
	add	sp, 4
	mov	ax, [bp+arg_0]
	jmp	loc_1DD02
loc_1DB34:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	cmp	ax, 1
	jg	short loc_1DB46
	sub	ax, ax
	jmp	loc_1DD93
loc_1DB46:
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_4], 2000h
	jmp	loc_1DD20
loc_1DB63:
	push	cs
	call	near ptr bat_cntActiveMonGroups
	mov	[bp+var_2], ax
	cmp	ax, 1
	jg	short loc_1DB75
	mov	ax, 80h
	jmp	loc_1DD93
loc_1DB75:
	mov	[bp+var_4], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB86
loc_1DB82:
	inc	[bp+var_11C]
loc_1DB86:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DC09
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DB82
loc_1DC09:
	jmp	loc_1DD20
loc_1DC0C:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	push	cs
	call	near ptr bat_cntActiveMonGroups
	mov	[bp+var_2], ax
	mov	[bp+var_4], 2000h
	mov	[bp+var_11C], 0
	jmp	short loc_1DC2C
loc_1DC28:
	inc	[bp+var_11C]
loc_1DC2C:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DCAF
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DC28
loc_1DCAF:
	cmp	[bp+var_2], 0
	jz	short loc_1DCCE
	mov	ax, offset aOr
	push	ds
	push	ax
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
loc_1DCCE:
	cmp	[bp+var_8], 1
	jle	short loc_1DCEB
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1DCF8
loc_1DCEB:
	mov	ax, offset aMember1
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_1DCF8:
	jmp	short loc_1DD20
loc_1DCFA:
	mov	ax, 80h
	jmp	loc_1DD93
	jmp	short loc_1DD20
loc_1DD02:
	or	ax, ax
	jl	short loc_1DCFA
	cmp	ax, target_partyMember
	jg	short loc_1DD0E
	jmp	loc_1DB34
loc_1DD0E:
	cmp	ax, 2
	jnz	short loc_1DD16
	jmp	loc_1DB63
loc_1DD16:
	cmp	ax, 3
	jnz	short loc_1DD1E
	jmp	loc_1DC0C
loc_1DD1E:
	jmp	short loc_1DCFA
loc_1DD20:
	push	[bp+var_4]
	call	getKey
	add	sp, 2
	mov	[bp+var_E], ax
	cmp	ax, 10Eh
	jl	short loc_1DD43
	cmp	ax, 119h
	jg	short loc_1DD43
	mov	si, ax
	mov	al, [bp+si+var_228]
	sub	ah, ah
	mov	[bp+var_E], ax
loc_1DD43:
	cmp	[bp+var_6], 0
	jz	short loc_1DD54
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD54
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD54:
	cmp	[bp+var_E], 30h	
	jle	short loc_1DD6D
	mov	ax, [bp+var_8]
	add	ax, 31h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD6D
	mov	ax, [bp+var_E]
	sub	ax, 31h	
	jmp	short loc_1DD93
loc_1DD6D:
	cmp	[bp+var_E], 41h	
	jl	short loc_1DD86
	mov	ax, [bp+var_2]
	add	ax, 41h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD86
	mov	ax, [bp+var_E]
	add	ax, 3Fh	
	jmp	short loc_1DD93
loc_1DD86:
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD91
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD91:
	jmp	short loc_1DD20
loc_1DD93:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getTarget endp

; Attributes: bp-based frame

bat_cntActiveMonGroups proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_1DDAD
loc_1DDAA:
	inc	[bp+var_2]
loc_1DDAD:
	cmp	[bp+var_2], 4
	jge	short loc_1DDCE
	getMonP	[bp+var_2], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1DDCC
	mov	ax, [bp+var_2]
	jmp	short loc_1DDD3
loc_1DDCC:
	jmp	short loc_1DDAA
loc_1DDCE:
	mov	ax, 4
	jmp	short $+2
loc_1DDD3:
	mov	sp, bp
	pop	bp
	retf
bat_cntActiveMonGroups endp

; Attributes: bp-based frame

bat_getCharDamage proc far

	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	dword ptr -1Eh
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 22h	
	call	someStackOperation
	push	si
	cmp	[bp+arg_2], 80h
	jge	short loc_1DED6
	getCharP	[bp+arg_2], bx
	mov	al, gs:party.ac[bx]
	cbw
	mov	[bp+var_4], ax
	jmp	loc_1DF74
loc_1DED6:
	mov	ax, [bp+arg_2]
	and	ax, 3
	mov	[bp+var_E], ax
	getMonP	[bp+var_E], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_C], ax
	or	ax, ax
	jz	short loc_1DF17
	mov	bx, [bp+arg_0]
	mov	al, gs:byte_42280[bx]
	sub	ah, ah
	mov	cx, [bp+var_C]
	dec	cx
	cmp	ax, cx
	jnb	short loc_1DF17
	sub	ax, ax
	jmp	loc_1E277
loc_1DF17:
	getMonP	[bp+var_E], si
	mov	al, gs:monGroups.packedGenAc[si]
	sub	ah, ah
	and	ax, 3Fh
	mov	[bp+var_4], ax
	mov	al, gs:monGroups.flags[si]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	mov	[bp+var_22], ax
	mov	bx, ax
	mov	al, byte_47606[bx]
	cbw
	add	[bp+var_4], ax
	mov	al, gs:monGroups.distance[si]
	sub	ah, ah
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_8], ax
	mov	bx, ax
	mov	al, byte_4760A[bx]
	cbw
	add	[bp+var_4], ax
	mov	bx, [bp+var_E]
	mov	al, gs:g_monFreezeAcPenalty[bx]
	sub	ah, ah
	sub	[bp+var_4], ax
loc_1DF74:
	mov	ax, itType_weapon
	push	ax
	push	[bp+arg_0]
	call	inven_getTypeEqSlot
	add	sp, 4
	mov	[bp+var_6], ax
	or	ax, ax
	jl	short loc_1DFB8
	mov	bx, ax
	mov	al, itemTypeList[bx]
	sub	ah, ah
	mov	cl, 4
	shr	ax, cl
	mov	gs:specialAttackVal, ax
	mov	al, item_acBonWeapDam[bx]
	sub	ah, ah
	shr	ax, cl
	mov	[bp+var_10], ax
	sub	[bp+var_4], ax
	jmp	short loc_1DFC8
loc_1DFB8:
	mov	[bp+var_10], 0
	mov	gs:specialAttackVal, 0
loc_1DFC8:
	mov	al, gs:byte_42567
	sub	ah, ah
	add	ax, [bp+var_4]
	mov	[bp+var_18], ax
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1E01B
	add	ax, offset party
	mov	word ptr [bp+var_1E], ax
	mov	word ptr [bp+var_1E+2],	seg seg027
	lfs	bx, [bp+var_1E]
	mov	al, fs:[bx+summonStat_t.toHitHi]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+summonStat_t.toHitLo]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	[bp+var_12], ax
	mov	ax, [bp+var_4]
	sub	ax, [bp+var_12]
	mov	[bp+var_A], ax
	jmp	short loc_1E059
loc_1E01B:
	getCharP	[bp+arg_0], bx
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1
	mov	[bp+var_12], ax
	cmp	ax, 0FFh
	jle	short loc_1E03D
	mov	[bp+var_12], 0FFh
loc_1E03D:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.strength[bx]
	sub	ah, ah
	shr	ax, 1
	mov	cx, [bp+var_4]
	sub	cx, ax
	sub	cx, [bp+var_12]
	mov	[bp+var_A], cx
loc_1E059:
	call	rnd_2d8
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, byte_475F8[bx]
	cbw
	mov	bx, [bp+arg_0]
	mov	dl, gs:strengthBonus[bx]
	sub	dh, dh
	add	ax, dx
	add	ax, cx
	mov	cl, gs:byte_41E70
	sub	ch, ch
	add	ax, cx
	sub	[bp+var_A], ax
	cmp	[bp+var_A], 0
	jle	short loc_1E0A5
	sub	ax, ax
	jmp	loc_1E277
loc_1E0A5:
	getCharP	bx, bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E0D5
	mov	ax, gs:summonMeleeType
	mov	gs:specialAttackVal, ax
	mov	ax, gs:summonMeleeDamage
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E0D5:
	cmp	[bp+var_6], 0
	jl	short loc_1E0EE
	mov	bx, [bp+var_6]
	mov	al, itemDamageDice[bx]
	sub	ah, ah
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E0EE:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monk
	jnz	short loc_1E126
	mov	ax, gs:party.level[si]
	shr	ax, 1
	shr	ax, 1
	mov	[bp+var_20], ax
	cmp	ax, 0Fh
	jle	short loc_1E118
	mov	[bp+var_20], 0Fh
loc_1E118:
	mov	bx, [bp+var_20]
	mov	al, byte_47412[bx]
	sub	ah, ah
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E126:
	mov	[bp+var_16], 20h 
loc_1E12B:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_rogue
	jnz	short loc_1E152
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jnz	short loc_1E152
	sub	ax, ax
	jmp	short loc_1E165
loc_1E152:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.numAttacks[bx]
	sub	ah, ah
loc_1E165:
	mov	[bp+var_2], ax
	mov	al, gs:songExtraAttack
	sub	ah, ah
	add	[bp+var_2], ax
	inc	[bp+var_2]
	mov	ax, [bp+var_2]
	mov	[bp+var_1A], ax
	mov	gs:damageAmount, 0
	jmp	short loc_1E18E
loc_1E18B:
	dec	[bp+var_2]
loc_1E18E:
	cmp	[bp+var_2], 0
	jle	short loc_1E1F8
	push	[bp+var_16]
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	bx, [bp+arg_0]
	mov	cl, gs:strengthBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	al, gs:byte_42440
	sub	ah, ah
	add	cx, ax
	add	cx, [bp+var_10]
	add	gs:damageAmount, cx
	mov	[bp+var_14], 0
	jmp	short loc_1E1D0
loc_1E1CD:
	inc	[bp+var_14]
loc_1E1D0:
	mov	bx, [bp+arg_0]
	mov	al, gs:vorpalPlateBonus[bx]
	sub	ah, ah
	cmp	ax, [bp+var_14]
	jbe	short loc_1E1F6
	call	_random
	and	ax, 4
	add	gs:damageAmount, ax
	jmp	short loc_1E1CD
loc_1E1F6:
	jmp	short loc_1E18B
loc_1E1F8:
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1E232
	call	_random
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short loc_1E226
	mov	ax, speAtt_criticalHit
	jmp	short loc_1E228
loc_1E226:
	sub	ax, ax
loc_1E228:
	mov	gs:specialAttackVal, ax
	jmp	short loc_1E272
loc_1E232:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_hunter
	;;jnz	short loc_1E267
	jnz	short loc_1E272
	call	_random
	cmp	gs:party.specAbil[si],	al
	jbe	short loc_1E25B
	mov	ax, speAtt_criticalHit
	jmp	short loc_1E25D
loc_1E25B:
	sub	ax, ax
loc_1E25D:
	mov	gs:specialAttackVal, ax
	jmp	short loc_1E272
;;loc_1E267:
;;	mov	gs:specialAttackVal, 0
loc_1E272:
	mov	ax, [bp+var_1A]
	jmp	short $+2
loc_1E277:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getCharDamage endp

; Attributes: bp-based frame
bat_printHitDamage proc	far

	dmgLo= word ptr	 6
	dmgHi= word ptr	 8
	multiAttackFlag= word ptr  0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+multiAttackFlag], 1
	jg	short loc_1E2A7
	mov	ax, offset aAndHitsFor
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	_strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short loc_1E2F4
loc_1E2A7:
	mov	ax, offset aAndHits
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	_strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+multiAttackFlag]
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, offset aTimesFor
	push	ds
	push	ax
	push	dx
	push	[bp+dmgLo]
	call	_strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
loc_1E2F4:
	sub	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	[bp+dmgLo]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_printHitDamage endp

; Attributes: bp-based frame

bat_getKillString proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, gs:specialAttackVal
	shl	bx, 1
	shl	bx, 1
	push	word ptr (specialAttString+2)[bx]
	push	word ptr specialAttString[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcat
	add	sp, 8
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getKillString endp

; Attributes: bp-based frame

bat_doHPDamage proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jge	short loc_1E3A1
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_charAfterDmgCheck
	add	sp, 2
	jmp	short loc_1E3B1
	jmp	short loc_1E3B1
loc_1E3A1:
	mov	ax, [bp+arg_0]
	and	ax, 7Fh
	push	ax
	push	cs
	call	near ptr bat_doMonHPDamage
	add	sp, 2
	jmp	short $+2
loc_1E3B1:
	mov	sp, bp
	pop	bp
	retf
bat_doHPDamage endp

; Attributes: bp-based frame

bat_doMonHPDamage proc far

	monNo= word ptr	-4
	groupSize= word	ptr -2
	groupNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	or	ax, ax
	jnz	short loc_1E3E1
	sub	ax, ax
	jmp	short loc_1E459
loc_1E3E1:
	mov	[bp+monNo], 0
	jmp	short loc_1E3EB
loc_1E3E8:
	inc	[bp+monNo]
loc_1E3EB:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E41E
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	test	byte ptr gs:bat_monPriorityList[bx], 1
	jz	short loc_1E41C
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monAfterDmgCheck
	add	sp, 4
	jmp	short loc_1E459
loc_1E41C:
	jmp	short loc_1E3E8
loc_1E41E:
	mov	[bp+monNo], 0
	jmp	short loc_1E428
loc_1E425:
	inc	[bp+monNo]
loc_1E428:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E44A
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	or	byte ptr gs:bat_monPriorityList[bx], 1
	jmp	short loc_1E425
loc_1E44A:
	sub	ax, ax
	push	ax
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monAfterDmgCheck
	add	sp, 4
	jmp	short $+2
loc_1E459:
	mov	sp, bp
	pop	bp
	retf
bat_doMonHPDamage endp

; Attributes: bp-based frame

bat_monAfterDmgCheck proc far

	var_4= dword ptr -4
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	and	gs:bat_monPriorityList[bx], 0FEh
	cmp	gs:specialAttackVal, speAtt_stoning
	jz	short loc_1E495
	cmp	gs:specialAttackVal, speAtt_criticalHit
	jnz	short loc_1E4A7
loc_1E495:
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_killMon
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4A7:
	mov	ax, [bp+groupNo]
	mov	cl, 6
	shl	ax, cl
	mov	cx, [bp+monNo]
	shl	cx, 1
	add	ax, cx
	add	ax, offset monHpList
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	mov	ax, gs:damageAmount
	lfs	bx, [bp+var_4]
	sub	fs:[bx], ax
	lfs	bx, [bp+var_4]
	cmp	word ptr fs:[bx], 0
	jg	short loc_1E4E9
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_killMon
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4E9:
	sub	ax, ax
	jmp	short $+2
loc_1E4ED:
	mov	sp, bp
	pop	bp
	retf
bat_monAfterDmgCheck endp

; Attributes: bp-based frame

bat_killMon proc far

	mon= word ptr -2
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, [bp+monNo]
	mov	[bp+mon], ax
	jmp	short loc_1E508
loc_1E505:
	inc	[bp+mon]
loc_1E508:
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	cmp	ax, [bp+mon]
	jb	short loc_1E54F
	mov	si, [bp+groupNo]
	mov	cl, 6
	shl	si, cl
	mov	ax, [bp+mon]
	shl	ax, 1
	add	si, ax
	mov	ax, gs:(monHpList+2)[si]
	mov	gs:monHpList[si], ax
	mov	ax, gs:(bat_monPriorityList+2)[si]
	mov	gs:bat_monPriorityList[si], ax
	jmp	short loc_1E505
loc_1E54F:
	getMonP	[bp+groupNo], si
	dec	gs:monGroups.groupSize[si]
	test	gs:monGroups.groupSize[si], 1Fh
	jnz	short loc_1E56E
	and	gs:monGroups.flags[si],	0FEh
loc_1E56E:
	getMonP	[bp+groupNo], si
	mov	ah, gs:monGroups.rewardMid[si]
	sub	al, al
	mov	dl, gs:monGroups.rewardHi[si]
	sub	dh, dh
	mov	cl, 10h
	shl	dx, cl
	add	ax, dx
	mov	cl, gs:monGroups.rewardLo[si]
	sub	ch, ch
	add	ax, cx
	sub	dx, dx
	add	gs:batRewardLo,	ax
	adc	gs:batRewardHi,	dx
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_killMon endp

; Attributes: bp-based frame

bat_charAfterDmgCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1E5CC
	sub	ax, ax
	jmp	loc_1E66E
loc_1E5CC:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_dead
	jz	short loc_1E5FA
	cmp	gs:specialAttackVal, speAtt_possess
	jnz	short loc_1E5F6
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_inflictStatus
	add	sp, 2
	jmp	short loc_1E66E
	jmp	short loc_1E5FA
loc_1E5F6:
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E5FA:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_stoned
	jz	short loc_1E612
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E612:
	getCharP	[bp+arg_0], si
	mov	ax, gs:damageAmount
	cmp	gs:party.currentHP[si], ax
	jnb	short loc_1E647
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	short loc_1E66E
	jmp	short loc_1E662
loc_1E647:
	mov	ax, gs:damageAmount
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	sub	gs:party.currentHP[bx], cx
loc_1E662:
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_inflictStatus
	add	sp, 2
	jmp	short $+2
loc_1E66E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_charAfterDmgCheck endp

; Attributes: bp-based frame

bat_inflictStatus proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	ax, gs:specialAttackVal
	jmp	loc_1E869
loc_1E68A:
	sub	ax, ax
	jmp	loc_1E88A
poisonChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_poisoned
	mov	ax, 1
	jmp	loc_1E88A
levelDrainChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E6C2
	sub	ax, ax
	jmp	loc_1E88A
	jmp	short loc_1E70E
loc_1E6C2:
	getCharP	[bp+charNo], bx
	cmp	gs:party.level[bx], 1
	jbe	short loc_1E6DF
	getCharP	[bp+charNo], bx
	dec	gs:party.level[bx]
loc_1E6DF:
	getCharP	[bp+charNo], si
	mov	ax, gs:party.level[si]
	dec	ax
	push	ax
	push	[bp+charNo]
	call	getLevelXp
	add	sp, 4
	cwd
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	mov	ax, 1
	jmp	loc_1E88A
loc_1E70E:
	sub	ax, ax
	jmp	loc_1E88A
nutsifyChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_nuts
	mov	ax, 1
	jmp	loc_1E88A
oldifyChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E744
	sub	ax, ax
	jmp	loc_1E88A
loc_1E744:
	getCharP	[bp+charNo], bx
	test	gs:party.status[bx], stat_old
	jz	short loc_1E759
	sub	ax, ax
	jmp	loc_1E88A
loc_1E759:
	getCharP	[bp+charNo], si
	mov	ax, 5
	push	ax
	lea	ax, party.savedST[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.strength[si]
	push	dx
	push	ax
	push	cs
	call	near ptr _doAgeStatus
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_old
	mov	ax, 1
	jmp	loc_1E88A
possessChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 64h 
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	mov	ax, 1
	jmp	loc_1E88A
stoneChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	or	gs:party.status[si], stat_stoned
	mov	ax, 1
	jmp	loc_1E88A
killChar:
	getCharP	[bp+charNo], si
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	loc_1E88A
loc_1E802:
	mov	[bp+var_4], 0
	jmp	short loc_1E80D
loc_1E809:
	add	[bp+var_4], 3
loc_1E80D:
	cmp	[bp+var_4], 24h	
	jge	short loc_1E846
	getCharP	[bp+charNo], si
	add	si, [bp+var_4]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	cmp	itemTypeList[bx], 1
	jnz	short loc_1E844
	and	gs:party.inventory.itemFlags[si], 0FCh
loc_1E844:
	jmp	short loc_1E809
loc_1E846:
	mov	ax, 1
	jmp	short loc_1E88A
consumeSppt:
	getCharP	[bp+charNo], bx
	mov	gs:party.currentSppt[bx], 0
	mov	ax, 1
	jmp	short loc_1E88A
loc_1E863:
	sub	ax, ax
	jmp	short loc_1E88A
	jmp	short loc_1E88A
loc_1E869:
	cmp	ax, 9
	ja	short loc_1E863
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1E876[bx]
off_1E876 dw offset loc_1E68A
dw offset poisonChar
dw offset levelDrainChar
dw offset nutsifyChar
dw offset oldifyChar
dw offset possessChar
dw offset stoneChar
dw offset killChar
dw offset loc_1E802
dw offset consumeSppt
loc_1E88A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_inflictStatus endp

; Attributes: bp-based frame

_doAgeStatus proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	jmp	short loc_1E89E
loc_1E89B:
	dec	[bp+arg_8]
loc_1E89E:
	cmp	[bp+arg_8], 0
	jl	short loc_1E8BF
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	jmp	short loc_1E89B
loc_1E8BF:
	mov	sp, bp
	pop	bp
	retf
_doAgeStatus endp

; Attributes: bp-based frame

partyDied proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	byte ptr g_printPartyFlag,	0
	mov	gs:byte_42296, 0FFh
	mov	ax, 57
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aSorryBud
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, offset aAlasYourPartyHasExp
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	al, al
	mov	gs:byte_42458, al
	mov	partyAttackFlag, al
	sub	ah, ah
	mov	currentLocationMaybe, ax
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	dirFacing, 0
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_1E958:
	retf
partyDied endp

seg008 ends
