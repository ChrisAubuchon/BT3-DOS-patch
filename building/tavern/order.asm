; Attributes: bp-based frame

; DWORD var_2 & var_4

tav_orderDrink proc far

	var_112= word ptr -112h
	var_12=	word ptr -12h
	drinkIndexNumber=	word ptr -10h
	var_E= word ptr	-0Eh
	orderer= word ptr	-0Ch
	inputKey= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	lastCharNo= word ptr  6

	FUNC_ENTER
	CHKSTK(112h)

	PUSH_OFFSET(s_whoWillOrder)
	PRINTSTRING(true)

	NEAR_CALL(readSlotNumber)
	mov	[bp+orderer], ax
	or	ax, ax
	jl	l_returnZero

	CHARINDEX(ax, STACKVAR(orderer), bx)
	test	gs:party.status[bx], stat_dead or stat_stoned or stat_paralyzed
	jz	short l_orderLoopEntry

	mov	bx, [bp+orderer]
	mov	tav_drunkLevel[bx], maxDrunkLevel
	jmp	l_checkDrunkLevel

l_orderLoopEntry:
	PUSH_OFFSET(s_seatThyself)
	PUSH_STACK_ADDRESS(var_112)
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	CHARINDEX(ax, STACKVAR(orderer), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	PUSH_STACK_ADDRESS(var_112)
	PRINTSTRING(true)
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 2
	mov	[bp+var_8], ax
	mov	[bp+var_6], 0
	mov	[bp+var_E], 0
	jmp	short loc_13B64
loc_13B61:
	inc	[bp+var_E]
loc_13B64:
	cmp	[bp+var_E], 5
	jge	short loc_13B80
	mov	bx, [bp+var_8]
	add	bx, [bp+var_E]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_6], ax
	jmp	short loc_13B61
loc_13B80:
	PUSH_OFFSET(s_drinkOptions)
	PRINTSTRING
loc_13B8D:
	push	[bp+var_6]
	GETKEY
	mov	[bp+inputKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_returnZero
	cmp	ax, 119h
	jz	l_returnZero
	mov	[bp+var_12], 1
	mov	[bp+var_E], 0
	jmp	short loc_13BB9
loc_13BB6:
	inc	[bp+var_E]
loc_13BB9:
	cmp	[bp+var_E], 5
	jge	short loc_13BE7
	mov	bx, [bp+var_E]
	mov	al, byte ptr s_drinkOptionKeys[bx]
	cbw
	cmp	ax, [bp+inputKey]
	jz	short loc_13BD9
	mov	ax, bx
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+inputKey]
	jnz	short loc_13BE5
loc_13BD9:
	mov	ax, bx
	mov	[bp+drinkIndexNumber], ax
	mov	[bp+var_12], 0
	jmp	short loc_13BE7
loc_13BE5:
	jmp	short loc_13BB6
loc_13BE7:
	cmp	[bp+var_12], 0
	jnz	short loc_13B8D
l_checkDrunkLevel:
	mov	bx, [bp+orderer]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short l_payForDrink
	PUSH_OFFSET(s_cantOrder)
	PRINTSTRING
	push	[bp+lastCharNo]
	NEAR_CALL(tav_isPartyDrunk, 2)
	or	ax, ax
	jz	l_returnZero
	PUSH_OFFSET(s_partyIsDisgrace)
	PRINTSTRING
	mov	g_currentHour, 16h
	mov	ax, 1
	jmp	l_return

l_payForDrink:
	; BUG - This should probably be [bp+drinkIndexOrder]. As it is, the amount paid
	; for the drink is dependent on which party slot the drinker is in. The character
	; in slot 7 actually pays 0 for each drink.
	;
	mov	bx, [bp+orderer]
	mov	al, g_drinkPriceList[bx]
	cbw
	cwd
	push	dx
	push	ax
	push	bx
	NEAR_CALL(character_removeGold, 6)
	or	ax, ax
	jz	short l_notEnoughGold
	PUSH_OFFSET(s_hereOrToGo)
	PRINTSTRING(true)

l_hereToGoLoopEntry:
	mov	ax, 6
	push	ax
	GETKEY
	mov	[bp+inputKey], ax
	jmp	short l_hereToGoSwitch

l_drinkHere:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	NEAR_CALL(tavern_drink, 4)
	jmp	l_returnZero

l_drinkToGo:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	NEAR_CALL(tavern_getWineskin, 4)
	jmp	short l_returnZero

l_hereToGoSwitch:
	cmp	ax, 'H'
	jz	short l_drinkHere
	cmp	ax, 'T'
	jz	short l_drinkToGo
	cmp	ax, 10Fh
	jz	short l_drinkHere
	cmp	ax, 110h
	jz	short l_drinkToGo
	jmp	short l_hereToGoLoopEntry

l_notEnoughGold:
	PUSH_OFFSET(s_notEnoughGold)
	PRINTSTRING(true)

l_returnZero:
	sub	ax, ax
l_return:
	FUNC_EXIT
	retf
tav_orderDrink endp
