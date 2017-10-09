; Attributes: bp-based frame

bat_doBreathAttack proc	far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	outputStringP= dword ptr -116h
	counter= word ptr -112h
	var_110= word ptr -110h
	target=	word ptr -10Eh
	var_10C= word ptr -10Ch
	partyAttackRval= word ptr -10Ah
	var_108= word ptr -108h
	stringBuf= word ptr -106h
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	specialAttackIndex= byte ptr	 8
	arg_3= byte ptr	 9
	arg_4= byte ptr	 0Ah
	arg_5= byte ptr	 0Bh
	arg_6= byte ptr	 0Ch
	breathFlags= byte ptr	 0Dh
	levelMultiplier= byte ptr	 0Eh
	spellRange= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 11Ah
	call	someStackOperation

	cmp	[bp+levelMultiplier], 0
	jnz	short l_allFoesCheck

	; Set levelMultiplier to 1 if source is an enemy
	cmp	[bp+partySlotNumber], 80h 
	jl	short l_partyMultiplier
	mov	[bp+levelMultiplier], 1
	jmp	short l_allFoesCheck

l_partyMultiplier:
	getCharP	[bp+partySlotNumber], bx
	push	gs:roster.level[bx]
	far_call _returnXor255,2
	mov	[bp+levelMultiplier], al

l_allFoesCheck:
	mov	[bp+partyAttackRval], 0
	test	[bp+breathFlags], breath_allFoes		; if breathFlags & breathAllFoes
	jz	short l_oneGroupCheck
	cmp	[bp+partySlotNumber], 80h 			;   if source.isEnemy
	jge	short l_stripAllFoesFlag			;     breathFlags &= !breathAllFoes
	mov	gs:bat_curTarget, 80h				;   else
	jmp	short l_oneGroupCheck				;     currentTarget = first enemy group
l_stripAllFoesFlag:
	and	[bp+breathFlags], 7Fh

l_oneGroupCheck:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	or	ax, [bp+partySlotNumber]
	cmp	ax, 80h
	jnb	short loc_201B9
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201B9
	mov	ax, [bp+partySlotNumber]
	jmp	short loc_201BC
loc_201B9:
	mov	ax, 0FFh
loc_201BC:
	mov	[bp+var_11A], ax

	mov	[bp+var_110], 0
loc_201C6:
	cmp	gs:bat_curTarget, 80h
	jnb	l_targetIsEnemy
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201E0
	mov	ax, 6
	jmp	short loc_201E6
loc_201E0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
loc_201E6:
	mov	[bp+target], ax
	mov	ax, offset aAtTheParty___
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	do_strcat outputStringP
	inc	[bp+partyAttackRval]
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	far_call bat_isPartyInRange, 4
	or	ax, ax
	jnz	loc_20324
	strcat_offset aButThePartyWas, outputStringP
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	func_printString
	mov	byte ptr word_44166,	0
	delayWithTable
	mov	ax, [bp+partyAttackRval]
	dec	ax
	jmp	bat_doBreathAttack_exit

l_targetIsEnemy:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	l_enemyGroupGone
loc_20289:
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_202B1
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	dec	ax
	jmp	short loc_202B3
loc_202B1:
	sub	ax, ax
loc_202B3:
	mov	[bp+target], ax

	; strcat(stringBuf, "at")
	mov	ax, offset aAt
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	do_strcat outputStringP

	push	[bp+target]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	far_call bat_getTargetName,8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, offset aElipsisNLNL
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	func_strcat
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	jmp	short loc_20324
l_enemyGroupGone:
	mov	[bp+target], 0FFFFh
	cmp	[bp+breathFlags], breath_allFoes
	jnb	short loc_20324
	mov	ax, [bp+partyAttackRval]
	jmp	bat_doBreathAttack_exit

loc_20324:
	cmp	[bp+target], 0
	jl	loc_2086F
loc_2032E:
	mov	gs:damageAmount, 0
	mov	[bp+counter], 0
	jmp	short loc_20345
loc_20341:
	inc	[bp+counter]
loc_20345:
	mov	al, [bp+levelMultiplier]
	sub	ah, ah
	cmp	ax, [bp+counter]
	jbe	short loc_20379
	mov	al, [bp+arg_6]
	push	ax
	std_call dice_doYDX, 2
	add	gs:damageAmount, ax
	cmp	gs:damageAmount, 20000
	jle	short loc_20377
	mov	gs:damageAmount, 20000
	jmp	short loc_20379
loc_20377:
	jmp	short loc_20341
loc_20379:
	cmp	gs:bat_curTarget, 80h
	jb	short loc_203AA
	strcat_offset aOne, outputStringP
	mov	[bp+var_2], 1
	jmp	loc_2047F
loc_203AA:
	mov	ax, [bp+target]
	cmp	[bp+var_11A], ax
	jz	loc_2047A
	mov	bx, ax
	cmp	gs:byte_42280[bx], 0
	jnz	loc_2047A
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	push	ax
	push	bx
	far_call _canAttackChar, 4
	or	ax, ax
	jz	loc_2047A
	getCharP	[bp+target], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	do_strcat outputStringP
	dword_appendChar outputStringP, ' '
	mov	ax, itemEff_breathDefense
	push	ax
	push	[bp+target]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jl	short loc_20467
	test	[bp+breathFlags], breath_isBreath
	jz	short loc_20467
	strcat_offset aRepelledTheAtt, outputStringP
	mov	byte ptr word_44166,	0
	mov	[bp+var_2], 0
	jmp	short loc_20478
loc_20467:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	mov	[bp+var_2], 1
loc_20478:
	jmp	short loc_2047F
loc_2047A:
	mov	[bp+var_2], 0
loc_2047F:
	cmp	[bp+var_2], 0
	jnz	short loc_20488
	jmp	loc_2050C
loc_20488:
	cmp	[bp+arg_5], 0
	jz	short loc_2050C
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_204B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:roster.repelFlags[bx]
	sub	ah, ah
	jmp	short loc_204CF
loc_204B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 7Fh
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.repelFlags[bx]
	sub	ah, ah
loc_204CF:
	mov	[bp+var_10C], ax
	mov	al, [bp+arg_5]
	sub	ah, ah
	test	[bp+var_10C], ax
	jnz	short loc_2050C
	strcat_offset aRepelledTheAtt, outputStringP
	mov	[bp+var_2], 0
loc_2050C:
	cmp	[bp+var_2], 0
	jnz	short loc_20515
	jmp	loc_20810
loc_20515:
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr bat_isPartyInRange
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jnz	short loc_2052C
	jmp	loc_207F3
loc_2052C:
	cmp	ax, 2
	jnz	short loc_2053B
	mov	gs:byte_41E63, 4
loc_2053B:
	mov	al, [bp+breathFlags]
	sub	ah, ah
	and	ax, 2
	push	ax
	push	[bp+partySlotNumber]
	far_call savingThrowCheck, 4
	mov	[bp+var_118], ax
	or	ax, ax
	jnz	short loc_20559
	jmp	loc_207D4
loc_20559:
	cmp	ax, 1
	jnz	short loc_20567
	sar	gs:damageAmount, 1
loc_20567:
	test	[bp+breathFlags], 3
	jz	short loc_2058E
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_2058E
	cmp	gs:songHalfDamage, 0
	jz	short loc_2058E
	sar	gs:damageAmount, 1
loc_2058E:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_205B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:roster.strongElement[bx]
	sub	ah, ah
	jmp	short loc_205CF
loc_205B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.strongElement[bx]
	sub	ah, ah
loc_205CF:
	mov	[bp+var_108], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_108], ax
	mov	[bp+counter], 0
	jmp	short loc_205E8
loc_205E4:
	inc	[bp+counter]
loc_205E8:
	cmp	[bp+counter], 7
	jge	short loc_2060F
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_108], ax
	jz	short loc_2060D
	sar	gs:damageAmount, 1
loc_2060D:
	jmp	short loc_205E4
loc_2060F:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20631
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:roster.weakElement[bx]
	sub	ah, ah
	jmp	short loc_20650
loc_20631:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.weakElement[bx]
	sub	ah, ah
loc_20650:
	mov	[bp+var_6], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_6], ax
	mov	[bp+counter], 0
	jmp	short loc_20667
loc_20663:
	inc	[bp+counter]
loc_20667:
	cmp	[bp+counter], 7
	jge	short loc_2068D
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_6], ax
	jz	short loc_2068B
	shl	gs:damageAmount, 1
loc_2068B:
	jmp	short loc_20663
loc_2068D:
	mov	ax, gs:damageAmount
	mov	cl, [bp+specialAttackIndex]
	sub	ch, ch
	or	ax, cx
	jnz	short loc_206A1
	jmp	loc_207B5
loc_206A1:
	strcat_offset aIs, outputStringP
	mov	bl, [bp+arg_4]
	sub	bh, bh
	and	bl, 0FEh
	shl	bx, 1
	push	word ptr (breathEffectStr+2)[bx]
	push	word ptr breathEffectStr[bx]
	push	dx
	push	ax
	do_strcat outputStringP
	strcat_offset aFor, outputStringP
	xor	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	do_itoa	outputStringP
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	do_pluralize outputStringP
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	mov	gs:specialAttackVal, ax
	mov	al, gs:bat_curTarget
	push	ax
	std_call	bat_doHPDamage, 2
	or	ax, ax
	jz	short loc_207A7
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	std_call	bat_getKillString, 4
	save_ptr_stack	dx,ax,outputStringP
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	std_call	printCharPronoun, 0Ah
	save_ptr_stack	dx,ax,outputStringP
	jmp	short loc_207D2
loc_207A7:
	strcat_offset	aPeriodBlankLine, outputStringP
	jmp	short loc_207D2
loc_207B5:
	strcat_offset aRepelledTheAtt, outputStringP
loc_207D2:
	jmp	short loc_207F1
loc_207D4:
	strcat_offset aRepelledTheAtt, outputStringP
loc_207F1:
	jmp	short loc_20810
loc_207F3:
	strcat_offset aWasTooFarAway, outputStringP
loc_20810:
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	func_printString
	mov	byte ptr word_44166,	0
	delayWithTable
	lea	ax, [bp+stringBuf]
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], ss
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20868
	test	[bp+breathFlags], 40h
	jnz	short loc_20868
	mov	[bp+target], 0FFFFh
loc_20868:
	dec	[bp+target]
	jmp	loc_20324
loc_2086F:
	test	[bp+breathFlags], breath_allFoes
	jz	short loc_20896
	test	gs:bat_curTarget, 80h
	jz	short loc_20896
	cmp	gs:bat_curTarget, 83h
	jz	short loc_20896
	mov	[bp+var_110], 1
	inc	gs:bat_curTarget
	jmp	short loc_2089C
loc_20896:
	mov	[bp+var_110], 0
loc_2089C:
	cmp	[bp+var_110], 0
	jnz	loc_201C6
bat_doBreathAttack_exit:
	mov	sp, bp
	pop	bp
	retf
bat_doBreathAttack endp

; Attributes: bp-based frame

_canAttackChar proc far
        partySlotNumber=        word ptr  6
        specialAttackIndex= word ptr  8

        push    bp
        mov     bp, sp
        xor     ax, ax
        call    someStackOperation
        getCharP        [bp+partySlotNumber], bx

        cmp     byte ptr gs:roster._name[bx], 0			; if partySlot.isEmpty
	jz	l_return_zero					;   return 0
        getCharP        [bp+partySlotNumber], bx
        test    gs:roster.status[bx], stat_dead or stat_stoned	; if !partySlot.isDead and !partySlot.isStoned
	jz	l_return_one					;   return 1

        getCharP        [bp+partySlotNumber], bx		; Character is either dead or stoned
        test    gs:roster.status[bx], stat_stoned		; if partySlot.isStoned
	jnz	l_return_zero					;   return 0

								; Character is dead
        cmp     [bp+specialAttackIndex], speAtt_possess		; if specialAttackIndex != speAtt_possess
        jnz     short l_return_zero				;   return 0
l_return_one:
	mov	ax, 1
	jmp	l_return
l_return_zero:
        sub     ax, ax
l_return:
        mov     sp, bp
        pop     bp
        retf
_canAttackChar endp
