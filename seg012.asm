; Segment type:	Pure code
seg012 segment byte public 'CODE' use16
	assume cs:seg012
;org 0Eh
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; This function	is useless....
; Attributes: bp-based frame
_returnValueOrFFFF proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_2], 0
	jnz	short loc_22FB4
	cmp	[bp+arg_0], 0FFFFh
	jbe	short loc_22FBE
loc_22FB4:
	mov	[bp+arg_0], 0FFFFh
	mov	[bp+arg_2], 0
loc_22FBE:
	mov	ax, [bp+arg_0]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_returnValueOrFFFF endp

; Attributes: bp-based frame

sub_22FC7 proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_2], 0FFh
	jb	short loc_22FEA
	ja	short loc_22FE0
	cmp	[bp+arg_0], 0FFFFh
	jbe	short loc_22FEA
loc_22FE0:
	mov	[bp+arg_0], 0FFFFh
	mov	[bp+arg_2], 0FFh
loc_22FEA:
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_22FF5:
	retf
sub_22FC7 endp

; Attributes: bp-based frame

rev_enter proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
loc_23001:
	and	byte_4EE71, 0FDh
	push	cs
	call	near ptr sub_24126
	test	byte_4EE71, 2
	jz	short loc_23020
	sub	ax, ax
	jmp	loc_23119
loc_23020:
	push	cs
	call	near ptr rev_doQuest
	test	byte_4EE71, 2
	jnz	short loc_23001
loc_23030:
	mov	ax, offset aTheLastOfTheGu
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 0
	mov	[bp+var_6], 0
	jmp	short loc_2304C
loc_23049:
	inc	[bp+var_6]
loc_2304C:
	cmp	[bp+var_6], 5
	jge	short loc_23070
	mov	bl, gs:txt_numLines
	sub	bh, bh
	sub	bx, [bp+var_6]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_2], ax
	jmp	short loc_23049
loc_23070:
	push	[bp+var_2]
	call	getKey
	add	sp, 2
	mov	[bp+var_4], ax
	cmp	ax, 10Eh
	jl	short loc_23098
	cmp	ax, 119h
	jg	short loc_23098
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 4
	sub	[bp+var_4], ax
loc_23098:
	mov	ax, [bp+var_4]
	jmp	short loc_230D7
loc_2309D:
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr rev_checkXP
	add	sp, 2
	jmp	short loc_23105
loc_230A9:
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr rev_learnSpells
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	jmp	short loc_23105
loc_230BF:
	push	cs
	call	near ptr rev_changeMageClass
	jmp	short loc_23105
loc_230C5:
	push	cs
	call	near ptr rev_speakToElder
	mov	byte ptr g_printPartyFlag,	0
loc_230D3:
	jmp	short loc_23105
	jmp	short loc_23105
loc_230D7:
	cmp	ax, 'T'
	jz	short loc_230C5
	jg	short loc_230EF
	cmp	ax, 'A'
	jz	short loc_2309D
	cmp	ax, 'C'
	jz	short loc_230BF
	cmp	ax, 'S'
	jz	short loc_230A9
	jmp	short loc_230D3
loc_230EF:
	cmp	ax, 10Eh
	jz	short loc_2309D
	cmp	ax, 10Fh
	jz	short loc_230A9
	cmp	ax, 110h
	jz	short loc_230BF
	cmp	ax, 111h
	jz	short loc_230C5
	jmp	short loc_230D3
loc_23105:
	cmp	[bp+var_4], 'E'
	jz	short loc_23115
	cmp	[bp+var_4], 112h
	jz	short loc_23115
	jmp	loc_23030
loc_23115:
	sub	ax, ax
	jmp	short $+2
loc_23119:
	mov	sp, bp
	pop	bp
	retf
rev_enter endp

; Attributes: bp-based frame

rev_checkXP proc far

	var_10A= word ptr -10Ah
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
loc_23128:
	mov	ax, offset aTheGuildElderP
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_6], ax
	or	ax, ax
	jge	short loc_23144
	jmp	loc_2329B
loc_23144:
	getCharP	[bp+var_6], bx
	test	gs:party.status[bx], 0Ch
	jz	short loc_23174
	mov	ax, offset aHmmm___ShouldI
	push	ds
	push	ax
	lea	ax, [bp+var_10A]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	loc_23274
loc_23174:
	mov	ax, offset aTheGuildElderD
	push	ds
	push	ax
	lea	ax, [bp+var_10A]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	getCharP	[bp+var_6], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	getCharP	[bp+var_6], bx
	cmp	gs:party.class[bx], class_monster
	jnz	short loc_231E2
	mov	ax, offset aCannotBeRaised
	push	ds
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	loc_23274
loc_231E2:
	push	[bp+var_6]
	push	cs
	call	near ptr rev_getXPDelta
	add	sp, 2
	mov	[bp+var_A], ax
	mov	[bp+var_8], dx
	or	dx, dx
	jg	short loc_23229
	jl	short loc_231FC
	or	ax, ax
	jnz	short loc_23229
loc_231FC:
	mov	ax, offset aHathEarnedALev
	push	ds
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	push	dx
	push	ax
	push	[bp+var_6]
	push	cs
	call	near ptr rev_doAdvance
	add	sp, 6
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	jmp	short loc_23274
loc_23229:
	mov	ax, offset aStillNeedeth
	push	ds
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	sub	ax, ax
	push	ax
	push	[bp+var_8]
	push	[bp+var_A]
	push	dx
	push	[bp+var_4]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset aExperiencePoin
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_23274:
	lea	ax, [bp+var_10A]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	wait4IO
	jmp	loc_23128
loc_2329B:
	mov	sp, bp
	pop	bp
	retf
rev_checkXP endp

; Attributes: bp-based frame

rev_doAdvance proc far

	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si
	getCharP	[bp+charNo], si
	inc	gs:party.maxLevel[si]
	mov	ax, gs:party.maxLevel[si]
	mov	gs:party.level[si], ax
	push	[bp+charNo]
	push	cs
	call	near ptr _rev_removeAgeStatus
	add	sp, 2
	mov	[bp+var_8], ax
	getCharP	[bp+charNo], si
	call	_random
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, hpLevelBonusMask[bx]
	sub	ah, ah
	and	ax, cx
	mov	cl, gs:party.constitution[si]
	sub	ch, ch
	shr	cx, 1
	shr	cx, 1
	add	ax, cx
	mov	[bp+var_4], ax
	mov	ax, gs:party.currentHP[si]
	add	ax, [bp+var_4]
	sub	cx, cx
	push	cx
	push	ax
	push	cs
	call	near ptr _returnValueOrFFFF
	add	sp, 4
	mov	gs:party.currentHP[si], ax
	getCharP	[bp+charNo], bx
	mov	ax, gs:party.maxHP[bx]
	add	ax, [bp+var_4]
	sub	cx, cx
	push	cx
	push	ax
	push	cs
	call	near ptr _returnValueOrFFFF
	add	sp, 4
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:party.maxHP[bx], cx
	getCharP	[bp+charNo], bx
	mov	al, gs:party.class[bx]
	sub	ah, ah
	jmp	loc_23562
fighterLevelUp:
	getCharP	[bp+charNo], si
	mov	ax, gs:party.level[si]
	dec	ax
	shr	ax, 1
	shr	ax, 1
	mov	[bp+var_2], ax
	cmp	ax, 8
	jge	short loc_2338C
	mov	al, byte ptr [bp+var_2]
	jmp	short loc_2338E
loc_2338C:
	mov	al, 7
loc_2338E:
	mov	gs:party.numAttacks[si], al
	jmp	loc_23594
rogueLevelUp:
	call	rnd_1d8
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	al, gs:party.dexterity[bx]
	sub	ah, ah
	mov	dx, cx
	mov	cl, 3
	shr	ax, cl
	add	ax, dx
	mov	[bp+var_2], ax
	getCharP	[bp+charNo], bx
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	add	ax, [bp+var_2]
	push	ax
	call	_returnXor255
	add	sp, 2
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:party.specAbil[bx],	cl
	call	rnd_1d8
	add	[bp+var_2], ax
	getCharP	[bp+charNo], bx
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	add	ax, [bp+var_2]
	push	ax
	call	_returnXor255
	add	sp, 2
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:(party.specAbil+1)[bx], cl
	call	rnd_1d8
	add	[bp+var_2], ax
	getCharP	[bp+charNo], bx
	mov	al, gs:(party.specAbil+2)[bx]
	sub	ah, ah
	add	ax, [bp+var_2]
	push	ax
	call	_returnXor255
	add	sp, 2
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:(party.specAbil+2)[bx], cl
	jmp	loc_23594
bardLevelUp:
	getCharP	[bp+charNo], si
	push	gs:party.level[si]
	call	_returnXor255
	add	sp, 2
	mov	gs:party.specAbil[si],	al
	jmp	loc_23594
hunterLevelUp:
	call	rnd_1d8
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	al, gs:party.dexterity[bx]
	sub	ah, ah
	mov	dx, cx
	mov	cl, 3
	shr	ax, cl
	add	ax, dx
	mov	[bp+var_2], ax
	getCharP	[bp+charNo], bx
	mov	al, gs:party.specAbil[bx]
	sub	ah, ah
	add	ax, [bp+var_2]
	push	ax
	call	_returnXor255
	add	sp, 2
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:party.specAbil[bx],	cl
	jmp	loc_23594
mageLevelUp:
	call	_random
	and	ax, 3
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	al, gs:party.intelligence[bx]
	sub	ah, ah
	shr	ax, 1
	shr	ax, 1
	add	ax, cx
	inc	ax
	mov	[bp+var_2], ax
	getCharP	[bp+charNo], bx
	mov	ax, gs:party.currentSppt[bx]
	add	ax, [bp+var_2]
	sub	cx, cx
	push	cx
	push	ax
	push	cs
	call	near ptr _returnValueOrFFFF
	add	sp, 4
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:party.currentSppt[bx], cx
	getCharP	[bp+charNo], bx
	mov	ax, gs:party.maxSppt[bx]
	add	ax, [bp+var_2]
	sub	cx, cx
	push	cx
	push	ax
	push	cs
	call	near ptr _returnValueOrFFFF
	add	sp, 4
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:party.maxSppt[bx], cx
	jmp	short loc_23594
	jmp	short loc_23594
loc_23562:
	or	ax, ax
	jnz	short loc_23569
	jmp	fighterLevelUp
loc_23569:
	cmp	ax, class_rogue
	jnz	short loc_23571
	jmp	rogueLevelUp
loc_23571:
	cmp	ax, class_bard
	jnz	short loc_23579
	jmp	bardLevelUp
loc_23579:
	cmp	ax, class_paladin
	jnz	short loc_23581
	jmp	fighterLevelUp
loc_23581:
	cmp	ax, class_hunter
	jnz	short loc_23589
	jmp	hunterLevelUp
loc_23589:
	cmp	ax, class_monk
	jnz	short loc_23591
	jmp	fighterLevelUp
loc_23591:
	jmp	mageLevelUp
loc_23594:
	mov	ax, 4
	push	ax
	sub	ax, ax
	push	ax
	call	randomBetweenXandY
	add	sp, 4
	mov	[bp+var_6], ax
	getCharIndex	ax, [bp+charNo]
	add	ax, offset party.strength
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], seg seg027
	jmp	short loc_235BC
loc_235B9:
	inc	[bp+var_6]
loc_235BC:
	cmp	[bp+var_6], 5
	jge	short loc_23619
	mov	bx, [bp+var_6]
	lfs	si, [bp+var_C]
	cmp	byte ptr fs:[bx+si], 30
	jl	short loc_235D4
	mov	byte ptr fs:[bx+si], 30
	jmp	short loc_23617
loc_235D4:
	mov	bx, [bp+var_6]
	lfs	si, [bp+var_C]
	inc	byte ptr fs:[bx+si]
	mov	ax, offset a1To
	push	ds
	push	ax
	push	[bp+arg_4]
	push	[bp+arg_2]
	call	_strcat
	add	sp, 8
	mov	[bp+arg_2], ax
	mov	[bp+arg_4], dx
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (fullAttributeString+2)[bx]
	push	word ptr fullAttributeString[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+arg_2], ax
	mov	[bp+arg_4], dx
	jmp	short loc_23619
loc_23617:
	jmp	short loc_235B9
loc_23619:
	cmp	[bp+var_8], 0
	jz	short loc_23629
	push	[bp+charNo]
	push	cs
	call	near ptr _rev_resetAgeStatus
	add	sp, 2
loc_23629:
	mov	ax, [bp+arg_2]
	mov	dx, [bp+arg_4]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
rev_doAdvance endp

; This function	returns	the difference between the
; players experience points and the requirements
; for the next level.
; Attributes: bp-based frame

rev_getXPDelta proc far

	var_2= word ptr	-2
	playerNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	getCharP	[bp+playerNo], bx
	mov	ax, gs:party.maxLevel[bx]
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_23689
	dec	ax
	push	ax
	push	[bp+playerNo]
	call	getLevelXp
	add	sp, 4
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+playerNo], si
	mov	ax, cx
	mov	dx, bx
	sub	ax, word ptr gs:party.experience[si]
	sbb	dx, word ptr gs:(party.experience+2)[si]
	jmp	short loc_236A4
	jmp	short loc_236A4
loc_23689:
	getCharP	[bp+playerNo], bx
	mov	ax, word ptr gs:party.experience[bx]
	mov	dx, word ptr gs:(party.experience+2)[bx]
	neg	ax
	adc	dx, 0
	neg	dx
	jmp	short $+2
loc_236A4:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rev_getXPDelta endp

; Attributes: bp-based frame

rev_learnSpells	proc far

	var_10E= word ptr -10Eh
	var_E= word ptr	-0Eh
	spellBase= word	ptr -0Ch
	counter= word ptr -0Ah
	var_8= word ptr	-8
	var_6= dword ptr -6
	charNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 10Eh
	call	someStackOperation
	push	si
	mov	ax, offset aWhoSeeksKnowle
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+charNo], ax
	or	ax, ax
	jge	short loc_236D1
	jmp	loc_238B7
loc_236D1:
	getCharP	[bp+charNo], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+spellBase],	ax
	cmp	ax, 0FFh
	jnz	short loc_23707
	mov	ax, offset aThouArtNotASpe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_238B7
loc_23707:
	mov	[bp+counter], 0
	jmp	short loc_23711
loc_2370E:
	inc	[bp+counter]
loc_23711:
	cmp	[bp+counter], 7
	jge	short loc_2372F
	push	[bp+spellBase]
	push	[bp+counter]
	push	[bp+charNo]
	push	cs
	call	near ptr mage_hasLearnedSpLevel
	add	sp, 6
	or	ax, ax
	jnz	short loc_2372D
	jmp	short loc_2372F
loc_2372D:
	jmp	short loc_2370E
loc_2372F:
	cmp	[bp+counter], 6
	jle	short loc_23745
	mov	ax, offset aThouHathLearne
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_238B7
loc_23745:
	getCharP	[bp+charNo], bx
	mov	ax, gs:party.level[bx]
	inc	ax
	shr	ax, 1
	mov	cx, [bp+counter]
	inc	cx
	cmp	ax, cx
	jnb	short loc_23771
	mov	ax, offset aThouCannotAcqu
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_238B7
loc_23771:
	getCharP	[bp+charNo], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (classString+2)[bx]
	push	word ptr classString[bx]
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	mov	ax, offset aSpellLevel
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_6]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	lfs	bx, [bp+var_6]
	inc	word ptr [bp+var_6]
	mov	al, byte ptr [bp+counter]
	add	al, '1'
	mov	fs:[bx], al
	mov	ax, offset aWillCost
	push	ds
	push	ax
	push	word ptr [bp+var_6+2]
	push	word ptr [bp+var_6]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	mov	bx, [bp+counter]
	shl	bx, 1
	mov	ax, spellLevelCost[bx]
	mov	[bp+var_8], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_8]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+var_6+2]
	push	word ptr [bp+var_6]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	mov	ax, offset aInGold_WhoWill
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_6]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_E], ax
	or	ax, ax
	jge	short loc_23844
	jmp	short loc_238B7
loc_23844:
	mov	ax, [bp+var_8]
	cwd
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_E], si
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_23877
	jb	short loc_23868
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_23877
loc_23868:
	mov	ax, offset aNotEnoughGoldNL
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	short loc_238B4
loc_23877:
	mov	ax, [bp+var_8]
	cwd
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_E], si
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, offset aTheElderTeache
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	push	[bp+spellBase]
	push	[bp+counter]
	push	[bp+charNo]
	push	cs
	call	near ptr mage_learnSpellLevel
	add	sp, 6
	jmp	short loc_238B7
loc_238B4:
	jmp	loc_23771
loc_238B7:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rev_learnSpells	endp

; Attributes: bp-based frame

mage_conjurorReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	mov	cx, ax
	cmp	cx, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mage_conjurorReqCheck endp

; Attributes: bp-based frame

mage_magicianReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 0Eh
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	mov	cx, ax
	cmp	cx, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mage_magicianReqCheck endp

; Attributes: bp-based frame

mage_sorcererReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1Ch
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	or	ax, ax
	jz	short loc_23929
	sub	ax, ax
	jmp	short loc_23941
loc_23929:
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_countClassesGained
	add	sp, 2
	cmp	ax, 1
	jl	short loc_2393D
	mov	ax, 1
	jmp	short loc_2393F
loc_2393D:
	sub	ax, ax
loc_2393F:
	jmp	short $+2
loc_23941:
	mov	sp, bp
	pop	bp
	retf
mage_sorcererReqCheck endp

; Attributes: bp-based frame

mage_wizardReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 2Ah
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	or	ax, ax
	jz	short loc_23965
	sub	ax, ax
	jmp	short loc_2397D
loc_23965:
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_countClassesGained
	add	sp, 2
	cmp	ax, 2
	jl	short loc_23979
	mov	ax, 1
	jmp	short loc_2397B
loc_23979:
	sub	ax, ax
loc_2397B:
	jmp	short $+2
loc_2397D:
	mov	sp, bp
	pop	bp
	retf
mage_wizardReqCheck endp

; Attributes: bp-based frame

mage_archmageReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 38h	
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	or	ax, ax
	jz	short loc_239A1
	sub	ax, ax
	jmp	short loc_239B9
loc_239A1:
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_countClassesGained
	add	sp, 2
	cmp	ax, 3
	jl	short loc_239B5
	mov	ax, 1
	jmp	short loc_239B7
loc_239B5:
	sub	ax, ax
loc_239B7:
	jmp	short $+2
loc_239B9:
	mov	sp, bp
	pop	bp
	retf
mage_archmageReqCheck endp

; Attributes: bp-based frame

mage_chronoReqCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 46h	
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	or	ax, ax
	jz	short loc_239DD
	sub	ax, ax
	jmp	short loc_239F5
loc_239DD:
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_countClassesGained
	add	sp, 2
	cmp	ax, 2
	jl	short loc_239F1
	mov	ax, 1
	jmp	short loc_239F3
loc_239F1:
	sub	ax, ax
loc_239F3:
	jmp	short $+2
loc_239F5:
	mov	sp, bp
	pop	bp
	retf
mage_chronoReqCheck endp

; Attributes: bp-based frame

rev_changeMageClass proc far

	var_78=	word ptr -78h
	var_24=	byte ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	counter= word ptr -1Eh
	charNo=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	push	si
	mov	ax, offset aWhichMageSeeks
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+charNo], ax
	or	ax, ax
	jge	short loc_23A21
	jmp	loc_23C5A
loc_23A21:
	getCharP	[bp+charNo], bx
	mov	al, gs:party.class[bx]
	mov	[bp+var_24], al
	cmp	al, class_chronomancer
	jz	short loc_23A3D
	cmp	al, class_geomancer
	jnz	short loc_23A4D
loc_23A3D:
	mov	ax, offset aThouCannotChan
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_23C5A
loc_23A4D:
	getCharP	[bp+charNo], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+var_20], ax
	cmp	ax, 0FFh
	jnz	short loc_23A83
	mov	ax, offset aThouArtNotASpe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_23C5A
loc_23A83:
	mov	[bp+counter], 0
	jmp	short loc_23A8D
loc_23A8A:
	inc	[bp+counter]
loc_23A8D:
	cmp	[bp+counter], 3
	jge	short loc_23AB9
	push	[bp+var_20]
	push	[bp+counter]
	push	[bp+charNo]
	push	cs
	call	near ptr mage_hasLearnedSpLevel
	add	sp, 6
	or	ax, ax
	jnz	short loc_23AB7
	mov	ax, offset aYouMustKnowAtL
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_23C5A
loc_23AB7:
	jmp	short loc_23A8A
loc_23AB9:
	mov	[bp+var_22], 0
	mov	[bp+var_2], 0
	mov	[bp+counter], 0
	jmp	short loc_23ACD
loc_23ACA:
	inc	[bp+counter]
loc_23ACD:
	cmp	[bp+counter], 6
	jge	short loc_23B2B
	push	[bp+charNo]
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	call	off_4A6A4[bx]
	add	sp, 2
	or	ax, ax
	jz	short loc_23B29
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (magicUserString+2)[bx]
	push	word ptr magicUserString[bx]
	push	[bp+var_22]
	call	printListItem
	add	sp, 6
	mov	si, [bp+var_22]
	inc	[bp+var_22]
	shl	si, 1
	mov	ax, [bp+counter]
	mov	[bp+si+var_16],	ax
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_2], ax
loc_23B29:
	jmp	short loc_23ACA
loc_23B2B:
	cmp	[bp+var_22], 0
	jnz	short loc_23B41
	mov	ax, offset aTheeDoesnTQual
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_23C5A
loc_23B41:
	mov	ax, offset aWhichClassShal
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_23B4E:
	push	[bp+var_2]
	call	getKey
	add	sp, 2
	mov	[bp+var_1A], ax
	cmp	ax, 1Bh
	jnz	short loc_23B64
	jmp	loc_23C5A
loc_23B64:
	cmp	[bp+var_1A], 10Eh
	jl	short loc_23B77
	cmp	[bp+var_1A], 119h
	jg	short loc_23B77
	sub	[bp+var_1A], 0DEh 
loc_23B77:
	cmp	[bp+var_1A], 31h 
	jl	short loc_23B4E
	mov	ax, [bp+var_22]
	add	ax, 31h	
	cmp	ax, [bp+var_1A]
	jl	short loc_23B4E
	mov	si, [bp+var_1A]
	shl	si, 1
	mov	ax, [bp+si+var_78]
	mov	[bp+counter], ax
	cmp	ax, 5
	jnz	short loc_23BE2
	mov	ax, offset aTheeUnderstand
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aDostThouAccept
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_23BBE
	jmp	loc_23C5A
loc_23BBE:
	mov	ax, offset aKnowThisTheSpe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aThereIsALargeG
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	push	[bp+charNo]
	push	cs
	call	near ptr mage_removeAllSpells
	add	sp, 2
loc_23BE2:
	getCharP	[bp+charNo], si
	mov	bx, [bp+counter]
	mov	al, byte_4A6BC[bx]
	sub	ah, ah
	mov	[bp+var_18], ax
	mov	cl, gs:party.class[si]
	sub	ch, ch
	cmp	ax, cx
	jz	short loc_23C5A
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	gs:party.maxLevel[si],	1
	mov	gs:party.level[si], 1
	mov	al, byte ptr [bp+var_18]
	mov	gs:party.class[si], al
	mov	bx, [bp+var_18]
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	push	ax
	sub	ax, ax
	push	ax
	push	[bp+charNo]
	push	cs
	call	near ptr mage_learnSpellLevel
	add	sp, 6
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, offset aNowThouBeginsT
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
loc_23C5A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rev_changeMageClass endp

; Attributes: bp-based frame

mage_learnSpellLevel proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+arg_2]
	shl	ax, 1
	add	ax, [bp+arg_4]
	mov	[bp+var_4], ax
	mov	bx, ax
	mov	al, byte ptr stru_489E2.levelBase[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, stru_489E2.numSpells[bx]
	mov	[bp+var_6], ax
loc_23C87:
	mov	ax, [bp+var_6]
	dec	[bp+var_6]
	or	ax, ax
	jz	short loc_23CA4
	push	[bp+var_2]
	inc	[bp+var_2]
	push	[bp+charNo]
	call	mage_learnSpell
	add	sp, 4
	jmp	short loc_23C87
loc_23CA4:
	mov	sp, bp
	pop	bp
	retf
mage_learnSpellLevel endp

; Attributes: bp-based frame

mage_hasLearnedSpLevel proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6
	_offset= word ptr  8
	base= word ptr	0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+_offset]
	shl	ax, 1
	add	ax, [bp+base]
	mov	[bp+var_4], ax
	mov	bx, ax
	mov	al, byte ptr stru_489E2.levelBase[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, stru_489E2.numSpells[bx]
	mov	[bp+var_6], ax
loc_23CD0:
	mov	ax, [bp+var_6]
	dec	[bp+var_6]
	or	ax, ax
	jz	short loc_23CF5
	push	[bp+var_2]
	inc	[bp+var_2]
	push	[bp+charNo]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jnz	short loc_23CF3
	sub	ax, ax
	jmp	short loc_23CFA
loc_23CF3:
	jmp	short loc_23CD0
loc_23CF5:
	mov	ax, 1
	jmp	short $+2
loc_23CFA:
	mov	sp, bp
	pop	bp
	retf
mage_hasLearnedSpLevel endp

; This function	returns	0 if the mage has learned
; at least one level of	a certain mage class
; Attributes: bp-based frame

mage_learnedClassSpLevel proc far

	spellLevel= word ptr -2
	charNo=	word ptr  6
	spellBase= word	ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+spellLevel], 6
	jmp	short loc_23D13
loc_23D10:
	dec	[bp+spellLevel]
loc_23D13:
	cmp	[bp+spellLevel], 0
	jl	short loc_23D33
	push	[bp+spellBase]
	push	[bp+spellLevel]
	push	[bp+charNo]
	push	cs
	call	near ptr mage_hasLearnedSpLevel
	add	sp, 6
	or	ax, ax
	jnz	short loc_23D31
	sub	ax, ax
	jmp	short loc_23D38
loc_23D31:
	jmp	short loc_23D10
loc_23D33:
	mov	ax, 1
	jmp	short $+2
loc_23D38:
	mov	sp, bp
	pop	bp
	retf
mage_learnedClassSpLevel endp

; This function	returns	the number of classes that
; a mage has learned a spell level as. This is used,
; for example, to ensure that a	mage has learned two
; classes before changing to a wizard.
; Attributes: bp-based frame

mage_countClassesGained	proc far

	rval= word ptr -4
	counter= word ptr -2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+rval], 0
	mov	[bp+counter], 0
	jmp	short loc_23D56
loc_23D53:
	inc	[bp+counter]
loc_23D56:
	cmp	[bp+counter], 6
	jge	short loc_23D7F
	mov	ax, [bp+counter]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_learnedClassSpLevel
	add	sp, 4
	or	ax, ax
	jz	short loc_23D7D
	inc	[bp+rval]
loc_23D7D:
	jmp	short loc_23D53
loc_23D7F:
	mov	ax, [bp+rval]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mage_countClassesGained	endp

; Attributes: bp-based frame

mage_removeAllSpells proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_23D9D
loc_23D9A:
	inc	[bp+var_2]
loc_23D9D:
	cmp	[bp+var_2], 0Eh
	jge	short loc_23DBA
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_2]
	mov	gs:party.spells[bx], 0
	jmp	short loc_23D9A
loc_23DBA:
	mov	sp, bp
	pop	bp
	retf
mage_removeAllSpells endp

; Attributes: bp-based frame

rev_speakToElder proc far

	charNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_23DC9:
	mov	ax, offset aWhoWishsToSpea
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+charNo], ax
	or	ax, ax
	jge	short loc_23DE5
	jmp	loc_23E8B
loc_23DE5:
	sub	ax, ax
	push	ax
	push	[bp+charNo]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_23E06
	mov	ax, offset aSeekOutBrilhas
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	loc_23E88
loc_23E06:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_chronomancer
	jz	short loc_23E29
	mov	ax, offset aILlTeachOnlyAC
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	jmp	short loc_23E88
loc_23E29:
	push	[bp+charNo]
	push	cs
	call	near ptr rev_chronGelidia
	add	sp, 2
	or	ax, ax
	jnz	short loc_23E7C
	push	[bp+charNo]
	push	cs
	call	near ptr rev_chronLucencia
	add	sp, 2
	or	ax, ax
	jnz	short loc_23E7C
	push	[bp+charNo]
	push	cs
	call	near ptr rev_chronKinestia
	add	sp, 2
	or	ax, ax
	jnz	short loc_23E7C
	push	[bp+charNo]
	push	cs
	call	near ptr rev_chronTenebrosia
	add	sp, 2
	or	ax, ax
	jnz	short loc_23E7C
	push	[bp+charNo]
	push	cs
	call	near ptr rev_chronTarmitia
	add	sp, 2
	or	ax, ax
	jnz	short loc_23E7C
	mov	ax, offset aHurryTimeIsRun
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_23E7C:
	wait4IO
loc_23E88:
	jmp	loc_23DC9
loc_23E8B:
	mov	sp, bp
	pop	bp
	retf
rev_speakToElder endp

; Attributes: bp-based frame

rev_chronGelidia proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 2
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_23EAF
	sub	ax, ax
	jmp	short loc_23F03
loc_23EAF:
	mov	ax, 54h	
	push	ax
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_23EC6
	sub	ax, ax
	jmp	short loc_23F03
loc_23EC6:
	mov	ax, offset aGelidiaTheLand
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aToTheNorthIsCo
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 54h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 55h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_23F03:
	mov	sp, bp
	pop	bp
	retf
rev_chronGelidia endp

; Attributes: bp-based frame

rev_chronLucencia proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 4
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_23F27
	sub	ax, ax
	jmp	short loc_23F7B
loc_23F27:
	mov	ax, 58h	
	push	ax
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_23F3E
	sub	ax, ax
	jmp	short loc_23F7B
loc_23F3E:
	mov	ax, offset aLucenciaIsEnte
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aToTheEastIsACr
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 58h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 59h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_23F7B:
	mov	sp, bp
	pop	bp
	retf
rev_chronLucencia endp

; Attributes: bp-based frame

rev_chronKinestia proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 6
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_23F9F
	sub	ax, ax
	jmp	short loc_23FF3
loc_23F9F:
	mov	ax, 5Ch	
	push	ax
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_23FB6
	sub	ax, ax
	jmp	short loc_23FF3
loc_23FB6:
	mov	ax, offset aKinestiaTheDim
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aToTheSouthWest
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 5Ch	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 5Dh	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_23FF3:
	mov	sp, bp
	pop	bp
	retf
rev_chronKinestia endp

; Attributes: bp-based frame

rev_chronTenebrosia proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 8
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_24017
	sub	ax, ax
	jmp	short loc_2406B
loc_24017:
	mov	ax, 60h	
	push	ax
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_2402E
	sub	ax, ax
	jmp	short loc_2406B
loc_2402E:
	mov	ax, offset aTenebrosiaCanB
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aToTheSoutheast
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 60h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 61h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_2406B:
	mov	sp, bp
	pop	bp
	retf
rev_chronTenebrosia endp

; Attributes: bp-based frame

rev_chronTarmitia proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 0Ah
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr chrono_isQuestComplete
	add	sp, 4
	or	ax, ax
	jnz	short loc_2408F
	sub	ax, ax
	jmp	short loc_240E3
loc_2408F:
	mov	ax, 64h	
	push	ax
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_240A6
	sub	ax, ax
	jmp	short loc_240E3
loc_240A6:
	mov	ax, offset aTarmitiaIsEnte
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aToTheSouthIsAV
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 64h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 65h	
	push	ax
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 1
	jmp	short $+2
loc_240E3:
	mov	sp, bp
	pop	bp
	retf
rev_chronTarmitia endp

; This function	returns	non-zero if the	chronomancer
; quest	flag has been set in charNo
; Attributes: bp-based frame

chrono_isQuestComplete proc far

	charNo=	word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+charNo], bx
	mov	ax, [bp+arg_2]
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+arg_2]
	and	bx, 7
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
chrono_isQuestComplete endp

; Attributes: bp-based frame

sub_24126 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	ax, 0Ch
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_6], cx
	or	cx, cx
	jz	short loc_24150
	mov	ax, 32h	
	jmp	short loc_24153
loc_24150:
	mov	ax, 2Fh	
loc_24153:
	mov	[bp+var_8], ax
	cmp	[bp+var_6], 0
	jz	short loc_24161
	mov	ax, offset s_building
	jmp	short loc_24164
loc_24161:
	mov	ax, offset aReviewBoard
loc_24164:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	[bp+var_8]
	call	bigpic_drawPictureNumber
	add	sp, 2
	push	[bp+var_2]
	push	[bp+var_4]
	call	setTitle
	add	sp, 4
	cmp	[bp+var_6], 0
	jz	short loc_241B7
	call	text_clear
	mov	ax, offset aTheOldReviewBo
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Eh	
	push	ax
	call	_updateFlags
	add	sp, 4
	wait4IO
loc_241B7:
	mov	sp, bp
	pop	bp
	retf
sub_24126 endp

; Attributes: bp-based frame

chron_questBrilhasti proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 35
	push	ax
	call	_partyCharUnderLevel
	add	sp, 2
	or	ax, ax
	jnz	short loc_24250
	mov	ax, quest_brilhastDone
	push	ax
	call	chron_questFlagSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_24250
	mov	ax, quest_brilhastActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_241F9
	sub	ax, ax
	jmp	short loc_2426C
loc_241F9:
	mov	ax, offset aTheOldManInThe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aBeneathSkaraBr
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aYouMayEnterThe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aDestroyBrilhas
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_brilhastActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_2426C
	jmp	short loc_2426C
loc_24250:
	mov	ax, quest_brilhastActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_brilhastDone
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	sub	ax, ax
	jmp	short $+2
loc_2426C:
	mov	sp, bp
	pop	bp
	retf
chron_questBrilhasti endp

; Attributes: bp-based frame

chron_questValarian proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_2428C
	jmp	loc_24347
loc_2428C:
	mov	ax, quest_valarianDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_2429F
	jmp	loc_24347
loc_2429F:
	mov	ax, quest_brilhastDone
	push	ax
	call	chron_questFlagSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_242B2
	jmp	loc_24347
loc_242B2:
	mov	ax, offset aWelcomeYeChild
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aThatWhichHasLa
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aIfYouCannotSto
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aPrepareThyselv
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aAboriaTheHomeO
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aBringToMeValar
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aYesAndBeOnTheL
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_brilhastActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_brilhastDone
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	sub	ax, ax
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_2434B
	jmp	short loc_2434B
loc_24347:
	sub	ax, ax
	jmp	short $+2
loc_2434B:
	mov	sp, bp
	pop	bp
	retf
chron_questValarian endp

; Attributes: bp-based frame
chron_questLanatir proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 2
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_2436C
	jmp	loc_2441C
loc_2436C:
	mov	ax, quest_lanatirDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_2437F
	jmp	loc_2441C
loc_2437F:
	mov	ax, 7Bh	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jnz	short loc_24392
	jmp	loc_2441C
loc_24392:
	mov	ax, 7Ch	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_2441C
	mov	ax, 7Bh	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, 7Ch	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, offset aTheOldManTakes
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aYouHaveDoneWel
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aItIsTheDimensi
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aBringLanatirWi
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_lanatirActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	sub	ax, ax
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_24420
	jmp	short loc_24420
loc_2441C:
	sub	ax, ax
	jmp	short $+2
loc_24420:
	mov	sp, bp
	pop	bp
	retf
chron_questLanatir endp

; Attributes: bp-based frame
chron_questAlliria proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, quest_alliriaDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_24441
	jmp	loc_244E2
loc_24441:
	mov	ax, quest_alliriaActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_24454
	jmp	loc_244E2
loc_24454:
	mov	ax, 73h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_244E2
	mov	ax, 74h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_244E2
	mov	ax, 73h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, 74h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, offset aTheOldManAppea
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aHisEyesFocusUp
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aIDareNotHopeAl
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_lanatirActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_alliriaActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_244E6
	jmp	short loc_244E6
loc_244E2:
	sub	ax, ax
	jmp	short $+2
loc_244E6:
	mov	sp, bp
	pop	bp
	retf
chron_questAlliria endp

; Attributes: bp-based frame

chron_questFerofist proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, quest_ferofistDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_24507
	jmp	loc_245B8
loc_24507:
	mov	ax, quest_ferofistActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_2451A
	jmp	loc_245B8
loc_2451A:
	mov	ax, 87h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jnz	short loc_2452D
	jmp	loc_245B8
loc_2452D:
	mov	ax, 88h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_245B8
	mov	ax, 87h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, 88h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, offset aTheOldManSLook
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aQuicklyThenMyC
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aYouMustReturnH
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aHurryThePaceQu
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_ferofistActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_alliriaActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_245BC
	jmp	short loc_245BC
loc_245B8:
	sub	ax, ax
	jmp	short $+2
loc_245BC:
	mov	sp, bp
	pop	bp
	retf
chron_questFerofist endp

; Attributes: bp-based frame

chron_questSceadu proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, quest_sceaduActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_245DD
	jmp	loc_2468E
loc_245DD:
	mov	ax, quest_sceaduDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_245F0
	jmp	loc_2468E
loc_245F0:
	mov	ax, 98h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jnz	short loc_24603
	jmp	loc_2468E
loc_24603:
	mov	ax, 99h	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_2468E
	mov	ax, 98h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, 99h	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, offset aTheOldManSEyes
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aHePausesASecon
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aRememberInTheL
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aFromThereIRequ
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_ferofistActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_sceaduActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_24692
	jmp	short loc_24692
loc_2468E:
	sub	ax, ax
	jmp	short $+2
loc_24692:
	mov	sp, bp
	pop	bp
	retf
chron_questSceadu endp

; Attributes: bp-based frame

chron_questWerra proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, quest_werraDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_246B3
	jmp	loc_24764
loc_246B3:
	mov	ax, quest_werraActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_246C6
	jmp	loc_24764
loc_246C6:
	mov	ax, 9Ch	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jnz	short loc_246D9
	jmp	loc_24764
loc_246D9:
	mov	ax, 9Dh	
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jz	short loc_24764
	mov	ax, 9Ch	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, 9Dh	
	push	ax
	call	_removeItem
	add	sp, 2
	mov	ax, offset aNoTheOldManCri
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aOffWithYouToTa
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aBringMeWerraSS
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aHisEyesLoseThe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Fh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_werraActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_sceaduActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 1
	jmp	short loc_24768
	jmp	short loc_24768
loc_24764:
	sub	ax, ax
	jmp	short $+2
loc_24768:
	mov	sp, bp
	pop	bp
	retf
chron_questWerra endp

; Attributes: bp-based frame

chron_questTarjan proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Eh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, quest_tarjanDone
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jz	short loc_247A8
	mov	ax, quest_tarjanActive
	push	ax
	call	chron_questFlagNotSet
	add	sp, 2
	or	ax, ax
	jnz	short loc_247AD
loc_247A8:
	sub	ax, ax
	jmp	loc_248A7
loc_247AD:
	sub	ax, ax
	push	ax
	mov	ax, 3Eh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, 0A0h 
	push	ax
	call	sub_19D2A
	add	sp, 2
	or	ax, ax
	jnz	short loc_247D1
	sub	ax, ax
	jmp	loc_248A7
loc_247D1:
	mov	ax, 0FFh
	push	ax
	mov	ax, 3Eh	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	ax, offset aIKnowTheOldMan
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aGatherUpThePri
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aIHavePlacedThe
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aGetYourselvesH
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, 4Ah	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aWithThoseFinal
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, quest_werraActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, quest_tarjanActive
	push	ax
	call	chron_setQuestFlag
	add	sp, 2
	mov	ax, 0FFh
	push	ax
	mov	ax, 46h	
	push	ax
	call	_updateFlags
	add	sp, 4
	mov	[bp+var_2], 0
	jmp	short loc_24860
loc_2485D:
	inc	[bp+var_2]
loc_24860:
	cmp	[bp+var_2], 7
	jge	short loc_248A2
	getCharP	[bp+var_2], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_248A0
	cmp	gs:party.class[si], class_chronomancer
	jnz	short loc_248A0
	mov	ax, 68h	
	push	ax
	push	[bp+var_2]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 69h	
	push	ax
	push	[bp+var_2]
	call	mage_learnSpell
	add	sp, 4
loc_248A0:
	jmp	short loc_2485D
loc_248A2:
	mov	ax, 1
	jmp	short $+2
loc_248A7:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chron_questTarjan endp

; Attributes: bp-based frame

rev_doQuest proc far

	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_248C1
loc_248BE:
	inc	[bp+counter]
loc_248C1:
	cmp	[bp+counter], 8
	jge	short loc_248F2
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	call	questFuncs[bx]
	or	ax, ax
	jz	short loc_248F0
	push	[bp+counter]
	push	cs
	call	near ptr sub_248F6
	add	sp, 2
	cmp	[bp+counter], 2
	jl	short loc_248F0
	cmp	[bp+counter], 7
	jge	short loc_248F0
	push	cs
	call	near ptr sub_24961
loc_248F0:
	jmp	short loc_248BE
loc_248F2:
	mov	sp, bp
	pop	bp
	retf
rev_doQuest endp

; Attributes: bp-based frame

sub_248F6 proc far

	var_6= dword ptr -6
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	di
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_2490D
loc_2490A:
	inc	[bp+var_2]
loc_2490D:
	cmp	[bp+var_2], 7
	jge	short loc_2495B
	getCharP	[bp+var_2], si
	cmp	gs:party.class[si], class_monster
	jz	short loc_24959
	mov	bx, [bp+arg_0]
	mov	al, byte_4A702[bx]
	sub	ah, ah
	add	ax, si
	add	ax, offset party.chronoQuest
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], seg seg027
	mov	al, byte_4A6FA[bx]
	sub	ah, ah
	lfs	bx, [bp+var_6]
	mov	cl, fs:[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_24959
	mov	di, [bp+arg_0]
	mov	al, byte_4A6FA[di]
	or	fs:[bx], al
loc_24959:
	jmp	short loc_2490A
loc_2495B:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_248F6 endp

; Attributes: bp-based frame

sub_24961 proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, offset aTheOldManAward
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	ax, offset aWithAWaveOfHis
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	[bp+var_2], 0
	jmp	short loc_24991
loc_2498E:
	inc	[bp+var_2]
loc_24991:
	cmp	[bp+var_2], 7
	jge	short loc_249EE
	getCharP	[bp+var_2], si
	cmp	gs:party.class[si], class_monster
	jnb	short loc_249EC
	test	gs:party.status[si], 4
	jnz	short loc_249EC
	mov	ax, word ptr gs:party.experience[si]
	mov	dx, word ptr gs:(party.experience+2)[si]
	add	ax, 27C0h
	adc	dx, 9
;	push	dx
;	push	ax
;	push	cs
;	call	near ptr sub_22FC7
;	add	sp, 4
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	getCharP	[bp+var_2], si
	mov	ax, gs:party.maxSppt[si]
	mov	gs:party.currentSppt[si], ax
loc_249EC:
	jmp	short loc_2498E
loc_249EE:
	mov	byte ptr g_printPartyFlag,	0
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_24961 endp

; Attributes: bp-based frame

_rev_removeAgeStatus proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	mov	al, gs:party.status[si]
	sub	ah, ah
	and	ax, 2
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_24A53
	mov	ax, 5
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
	getCharP	[bp+arg_0], bx
	and	gs:party.status[bx], 0FDh
loc_24A53:
	mov	ax, [bp+var_2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
_rev_removeAgeStatus endp

; Attributes: bp-based frame

_rev_resetAgeStatus proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
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
	call	_doAgeStatus
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_old
	pop	si
	mov	sp, bp
	pop	bp
	retf
_rev_resetAgeStatus endp

; Attributes: bp-based frame
enterHallOfWizards proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, offset aGuild
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, 36h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
loc_24AC6:
	mov	ax, offset aThouArtInTheHallOfW
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 0
	mov	[bp+var_6], 0
	jmp	short loc_24AE2
loc_24ADF:
	inc	[bp+var_6]
loc_24AE2:
	cmp	[bp+var_6], 4
	jge	short loc_24B06
	mov	bl, gs:txt_numLines
	sub	bh, bh
	sub	bx, [bp+var_6]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_2], ax
	jmp	short loc_24ADF
loc_24B06:
	push	[bp+var_2]
	call	getKey
	add	sp, 2
	mov	[bp+var_4], ax
	cmp	ax, 10Eh
	jl	short loc_24B2E
	cmp	ax, 119h
	jg	short loc_24B2E
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 3
	sub	[bp+var_4], ax
loc_24B2E:
	mov	ax, [bp+var_4]
	jmp	short loc_24B73
loc_24B33:
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr rev_checkXP
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	jmp	short loc_24B93
loc_24B4A:
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr rev_learnSpells
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	jmp	short loc_24B93
loc_24B61:
	push	cs
	call	near ptr nonClassSpellGain
	mov	byte ptr g_printPartyFlag,	0
loc_24B6F:
	jmp	short loc_24B93
	jmp	short loc_24B93
loc_24B73:
	cmp	ax, 41h	
	jz	short loc_24B33
	cmp	ax, 42h	
	jz	short loc_24B61
	cmp	ax, 53h	
	jz	short loc_24B4A
	cmp	ax, 10Eh
	jz	short loc_24B33
	cmp	ax, 10Fh
	jz	short loc_24B4A
	cmp	ax, 110h
	jz	short loc_24B61
	jmp	short loc_24B6F
loc_24B93:
	cmp	[bp+var_4], 45h	
	jz	short loc_24BA3
	cmp	[bp+var_4], 111h
	jz	short loc_24BA3
	jmp	loc_24AC6
loc_24BA3:
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
enterHallOfWizards endp

; Attributes: bp-based frame

nonClassSpellGain proc far

	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si
	mov	ax, offset aWhoSeeksTheSpecialK
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_102], ax
	or	ax, ax
	jge	short loc_24BD4
	jmp	loc_24D7F
loc_24BD4:
	getCharP	[bp+var_102], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short loc_24C10
	mov	ax, offset aThouArtNotASpe
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	jmp	loc_24D7F
loc_24C10:
	mov	ax, currentLocationMaybe
	jmp	short loc_24C32
loc_24C1A:
	mov	[bp+var_10A], 0
	jmp	short loc_24C3E
loc_24C22:
	mov	[bp+var_10A], 1
	jmp	short loc_24C3E
loc_24C2A:
	mov	[bp+var_10A], 2
	jmp	short loc_24C3E
loc_24C32:
	cmp	ax, 3
	jz	short loc_24C1A
	cmp	ax, 6
	jz	short loc_24C22
	jmp	short loc_24C2A
loc_24C3E:
	mov	ax, offset aThouMayLearn
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (nonClassSpellList+2)[bx]
	push	word ptr nonClassSpellList[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (specialSpellCost+2)[bx]
	push	word ptr specialSpellCost[bx]
	push	dx
	push	[bp+var_106]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	ax, offset aInGold_WhoWill
	push	ds
	push	ax
	push	dx
	push	[bp+var_106]
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_108], ax
	or	ax, ax
	jge	short loc_24CDB
	jmp	loc_24D7F
loc_24CDB:
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr specialSpellCost[bx]
	mov	dx, word ptr (specialSpellCost+2)[bx]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_108], si
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_24D27
	jb	short loc_24D0C
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_24D27
loc_24D0C:
	mov	ax, offset aNotEnoughGoldNL
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	jmp	short loc_24D7F
loc_24D27:
	mov	bx, [bp+var_10A]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr specialSpellCost[bx]
	mov	dx, word ptr (specialSpellCost+2)[bx]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_108], si
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, [bp+var_10A]
	add	ax, 7Ah	
	push	ax
	push	[bp+var_102]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, offset aTheEldersTeachYouTh
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	delayNoTable	5
loc_24D7F:
	pop	si
	mov	sp, bp
	pop	bp
locret_24D83:
	retf
nonClassSpellGain endp

seg012 ends
