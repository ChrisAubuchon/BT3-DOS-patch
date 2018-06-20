; Attributes: bp-based frame

tavern_talkToBarkeep proc far

	var_A= word ptr	-0Ah
	talkerSlotNumber= word ptr	-8
	tipAmount= dword ptr	-4

	FUNC_ENTER(0Ah)

	PUSH_OFFSET(s_whoTalksToBarkeep)
	PRINTSTRING(true)
	CALL(readSlotNumber, near)
	mov	[bp+talkerSlotNumber], ax
	or	ax, ax
	jl	l_returnZero

	CALL(text_clear)

	; Check talker drunk level
	mov	bx, [bp+talkerSlotNumber]
	cmp	tav_drunkLevel[bx], 0Ch
	jge	l_noConditionToTalk

	PUSH_OFFSET(s_talkAintCheap)
	PRINTSTRING

	mov	bx, [bp+talkerSlotNumber]
	cmp	tav_drunkLevel[bx], 5
	jl	short l_skipNameCalling

	PUSH_OFFSET(s_beerBreath)
	PRINTSTRING

l_skipNameCalling:
	PUSH_OFFSET(s_barkeepSays)
	PRINTSTRING
	PUSH_OFFSET(s_howMuchWillTip)
	PRINTSTRING
	CALL(readGold)
	mov	word ptr [bp+tipAmount], ax
	mov	word ptr [bp+tipAmount+2], dx
	or	dx, ax
	jz	l_return
	PUSH_STACK_PTR(tipAmount)
	push	[bp+talkerSlotNumber]
	CALL(character_removeGold, near)
	or	ax, ax
	jnz	short l_hasEnoughGold

	PUSH_OFFSET(s_notEnoughGold)
	PRINTSTRING
	jmp	short l_return

l_hasEnoughGold:
	CHARINDEX(ax, STACKVAR(talkerSlotNumber), bx)
	mov	ax, word ptr gs:party.gold[bx]
	or	ax, word ptr gs:(party.gold+2)[bx]
	jz	short l_gaveAllGold
	mov	[bp+var_A], 4

	jmp	short loc_14020
loc_1401D:
	dec	[bp+var_A]
loc_14020:
	cmp	[bp+var_A], 0
	jl	short l_return
	mov	bx, [bp+var_A]
	shl	bx, 1
	mov	ax, g_tavernSayingCost[bx]
	sub	dx, dx
	cmp	dx, word ptr [bp+tipAmount+2]
	ja	short loc_1401D
	jb	short loc_1403D
	cmp	ax, word ptr [bp+tipAmount]
	jnb	short loc_1401D
loc_1403D:
	mov	bx, [bp+var_A]
	add	bx, g_tavernSayingBase
	shl	bx, 1
	shl	bx, 1
	push	word ptr (barkeepSayings+2)[bx]
	push	word ptr barkeepSayings[bx]
	PRINTSTRING
	jmp	short l_return

l_gaveAllGold:
	PUSH_OFFSET(s_moneyTalks)
	PRINTSTRING
	jmp	short l_return

l_noConditionToTalk:
	PUSH_OFFSET(s_noConditionToTalk)
	PRINTSTRING
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
tavern_talkToBarkeep endp
