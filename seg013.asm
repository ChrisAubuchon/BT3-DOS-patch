; Segment type:	Pure code
seg013 segment byte public 'CODE' use16
	assume cs:seg013
;org 4
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

dunsq_battleCheck proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	_random
	and	ax, 80h
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_24DA7
	inc	byte_4EECC

	; Add code to mask the encounter out
	push_imm	7Fh
	push_imm	2
	push	sq_east
	push	sq_north
	func_dun_maskSquare

loc_24DA7:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_24DAF:
	retf
dunsq_battleCheck endp

; Attributes: bp-based frame

dunsq_doTrap proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	push	si
	push	cs
	call	near ptr trap_levitationCheck
	mov	[bp+var_102], ax
	or	ax, ax
	jnz	short loc_24DCB
	jmp	loc_24EB3
loc_24DCB:
	call	_random
	and	ax, 3
	mov	[bp+var_10A], ax
	cmp	ax, 3
	jnz	short loc_24DDE
	jmp	short loc_24DCB
loc_24DDE:
	mov	al, levelNoMaybe
	sub	ah, ah
	and	ax, 7
	shl	ax, 1
	shl	ax, 1
	or	ax, [bp+var_10A]
	mov	gs:trapIndex, ax
	mov	ax, offset aTrapYouVeHitA
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, byte_4B278[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapTypeString+2)[bx]
	push	word ptr trapTypeString[bx]
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
	mov	bx, gs:trapIndex
	mov	al, byte_4B258[bx]
	cbw
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	[bp+var_10C], ax
	mov	si, gs:trapIndex
	shl	si, 1
	mov	al, trapSaveList._low[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, trapSaveList._high[si]
	mov	gs:monGroups.breathSaveHi, al
	mov	[bp+var_108], 0
	jmp	short loc_24E9B
loc_24E97:
	inc	[bp+var_108]
loc_24E9B:
	cmp	[bp+var_108], 7
	jge	short loc_24EB3
	push	[bp+var_10C]
	push	[bp+var_108]
	push	cs
	call	near ptr trap_doDamage
	add	sp, 4
	jmp	short loc_24E97
loc_24EB3:
	mov	byte ptr word_44166,	0
	;delayNoTable	2
	sub	ax, ax
	push	ax
	push	sq_east
	push	sq_north
	call	dun_removeTrap
	add	sp, 6
	mov	ax, [bp+var_102]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
dunsq_doTrap endp

; Attributes: bp-based frame

trap_doDamage proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	cmp	byte ptr gs:roster._name[si], 0
	jz	short loc_24F77
	test	gs:roster.status[si], stat_dead
	jnz	short loc_24F77
	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	bx, gs:trapIndex
	mov	al, byte_4B238[bx]
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
	jz	short loc_24F77
	mov	ax, 1
	mov	[bp+var_2], ax
	sar	gs:damageAmount, 1
	push	[bp+arg_0]
	call	bat_doHPDamage
	add	sp, 2
loc_24F77:
	pop	si
	mov	sp, bp
	pop	bp
	retf
trap_doDamage endp

; Attributes: bp-based frame

trap_levitationCheck proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	levitationDuration, 0
	jnz	short loc_24F97
	mov	ax, 1
	jmp	short loc_24FA9
loc_24F97:
	call	_random
	and	al, 3
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
loc_24FA9:
	mov	sp, bp
	pop	bp
	retf
trap_levitationCheck endp

; Attributes: bp-based frame

dunsq_doDarkness proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	lightDuration, 0
	jz	short loc_24FCE
	sub	ax, ax
	push	ax
	call	sub_17920
	add	sp, 2
loc_24FCE:
	mov	lightDistance, 0
	cmp	gs:byte_4266B, 0
	jz	short loc_24FF5
	cmp	gs:byte_42420, 5
	jnz	short loc_24FF5
	call	sub_22DA1
loc_24FF5:
	mov	ax, offset aDarkness
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_doDarkness endp

; Attributes: bp-based frame

dunsq_doSpinner	proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_2501F
loc_2501C:
	inc	[bp+var_2]
loc_2501F:
	cmp	[bp+var_2], 7
	jge	short loc_2503F
	mov	ax, itemEff_noSpin
	push	ax
	push	[bp+var_2]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_2503D
	mov	ax, 1
	jmp	short loc_25053
loc_2503D:
	jmp	short loc_2501C
loc_2503F:
	call	_random
	and	ax, 3
	mov	dirFacing, ax
	sub	ax, ax
	jmp	short $+2
loc_25053:
	mov	sp, bp
	pop	bp
	retf
dunsq_doSpinner	endp

; Attributes: bp-based frame

dunsq_antiMagic	proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	inc	gs:sq_antiMagicFlag

	; Change to 1 to skip over lightDuration
	mov	[bp+var_2], 1
	jmp	short loc_25075
loc_25072:
	inc	[bp+var_2]
loc_25075:
	cmp	[bp+var_2], 5
	jge	short loc_25095
	mov	bx, [bp+var_2]

	cmp	lightDuration[bx], 0
	jz	short loc_25093
	push	[bp+var_2]
	call	sub_17920
	add	sp, 2
loc_25093:
	jmp	short loc_25072
loc_25095:
	mov	byte ptr word_44166, 0
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_antiMagic	endp

; Attributes: bp-based frame

dunsq_drainHP proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	di
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_250B4
loc_250B1:
	inc	[bp+var_2]
loc_250B4:
	cmp	[bp+var_2], 7
	jge	short loc_25103
	getCharP	[bp+var_2], si
	test	gs:roster.status[si], stat_dead	or stat_stoned
	jnz	short loc_25101
	mov	al, levelNoMaybe
	sub	ah, ah
	mov	di, ax
	cmp	gs:roster.currentHP[si], di
	jbe	short loc_250EC
	sub	gs:roster.currentHP[si], di
	jmp	short loc_25101
loc_250EC:
	getCharP	[bp+var_2], si
	mov	gs:roster.currentHP[si], 0
	or	gs:roster.status[si], stat_dead
loc_25101:
	jmp	short loc_250B1
loc_25103:
	call	rost_getLastActiveSlot
	cmp	ax, 7
	jle	short loc_25118
	mov	buildingRvalMaybe, 5
loc_25118:
	mov	byte ptr word_44166, 0
	sub	ax, ax
	jmp	short $+2
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
dunsq_drainHP endp

do_partyHPRegen	proc far
	push		cx
	xor		cx, cx

loc_do_partyHPRegen_loopStart:
	cmp		cx, 7
	jge		loc_do_partyHPRegen_exit
	getCharP	cx, bx
	test		gs:roster.status[si], stat_dead or stat_stoned
	jnz		loc_do_partyHPRegen_incCounter
	mov		al, levelNoMaybe
	sub		ah, ah
	add		gs:roster.currentHP[bx], ax
	mov		ax, gs:roster.maxHP[bx]
	cmp		roster.currentHP[bx], ax
	jbe		loc_do_partyHPRegen_incCounter
	mov		gs:roster.currentHP[bx], ax

loc_do_partyHPRegen_incCounter:
	inc		cx
	jmp		loc_do_partyHPRegen_loopStart

loc_do_partyHPRegen_exit:
	pop		cx
	retf
do_partyHPRegen	endp

; Attributes: bp-based frame
dunsq_somethingOdd proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	al, al
	mov	detectType, al
	mov	gs:gl_detectSecretDoorFlag, al
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_somethingOdd endp

; Attributes: bp-based frame

dunsq_doSilence	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	gs:byte_4266B, 0
	jz	short loc_2516E
	mov	ax, offset aTheSoundOfSile
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	sub_22DA1
loc_2516E:
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_doSilence	endp

; Attributes: bp-based frame

dunsq_regenSppt	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	inc	gs:regenSpptSq
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_regenSppt	endp

; Attributes: bp-based frame

dunsq_drainSppt	proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+var_4], 0
	jmp	short loc_251A6
loc_251A3:
	inc	[bp+var_4]
loc_251A6:
	cmp	[bp+var_4], 7
	jge	short loc_251F9
	call	_random
	and	ax, 3
	mov	cl, levelNoMaybe
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	mov	cx, ax
	getCharP	[bp+var_4], bx
	cmp	gs:roster.currentSppt[bx], cx
	jbe	short loc_251E8
	getCharP	[bp+var_4], bx
	sub	gs:roster.currentSppt[bx], cx
	jmp	short loc_251F7
loc_251E8:
	getCharP	[bp+var_4], bx
	mov	gs:roster.currentSppt[bx], 0
loc_251F7:
	jmp	short loc_251A3
loc_251F9:
	mov	byte ptr word_44166,	0
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_drainSppt	endp

; Attributes: bp-based frame

dunsq_monHostile proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_25220
loc_2521D:
	inc	[bp+var_2]
loc_25220:
	cmp	[bp+var_2], 7
	jge	short loc_25240
	mov	ax, itemEff_calmMonster
	push	ax
	push	[bp+var_2]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_2523E
	mov	ax, 1
	jmp	short loc_25290
loc_2523E:
	jmp	short loc_2521D
loc_25240:
	mov	[bp+var_2], 0
	jmp	short loc_2524A
loc_25247:
	inc	[bp+var_2]
loc_2524A:
	cmp	[bp+var_2], 7
	jge	short loc_2528B
	getCharP	[bp+var_2], bx
	cmp	gs:roster.class[bx], class_monster

	; FIXED - Was jz. This activated the square when there were no monsters
	; in the party.
	jnz	short loc_25289
	call	_random
	test	al, 3
	jnz	short loc_25289
	getCharP	[bp+var_2], bx
	mov	gs:roster.hostileFlag[bx], 1
	mov	byte_4EECC, 1
loc_25289:
	jmp	short loc_25247
loc_2528B:
	mov	ax, 1
	jmp	short $+2
loc_25290:
	push_imm	7Fh
	push_imm	3
	push	sq_east
	push	sq_north
	func_dun_maskSquare

	mov	sp, bp
	pop	bp
	retf
dunsq_monHostile endp

; Attributes: bp-based frame

dunsq_doStuck proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	_random
	and	al, 3
	mov	gs:stuckFlag, al
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_doStuck endp

; Attributes: bp-based frame

dunsq_regenHP proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	inc	gs:sqRegenHPFlag
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_regenHP endp

; Attributes: bp-based frame

dunsq_doExplosion proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	lightDuration, 0
	jz	short loc_252F7
	mov	ax, offset aAnExplosion
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr dunsq_drainHP
loc_252F7:
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dunsq_doExplosion endp

; Attributes: bp-based frame

dunsq_portalAbove proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aThereIsAPortAbove
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
dunsq_portalAbove endp

; Attributes: bp-based frame

dunsq_portalBelow proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aThereIsAPortBelow
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
dunsq_portalBelow endp

; Attributes: bp-based frame

dun_doSpecialSquare proc far

	counter= word ptr -6
	var_4= dword ptr -4
	rowBuf=	dword ptr  6
	sqEast=	word ptr  0Ah
	sqNorth= word ptr  0Ch

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	sub	al, al
	mov	gs:sqRegenHPFlag, al
	mov	gs:stuckFlag, al
	mov	gs:sq_antiMagicFlag, al
	mov	gs:regenSpptSq,	al
	mov	byte_4EECC, al
	mov	bx, [bp+sqNorth]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+sqEast]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	[bp+counter], 0
	jmp	short loc_2539D
loc_2539A:
	inc	[bp+counter]
loc_2539D:
	cmp	[bp+counter], 10h
	jge	short loc_253CB
	mov	bx, [bp+counter]
	mov	bl, byte_4B326[bx]
	sub	bh, bh
	lfs	si, [bp+var_4]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, byte_4B336[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_253C9
	shl	bx, 1
	shl	bx, 1
	call	off_4B2E6[bx]
loc_253C9:
	jmp	short loc_2539A
loc_253CB:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_doSpecialSquare endp

; Attributes: bp-based frame

sub_253D0 proc far

	var_4= byte ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_253E6
loc_253E3:
	inc	[bp+var_2]
loc_253E6:
	cmp	[bp+var_2], 7
	jge	short loc_2544D
	push	[bp+var_2]
	push	cs
	call	near ptr sub_25452
	add	sp, 2
	or	ax, ax
	jz	short loc_2544B
	getCharP	[bp+var_2], bx
	mov	al, gs:roster.class[bx]
	mov	[bp+var_4], al
	or	al, al
	jz	short loc_25422
	cmp	al, 5
	jnb	short loc_25422
	push	[bp+var_2]
	push	cs
	call	near ptr sub_2549D
	add	sp, 2
	jmp	short loc_2544B
loc_25422:
	mov	ax, 34
	push	ax
	push	[bp+var_2]
	call	getXPForLevel
	add	sp, 4
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_2], si
	mov	word ptr gs:roster.experience[si], cx
	mov	word ptr gs:(roster.experience+2)[si], bx
loc_2544B:
	jmp	short loc_253E3
loc_2544D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_253D0 endp

; Attributes: bp-based frame

sub_25452 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	test	gs:(roster.chronoQuest+1)[bx], 1
	jnz	short loc_25495
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jnb	short loc_25495
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.level[bx], 35
	jnb	short loc_25495
	mov	ax, 1
	jmp	short loc_25497
loc_25495:
	sub	ax, ax
loc_25497:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_25452 endp

; Attributes: bp-based frame

sub_2549D proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_254B3
loc_254B0:
	inc	[bp+var_2]
loc_254B3:
	cmp	[bp+var_2], 74
	jge	short loc_254C9
	push	[bp+var_2]
	push	[bp+arg_0]
	call	mage_learnSpell
	add	sp, 4
	jmp	short loc_254B0
loc_254C9:
	getCharP	[bp+arg_0], si
	mov	gs:roster.class[si], class_archmage
	sub	ax, ax
	mov	word ptr gs:(roster.experience+2)[si], ax
	mov	word ptr gs:roster.experience[si], ax
	mov	ax, 14h
	push	ax
	lea	ax, roster.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr sub_25544
	add	sp, 6
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.maxHP[bx], 375
	jnb	short loc_2551F
	getCharP	[bp+arg_0], bx
	mov	gs:roster.maxHP[bx], 375
loc_2551F:
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.maxSppt[bx], 350
	jnb	short loc_2553F
	getCharP	[bp+arg_0], bx
	mov	gs:roster.maxSppt[bx], 350
loc_2553F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2549D endp

; Attributes: bp-based frame

sub_25544 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_2555A
loc_25557:
	inc	[bp+var_2]
loc_2555A:
	cmp	[bp+var_2], 5
	jge	short loc_25577
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	cmp	ax, [bp+arg_4]
	jge	short loc_25575
	mov	al, byte ptr [bp+arg_4]
	mov	fs:[bx+si], al
loc_25575:
	jmp	short loc_25557
loc_25577:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_25544 endp

; Attributes: bp-based frame
convertToGeomancer proc	far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+charNo], si
	mov	gs:roster.class[si], class_geomancer
	sub	ax, ax
	mov	word ptr gs:(roster.experience+2)[si], ax
	mov	word ptr gs:roster.experience[si], ax
	mov	gs:roster.level[si], 1
	mov	gs:roster.maxLevel[si],	1
	mov	gs:roster.currentSppt[si], 25
	mov	gs:roster.maxSppt[si], 25
	mov	ax, 0Ch
	push	ax
	push	[bp+charNo]
	push	cs
	call	near ptr sub_2561D
	add	sp, 4
	getCharP	[bp+charNo], bx
	mov	gs:roster.numAttacks[bx], 0
	mov	ax, 106
	push	ax
	push	[bp+charNo]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 107
	push	ax
	push	[bp+charNo]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 108
	push	ax
	push	[bp+charNo]
	call	mage_learnSpell
	add	sp, 4
	mov	byte ptr word_44166,	0
	pop	si
	mov	sp, bp
	pop	bp
	retf
convertToGeomancer endp

; Attributes: bp-based frame

sub_2561D proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	[bp+var_4], 0
	jmp	short loc_25634
loc_25630:
	add	[bp+var_4], 3
loc_25634:
	cmp	[bp+var_4], 24h	
	jge	short loc_2568F
	getCharP	[bp+arg_0], si
	add	si, [bp+var_4]
	mov	al, gs:roster.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	bx, ax
	mov	al, itemEquipMask[bx]
	mov	bx, [bp+arg_2]
	mov	cl, classEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_25674
	sub	ax, ax
	jmp	short loc_25677
loc_25674:
	mov	ax, 2
loc_25677:
	mov	[bp+var_2], ax
	mov	al, gs:roster.inventory.itemFlags[si]
	and	al, 0FCh
	or	al, byte ptr [bp+var_2]
	mov	gs:roster.inventory.itemFlags[si], al
	jmp	short loc_25630
loc_2568F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2561D endp

; Attributes: bp-based frame

dun_detectSquares proc far

	aheadFlags= word ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	sqE= word ptr  6
	sqN= word ptr  8
	_dirFacing= word ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	cmp	detectDuration, 0
	jnz	short loc_256AF
	jmp	loc_25768
loc_256AF:
	mov	al, gs:byte_4255D
	sub	ah, ah
	cmp	ax, [bp+sqE]
	jnz	short loc_256DB
	mov	al, gs:byte_42242
	cmp	ax, [bp+sqN]
	jnz	short loc_256DB
	mov	al, gs:byte_42566
	cmp	ax, [bp+_dirFacing]
	jnz	short loc_256DB
	jmp	loc_25768
loc_256DB:
	mov	al, byte ptr [bp+sqE]
	mov	gs:byte_4255D, al
	mov	al, byte ptr [bp+sqN]
	mov	gs:byte_42242, al
	mov	al, byte ptr [bp+_dirFacing]
	mov	gs:byte_42566, al
	lea	ax, [bp+aheadFlags]
	push	ss
	push	ax
	push	[bp+sqN]
	push	[bp+sqE]
	push	cs
	call	near ptr dun_getSqFlagAhead3
	add	sp, 8
	mov	bl, detectType
	sub	bh, bh
	mov	al, byte_4B2B8[bx]
	cbw
	mov	[bp+var_4], ax
loc_25721:
	mov	bx, [bp+var_4]
	mov	al, detectByte[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0FFh
	jge	short loc_25768
	mov	si, ax
	mov	al, byte ptr [bp+si+aheadFlags]
	cbw
	mov	cl, detectMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_25763

	;mov	bx, si
	mov	bx, [bp+var_4]
	mov	al, detectMsgIndex[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (detectMessages+2)[bx]
	push	word ptr detectMessages[bx]
	call	printString
	add	sp, 4
loc_25763:
	inc	[bp+var_4]
loc_25766:
	jmp	short loc_25721
loc_25768:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_detectSquares endp

; This function	returns	a list of the square flags
; for the three	squares	ahead.
; Attributes: bp-based frame

dun_getSqFlagAhead3 proc far

	sqFlagP= dword ptr -8
	counter= word ptr -4
	deltaSq= word ptr -2
	sqE= word ptr  6
	sqN= word ptr  8
	rSqList= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	[bp+deltaSq], 0
	jmp	short loc_25783
loc_25780:
	inc	[bp+deltaSq]
loc_25783:
	cmp	[bp+deltaSq], 3
	jge	short loc_25795
	mov	bx, [bp+deltaSq]
	lfs	si, [bp+rSqList]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_25780
loc_25795:
	mov	[bp+deltaSq], 0
	jmp	short loc_2579F
loc_2579C:
	inc	[bp+deltaSq]
loc_2579F:
	cmp	[bp+deltaSq], 3
	jge	loc_25816
	mov	si, dirFacing
	shl	si, 1
	mov	ax, dirDeltaE[si]
	add	[bp+sqE], ax
	mov	al, dunWidth
	sub	ah, ah
	push_reg	ax
	push_var_stack	sqE
	std_call	wrapNumber, 4
	mov	[bp+sqE], ax
	mov	ax, dirDeltaN[si]
	sub	[bp+sqN], ax
	mov	al, dunHeight
	sub	ah, ah
	push_reg	ax
	push_var_stack	sqN
	std_call	wrapNumber, 4
	mov	[bp+sqN], ax
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+sqE]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+sqFlagP], ax
	mov	word ptr [bp+sqFlagP+2], dx
	mov	[bp+counter], 0
	jmp	short loc_257DA
loc_257D7:
	inc	[bp+counter]
loc_257DA:
	cmp	[bp+counter], 3
	jge	short loc_2579C
	mov	bx, [bp+counter]
	lfs	si, [bp+sqFlagP]
	mov	al, fs:[bx+si]
	lfs	si, [bp+rSqList]
	or	fs:[bx+si], al
	jmp	short loc_257D7
loc_25816:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_getSqFlagAhead3 endp

; Attributes: bp-based frame

dun_ascendPortal proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+arg_2]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+arg_0]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	test	byte ptr fs:[bx], 40h
	jz	short loc_2587C
	cmp	levitationDuration, 0
	jz	short loc_2587C
	test	levFlags, 10h
	jz	short loc_25878
	push	cs
	call	near ptr sub_2590E
	jmp	short loc_2587C
loc_25878:
	push	cs
	call	near ptr sub_258E9
loc_2587C:
	mov	sp, bp
	pop	bp
	retf
dun_ascendPortal endp

; Attributes: bp-based frame

dun_descendPortal proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+arg_2]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+arg_0]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	test	byte ptr fs:[bx], 20h
	jz	short loc_258E5
	cmp	levitationDuration, 0
	jnz	short loc_258CF
	push	cs
	call	near ptr dunsq_drainHP
loc_258CF:
	test	levFlags, 10h
	jz	short loc_258E1
	push	cs
	call	near ptr sub_258E9
	jmp	short loc_258E5
loc_258E1:
	push	cs
	call	near ptr sub_2590E
loc_258E5:
	mov	sp, bp
	pop	bp
	retf
dun_descendPortal endp

; Attributes: bp-based frame

sub_258E9 proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	dec	dunLevelNum
	jns	short loc_25905
	call	dun_setExitLocation
	jmp	short loc_2590A
loc_25905:
	call	dun_changeLevels
loc_2590A:
	mov	sp, bp
	pop	bp
	retf
sub_258E9 endp

; Attributes: bp-based frame

sub_2590E proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	inc	dunLevelNum
	call	dun_changeLevels
	mov	sp, bp
	pop	bp
	retf
sub_2590E endp

; Attributes: bp-based frame

dun_randomMonJoin proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	findEmptyRosterNum
	mov	[bp+var_2], ax
	cmp	ax, 7
	jl	short loc_25963
	call	dropPartyMember
	or	ax, ax
	jnz	short loc_25951
	sub	ax, ax
	jmp	short loc_25983
	jmp	short loc_25963
loc_25951:
	call	findEmptyRosterNum
	mov	[bp+var_2], ax
	mov	byte ptr word_44166,	0
loc_25963:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+var_2]
	call	_sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr word_44166,	0
	mov	ax, 1
	jmp	short $+2
loc_25983:
	mov	sp, bp
	pop	bp
	retf
dun_randomMonJoin endp

; Attributes: bp-based frame
dun_randomMonFight proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	byte_4EEC9, 1
	mov	gs:byte_42458, 1
	mov	byte_4EECC, 1
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dun_randomMonFight endp

; Attributes: bp-based frame
dun_randomMonLeave proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dun_randomMonLeave endp

; Attributes: bp-based frame

dun_wanderingCreature proc far

	var_48=	dword ptr -48h
	var_44=	word ptr -44h
	var_42=	word ptr -42h
	var_40=	word ptr -40h
	var_30=	dword ptr -30h
	var_2C=	word ptr -2Ch
	var_1C=	word ptr -1Ch
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_8= word ptr	-8
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 48h	
	call	someStackOperation
	push	si
loc_259D7:
	mov	ax, 17h
	push	ax
	sub	ax, ax
	push	ax
	call	randomBetweenXandY
	add	sp, 4
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_30], ax
	mov	word ptr [bp+var_30+2],	seg seg023
	lfs	bx, [bp+var_30]
	test	fs:[bx+mon_t.flags], mon_noSummon
	jnz	short loc_259D7
	cmp	byte ptr fs:[bx], 0
	jz	short loc_259D7
	mov	al, fs:[bx+mon_t.picIndex]
	sub	ah, ah
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	lea	ax, [bp+var_2C]
	push	ss
	push	ax
	push	word ptr [bp+var_30+2]
	push	word ptr [bp+var_30]
	call	decryptName
	add	sp, 8
	sub	ax, ax
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	lea	ax, [bp+var_2C]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_48], ax
	mov	word ptr [bp+var_48+2],	dx
	lfs	bx, [bp+var_48]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	gs:monGroups.groupSize,	1
	mov	al, byte ptr [bp+var_2]
	mov	byte ptr gs:monGroups._name, al
	mov	[bp+var_44], 0
	jmp	short loc_25A76
loc_25A73:
	inc	[bp+var_44]
loc_25A76:
	cmp	[bp+var_44], 5
	jge	short loc_25A85
	mov	si, [bp+var_44]
	mov	byte ptr [bp+si+var_8],	1
	jmp	short loc_25A73
loc_25A85:
	call	clearTextWindow
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	lea	ax, [bp+var_1C]
	push	ss
	push	ax
	lea	ax, [bp+var_8]
	push	ss
	push	ax
	mov	ax, offset aAWanderingCreatureOff
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_42], ax
	mov	[bp+var_44], 0
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_16], ax
	cmp	ax, 1Bh
	jnz	short loc_25AC1
	jmp	short loc_25B03
loc_25AC1:
	mov	si, [bp+var_44]
	cmp	byte ptr [bp+si+var_1C], 0
	jz	short loc_25B01
	mov	al, byte ptr [bp+si+var_1C]
	cbw
	cmp	ax, [bp+var_16]
	jz	short loc_25ADD
	shl	si, 1
	mov	ax, [bp+var_16]
	cmp	[bp+si+var_14],	ax
	jnz	short loc_25AFC
loc_25ADD:
	push	word ptr [bp+var_30+2]
	push	word ptr [bp+var_30]
	mov	bx, [bp+var_44]
	shl	bx, 1
	shl	bx, 1
	call	off_4B346[bx]
	add	sp, 4
	or	ax, ax
	jz	short loc_25AFA
	call	clearTextWindow
loc_25AFA:
	jmp	short loc_25B03
loc_25AFC:
	inc	[bp+var_44]
	jmp	short loc_25AC1
loc_25B01:
	jmp	short loc_25A85
loc_25B03:
	pop	si
	mov	sp, bp
	pop	bp
locret_25B07:
	retf
dun_wanderingCreature endp

seg013 ends
