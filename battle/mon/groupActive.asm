; Attributes: bp-based frame

bat_isAMonGroupActive proc far

	groupNo= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+groupNo], 0
	jmp	short loc_1F13A
loc_1F137:
	inc	[bp+groupNo]
loc_1F13A:
	cmp	[bp+groupNo], 4
	jge	short loc_1F15B
	getMonP	[bp+groupNo], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1F159
	mov	ax, 1
	jmp	short loc_1F15F
loc_1F159:
	jmp	short loc_1F137
loc_1F15B:
	sub	ax, ax
	jmp	short $+2
loc_1F15F:
	mov	sp, bp
	pop	bp
	retf
bat_isAMonGroupActive endp

; Attributes: bp-based frame

_return_zero proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_return_zero endp

; Attributes: bp-based frame

bat_end	proc far

	var_2= word ptr	-2
	song= word ptr	6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	byte_4EECC, al
	mov	g_partyAttackFlag, al
	mov	[bp+var_2], 0
	jmp	short loc_1F1A5
loc_1F1A2:
	inc	[bp+var_2]
loc_1F1A5:
	cmp	[bp+var_2], 4
	jge	short loc_1F1C5
	getMonP	[bp+var_2], si
	mov	byte ptr gs:monGroups._name[si], 0
	mov	gs:monGroups.groupSize[si], 0
	jmp	short loc_1F1A2
loc_1F1C5:
	cmp	[bp+song], 0
	jz	short loc_1F1EF
	push	[bp+arg_2]
	call	_charCanPlaySong
	add	sp, 2
	or	ax, ax
	jz	short loc_1F1EF
	push	[bp+arg_4]
	push	[bp+arg_2]
	call	song_playSong
	add	sp, 4
	call	song_doNoncombatEffect
	jmp	short loc_1F1F4
loc_1F1EF:
	call	song_endMusic
loc_1F1F4:
	call	bat_reset
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_end	endp

; Attributes: bp-based frame

bat_getReward proc far

	var_114= word ptr -114h
	var_112= word ptr -112h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= dword ptr -108h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	func_enter
	_chkstk	114h
	delayNoTable	2
	call	text_clear
	mov	gs:trapIndex, 0
	mov	ax, gs:batRewardLo
	or	ax, gs:batRewardHi
	jnz	short loc_1F239
	sub	ax, ax
	jmp	loc_1F565
loc_1F239:
	cmp	inDungeonMaybe, 0
	jz	short loc_1F255
	cmp	byte_4EECC, 0
	jz	short loc_1F255
	push	cs
	call	near ptr bat_doChest
loc_1F255:
	call	party_getLastSlot
	cmp	ax, 7
	jle	short loc_1F265
	mov	ax, 1
	jmp	loc_1F565
loc_1F265:
	mov	ax, gs:batRewardLo
	or	ax, gs:batRewardHi
	jnz	short loc_1F279
	sub	ax, ax
	jmp	loc_1F565
loc_1F279:
	mov	ax, offset aEachCharacterReceive
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	sub	ax, ax
	push	ax
	push	gs:batRewardHi
	push	gs:batRewardLo
	push	cs
	call	near ptr bat_giveExperience
	add	sp, 4
	push	dx
	push	ax
	push	word ptr [bp+var_108+2]
	push	word ptr [bp+var_108]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	mov	ax, offset s_experiencePoinsForV
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_108]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	cmp	gs:trapIndex, 0
	jz	short loc_1F2F1
	sub	ax, ax
	cwd
	jmp	short loc_1F30A
loc_1F2F1:
	mov	ax, 5
	cwd
	push	dx
	push	ax
	push	gs:batRewardHi
	push	gs:batRewardLo
	call	__32bitDivide
loc_1F30A:
	mov	[bp+var_10E], ax
	mov	[bp+var_10C], dx
loc_1F319:
	mov	ax, 34h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aTreasure
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	sub	ax, ax
	push	ax
	push	[bp+var_10C]
	push	[bp+var_10E]
	push	cs
	call	near ptr bat_giveGold
	add	sp, 4
	push	dx
	push	ax
	push	word ptr [bp+var_108+2]
	push	word ptr [bp+var_108]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	mov	ax, offset aInGold_
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_108]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	mov	[bp+var_112], 0
	jmp	short loc_1F384
loc_1F380:
	inc	[bp+var_112]
loc_1F384:
	cmp	[bp+var_112], 4
	jl	short loc_1F38E
	jmp	loc_1F547
loc_1F38E:
	mov	al, g_levelNumber
	sub	ah, ah
	sub	ax, 9
	neg	ax
	push	ax
	sub	ax, ax
	push	ax
	call	randomBetweenXandY
	add	sp, 4
	or	ax, ax
	jz	short loc_1F3B0
	jmp	loc_1F544
loc_1F3B0:
	cmp	gs:trapIndex, 0
	jnz	short loc_1F3C8
	delayNoTable	1
loc_1F3C8:
	call	random
	sub	ah, ah
	cmp	ax, 224
	jl	short loc_1F3E9
	cmp	ax, 240
	jge	short loc_1F3E9
	mov	ax, 195
loc_1F3E9:
	mov	[bp+var_104], ax
	mov	bl, g_levelNumber
	sub	bh, bh
	mov	al, byteMaskList[bx]
	sub	ah, ah
	mov	bx, [bp+var_104]
	mov	cl, itemLevMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_1F3C8
	mov	al, g_itemBaseCount[bx]
	mov	[bp+var_10A], ax
	cmp	ax, 1
	jz	short loc_1F43A
	cmp	ax, 0FFh
	jz	short loc_1F43A
	push	ax
	mov	ax, 1
	push	ax
	call	randomBetweenXandY
	add	sp, 4
	mov	[bp+var_10A], ax
loc_1F43A:
	call	random
	test	al, 7
	jnz	short loc_1F448
	mov	ax, 80h
	jmp	short loc_1F44A
loc_1F448:
	sub	ax, ax
loc_1F44A:
	mov	[bp+var_110], ax
	mov	ax, 7
	push	ax
	call	bat_getRandomChar
	add	sp, 2
	mov	[bp+var_102], ax
	mov	[bp+var_114], 0
	jmp	short loc_1F46A
loc_1F466:
	inc	[bp+var_114]
loc_1F46A:
	cmp	[bp+var_114], 7
	jl	short loc_1F474
	jmp	loc_1F544
loc_1F474:
	push	[bp+var_102]
	push	cs
	call	near ptr bat_canGetTreasure
	add	sp, 2
	or	ax, ax
	jnz	short loc_1F486
	jmp	loc_1F535
loc_1F486:
	push	[bp+var_10A]
	push	[bp+var_110]
	push	[bp+var_104]
	push	[bp+var_102]
	call	inventory_addItem
	add	sp, 8
	or	ax, ax
	jnz	short loc_1F4A5
	jmp	loc_1F535
loc_1F4A5:
	getCharP	[bp+var_102], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+var_108+2]
	push	word ptr [bp+var_108]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	mov	ax, offset aFoundA
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_108]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	push	[bp+var_110]
	push	[bp+var_104]
	push	dx
	push	ax
	call	inventory_getItemName
	add	sp, 8
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	lea	ax, [bp+var_100]
	mov	word ptr [bp+var_108], ax
	mov	word ptr [bp+var_108+2], ss
	lfs	bx, [bp+var_108]
	mov	byte ptr fs:[bx], 0
	delayNoTable	2
	jmp	short loc_1F544
	jmp	short loc_1F541
loc_1F535:
	dec	[bp+var_102]
	jns	short loc_1F541
	mov	[bp+var_102], 6
loc_1F541:
	jmp	loc_1F466
loc_1F544:
	jmp	loc_1F380
loc_1F547:
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	8
	sub	ax, ax
	jmp	short $+2
loc_1F565:
	mov	sp, bp
	pop	bp
	retf
bat_getReward endp

; Attributes: bp-based frame
bat_canGetTreasure proc	far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1F58B
	sub	ax, ax
	jmp	short loc_1F5B9
loc_1F58B:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F59F
	sub	ax, ax
	jmp	short loc_1F5B9
loc_1F59F:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.status[bx]
	and	al, stat_dead or stat_stoned or	stat_paralyzed
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
loc_1F5B9:
	mov	sp, bp
	pop	bp
	retf
bat_canGetTreasure endp

; Attributes: bp-based frame

chest_examine proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 106h
	call	someStackOperation
	push	si
	mov	ax, offset aWhoWillExamineIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_106], ax
	or	ax, ax
	jge	short loc_1F5E8
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F5E8:
	getCharP	[bp+var_106], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F602
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F602:
	mov	bx, [bp+var_106]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	gs:word_42298, ax
	jz	short loc_1F62E
	mov	ax, offset aThatCharacterHasAlr
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F62E:
	mov	bx, [bp+var_106]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	or	gs:word_42298, ax
	getCharP	bx, bx
	test	gs:party.status[bx], 1Ch
	jz	short loc_1F65E
	sub	ax, ax
	jmp	loc_1F6EE
loc_1F65E:
	getCharP	[bp+var_106], si
	cmp	gs:party.class[si], class_rogue
	jnz	short loc_1F67F
	call	random
	cmp	gs:(party.specAbil+1)[si], al
	jnb	short loc_1F690
loc_1F67F:
	mov	ax, offset aYouFoundNothing_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1F6EE
loc_1F690:
	mov	ax, offset aItLooksLikeA
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	push	dx
	push	[bp+var_104]
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
loc_1F6EE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_examine endp

; Attributes: bp-based frame

chest_setOffTrap proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si
	mov	ax, offset aYouSetOffA
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	push	dx
	push	[bp+var_106]
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, trapDice[bx]
	sub	ah, ah
	push	ax
	call	randomYdX
	add	sp, 2
	mov	[bp+var_108], ax
	mov	si, gs:trapIndex
	shl	si, 1
	mov	al, byte ptr stru_47938.lo[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, stru_47938.hi[si]
	mov	gs:monGroups.breathSaveHi, al
	mov	bx, gs:trapIndex
	test	trapFlags[bx], 80h
	jz	short loc_1F7A6
	push	[bp+var_108]
	push	[bp+arg_0]
	push	cs
	call	near ptr chest_doTrapAttack
	add	sp, 4
	jmp	short loc_1F7CA
loc_1F7A6:
	mov	[bp+var_102], 0
	jmp	short loc_1F7B2
loc_1F7AE:
	inc	[bp+var_102]
loc_1F7B2:
	cmp	[bp+var_102], 7
	jge	short loc_1F7CA
	push	[bp+var_108]
	push	[bp+var_102]
	push	cs
	call	near ptr chest_doTrapAttack
	add	sp, 4
	jmp	short loc_1F7AE
loc_1F7CA:
	mov	gs:trapIndex, 0
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	wait4IO
	mov	ax, 1
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_setOffTrap endp

; Attributes: bp-based frame
chest_doTrapAttack proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1F88B
	test	gs:party.status[si], stat_dead
	jnz	short loc_1F88B
	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	bx, gs:trapIndex
	mov	al, trapFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	mov	gs:specialAttackVal, ax
	mov	ax, [bp+arg_2]
	mov	gs:damageAmount, ax
	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	call	savingThrowCheck
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_1F88B
	mov	ax, 1
	mov	[bp+var_2], ax
	sar	gs:damageAmount, 1
	push	[bp+arg_0]
	call	bat_damageHp
	add	sp, 2
loc_1F88B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_doTrapAttack endp

; Attributes: bp-based frame
chest_open proc	far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhoWillOpenIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1F8B8
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8B8:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 7Ch
	jz	short loc_1F8D0
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8D0:
	getCharP	[bp+var_2], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1F8E4
	sub	ax, ax
	jmp	short loc_1F920
loc_1F8E4:
	call	random
	test	al, 80h
	jz	short loc_1F8F9
	push	[bp+var_2]
	push	cs
	call	near ptr chest_setOffTrap
	add	sp, 2
	jmp	short loc_1F90F
loc_1F8F9:
	mov	gs:trapIndex, 0
	mov	gs:word_42560, 1
loc_1F90F:
	delayNoTable	5
	mov	ax, 1
	jmp	short $+2
loc_1F920:
	mov	sp, bp
	pop	bp
	retf
chest_open endp

; Attributes: bp-based frame

chest_disarm proc far

	var_2A=	word ptr -2Ah
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2Ah	
	call	someStackOperation
	push	si
	mov	ax, offset aWhoWillDisarmIt?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1F94E
	sub	ax, ax
	jmp	loc_1FA16
loc_1F94E:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 1Ch
	jz	short loc_1F967
	sub	ax, ax
	jmp	loc_1FA16
loc_1F967:
	mov	ax, offset aEnterTrapName
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 28h	
	push	ax
	lea	ax, [bp+var_2A]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	mov	bx, gs:trapIndex
	mov	al, byte_47988[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapName+2)[bx]
	push	word ptr trapName[bx]
	lea	ax, [bp+var_2A]
	push	ss
	push	ax
	push	cs
	call	near ptr chest_trapStrcmp
	add	sp, 8
	or	ax, ax
	jz	short loc_1FA07
	getCharP	[bp+var_2], si
	cmp	gs:party.class[si], class_rogue
	jnz	short loc_1F9F4
	call	random
	cmp	gs:party.specAbil[si],	al
	jb	short loc_1F9F4
	mov	ax, offset aYouDisarmedIt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	gs:trapIndex, 0
	mov	ax, 1
	jmp	short loc_1FA16
	jmp	short loc_1FA05
loc_1F9F4:
	mov	ax, offset aDisarmFailed
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1FA16
loc_1FA05:
	jmp	short loc_1FA11
loc_1FA07:
	push	[bp+var_2]
	push	cs
	call	near ptr chest_setOffTrap
	add	sp, 2
loc_1FA11:
	mov	ax, 1
	jmp	short $+2
loc_1FA16:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_disarm endp

; Attributes: bp-based frame

chest_trapZap proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhoWillCastATrzp?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1FA44
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA44:
	getCharP	[bp+var_2], bx
	test	gs:party.status[bx], 7Ch
	jz	short loc_1FA5D
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA5D:
	getCharP	[bp+var_2], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1FA72
	sub	ax, ax
	jmp	loc_1FB00
loc_1FA72:
	mov	ax, 2
	push	ax
	push	[bp+var_2]
	call	character_learnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_1FAEF
	getCharP	[bp+var_2], bx
	cmp	gs:party.currentSppt[bx], 2
	jnb	short loc_1FAAA
	mov	ax, offset aYouNeedAtLeast2SpellP
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_1FB00
loc_1FAAA:
	getCharP	[bp+var_2], bx
	sub	gs:party.currentSppt[bx], 2
	mov	gs:trapIndex, 0
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, offset aYouDisarmedIt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	ax, 1
	jmp	short loc_1FB00
loc_1FAEF:
	mov	ax, offset s_dontKnowThatSpell_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
loc_1FB00:
	mov	sp, bp
	pop	bp
	retf
chest_trapZap endp

; Attributes: bp-based frame

chest_returnOne	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
chest_returnOne	endp

; Attributes: bp-based frame

chest_trapStrcmp proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1FB2D
loc_1FB2A:
	inc	[bp+var_2]
loc_1FB2D:
	cmp	[bp+var_2], 28h	
	jge	short loc_1FB80
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	or	ax, cx
	jnz	short loc_1FB4F
	mov	ax, 1
	jmp	short loc_1FB85
loc_1FB4F:
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	call	toUpper
	add	sp, 2
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	push	ax
	mov	si, cx
	call	toUpper
	add	sp, 2
	cmp	ax, si
	jz	short loc_1FB7E
	sub	ax, ax
	jmp	short loc_1FB85
loc_1FB7E:
	jmp	short loc_1FB2A
loc_1FB80:
	mov	ax, 1
	jmp	short $+2
loc_1FB85:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chest_trapStrcmp endp

; Attributes: bp-based frame

bat_doChest proc far

	var_30=	word ptr -30h
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah

	push	bp
	mov	bp, sp
	mov	ax, 30h	
	call	someStackOperation
	push	si
	mov	ax, 35h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aChest
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	call	random
	and	ax, 3
	mov	cl, g_levelNumber
	sub	ch, ch
	shl	cx, 1
	shl	cx, 1
	add	cx, ax
	mov	gs:trapIndex, cx
	mov	gs:word_42298, 0
	mov	[bp+var_1A], 0
	jmp	short loc_1FBE6
loc_1FBE3:
	inc	[bp+var_1A]
loc_1FBE6:
	cmp	[bp+var_1A], 0Ah
	jge	short loc_1FBF5
	mov	si, [bp+var_1A]
	mov	byte ptr [bp+si+var_A],	1
	jmp	short loc_1FBE3
loc_1FBF5:
	call	text_clear
	lea	ax, [bp+var_30]
	push	ss
	push	ax
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	lea	ax, [bp+var_A]
	push	ss
	push	ax
	mov	ax, offset aThereIsAChestHere_Wil
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_18], ax
loc_1FC19:
	mov	[bp+var_1C], 1
	push	[bp+var_18]
	call	getKey
	add	sp, 2
	mov	[bp+var_C], ax
	mov	[bp+var_1A], 0
loc_1FC31:
	mov	si, [bp+var_1A]
	cmp	byte ptr [bp+si+var_16], 0
	jz	short loc_1FC7B
	mov	al, byte ptr [bp+si+var_16]
	cbw
	cmp	ax, [bp+var_C]
	jz	short loc_1FC4D
	shl	si, 1
	mov	ax, [bp+var_C]
	cmp	[bp+si+var_30],	ax
	jnz	short loc_1FC76
loc_1FC4D:
	mov	bx, [bp+var_1A]
	shl	bx, 1
	shl	bx, 1
	call	off_47A00[bx]
	or	ax, ax
	jz	short loc_1FC65
	call	text_clear
	jmp	short loc_1FC84
	jmp	short loc_1FC6A
loc_1FC65:
	mov	[bp+var_1C], 0
loc_1FC6A:
	delayNoTable	2
loc_1FC76:
	inc	[bp+var_1A]
	jmp	short loc_1FC31
loc_1FC7B:
	cmp	[bp+var_1C], 0
	jnz	short loc_1FC19
	jmp	loc_1FBF5
loc_1FC84:
	pop	si
	mov	sp, bp
	pop	bp
locret_1FC88:
	retf
bat_doChest endp
align 2
