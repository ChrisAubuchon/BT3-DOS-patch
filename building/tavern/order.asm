; Attributes: bp-based frame

tav_orderDrink proc far

	stringBuffer= word ptr -112h
	isOrdered=	word ptr -12h
	drinkIndexNumber=	word ptr -10h
	loopCounter= word ptr	-0Eh
	orderer= word ptr	-0Ch
	inputKey= word ptr	-0Ah
	lineCount= word ptr	-8
	mouseMask= word ptr	-6
	stringBufferP= dword ptr	-4
	lastCharNo= word ptr  6

	FUNC_ENTER(112h)

	PRINTOFFSET(s_whoWillOrder)

	CALL(readSlotNumber, near)
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
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	CHARINDEX(ax, STACKVAR(orderer), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	PUSH_STACK_PTR(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(clear)
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 2
	mov	[bp+lineCount], ax
	mov	[bp+mouseMask], 0
	mov	[bp+loopCounter], 0
loc_13B61:
	mov	bx, [bp+lineCount]
	add	bx, [bp+loopCounter]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+mouseMask], ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short loc_13B61

	PRINTOFFSET(s_drinkOptions)

l_inputLoop:
	push	[bp+mouseMask]
	CALL(getKey)
	mov	[bp+inputKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_returnZero
	cmp	ax, 119h
	jz	l_returnZero

	mov	[bp+isOrdered], 1
	mov	[bp+loopCounter], 0
l_checkKeyLoop:
	mov	bx, [bp+loopCounter]
	mov	al, byte ptr s_drinkOptionKeys[bx]
	cbw
	cmp	ax, [bp+inputKey]
	jz	short l_setDrinkNumber

	mov	ax, bx
	add	ax, [bp+lineCount]
	add	ax, 10Eh
	cmp	ax, [bp+inputKey]
	jz	short l_setDrinkNumber

l_checkKeyNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_checkKeyLoop
	jmp	short l_checkForOrder

l_setDrinkNumber:
	mov	ax, bx
	mov	[bp+drinkIndexNumber], ax
	mov	[bp+isOrdered], 0

l_checkForOrder:
	cmp	[bp+isOrdered], 0
	jnz	short l_inputLoop

l_checkDrunkLevel:
	mov	bx, [bp+orderer]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short l_payForDrink

	PRINTOFFSET(s_cantOrder)
	push	[bp+lastCharNo]
	CALL(tav_isPartyDrunk, near)
	or	ax, ax
	jz	l_returnZero

	PRINTOFFSET(s_partyIsDisgrace)
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
	CALL(character_removeGold, near)
	or	ax, ax
	jz	short l_notEnoughGold
	PUSH_OFFSET(s_hereOrToGo)
	PRINTSTRING(true)

l_hereToGoLoopEntry:
	mov	ax, 6
	push	ax
	CALL(getKey)
	cmp	ax, 'H'
	jz	short l_drinkHere
	cmp	ax, 'T'
	jz	short l_drinkToGo
	cmp	ax, 10Fh
	jz	short l_drinkHere
	cmp	ax, 110h
	jz	short l_drinkToGo
	jmp	short l_hereToGoLoopEntry

l_drinkHere:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	CALL(tavern_drink, near)
	jmp	l_returnZero

l_drinkToGo:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	CALL(tavern_getWineskin, near)
	jmp	short l_returnZero

l_notEnoughGold:
	PUSH_OFFSET(s_notEnoughGold)
	PRINTSTRING(true)

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
tav_orderDrink endp
