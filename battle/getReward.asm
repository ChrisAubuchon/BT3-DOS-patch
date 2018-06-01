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
	call	near ptr bat_charGetReward
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
