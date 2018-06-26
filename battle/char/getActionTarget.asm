; Attributes: bp-based frame

bat_charGetActionOptionsTarget proc far

	loopCounter= word ptr -11Ah
	monsterMouseKeyMap= byte ptr -118h		; Map mouse mask to [A-D]
	stringBuffer= word ptr -10Ch
	inKey= word ptr	-0Ch
	stringBufferP= dword ptr -0Ah
	partyLastSlot= word ptr	-6
	mouseIoMask= word ptr	-4
	monsterGroupCount= word ptr	-2
	targetingFlags= word ptr	 6
	inStringBuffer= word	ptr  8

	FUNC_ENTER(11Ch)
	push	si

	mov	ax, 0FFFFh
	mov	[bp+partyLastSlot], ax
	mov	[bp+monsterGroupCount], ax
	mov	[bp+loopCounter], 0
loc_1DB0A:
	mov	si, [bp+loopCounter]
	mov	[bp+si+monsterMouseKeyMap], ' '
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ch
	jl	short loc_1DB0A

	PUSH_STACK_DWORD(inStringBuffer)
	PRINTSTRING(clear)
	mov	ax, [bp+targetingFlags]
	or	ax, ax
	jl	l_returnGroupZero

	cmp	ax, target_partyMember
	jle	l_getPartyMemberTarget

	cmp	ax, target_monGroup
	jz	l_getMonsterTarget

	cmp	ax, target_monAndParty
	jz	l_getAnyTarget

	jmp	l_returnGroupZero

l_getPartyMemberTarget:
	CALL(party_findEmptySlot)
	mov	[bp+partyLastSlot], ax
	cmp	ax, 1
	jle	l_returnZero

	mov	al, byte ptr [bp+partyLastSlot]
	add	al, '0'
	mov	byte ptr s_memberOneToSeven+0Bh,	al		; Changes (1-7) to (1-{lastSlot})
	PRINTOFFSET(s_memberOneToSeven)
	mov	[bp+mouseIoMask], 2000h
	jmp	l_ioLoop

l_getMonsterTarget:
	CALL(bat_monGroupCount, near)
	mov	[bp+monsterGroupCount], ax
	cmp	ax, 1
	jle	l_returnGroupZero

	mov	[bp+mouseIoMask], 0
	mov	[bp+loopCounter], 0
l_monsterOnlyLoop:
	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+mouseIoMask], ax
	mov	al, byte ptr [bp+loopCounter]
	add	al, 'A'
	mov	[bp+si+monsterMouseKeyMap+1], al
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	fs:[bx], al
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ')'
	push	[bp+loopCounter]
	push	word ptr [bp+stringBufferP+2]
	push	word ptr [bp+stringBufferP]
	CALL(bat_monPrintGroup, near)
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], dx
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

	inc	[bp+loopCounter]
	mov	ax, [bp+monsterGroupCount]
	cmp	[bp+loopCounter], ax
	jl	l_monsterOnlyLoop
	jmp	l_ioLoop

l_getAnyTarget:
	CALL(party_findEmptySlot)
	mov	[bp+partyLastSlot], ax
	CALL(bat_monGroupCount, near)
	or	ax, ax
	jz	l_anyTargetParty

	mov	[bp+monsterGroupCount], ax
	mov	[bp+mouseIoMask], 2000h
	mov	[bp+loopCounter], 0
l_anyTargetMonsterLoop:
	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+mouseIoMask], ax
	mov	al, byte ptr [bp+loopCounter]
	add	al, 'A'
	mov	[bp+si+monsterMouseKeyMap+1], al
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	fs:[bx], al
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	byte ptr fs:[bx], ')'
	push	[bp+loopCounter]
	PUSH_STACK_DWORD(stringBufferP)
	CALL(bat_monPrintGroup, near)
	SAVE_STACK_DWORD(dx, ax, stringBufferP)
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	inc	[bp+loopCounter]
	jl	l_anyTargetMonsterLoop


	PUSH_OFFSET(s_or)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

l_anyTargetParty:
	cmp	[bp+partyLastSlot], 1
	jle	short l_anyTargetSingleCharacter

	mov	al, byte ptr [bp+partyLastSlot]
	add	al, monStruSize
	mov	byte ptr s_memberOneToSeven+0Bh,	al
	PRINTOFFSET(s_memberOneToSeven)
	jmp	short l_ioLoop

l_anyTargetSingleCharacter:
	PRINTOFFSET(s_memberOne)

l_ioLoop:
	push	[bp+mouseIoMask]
	CALL(getKey)
	mov	[bp+inKey], ax
	cmp	ax, 10Eh
	jl	short l_checkNumbers
	cmp	ax, 119h
	jg	short l_checkNumbers
	sub	ax, 10Eh
	mov	si, ax
	mov	al, [bp+si+monsterMouseKeyMap]
	sub	ah, ah
	mov	[bp+inKey], ax

l_checkNumbers:
	cmp	[bp+inKey], '0'	
	jle	short l_checkLetters

	mov	ax, [bp+partyLastSlot]
	add	ax, '1'	
	cmp	ax, [bp+inKey]
	jle	short l_checkLetters

	mov	ax, [bp+inKey]
	sub	ax, '1'
	jmp	short l_return

l_checkLetters:
	cmp	[bp+inKey], 'A'
	jl	short l_checkForEscape
	mov	ax, [bp+monsterGroupCount]
	add	ax, 'A'
	cmp	ax, [bp+inKey]
	jle	short l_checkForEscape
	mov	ax, [bp+inKey]
	add	ax, 3Fh				; Add 3Fh to get 80h-83h
	jmp	short l_return

l_checkForEscape:
	cmp	[bp+inKey], dosKeys_ESC
	jz	short l_returnFail

	jmp	short l_ioLoop

l_returnFail:
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnGroupZero:
	mov	ax, 80h
	jmp	short l_return

l_returnZero:
	sub	ax, ax
	jmp	short l_return

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_charGetActionOptionsTarget endp
