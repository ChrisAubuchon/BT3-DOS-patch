; DWORD - var_2 & var_4
; Attributes: bp-based frame

bards_learnSong	proc far

	stringBuffer= word ptr -108h
	partySlotNumber= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	songNumber= word ptr	 6

	FUNC_ENTER(108h)
	push	si

	PUSH_OFFSET(s_bardSmiles)
	PRINTSTRING(true)
	IOWAIT
	PUSH_OFFSET(s_itWillCostYou)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	sub	ax, ax
	push	ax
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (bardSongPrice+2)[bx]
	push	word ptr bardSongPrice[bx]
	push	dx
	push	[bp+var_4]
	CALL(itoa)
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	PUSH_OFFSET(s_bardInGold)
	push	dx
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
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
	mov	[bp+var_6], 0
l_loop:
	CHARINDEX(ax, STACKVAR(var_6), si)
	cmp	gs:party.class[si], class_bard
	jnz	short l_increment
	mov	bx, [bp+songNumber]
	mov	al, byte_4BDF0[bx]
	or	gs:(party.specAbil+1)[si], al
l_increment:
	inc	[bp+var_6]
	cmp	[bp+var_6], 7
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
