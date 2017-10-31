; Attributes: bp-based frame

; DWORD - var_2 & var_4

tavern_talkToBarkeep proc far

	var_A= word ptr	-0Ah
	talkerSlotNumber= word ptr	-8
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER
	CHKSTK(0Ah)

	PUSH_OFFSET(s_whoTalksToBarkeep)
	PRINTSTRING(true)
	NEAR_CALL(readSlotNumber)
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
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	or	dx, ax
	jz	l_return
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+talkerSlotNumber]
	NEAR_CALL(character_removeGold, 6)
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
	mov	al, byte_43876[bx]
	sub	ah, ah
	sub	dx, dx
	cmp	dx, [bp+var_2]
	ja	short loc_1401D
	jb	short loc_1403D
	cmp	ax, [bp+var_4]
	jnb	short loc_1401D
loc_1403D:
	add	bx, tavern_sayingBase
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
