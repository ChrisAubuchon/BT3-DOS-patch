; Attributes: bp-based frame

bards_listen proc far

	validMouseKeys=	word ptr -2Eh
	validKeys=	word ptr -1Ah
	loopCounter=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	inKey= word ptr	-2

	FUNC_ENTER(2Eh)
	push	si

	PUSH_STACK_ADDRESS(var_C)
	cmp	g_locationNumber, 9
	jnz	short loc_25BCC
	mov	ax, 1
	jmp	short loc_25BCE
loc_25BCC:
	sub	ax, ax
loc_25BCE:
	push	ax
	CALL(bards_configOptionList, near)
	CALL(text_clear)
	PUSH_STACK_ADDRESS(validMouseKeys)
	PUSH_STACK_ADDRESS(validKeys)
	PUSH_STACK_ADDRESS(var_C)
	PUSH_OFFSET(s_songTitleList)
	CALL(printVarString)
	mov	[bp+var_E], ax
l_readKey:
	push	[bp+var_E]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, dosKeys_ESC
	jz	short l_return

	mov	[bp+loopCounter], 0
l_checkKeysLoop:
	mov	si, [bp+loopCounter]
	mov	al, byte ptr [bp+si+validKeys]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_songSelected
	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+validMouseKeys],	ax
	jz	short l_songSelected
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short l_checkKeysLoop
	jmp	short l_readKey

l_songSelected:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongLyrics[bx]
	or	ax, word ptr (bardSongLyrics+2)[bx]
	jnz	short loc_25C5D
	cmp	[bp+loopCounter], 2
	jnz	short loc_25C51
	mov	ax, 1
	jmp	short loc_25C53
loc_25C51:
	sub	ax, ax

loc_25C53:
	push	ax
	CALL(bards_learnSong, near)
	jmp	short l_return

loc_25C5D:
	push	[bp+loopCounter]
	CALL(bards_printLyrics, near)
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_listen endp
