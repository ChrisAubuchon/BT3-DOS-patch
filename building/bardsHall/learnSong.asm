; Attributes: bp-based frame

bards_learnSong	proc far

	stringBuffer= word ptr -108h
	partySlotNumber= word ptr	-8
	loopCounter= word ptr	-6
	stringBufferP= dword ptr	-4
	songNumber= word ptr	 6

	FUNC_ENTER(108h)
	push	si

	PUSH_OFFSET(s_bardSmiles)
	PRINTSTRING(true)
	IOWAIT
	PUSH_OFFSET(s_itWillCostYou)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	sub	ax, ax
	push	ax
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (bardSongPrice+2)[bx]
	push	word ptr bardSongPrice[bx]
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	PUSH_OFFSET(s_inGoldWhoWillPay)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	CALL(readSlotNumber)
	mov	[bp+partySlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_25DA2
	jb	short loc_25D93
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_25DA2
loc_25D93:
	PUSH_OFFSET(s_notEnoughGoldNl)
	PRINTSTRING(true)
	jmp	short l_waitAndReturn

loc_25DA2:
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	gs:party.class[si], class_bard
	jnz	short l_increment
	mov	bx, [bp+songNumber]
	mov	al, g_bardSongMask[bx]
	or	gs:(party.specAbil+1)[si], al
l_increment:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

l_playSong:
	PUSH_OFFSET(s_bardPlaysSong)
	PRINTSTRING(clear)
l_waitAndReturn:
	IOWAIT
l_return:
	pop	si
	FUNC_EXIT
	retf
bards_learnSong	endp
