; Attributes: bp-based frame

bat_getReward proc far

	loopCounter= word ptr -114h
	itemLoopCounter= word ptr -112h
	newItemIdentification= word ptr -110h
	goldReward= dword ptr -10Eh
	newItemCount= word ptr -10Ah
	stringBufferP= dword ptr -108h
	newItemNumber= word ptr -104h
	currentSlotNumber= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(114h)

	DELAY(2)
	CALL(text_clear)
	mov	gs:g_trapIndex, 0
	mov	ax, gs:batRewardLo
	or	ax, gs:batRewardHi
	jz	l_returnZero

	cmp	inDungeonMaybe, 0
	jz	short loc_1F255

	cmp	byte_4EECC, 0
	jz	short loc_1F255

	CALL(bat_doChest, near)

loc_1F255:
	CALL(party_getLastSlot)
	cmp	ax, 7
	jg	l_returnOne

	mov	ax, gs:batRewardLo
	or	ax, gs:batRewardHi
	jz	l_returnZero

	PUSH_OFFSET(s_eachCharacterReceives)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	sub	ax, ax
	push	ax
	push	gs:batRewardHi
	push	gs:batRewardLo
	CALL(bat_giveExperience, near)

	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	PUSH_OFFSET(s_experiencePoinsForV)
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)

	cmp	gs:g_trapIndex, 0
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
	CALL(__32bitDivide)

loc_1F30A:
	mov	word ptr [bp+goldReward], ax
	mov	word ptr [bp+goldReward+2], dx

loc_1F319:
	mov	ax, bigpic_treasure
	push	ax
	CALL(bigpic_drawPictureNumber)

	PUSH_OFFSET(s_treasure)
	CALL(setTitle)

	sub	ax, ax
	push	ax
	PUSH_STACK_DWORD(goldReward)
	CALL(bat_giveGold, near)

	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	PUSH_OFFSET(s_inGold)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	[bp+itemLoopCounter], 0
loc_1F38E:
	mov	al, g_levelNumber
	sub	ah, ah
	sub	ax, 9
	neg	ax
	push	ax
	sub	ax, ax
	push	ax
	CALL(randomBetweenXandY)
	or	ax, ax
	jnz	l_itemLoopNext

	cmp	gs:g_trapIndex, 0
	jnz	short l_getRewardItemNumber
	DELAY(1)

l_getRewardItemNumber:
	CALL(random)
	sub	ah, ah
	cmp	ax, 224			; Undefined values are returned
	jl	short l_checkLevelMask		; as harmonic gems
	cmp	ax, 240
	jge	short l_checkLevelMask
	mov	ax, item_harmonicGem

l_checkLevelMask:
	mov	[bp+newItemNumber], ax
	mov	bl, g_levelNumber
	sub	bh, bh
	mov	al, g_byteMaskList[bx]
	sub	ah, ah
	mov	bx, [bp+newItemNumber]
	mov	cl, g_itemRewardTable[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_getRewardItemNumber

	mov	al, g_itemBaseCount[bx]
	mov	[bp+newItemCount], ax
	cmp	ax, 1
	jz	short l_checkIdentificationFlag

	cmp	ax, 0FFh
	jz	short l_checkIdentificationFlag

	push	ax
	mov	ax, 1
	push	ax
	CALL(randomBetweenXandY)
	mov	[bp+newItemCount], ax

l_checkIdentificationFlag:
	CALL(random)
	test	al, 7
	jnz	short l_itemIsIdentified

	mov	ax, itemFlag_unidentified
	jmp	short l_setIdentificationFlag

l_itemIsIdentified:
	sub	ax, ax

l_setIdentificationFlag:
	mov	[bp+newItemIdentification], ax
	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar)
	mov	[bp+currentSlotNumber], ax

	mov	[bp+loopCounter], 0
loc_1F474:
	push	[bp+currentSlotNumber]
	CALL(bat_charCanGetReward, near)
	or	ax, ax
	jz	l_characterLoopNext

	push	[bp+newItemCount]
	push	[bp+newItemIdentification]
	push	[bp+newItemNumber]
	push	[bp+currentSlotNumber]
	CALL(inventory_addItem)
	or	ax, ax
	jz	l_characterLoopNext

	CHARINDEX(ax, STACKVAR(currentSlotNumber), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_foundA)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	push	[bp+newItemIdentification]
	push	[bp+newItemNumber]
	push	dx
	push	ax
	CALL(inventory_getItemName)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	DELAY(2)
	jmp	short l_itemLoopNext

l_characterLoopNext:
	dec	[bp+currentSlotNumber]
	jns	short loc_1F466

	mov	[bp+currentSlotNumber], 6

loc_1F466:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	loc_1F474

l_itemLoopNext:
	inc	[bp+itemLoopCounter]
	cmp	[bp+itemLoopCounter], 4
	jl	loc_1F38E

loc_1F547:
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	DELAY(8)

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
bat_getReward endp
