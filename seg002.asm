; Segment type:	Pure code
seg002 segment byte public 'CODE' use16
	assume cs:seg002
;org 6
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

camp_addMember proc far

	var_15C= word ptr -15Ch
	var_15A= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	partyBuf= dword	ptr -154h

	push	bp
	mov	bp, sp
	mov	ax, 15Ch
	call	someStackOperation
	push	si
	call	clearTextWindow
	push	cs
	call	near ptr countSavedChars
	or	ax, ax
	jnz	short loc_12422
	jmp	loc_1258F
loc_12422:
	mov	[bp+var_15A], 0
	mov	[bp+var_15C], 0
loc_12428:
	cmp	[bp+var_15A], 10
	jge	l_addMember_partyLimitReached
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_15C]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+si+partyBuf], ax
	mov	word ptr [bp+si+partyBuf+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+partyBuf]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12428
l_addMember_partyLimitReached:
	dec	[bp+var_15C]
	mov	ax, [bp+var_15C]
	mov	[bp+var_156], ax
	mov	[bp+var_15A], 0
loc_12467:
	cmp	[bp+var_15A], 75
	jge	l_addMember_charLimitReached
	mov	ax, [bp+var_15C]
	sub	ax, [bp+var_156]
	getCharIndex	cx, cx
	add	ax, 0
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+partyBuf], ax
	mov	word ptr [bp+si+partyBuf+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+partyBuf]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12467
l_addMember_charLimitReached:
	dec	[bp+var_15C]
loc_124A3:
	push	[bp+var_15C]
	lea	ax, [bp+partyBuf]
	push	ss
	push	ax
	mov	ax, offset aWhoShallJoin?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_15A], ax
	or	ax, ax
	jge	short loc_124C5
	jmp	loc_125A8
loc_124C5:
	mov	ax, [bp+var_156]
	cmp	[bp+var_15A], ax
	jge	short loc_124DD
	push	[bp+var_15A]
	push	cs
	call	near ptr rost_insertParty
	add	sp, 2
	jmp	loc_125A8
loc_124DD:
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+partyBuf+2]
	push	word ptr [bp+si+partyBuf]
	push	cs
	call	near ptr charNameInParty
	add	sp, 4
	or	ax, ax
	jl	short loc_12531
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+partyBuf+2]
	push	word ptr [bp+si+partyBuf]
	call	printStringWClear
	add	sp, 4
	mov	ax, offset aIsAlreadyInThe
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	mov	[bp+var_158], 1
	jmp	short loc_12537
loc_12531:
	mov	[bp+var_158], 0
loc_12537:
	cmp	[bp+var_158], 0
	jz	short loc_12541
	jmp	loc_124A3
loc_12541:
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_158], ax
	cmp	ax, 7
	jge	short loc_1258D
	getCharP [bp+var_158], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_15A]
	sub	ax, [bp+var_156]
	getCharIndex	cx, cx
	mov	bx, ax
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	cs
	call	near ptr rost_insertMember
	mov	byte ptr word_44166,	0
loc_1258D:
	jmp	short loc_125A8
loc_1258F:
	mov	ax, offset aThereAreNoChar
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_125A8:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_addMember endp

; Attributes: bp-based frame

rost_insertParty proc far

	var_A= word ptr	-0Ah
	var_8= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], seg seg022
	call	clearTextWindow
	mov	[bp+var_A], 0
	jmp	short loc_125DA
loc_125D7:
	inc	[bp+var_A]
loc_125DA:
	cmp	[bp+var_A], 7
	jl	short loc_125E3
	jmp	loc_12704
loc_125E3:
	mov	si, [bp+var_A]
	mov	cl, 4
	shl	si, cl
	lfs	bx, [bp+var_8]
	cmp	byte ptr fs:[bx+si+10h], 0
	jnz	short loc_125FA
	jmp	loc_12704
	jmp	loc_12701
loc_125FA:
	mov	ax, [bp+var_A]
	mov	cl, 4
	shl	ax, cl
	add	ax, bx
	mov	dx, fs
	add	ax, 10h
	push	dx
	push	ax
	push	cs
	call	near ptr charNameInParty
	add	sp, 4
	or	ax, ax
	jl	short loc_1264B
	mov	ax, [bp+var_A]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+var_8]
	mov	dx, word ptr [bp+var_8+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aIsAlreadyInThe
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	jmp	loc_12701
loc_1264B:
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_2], ax
	cmp	ax, 7
	jl	short loc_1265A
	jmp	loc_126E8
loc_1265A:
	mov	ax, [bp+var_A]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+var_8]
	mov	dx, word ptr [bp+var_8+2]
	add	ax, 10h
	push	dx
	push	ax
	push	cs
	call	near ptr rost_charNameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_126AF
	mov	ax, [bp+var_A]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+var_8]
	mov	dx, word ptr [bp+var_8+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aThereSNoOneHer
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	jmp	short loc_126E6
loc_126AF:
	getCharP [bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getCharP [bp+var_4], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	cs
	call	near ptr rost_insertMember
	mov	byte ptr word_44166,	0
loc_126E6:
	jmp	short loc_12701
loc_126E8:
	mov	ax, offset aTheRosterIsFul
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
loc_12701:
	jmp	loc_125D7
loc_12704:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rost_insertParty endp

; Attributes: bp-based frame

camp_removeMember proc far

	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	push	si
	mov	[bp+var_24], 0
	mov	ax, offset aRemoveThemAll
	mov	[bp+var_20], ax
	mov	[bp+var_1E], ds
loc_12723:
	cmp	[bp+var_24], 7
	jge	short loc_1275A
	getCharP	[bp+var_24], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jz	short loc_1275A
	getCharIndex	ax, [bp+var_24]
	add	ax, offset roster
	mov	si, [bp+var_24]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_1C],	ax
	mov	[bp+si+var_1A],	seg seg027
	inc	[bp+var_24]
	jmp	short loc_12723
loc_1275A:
	mov	ax, [bp+var_24]
	inc	ax
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	mov	ax, offset aSelectWhichPar
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_22], ax
	or	ax, ax
	jge	short loc_1277A
	jmp	short loc_1279C
loc_1277A:
	cmp	[bp+var_22], 0
	jnz	short loc_12786
	push	cs
	call	near ptr rost_clearRoster
	jmp	short loc_12792
loc_12786:
	mov	ax, [bp+var_22]
	dec	ax
	push	ax
	std_call	roster_writeCharacter,2

	mov	ax, [bp+var_22]
	dec	ax
	push	ax
	push	cs
	call	near ptr rost_removeMember
	add	sp, 2
loc_12792:
	call		countSavedChars
	push		ax
	std_call	saveCharsInf,2
	mov	byte ptr word_44166,	0
loc_1279C:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_removeMember endp

; This function	moves all of the roster	slots below
; slotNo up one	slot. It then zeroes the tail of the
; roster. This effectively removes the character from
; the roster.
; Attributes: bp-based frame

rost_removeMember proc far

	slotNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	jmp	short loc_127B1
loc_127AE:
	inc	[bp+slotNo]
loc_127B1:
	cmp	[bp+slotNo], 6
	jge	short loc_127D7
	getCharP	[bp+slotNo], si
	lea	ax, roster._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, stru_41EFA._name[si]
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	jmp	short loc_127AE
loc_127D7:
	mov	gs:rosterTail._name, 0
	pop	si
	mov	sp, bp
	pop	bp
	retf
rost_removeMember endp

; Attributes: bp-based frame

rost_clearRoster proc far

	slotNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	roster_writeParty
	mov	[bp+slotNo], 0
	jmp	short loc_127FB
loc_127F8:
	inc	[bp+slotNo]
loc_127FB:
	cmp	[bp+slotNo], 7
	jge	short loc_12815
	getCharP	[bp+slotNo], bx
	mov	byte ptr gs:roster._name[bx], 0
	jmp	short loc_127F8
loc_12815:
	mov	sp, bp
	pop	bp
	retf
rost_clearRoster endp

; Attributes: bp-based frame

camp_renameMember proc far

	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	var_25A= word ptr -25Ah
	var_258= word ptr -258h
	nameBuf= word ptr -254h
	var_22C= dword ptr -22Ch
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 25Eh
	call	someStackOperation
	push	si
	call	clearTextWindow
	push	cs
	call	near ptr countSavedChars
	or	ax, ax
	jnz	short loc_12835
	jmp	loc_1297E
loc_12835:
	mov	[bp+var_25A], 0
	mov	[bp+var_258], 0
loc_1283B:
	cmp	[bp+var_258], 75
	jge	l_rename_charLimitReached
	getCharIndex	ax, [bp+var_25A]
	add	ax, 0
	mov	si, [bp+var_25A]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_22C], ax
	mov	word ptr [bp+si+var_22C+2], seg	seg022
	mov	si, [bp+var_25A]
	inc	[bp+var_25A]
	inc	[bp+var_258]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_22C]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_1283B
l_rename_charLimitReached:
	dec	[bp+var_25A]
	push	[bp+var_25A]
	lea	ax, [bp+var_22C]
	push	ss
	push	ax
	mov	ax, offset aRenameWho?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_258], ax
	or	ax, ax
	jge	short loc_12893
	jmp	loc_12997
loc_12893:
	mov	ax, offset aWhatIs
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	si, [bp+var_258]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_22C+2]
	push	word ptr [bp+si+var_22C]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	ax, offset aSNewName?
	push	ds
	push	ax
	push	dx
	push	[bp+var_25E]
	call	_strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_25A], 0
	jmp	short loc_12904
loc_12900:
	inc	[bp+var_25A]
loc_12904:
	cmp	[bp+var_25A], 10h
	jge	short loc_12916
	mov	si, [bp+var_25A]
	mov	byte ptr [bp+si+nameBuf], 0
	jmp	short loc_12900
loc_12916:
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short loc_1297C
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	push	cs
	call	near ptr rost_charNameExists
	add	sp, 4
	or	ax, ax
	jl	short loc_1294C
	mov	ax, offset aThereIsAlready
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short loc_1297C
loc_1294C:
	mov	[bp+var_25A], 0
	jmp	short loc_12958
loc_12954:
	inc	[bp+var_25A]
loc_12958:
	cmp	[bp+var_25A], 10h
	jge	short loc_1297C
	mov	si, [bp+var_25A]
	mov	al, byte ptr [bp+si+nameBuf]
	mov	si, [bp+var_258]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_22C]
	mov	si, [bp+var_25A]
	mov	fs:[bx+si], al
	jmp	short loc_12954
loc_1297C:
	jmp	short loc_12997
loc_1297E:
	mov	ax, offset aThereAreNoChar
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_12997:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_renameMember endp

; Attributes: bp-based frame

camp_createMember proc far

	var_23A= byte ptr -23Ah
	var_EC=	byte ptr -0ECh
	var_EA=	word ptr -0EAh
	var_E8=	word ptr -0E8h
	var_7E=	byte ptr -7Eh
	var_34=	word ptr -34h
	counter= word ptr -32h
	var_30=	word ptr -30h
	var_2E=	word ptr -2Eh
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	dword ptr -20h
	var_1C=	word ptr -1Ch
	var_8= word ptr	-8
	raceGenderValue= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0ECh 
	call	someStackOperation
	push	di
	push	si
	mov	word ptr [bp+var_20], offset newCharBuffer
	mov	word ptr [bp+var_20+2],	seg seg027
loc_129B3:
	mov	[bp+counter], 0
	jmp	short loc_129BD
loc_129BA:
	inc	[bp+counter]
loc_129BD:
	cmp	[bp+counter], 78h 
	jge	short loc_129CF
	mov	bx, [bp+counter]
	lfs	si, [bp+var_20]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_129BA
loc_129CF:
	push	cs
	call	near ptr getCharacterGender
	mov	gs:newCharBuffer.gender, al
	cmp	al, 0FFh
	jnz	short loc_129E4
	sub	ax, ax
	jmp	loc_12DAE
loc_129E4:
	push	cs
	call	near ptr getCharacterRace
	mov	gs:newCharBuffer.race, al
	cmp	al, 0FFh
	jnz	short loc_129F9
	sub	ax, ax
	jmp	loc_12DAE
loc_129F9:
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	shl	ax, 1
	mov	cl, gs:newCharBuffer.gender
	sub	ch, ch
	add	ax, cx
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
	jmp	short loc_12A1F
loc_12A1C:
	inc	[bp+counter]
loc_12A1F:
	cmp	[bp+counter], 5
	jge	short loc_12A5A
	call	_random
	and	ax, 7
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, byte ptr baseAttributes.male_st[bx+si]
	cbw
	add	ax, cx
	mov	si, bx
	shl	si, 1
	mov	[bp+si+var_2E],	ax
	mov	si, [bp+counter]
	shl	si, 1
	cmp	[bp+si+var_2E],	1Eh
	jle	short loc_12A58
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+var_2E],	1Eh
loc_12A58:
	jmp	short loc_12A1C
loc_12A5A:
	call	_random
	and	ax, 0Fh
	add	ax, 13
	mov	[bp+var_30], ax
	mov	gs:newCharBuffer.currentHP, ax
	mov	gs:newCharBuffer.maxHP,	ax
	mov	[bp+var_24], ax
	call	clearTextWindow
	mov	ax, 5
	push	ax
	lea	ax, [bp+var_E8]
	push	ss
	push	ax
	lea	ax, [bp+var_2E]
	push	ss
	push	ax
	call	getAttributeString
	add	sp, 0Ah
	lea	ax, [bp+var_E8]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	al, gs:newCharBuffer.race
	sub	ah, ah
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+raceGenderValue], ax
	sub	ax, ax
	mov	[bp+var_EA], ax
	mov	[bp+var_2], ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_8], ax
	mov	[bp+counter], 0
	jmp	short loc_12AD8
loc_12AD5:
	inc	[bp+counter]
loc_12AD8:
	cmp	[bp+counter], 10
	jge	short loc_12B30
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	cmp	byte ptr startingClasses.canBeWarrior[bx+si], 0
	jz	short loc_12B2E
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_2], ax
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (classString+2)[bx]
	push	word ptr classString[bx]
	push	[bp+var_EA]
	push	cs
	call	near ptr printOrderedList
	add	sp, 6
	mov	si, [bp+var_EA]
	inc	[bp+var_EA]
	shl	si, 1
	mov	ax, [bp+counter]
	mov	[bp+si+var_1C],	ax
loc_12B2E:
	jmp	short loc_12AD5
loc_12B30:
	mov	[bp+var_4], 0
	mov	[bp+var_34], 1
loc_12B3A:
	push	[bp+var_2]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_22], ax
	mov	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+var_22]
	jg	short loc_12B7B
	mov	ax, [bp+var_EA]
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+var_22]
	jl	short loc_12B7B
	mov	si, [bp+var_22]
	sub	si, [bp+var_8]
	shl	si, 1
	mov	al, [bp+si+var_23A]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
loc_12B7B:
	cmp	[bp+var_22], 30h 
	jle	short loc_12BA4
	mov	ax, [bp+var_EA]
	add	ax, 30h	
	cmp	ax, [bp+var_22]
	jl	short loc_12BA4
	mov	si, [bp+var_22]
	shl	si, 1
	mov	al, [bp+si+var_7E]
	mov	gs:newCharBuffer.class,	al
	mov	[bp+var_34], 0
	jmp	short loc_12BB4
loc_12BA4:
	cmp	[bp+var_22], 1Bh
	jnz	short loc_12BB4
	mov	[bp+var_34], 0
	mov	[bp+var_4], 1
loc_12BB4:
	cmp	[bp+var_34], 0
	jz	short loc_12BBD
	jmp	loc_12B3A
loc_12BBD:
	cmp	[bp+var_4], 0
	jz	short loc_12BC6
	jmp	loc_129B3
loc_12BC6:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	mov	si, ax
	mov	di, word ptr gs:newCharBuffer.gender
	and	di, 0FFh
	mov	bx, si
	shl	bx, 1
	mov	al, byte_42F8C[bx+di]
	mov	gs:newCharBuffer.picIndex, al
	mov	ax, si
	jmp	short loc_12C3B
loc_12BEB:
	mov	gs:newCharBuffer.spells, 0E0h ;	'à'
	jmp	short loc_12C56
loc_12BF7:
	mov	gs:newCharBuffer.spells+2, 1Ch
	jmp	short loc_12C56
loc_12C03:
	mov	gs:newCharBuffer.specAbil, 14h
	mov	gs:newCharBuffer.specAbil+1, 14h
	mov	gs:newCharBuffer.specAbil+2, 14h
	jmp	short loc_12C56
loc_12C1B:
	mov	gs:newCharBuffer.specAbil, 1
	mov	gs:newCharBuffer.specAbil+1, 0FCh 
	jmp	short loc_12C56
loc_12C2D:
	mov	gs:newCharBuffer.specAbil, 5
	jmp	short loc_12C56
	jmp	short loc_12C56
loc_12C3B:
	cmp	ax, class_conjurer
	jz	short loc_12BEB
	cmp	ax, class_magician
	jz	short loc_12BF7
	cmp	ax, class_rogue
	jz	short loc_12C03
	cmp	ax, class_bard
	jz	short loc_12C1B
	cmp	ax, class_hunter
	jz	short loc_12C2D
	jmp	short $+2
loc_12C56:
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, byte_4302E[bx]
	cbw
	mov	[bp+raceGenderValue], ax
	mov	[bp+counter], 0
loc_12C6E:
	mov	si, [bp+raceGenderValue]
	mov	bx, [bp+counter]
	mov	al, startingInventory[bx+si]
	mov	[bp+var_EC], al
	cmp	al, 0FEh 
	jz	short loc_12C8A
	mov	gs:newCharBuffer.inventory.itemFlags[bx], al
	inc	[bp+counter]
	jmp	short loc_12C6E
loc_12C8A:
	mov	word ptr [bp+var_20], offset newCharBuffer.strength
	mov	word ptr [bp+var_20+2],	seg seg027
	mov	[bp+counter], 0
	jmp	short loc_12C9E
loc_12C9B:
	inc	[bp+counter]
loc_12C9E:
	cmp	[bp+counter], 5
	jge	short loc_12CB7
	mov	si, [bp+counter]
	shl	si, 1
	mov	al, byte ptr [bp+si+var_2E]
	mov	bx, [bp+counter]
	lfs	si, [bp+var_20]
	mov	fs:[bx+si], al
	jmp	short loc_12C9B
loc_12CB7:
	mov	gs:newCharBuffer.level,	1
	mov	gs:newCharBuffer.maxLevel, 1
	cmp	gs:newCharBuffer.class,	class_warrior
	jz	short loc_12CEE
	cmp	gs:newCharBuffer.class,	class_rogue
	jnb	short loc_12CEE
	call	_random
	and	ax, 0Fh
	add	ax, 8
	mov	gs:newCharBuffer.currentSppt, ax
	jmp	short loc_12CF5
loc_12CEE:
	mov	gs:newCharBuffer.currentSppt, 0
loc_12CF5:
	mov	ax, gs:newCharBuffer.currentSppt
	mov	gs:newCharBuffer.maxSppt, ax
loc_12CFD:
	mov	ax, offset aNameYourNewCha
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 0Eh
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jnz	short loc_12D25
	jmp	loc_12DAE
loc_12D25:
	cmp	gs:newCharBuffer._name,	2Ah 
	jnz	short loc_12D37
	mov	gs:newCharBuffer._name,	58h 
loc_12D37:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr rost_charNameExists
	add	sp, 4
	or	ax, ax
	jl	short loc_12D6A
	mov	ax, offset aThereIsAlready
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	[bp+var_4], 1
	jmp	short loc_12D6F
loc_12D6A:
	mov	[bp+var_4], 0
loc_12D6F:
	cmp	[bp+var_4], 0
	jnz	short loc_12CFD
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_30], ax
	getCharP	[bp+var_30], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	getCharP	[bp+var_30], bx
	mov	fs, seg022_x
	assume fs:seg022
	mov	fs:(characterIOBuf+78h)[bx], 0
loc_12DAE:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
camp_createMember endp

; Attributes: bp-based frame
getCharacterGender proc	far

	func_enter

loc_getCharacterGender_loop_start:
	push_ds_string	aDoYouWishYourC
	std_call	printStringWClear, 4

	mov	ax, 0Ch
	push	ax
	std_call	sub_14E41, 2

	cmp	ax, 1Bh
	jz	loc_getCharacterGender_return_ff

	cmp	ax, 'F'
	jz	loc_getCharacterGender_return_one
	cmp	ax, 111h
	jz	loc_getCharacterGender_return_one

	cmp	ax, 'M'
	jz	loc_getCharacterGender_return_zero
	cmp	ax, 110h
	jnz	loc_getCharacterGender_loop_start
	
loc_getCharacterGender_return_zero:
	xor	ax, ax
	jmp	loc_getCharacterGender_exit

loc_getCharacterGender_return_one:
	mov	ax, 1
	jmp	loc_getCharacterGender_exit

loc_getCharacterGender_return_ff:
	mov	ax, 0FFh

loc_getCharacterGender_exit:
	mov	sp, bp
	pop	bp
	retf
getCharacterGender endp

; Attributes: bp-based frame

getCharacterRace proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_12E19:
	mov	ax, offset aSelectARaceFor
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 1FCh
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 1Bh
	jnz	short loc_12E3F
	mov	ax, 0FFh
	jmp	short loc_12E6B
loc_12E3F:
	cmp	[bp+var_2], 10Fh
	jle	short loc_12E55
	cmp	[bp+var_2], 117h
	jge	short loc_12E55
	mov	ax, [bp+var_2]
	sub	ax, 110h
	jmp	short loc_12E6B
loc_12E55:
	cmp	[bp+var_2], 30h	
	jle	short loc_12E69
	cmp	[bp+var_2], 38h	
	jge	short loc_12E69
	mov	ax, [bp+var_2]
	sub	ax, 31h	
	jmp	short loc_12E6B
loc_12E69:
	jmp	short loc_12E19
loc_12E6B:
	mov	sp, bp
	pop	bp
	retf
getCharacterRace endp

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	gs:rosterTail._name, 1
	sbb	ax, ax
	inc	ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
; Returns the character	number of the character	name.
; Returns -1 if	there is no character by the provided
; name in the party
; Attributes: bp-based frame

charNameInParty	proc far

	var_2= word ptr	-2
	_offset= word ptr  6
	_segment= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_12EA1
loc_12E9E:
	inc	[bp+var_2]
loc_12EA1:
	cmp	[bp+var_2], 7
	jge	short loc_12ED1
	getCharP	[bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+_segment]
	push	[bp+_offset]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jnz	short loc_12ECF
	mov	ax, [bp+var_2]
	jmp	short loc_12ED6
loc_12ECF:
	jmp	short loc_12E9E
loc_12ED1:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_12ED6:
	mov	sp, bp
	pop	bp
	retf
charNameInParty	endp

; This function	returns	the index of the character
; in the saved character list matching "name". If the
; name is not found it returns 0xffff
; Attributes: bp-based frame

rost_charNameExists proc far

	counter= word ptr -2
	nameOffset= word ptr  6
	nameString= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_12EEF
loc_12EEC:
	inc	[bp+counter]
loc_12EEF:
	cmp	[bp+counter], 75
	jge	short loc_12F1F
	getCharP	[bp+counter], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+nameString]
	push	[bp+nameOffset]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jnz	short loc_12F1D
	mov	ax, [bp+counter]
	jmp	short loc_12F24
loc_12F1D:
	jmp	short loc_12EEC
loc_12F1F:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_12F24:
	mov	sp, bp
	pop	bp
	retf
rost_charNameExists endp

; This function	prints a string	with a number in
; front	of it. e.g. 1) Wizard
; Attributes: bp-based frame

printOrderedList proc far

	var_2C=	word ptr -2Ch
	var_4= dword ptr -4
	arg_0= byte ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2Ch	
	call	someStackOperation
	lea	ax, [bp+var_2C]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ss
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	al, [bp+arg_0]
	add	al, '1'
	mov	fs:[bx], al
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	byte ptr fs:[bx], ')'
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	call	_strcat
	add	sp, 8
	lea	ax, [bp+var_2C]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printOrderedList endp

; Attributes: bp-based frame

camp_deleteCharacter proc far

	counter= word ptr -15Ch
	var_15A= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	var_154= dword ptr -154h
	var_150= word ptr -150h
	var_14E= word ptr -14Eh

	push	bp
	mov	bp, sp
	mov	ax, 15Ch
	call	someStackOperation
	push	si
	call	clearTextWindow
	push	cs
	call	near ptr countSavedChars
	or	ax, ax
	jnz	short loc_12F95
	jmp	loc_13120
loc_12F95:
	mov	[bp+counter], 0
	mov	[bp+var_15A], 0
loc_12F9B:
	cmp	[bp+var_15A], 10
	jge	l_delete_partyLimitReached
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+counter]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12F9B
l_delete_partyLimitReached:
	dec	[bp+counter]
	mov	ax, [bp+counter]
	mov	[bp+var_156], ax
	mov	[bp+var_15A], 0
loc_12FDA:
	cmp	[bp+var_15A], 75
	jge	l_delete_charLimitReached
	mov	ax, [bp+counter]
	sub	ax, [bp+var_156]
	getCharIndex	cx, cx
	add	ax, 0
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12FDA
l_delete_charLimitReached:
	dec	[bp+counter]
	push	[bp+counter]
	lea	ax, [bp+var_154]
	push	ss
	push	ax
	mov	ax, offset aDeleteWho?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_15A], ax
	or	ax, ax
	jge	short loc_13038
	jmp	loc_13139
loc_13038:
	mov	ax, [bp+var_156]
	cmp	[bp+var_15A], ax
	jge	short loc_13050
	push	[bp+var_15A]
	push	cs
	call	near ptr sub_1313E
	add	sp, 2
	jmp	loc_13139
loc_13050:
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	push	cs
	call	near ptr charNameInParty
	add	sp, 4
	or	ax, ax
	jl	short loc_1309F
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printStringWClear
	add	sp, 4
	mov	ax, offset aIsCurrentlyInT
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	loc_13139
loc_1309F:
	mov	ax, offset aAreYouSureYouW
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short loc_1311E
	mov	ax, [bp+var_15A]
	mov	[bp+var_158], ax
	jmp	short loc_130DB
loc_130D7:
	inc	[bp+var_158]
loc_130DB:
	mov	ax, [bp+counter]
	cmp	[bp+var_158], ax
	jge	short loc_1310E
	mov	si, [bp+var_158]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	mov	si, [bp+var_158]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_14E]
	push	[bp+si+var_150]
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	jmp	short loc_130D7
loc_1310E:
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	mov	byte ptr fs:[bx], 0
loc_1311E:
	jmp	short loc_13139
loc_13120:
	mov	ax, offset aThereAreNoChar
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_13139:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_deleteCharacter endp

; Attributes: bp-based frame

sub_1313E proc far

	var_10A= dword ptr -10Ah
	var_106= dword ptr -106h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], seg seg022
	mov	ax, offset aAreYouSureYouW
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_10A], ax
	mov	word ptr [bp+var_10A+2], dx
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_10A], ax
	mov	word ptr [bp+var_10A+2], dx
	lfs	bx, [bp+var_10A]
	inc	word ptr [bp+var_10A]
	mov	byte ptr fs:[bx], 3Fh ;	'?'
	lfs	bx, [bp+var_10A]
	inc	word ptr [bp+var_10A]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short loc_1323F
	mov	ax, [bp+arg_0]
	mov	[bp+var_102], ax
	jmp	short loc_131CF
loc_131CB:
	inc	[bp+var_102]
loc_131CF:
	cmp	[bp+var_102], 9
	jge	short loc_13211
	mov	ax, word ptr [bp+var_106]
	mov	dx, word ptr [bp+var_106+2]
	add	ax, 80h
	mov	word ptr [bp+var_10A], ax
	mov	word ptr [bp+var_10A+2], dx
	mov	ax, 80h
	push	ax
	push	dx
	push	word ptr [bp+var_10A]
	push	dx
	push	word ptr [bp+var_106]
	call	_memcpy
	add	sp, 0Ah
	mov	ax, word ptr [bp+var_10A]
	mov	dx, word ptr [bp+var_10A+2]
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	jmp	short loc_131CB
loc_13211:
	mov	word ptr [bp+var_106], offset byte_31268
	mov	word ptr [bp+var_106+2], seg seg022
	mov	[bp+var_102], 0
	jmp	short loc_13229
loc_13225:
	inc	[bp+var_102]
loc_13229:
	cmp	[bp+var_102], 80h
	jge	short loc_1323F
	mov	bx, [bp+var_102]
	lfs	si, [bp+var_106]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13225
loc_1323F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_1313E endp

; Attributes: bp-based frame

saveParty proc far

	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 18h
	call	someStackOperation
	mov	ax, offset aNameToSavePart
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	call	_readString
	add	sp, 6
	or	ax, ax
	jz	short loc_132A6
	push	cs
	call	near ptr countSavedParties
	mov	[bp+var_18], ax
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_132AA
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_13291
	mov	ax, [bp+var_18]
	mov	[bp+var_2], ax
loc_13291:
	cmp	[bp+var_2], 9
	jg	short loc_132A6
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr sub_132F7
	add	sp, 6
loc_132A6:
	mov	sp, bp
	pop	bp
	retf
saveParty endp

; Attributes: bp-based frame

sub_132AA proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_132BF
loc_132BC:
	inc	[bp+var_2]
loc_132BF:
	cmp	[bp+var_2], 0Ah
	jge	short loc_132EE
	mov	bx, [bp+var_2]
	mov	cl, 7
	shl	bx, cl
	lea	ax, partyIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jnz	short loc_132EC
	mov	ax, [bp+var_2]
	jmp	short loc_132F3
loc_132EC:
	jmp	short loc_132BC
loc_132EE:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_132F3:
	mov	sp, bp
	pop	bp
	retf
sub_132AA endp

; Attributes: bp-based frame

sub_132F7 proc far

	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg022
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 3Eh
	push	[bp+arg_4]
	push	[bp+arg_2]
	mov	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	inc	ax
	push	dx
	push	ax
	call	sub_2A912
	add	sp, 8
	mov	[bp+var_6], 0
	jmp	short loc_1333C
loc_13339:
	inc	[bp+var_6]
loc_1333C:
	cmp	[bp+var_6], 7
	jge	short loc_1336F
	getCharP	[bp+var_6], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_6]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	add	ax, 10h
	push	dx
	push	ax
	call	sub_2A912
	add	sp, 8
	jmp	short loc_13339
loc_1336F:
	mov	sp, bp
	pop	bp
	retf
sub_132F7 endp

; Attributes: bp-based frame

countSavedParties proc far

	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	word ptr [bp+var_4], offset partyIOBuf
	mov	word ptr [bp+var_4+2], seg seg022
	mov	[bp+var_6], 0
	jmp	short loc_13393
loc_13390:
	inc	[bp+var_6]
loc_13393:
	cmp	[bp+var_6], 0Ah
	jge	short loc_133B0
	mov	bx, [bp+var_6]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_4]
	cmp	byte ptr fs:[bx+si], 0
	jnz	short loc_133AE
	mov	ax, [bp+var_6]
	jmp	short loc_133B5
loc_133AE:
	jmp	short loc_13390
loc_133B0:
	mov	ax, 0Ah
	jmp	short $+2
loc_133B5:
	pop	si
	mov	sp, bp
	pop	bp
	retf
countSavedParties endp

; Attributes: bp-based frame

saveAndExitMaybe proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aPressReturnToS
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr roster_writeParty
	sub	ax, ax
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 0Dh
	jnz	short loc_13412
	mov	buildingRvalMaybe, 0FFh
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr saveCharsInf
	add	sp, 2
	push	cs
	call	near ptr countSavedParties
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr savePartiesInf
	add	sp, 2
loc_13412:
	call	clearTextWindow
	mov	sp, bp
	pop	bp
	retf
saveAndExitMaybe endp

; Attributes: bp-based frame

enterWilderness	proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	cs
	call	near ptr roster_writeParty
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr saveCharsInf
	add	sp, 2
	push	cs
	call	near ptr countSavedParties
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr savePartiesInf
	add	sp, 2
	mov	byte_4EEBA, 6
	sub	al, al
	mov	levelNoMaybe, al
	mov	gs:isNight, al
	mov	buildingRvalMaybe, 2
	mov	sp, bp
	pop	bp
	retf
enterWilderness	endp

; Attributes: bp-based frame

camp_enter proc	far

	var_58=	word ptr -58h
	var_56=	word ptr -56h
	var_54=	word ptr -54h
	var_52=	word ptr -52h
	var_3E=	word ptr -3Eh
	var_3C=	word ptr -3Ch
	var_14=	word ptr -14h

	push	bp
	mov	bp, sp
	mov	ax, 58h	
	call	someStackOperation
	push	si
	call	sub_22DA1
	mov	[bp+var_56], 0
	jmp	short loc_1348E
loc_1348B:
	inc	[bp+var_56]
loc_1348E:
	cmp	[bp+var_56], 5
	jge	short loc_134AE
	mov	bx, [bp+var_56]
	cmp	lightDuration[bx], 0
	jz	short loc_134AC
	push	bx
	call	sub_17920
	add	sp, 2
loc_134AC:
	jmp	short loc_1348B
loc_134AE:
	mov	gs:gl_detectSecretDoorFlag, 0
	mov	gs:songACBonus,	0
	push	cs
	call	near ptr camp_readCharsParties
	push	cs
	call	near ptr roster_writeParty
	mov	ax, offset aTheRuin
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	sub	ax, ax
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
loc_134E2:
	call	clearTextWindow
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	cs
	call	near ptr camp_configOptionList
	add	sp, 4
	lea	ax, [bp+var_3C]
	push	ss
	push	ax
	lea	ax, [bp+var_52]
	push	ss
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	mov	ax, offset aThouArtInTheCa
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_54], ax
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_58], ax
	mov	ax, [bp+var_54]
	or	ah, 20h
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_3E], ax
	cmp	ax, 30h	
	jle	short loc_13564
	mov	ax, [bp+var_58]
	add	ax, 31h	
	cmp	ax, [bp+var_3E]
	jle	short loc_13564
	mov	ax, [bp+var_3E]
	sub	ax, 31h	
	push	ax
	call	printCharacter
	add	sp, 2
	sub	ax, ax
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	mov	ax, offset aTheRuin
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_135A7
loc_13564:
	mov	[bp+var_56], 0
loc_13569:
	mov	si, [bp+var_56]
	cmp	byte ptr [bp+si+var_52], 0
	jz	short loc_135A7
	mov	al, byte ptr [bp+si+var_52]
	cbw
	cmp	ax, [bp+var_3E]
	jz	short loc_13585
	shl	si, 1
	mov	ax, [bp+var_3E]
	cmp	[bp+si+var_3C],	ax
	jnz	short loc_135A2
loc_13585:
	mov	bx, [bp+var_56]
	shl	bx, 1
	shl	bx, 1
	call	off_430BC[bx]
	cmp	buildingRvalMaybe, 0
	jz	short loc_135A2
	mov	ax, buildingRvalMaybe
	jmp	short loc_135AA
loc_135A2:
	inc	[bp+var_56]
	jmp	short loc_13569
loc_135A7:
	jmp	loc_134E2
loc_135AA:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_enter endp

; Attributes: bp-based frame

camp_readCharsParties proc far

	var_A= dword ptr -0Ah
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	mov	word ptr [bp+var_A], offset characterIOBuf
	mov	word ptr [bp+var_A+2], seg seg022
	mov	[bp+var_6], 0
	jmp	short loc_135CF
loc_135CC:
	inc	[bp+var_6]
loc_135CF:
	cmp	[bp+var_6], 4Bh	
	jge	short loc_135E6
	getCharP	[bp+var_6], bx
	lfs	si, [bp+var_A]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_135CC
loc_135E6:
	mov	ax, offset aThieves_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_4], ax
	mov	ax, 9000
	push	ax
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	_read
	add	sp, 8
	push	[bp+var_4]
	call	_close
	add	sp, 2
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	mov	[bp+var_6], ax
	jmp	short loc_13626
loc_13623:
	inc	[bp+var_6]
loc_13626:
	cmp	[bp+var_6], 75
	jge	short loc_1363D
	getCharP	[bp+var_6], bx
	lfs	si, [bp+var_A]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13623
loc_1363D:
	mov	word ptr [bp+var_A], offset partyIOBuf
	mov	word ptr [bp+var_A+2], seg seg022
	mov	[bp+var_6], 0
	jmp	short loc_13651
loc_1364E:
	inc	[bp+var_6]
loc_13651:
	cmp	[bp+var_6], 0Ah
	jge	short loc_13667
	mov	bx, [bp+var_6]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_A]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_1364E
loc_13667:
	mov	ax, offset aParties_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_4], ax
	mov	ax, 500h
	push	ax
	mov	ax, offset partyIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	_read
	add	sp, 8
	push	cs
	call	near ptr countSavedParties
	mov	[bp+var_6], ax
	jmp	short loc_13699
loc_13696:
	inc	[bp+var_6]
loc_13699:
	cmp	[bp+var_6], 0Ah
	jge	short loc_136AF
	mov	bx, [bp+var_6]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_A]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13696
loc_136AF:
	push	[bp+var_4]
	call	_close
	add	sp, 2
	mov	ax, [bp+var_2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_readCharsParties endp

; Attributes: bp-based frame

saveCharsInf proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aThieves_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_2], ax
	getCharIndex	ax, [bp+arg_0]
	inc	ax
	push	ax
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_2]
	call	_write
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
saveCharsInf endp

; Attributes: bp-based frame

savePartiesInf proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aParties_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	inc	ax
	push	ax
	mov	ax, offset partyIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_2]
	call	_write
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
savePartiesInf endp

; Attributes: bp-based frame

roster_writeParty proc far

	emptySlot= word ptr -4
	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+emptySlot],	ax
	mov	[bp+counter], 0
	jmp	short loc_13769
loc_13766:
	inc	[bp+counter]
loc_13769:
	mov	ax, [bp+emptySlot]
	cmp	[bp+counter], ax
	jl	short loc_13774
	jmp	loc_137FD
loc_13774:
	push_var_stack		counter
	std_call		roster_writeCharacter,2
	jmp	loc_13766
loc_137FD:
	mov	sp, bp
	pop	bp
	retf
roster_writeParty endp

; Attributes: bp-based frame

roster_writeCharacter proc far
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr  6

	func_enter
	mov	ax, 4
	call	someStackOperation

	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr rost_charNameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_wc_overwrite
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	getCharP	[bp+var_2], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	getCharP	[bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	jmp	short loc_wc_exit
loc_wc_overwrite:
	getCharP	[bp+var_4], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8

loc_wc_exit:
	func_exit
	retf
roster_writeCharacter endp

; Attributes: bp-based frame

copyCharacterBuf proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 78h	
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	_memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
copyCharacterBuf endp

; This function	counts the number of characters	in
; the ioBuffer memory area.
; Attributes: bp-based frame

countSavedChars	proc far

	var_6= dword ptr -6
	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	word ptr [bp+var_6], offset characterIOBuf
	mov	word ptr [bp+var_6+2], seg seg022
	mov	[bp+counter], 0
loc_13842:
	cmp	[bp+counter], 75
	jge	loc_13858
	getCharP	[bp+counter], bx
	lfs	si, [bp+var_6]
	cmp	fs:[bx+si+character_t._name], 0
	jz	short loc_13858
	inc	[bp+counter]
	jmp	short loc_13842
loc_13858:
	mov	ax, [bp+counter]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
countSavedChars	endp

; This function	configures a byte-array	for use	in
; the camp.
;
; Structure:
; a[0] is zero if no empty roster slots, One otherwise
; Attributes: bp-based frame

camp_configOptionList proc far

	counter= word ptr -2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	push	cs
	call	near ptr findEmptyRosterNum
	cmp	ax, 7
	jge	short loc_1387B
	mov	al, 1
	jmp	short loc_1387D
loc_1387B:
	sub	al, al
loc_1387D:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.hasEmptySlot], al
	push	cs
	call	near ptr rost_isNotEmpty
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.notEmpty], al
	cmp	fs:[bx+campStru_t.notEmpty], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+campStru_t.isEmpty], al
	push	cs
	call	near ptr countSavedChars
	cmp	ax, 75
	jge	short loc_138AB
	mov	al, 1
	jmp	short loc_138AD
loc_138AB:
	sub	al, al
loc_138AD:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.canSaveChar],	al
	mov	al, fs:[bx+campStru_t.canSaveChar]
	mov	fs:[bx+campStru_t.canSaveChar_1], al
	mov	[bp+counter], campStru_t.field_5
	jmp	short loc_138C9
loc_138C6:
	inc	[bp+counter]
loc_138C9:
	cmp	[bp+counter], 8
	jge	short loc_138DB
	mov	bx, [bp+counter]
	lfs	si, [bp+arg_0]
	mov	byte ptr fs:[bx+si], 1
	jmp	short loc_138C6
loc_138DB:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+campStru_t.notEmpty]
	mov	fs:[bx+campStru_t.field_6], al
	push	cs
	call	near ptr rost_getLastActiveSlot
	cmp	ax, 7
	jge	short loc_138F3
	mov	al, 1
	jmp	short loc_138F5
loc_138F3:
	sub	al, al
loc_138F5:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+8], al
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_configOptionList endp

; This function	searches through the roster looking
; for an entry that has	0 as the first character of
; the name field.
; Attributes: bp-based frame
findEmptyRosterNum proc	far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_13916
loc_13913:
	inc	[bp+var_2]
loc_13916:
	cmp	[bp+var_2], 7
	jge	short loc_13937
	getCharP	[bp+var_2], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jnz	short loc_13935
	mov	ax, [bp+var_2]
	jmp	short loc_1393C
loc_13935:
	jmp	short loc_13913
loc_13937:
	mov	ax, 7
	jmp	short $+2
loc_1393C:
	mov	sp, bp
	pop	bp
	retf
findEmptyRosterNum endp

; This function	returns	1 if roster slot zero
; is occupied. Zero otherwise
; Attributes: bp-based frame

rost_isNotEmpty	proc far
	push	bp
	mov	bp, sp
	cmp	gs:roster._name, 1
	sbb	ax, ax
	inc	ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
rost_isNotEmpty	endp

; This function	starts at the end of the roster	and
; returns the index of the last	slot that still	has
; a character active
; Attributes: bp-based frame

rost_getLastActiveSlot proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 6
	jmp	short loc_13972
loc_1396F:
	dec	[bp+var_2]
loc_13972:
	cmp	[bp+var_2], 0
	jl	short loc_1398D
	push	[bp+var_2]
	push	cs
	call	near ptr isRosterSlotActive
	add	sp, 2
	or	ax, ax
	jz	short loc_1398B
	mov	ax, [bp+var_2]
	jmp	short loc_13992
loc_1398B:
	jmp	short loc_1396F
loc_1398D:
	mov	ax, 63h	
	jmp	short $+2
loc_13992:
	mov	sp, bp
	pop	bp
	retf
rost_getLastActiveSlot endp

; This function	returns	0 if the roster	slot at	slotNo
; is empty, field_67 !=	0, or field_2d & 1c
; Attributes: bp-based frame
isRosterSlotActive proc	far

	slotNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+slotNo], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jz	short loc_139D9
	getCharP	[bp+slotNo], bx
	cmp	gs:(roster.specAbil+3)[bx], 0
	jnz	short loc_139D9
	getCharP	[bp+slotNo], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short loc_139D9
	mov	ax, 1
	jmp	short loc_139DB
loc_139D9:
	sub	ax, ax
loc_139DB:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
isRosterSlotActive endp

; Attributes: bp-based frame

tav_enter proc far

	counter= word ptr -6
	lastCharNo= word ptr -4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+lastCharNo], ax
	mov	[bp+counter], 0
	jmp	short loc_139FD
loc_139FA:
	inc	[bp+counter]
loc_139FD:
	cmp	[bp+counter], 7
	jge	short loc_13A0D
	mov	bx, [bp+counter]
	mov	tav_drunkLevel[bx], 0
	jmp	short loc_139FA
loc_13A0D:
	mov	ax, 83
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	push	cs
	call	near ptr tav_setTitle
	mov	word_4FD56, ax
loc_13A20:
	mov	ax, offset aHailTravelersS
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 70h	
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_2], ax
	jmp	short loc_13A7F
loc_13A3E:
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tav_orderDrink
	add	sp, 2
	or	ax, ax
	jz	short loc_13A50
	sub	ax, ax
	jmp	short loc_13AAE
loc_13A50:
	mov	byte ptr word_44166,	0
	jmp	short loc_13A9F
loc_13A5C:
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tav_talkToBarkeep
	add	sp, 2
	mov	byte ptr word_44166,	0
	jmp	short loc_13A9F
loc_13A72:
	call	clearTextWindow
	sub	ax, ax
	jmp	short loc_13AAE
loc_13A7B:
	jmp	short loc_13A9F
	jmp	short loc_13A9F
loc_13A7F:
	cmp	ax, 45h	
	jz	short loc_13A72
	cmp	ax, 4Fh	
	jz	short loc_13A3E
	cmp	ax, 54h	
	jz	short loc_13A5C
	cmp	ax, 112h
	jz	short loc_13A3E
	cmp	ax, 113h
	jz	short loc_13A5C
	cmp	ax, 114h
	jz	short loc_13A72
	jmp	short loc_13A7B
loc_13A9F:
	wait4IO
	jmp	loc_13A20
loc_13AAE:
	mov	sp, bp
	pop	bp
	retf
tav_enter endp

; Attributes: bp-based frame

tav_orderDrink proc far

	var_112= word ptr -112h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	lastCharNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 112h
	call	someStackOperation
	mov	ax, offset aWhoWillOrderAD
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+var_C], ax
	or	ax, ax
	jge	short loc_13ADA
	sub	ax, ax
	jmp	loc_13CB6
loc_13ADA:
	getCharP	[bp+var_C], bx
	test	gs:roster.status[bx], 1Ch
	jz	short loc_13AF9
	mov	bx, [bp+var_C]
	mov	tav_drunkLevel[bx], maxDrunkLevel
	jmp	loc_13BED
loc_13AF9:
	mov	ax, offset aSeatThyself
	push	ds
	push	ax
	lea	ax, [bp+var_112]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	getCharP	[bp+var_C], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+var_112]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
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
	mov	ax, offset aWhatLlItBe?Ale
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13B8D:
	push	[bp+var_6]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_A], ax
	cmp	ax, 1Bh
	jz	short loc_13BA5
	cmp	ax, 119h
	jnz	short loc_13BAA
loc_13BA5:
	sub	ax, ax
	jmp	loc_13CB6
loc_13BAA:
	mov	[bp+var_12], 1
	mov	[bp+var_E], 0
	jmp	short loc_13BB9
loc_13BB6:
	inc	[bp+var_E]
loc_13BB9:
	cmp	[bp+var_E], 5
	jge	short loc_13BE7
	mov	bx, [bp+var_E]
	mov	al, byte ptr aAbmfg[bx]
	cbw
	cmp	ax, [bp+var_A]
	jz	short loc_13BD9
	mov	ax, bx
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+var_A]
	jnz	short loc_13BE5
loc_13BD9:
	mov	ax, bx
	mov	[bp+var_10], ax
	mov	[bp+var_12], 0
	jmp	short loc_13BE7
loc_13BE5:
	jmp	short loc_13BB6
loc_13BE7:
	cmp	[bp+var_12], 0
	jnz	short loc_13B8D
loc_13BED:
	mov	bx, [bp+var_C]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short loc_13C34
	mov	ax, offset aThouAreInNoCon
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tav_isPartyDrunk
	add	sp, 2
	or	ax, ax
	jz	short loc_13C2F
	mov	ax, offset aInFactThyParty
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	byte_4EEBA, 16h
	mov	ax, 1
	jmp	loc_13CB6
loc_13C2F:
	sub	ax, ax
	jmp	loc_13CB6
loc_13C34:
	mov	bx, [bp+var_C]
	mov	al, byte_437D8[bx]
	cbw
	cwd
	push	dx
	push	ax
	push	bx
	push	cs
	call	near ptr payGold
	add	sp, 6
	or	ax, ax
	jz	short loc_13CA9
	mov	ax, offset aWillYouHaveIt_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_13C58:
	mov	ax, 6
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_A], ax
	jmp	short loc_13C8F
loc_13C69:
	push	[bp+var_10]
	push	[bp+var_C]
	push	cs
	call	near ptr tav_drink
	add	sp, 4
	sub	ax, ax
	jmp	short loc_13CB6
loc_13C7A:
	push	[bp+var_10]
	push	[bp+var_C]
	push	cs
	call	near ptr tav_getWineskin
	add	sp, 4
	sub	ax, ax
	jmp	short loc_13CB6
loc_13C8B:
	jmp	short loc_13CA5
	jmp	short loc_13CA5
loc_13C8F:
	cmp	ax, 48h	
	jz	short loc_13C69
	cmp	ax, 54h	
	jz	short loc_13C7A
	cmp	ax, 10Fh
	jz	short loc_13C69
	cmp	ax, 110h
	jz	short loc_13C7A
	jmp	short loc_13C8B
loc_13CA5:
	jmp	short loc_13C58
	jmp	short loc_13CB6
loc_13CA9:
	mov	ax, offset aNotEnoughGold_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_13CB6:
	mov	sp, bp
	pop	bp
	retf
tav_orderDrink endp

; Attributes: bp-based frame

payGold	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	mov	ax, [bp+arg_2]
	mov	dx, [bp+arg_4]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+arg_0], si
	cmp	word ptr gs:(roster.gold+2)[si], bx
	ja	short loc_13CEF
	jb	short loc_13CEB
	cmp	word ptr gs:roster.gold[si], cx
	jnb	short loc_13CEF
loc_13CEB:
	sub	ax, ax
	jmp	short loc_13D0D
loc_13CEF:
	mov	ax, [bp+arg_2]
	mov	dx, bx
	mov	cx, ax
	getCharP	[bp+arg_0], si
	sub	word ptr gs:roster.gold[si], cx
	sbb	word ptr gs:(roster.gold+2)[si], bx
	mov	ax, 1
	jmp	short $+2
loc_13D0D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
payGold	endp

; Attributes: bp-based frame

tav_drink proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	call	clearTextWindow
	cmp	[bp+arg_2], 4
	jnz	short loc_13D39
	mov	ax, offset aNowThatSARealT
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_13DCD
loc_13D39:
	cmp	[bp+arg_2], 3
	jnz	short loc_13D4E
	mov	ax, offset aMyGoodnessThat
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_13D5B
loc_13D4E:
	mov	ax, offset aBurpNotTooBad_
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13D5B:
	mov	bx, [bp+arg_0]
	mov	si, [bp+arg_2]
	mov	al, tav_drinkStrength[si]
	add	tav_drunkLevel[bx], al
	cmp	tav_drunkLevel[bx], 0Ch
	jle	short loc_13D78
	mov	bx, [bp+arg_0]
	mov	tav_drunkLevel[bx], 0Ch
loc_13D78:
	mov	bx, [bp+arg_0]
	mov	al, tav_drunkLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drunkString+2)[bx]
	push	word ptr drunkString[bx]
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], si
	cmp	gs:roster.class[si], class_bard
	jnz	short loc_13DCD
	mov	ax, gs:roster.level[si]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	mov	[bp+var_2], ax
	mov	al, gs:roster.specAbil[si]
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jnb	short loc_13DCD
	inc	gs:roster.specAbil[si]
loc_13DCD:
	wait4IO
	pop	si
	mov	sp, bp
	pop	bp
	retf
tav_drink endp

; Attributes: bp-based frame

tav_getWineskin	proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_2], 4
	jnz	short loc_13DF3
	sub	ax, ax
	jmp	short loc_13DF6
loc_13DF3:
	mov	ax, 4
loc_13DF6:
	mov	[bp+var_2], ax
	mov	ax, 1
	push	ax
	push	[bp+var_2]
	mov	ax, 76h	
	push	ax
	push	[bp+arg_0]
	call	inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short loc_13E22
	mov	ax, offset aTheBartenderFi
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_13E55
loc_13E22:
	mov	ax, offset aSorryBut
	push	ds
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aCanTCarryAnyMo
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13E55:
	wait4IO
	mov	sp, bp
	pop	bp
	retf
tav_getWineskin	endp

; Attributes: bp-based frame

tav_isPartyDrunk proc far

	lastCharNo= word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	jmp	short loc_13E74
loc_13E71:
	dec	[bp+lastCharNo]
loc_13E74:
	cmp	[bp+lastCharNo], 0
	jl	short loc_13E8A
	mov	bx, [bp+lastCharNo]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jge	short loc_13E88
	sub	ax, ax
	jmp	short loc_13E8F
loc_13E88:
	jmp	short loc_13E71
loc_13E8A:
	mov	ax, 1
	jmp	short $+2
loc_13E8F:
	mov	sp, bp
	pop	bp
	retf
tav_isPartyDrunk endp

; Attributes: bp-based frame

tav_setTitle proc far
deltaN=	word ptr -8
counter= word ptr -6
var_4= word ptr	-4
deltaE=	word ptr -2
	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	[bp+var_4], 4
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaN], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+deltaE], ax
	mov	[bp+counter], 0
	jmp	short loc_13EE2
loc_13EDF:
	inc	[bp+counter]
loc_13EE2:
	cmp	[bp+counter], 4
	jge	short loc_13F22
	mov	ax, [bp+counter]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, byte ptr tavCoords.sqN[si]
	cbw
	cmp	ax, [bp+deltaN]
	jnz	short loc_13F20
	mov	al, tavCoords.sqE[si]
	cbw
	cmp	ax, [bp+deltaE]
	jnz	short loc_13F20
	mov	al, tavCoords.location[si]
	cbw
	cmp	ax, currentLocationMaybe
	jnz	short loc_13F20
	mov	ax, cx
	mov	[bp+var_4], ax
	jmp	short loc_13F22
loc_13F20:
	jmp	short loc_13EDF
loc_13F22:
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (tavernNames+2)[bx]
	push	word ptr tavernNames[bx]
	call	setTitle
	add	sp, 4
	mov	bx, [bp+var_4]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	al, tavCoords.field_4[bx]
	cbw
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
tav_setTitle endp

; Attributes: bp-based frame

tav_talkToBarkeep proc far

	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	mov	ax, offset aWhoWillTalkToT
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+var_8], ax
	or	ax, ax
	jge	short loc_13F78
	sub	ax, ax
	jmp	loc_14079
loc_13F78:
	call	clearTextWindow
	mov	bx, [bp+var_8]
	cmp	tav_drunkLevel[bx], 0Ch
	jl	short loc_13F8A
	jmp	loc_1406A
loc_13F8A:
	mov	ax, offset aTalkAinTCheap
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+var_8]
	cmp	tav_drunkLevel[bx], 5
	jl	short loc_13FAE
	mov	ax, offset aBeerBreath
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13FAE:
	mov	ax, offset aTheBarkeepSays
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aHowMuchWillYou
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	sub_16001
	cwd
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	or	dx, ax
	jnz	short loc_13FDB
	jmp	loc_14079
loc_13FDB:
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+var_8]
	push	cs
	call	near ptr payGold
	add	sp, 6
	or	ax, ax
	jnz	short loc_13FFE
	mov	ax, offset aNotEnoughGold_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_14079
loc_13FFE:
	getCharP	[bp+var_8], bx
	mov	ax, word ptr gs:roster.gold[bx]
	or	ax, word ptr gs:(roster.gold+2)[bx]
	jz	short loc_1405B
	mov	[bp+var_A], 4
	jmp	short loc_14020
loc_1401D:
	dec	[bp+var_A]
loc_14020:
	cmp	[bp+var_A], 0
	jl	short loc_14059
	mov	bx, [bp+var_A]
	mov	al, byte_43876[bx]
	sub	ah, ah
	sub	dx, dx
	cmp	dx, [bp+var_2]
	ja	short loc_14057
	jb	short loc_1403D
	cmp	ax, [bp+var_4]
	jnb	short loc_14057
loc_1403D:
	add	bx, word_4FD56
	shl	bx, 1
	shl	bx, 1
	push	word ptr (barkeepSayings+2)[bx]
	push	word ptr barkeepSayings[bx]
	call	printString
	add	sp, 4
	jmp	short loc_14059
loc_14057:
	jmp	short loc_1401D
loc_14059:
	jmp	short loc_14068
loc_1405B:
	mov	ax, offset aMoneyTalksFrie
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_14068:
	jmp	short loc_14079
loc_1406A:
	mov	ax, offset aYouAreInNoCond
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short $+2
loc_14079:
	mov	sp, bp
	pop	bp
	retf
tav_talkToBarkeep endp

; Attributes: bp-based frame

temple_enter proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	call	clearTextWindow
	mov	ax, 49
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	push	cs
	call	near ptr temple_setTitle
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_6], ax
loc_140A4:
	mov	ax, offset aWelcomeOhWearyOne
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 70h	
	mov	ax, 70h	
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_4], ax
	cmp	ax, 10Eh
	jl	short loc_140D3
	cmp	ax, 119h
	jg	short loc_140D3
	sub	[bp+var_4], 4
loc_140D3:
	mov	ax, [bp+var_4]
	jmp	short loc_140F2
loc_140D8:
	push	cs
	call	near ptr temple_getHealee
	jmp	short loc_14112
loc_140DE:
	push	[bp+var_6]
	push	cs
	call	near ptr temple_getPoolGoldee
	add	sp, 2
	jmp	short loc_14112
loc_140EA:
	sub	ax, ax
	jmp	short loc_1412B
loc_140EE:
	jmp	short loc_14112
	jmp	short loc_14112
loc_140F2:
	cmp	ax, 45h	
	jz	short loc_140EA
	cmp	ax, 48h	
	jz	short loc_140D8
	cmp	ax, 50h	
	jz	short loc_140DE
	cmp	ax, 10Eh
	jz	short loc_140D8
	cmp	ax, 10Fh
	jz	short loc_140DE
	cmp	ax, 110h
	jz	short loc_140EA
	jmp	short loc_140EE
loc_14112:
	mov	byte ptr word_44166,	0
	wait4IO
	jmp	loc_140A4
loc_1412B:
	mov	sp, bp
	pop	bp
	retf
temple_enter endp

; Attributes: bp-based frame

temple_getHealee proc far

	deltaHP= word ptr -112h
	payee= word ptr	-110h
	statusAilment= word ptr	-10Eh
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_104= word ptr -104h
	charP= word ptr	-4
	healCost= word ptr -2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 112h
	call	someStackOperation
	push	si
	mov	ax, offset aWhoNeedethHealing
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+charP], ax
	or	ax, ax
	jge	short loc_14156
	jmp	loc_1444D
loc_14156:
	mov	ax, [bp+arg_0]
	cmp	[bp+charP], ax
	jl	short loc_14161
	jmp	loc_1444D
loc_14161:
	getCharP	[bp+charP], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+charP]
	push	cs
	call	near ptr temple_getStatAilment
	add	sp, 2
	mov	[bp+statusAilment], ax
	or	ax, ax
	jz	short loc_141E5
	mov	ax, offset aIsInBadShapeIndeed_
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aThouMustSacrifice
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+statusAilment]
	push	[bp+charP]
	push	cs
	call	near ptr temple_getHealPrice
	add	sp, 4
	mov	[bp+healCost], ax
	jmp	loc_142B5
loc_141E5:
	getCharP	[bp+charP], si
	mov	ax, gs:roster.maxHP[si]
	sub	ax, gs:roster.currentHP[si]
	mov	[bp+deltaHP], ax
	or	ax, ax
	jnz	short loc_1426D
	mov	ax, gs:roster.maxLevel[si]
	cmp	gs:roster.level[si], ax
	jnz	short loc_1423D
	mov	ax, offset aDoesNotRequireAnyHeal
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	loc_1444D
loc_1423D:
	mov	ax, offset aHathBeenDrainedOfLife
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, 8
	push	ax
	push	[bp+charP]
	push	cs
	call	near ptr temple_getHealPrice
	add	sp, 4
	mov	[bp+healCost], ax
	jmp	short loc_142B5
loc_1426D:
	mov	ax, offset aHasWoundsWhichNeedTen
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+deltaHP]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	[bp+healCost], ax
	mov	ax, offset aTheDonationWillBe
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_142B5:
	sub	ax, ax
	push	ax
	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aInGold_WhoWillForfeit
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+payee], ax
	or	ax, ax
	jge	short loc_1430D
	jmp	loc_1444D
loc_1430D:
	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+payee]
	push	cs
	call	near ptr payGold
	add	sp, 6
	or	ax, ax
	jnz	short loc_14332
	mov	ax, offset aSorryButWithoutProper
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	loc_1444D
loc_14332:
	cmp	[bp+statusAilment], 0
	jz	short loc_14349
	push	[bp+statusAilment]
	push	[bp+charP]
	push	cs
	call	near ptr temple_clrStatAilment
	add	sp, 4
	jmp	short loc_143A1
loc_14349:
	getCharP	[bp+charP], si
	mov	ax, gs:roster.maxLevel[si]
	cmp	gs:roster.level[si], ax
	jz	short loc_1438F
	dec	ax
	push	ax
	push	[bp+charP]
	push	cs
	call	near ptr getXPForLevel
	add	sp, 4
	mov	word ptr gs:roster.experience[si], ax
	mov	word ptr gs:(roster.experience+2)[si], dx
	getCharP	[bp+charP], si
	mov	ax, gs:roster.maxLevel[si]
	mov	gs:roster.level[si], ax
	jmp	short loc_143A1
loc_1438F:
	getCharP	[bp+charP], si
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
loc_143A1:
	mov	ax, offset aThePriestsLayHandsOn
	push	ds
	push	ax
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	xor	ax, ax
	push ax
	mov	ax, 3
	push	ax
	push	[bp+charP]
	push	dx
	push	[bp+var_10A]
	push	cs
	call	near ptr printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aElipsis
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aElipsisAnd
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	sub	ax, ax
	push	ax
	push	ax
	push	[bp+charP]
	push	dx
	push	[bp+var_10A]
	push	cs
	call	near ptr printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset aIsHealed
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	_strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
loc_1444D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
temple_getHealee endp

; Attributes: bp-based frame

printCharPronoun proc far

	var_16=	word ptr -16h
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= byte ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr  0Eh

	push	bp
	mov	bp, sp
	mov	ax, 16h
	call	someStackOperation
	push	si
	test	[bp+arg_4], 80h
	jz	short loc_1452D
	mov	ax, word ptr [bp+arg_4]
	and	ax, 3
	getMonIndex	cx, cx
	mov	si, ax
	mov	al, gs:monGroups.packedGenAc[si]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	mov	[bp+var_2], ax
	cmp	ax, 3
	jnz	short loc_1452B
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	lea	ax, monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	decryptName
	add	sp, 8
	sub	ax, ax
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	lea	ax, [bp+var_16]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	jmp	short loc_14586
loc_1452B:
	jmp	short loc_14564
loc_1452D:
	getCharP	word ptr [bp+arg_4], si
	mov	al, gs:roster.gender[si]
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_2], ax
	cmp	ax, 3
	jnz	short loc_14564
	lea	ax, roster._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcat
	add	sp, 8
	jmp	short loc_14586
loc_14564:
	mov	bx, [bp+var_2]
	add	bx, [bp+arg_6]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (pronounString+2)[bx]
	push	word ptr pronounString[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcat
	add	sp, 8
	jmp	short $+2
loc_14586:
	cmp	[bp+arg_8], 0
	jz	printCharPronoun_exit
	push	ds
	push	offset aExclBlankLine
	push	dx
	push	ax
	call	_strcat
	add	sp, 8

printCharPronoun_exit:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printCharPronoun endp

; Attributes: bp-based frame

temple_setTitle	proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+var_8], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+var_2], ax
	mov	[bp+var_4], 3
	mov	[bp+var_6], 0
	jmp	short loc_145DA
loc_145D7:
	inc	[bp+var_6]
loc_145DA:
	cmp	[bp+var_6], 3
	jge	short loc_14614
	mov	si, [bp+var_6]
	mov	cl, 2
	shl	si, cl
	mov	al, byte ptr templeLoc.sqN[si]
	sub	ah, ah
	cmp	ax, [bp+var_8]
	jnz	short loc_14612
	mov	al, templeLoc.sqE[si]
	cmp	ax, [bp+var_2]
	jnz	short loc_14612
	mov	al, templeLoc.location[si]
	cmp	ax, currentLocationMaybe
	jnz	short loc_14612
	mov	ax, [bp+var_6]
	mov	[bp+var_4], ax
	jmp	short loc_14614
loc_14612:
	jmp	short loc_145D7
loc_14614:
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (templeTitles+2)[bx]
	push	word ptr templeTitles[bx]
	call	setTitle
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
temple_setTitle	endp

; Attributes: bp-based frame

temple_getHealPrice proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jb	short loc_14656
	mov	[bp+var_2], 1
	jmp	short loc_14670
loc_14656:
	getCharP	[bp+arg_0], bx
	mov	ax, gs:roster.level[bx]
	sub	ax, 0Dh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0Dh
	mov	[bp+var_2], ax
loc_14670:
	mov	bx, [bp+arg_2]
	shl	bx, 1
	mov	ax, temple_healPrice[bx]
	imul	[bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
temple_getHealPrice endp

; Attributes: bp-based frame

temple_getStatAilment proc far

	counter= word ptr -4
	status=	word ptr -2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.status[bx]
	sub	ah, ah
	mov	[bp+status], ax
	or	ax, ax
	jz	short loc_146CD
	mov	[bp+counter], 6
	jmp	short loc_146B1
loc_146AE:
	dec	[bp+counter]
loc_146B1:
	cmp	[bp+counter], 0
	jl	short loc_146CD
	mov	bx, [bp+counter]
	mov	al, byte_43B50[bx]
	sub	ah, ah
	test	[bp+status], ax
	jz	short loc_146CB
	mov	al, byte_43B58[bx]
	jmp	short loc_146D1
loc_146CB:
	jmp	short loc_146AE
loc_146CD:
	sub	ax, ax
	jmp	short $+2
loc_146D1:
	mov	sp, bp
	pop	bp
	retf
temple_getStatAilment endp

; Attributes: bp-based frame

temple_clrStatAilment proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	mov	bx, [bp+arg_2]
	mov	al, statusHealMask[bx]
	and	gs:roster.status[si], al
	mov	gs:roster.hostileFlag[si], 0
	mov	ax, [bp+arg_2]
	jmp	short loc_14760
loc_14703:
	getCharP	[bp+arg_0], si
	mov	ax, 5
	push	ax
	lea	ax, roster.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, roster.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
	jmp	short loc_1476C
loc_14728:
	getCharP	[bp+arg_0], bx
	mov	gs:roster.currentHP[bx], 1
loc_1473B:
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.currentHP[bx], 0
	jnz	short loc_1475E
	getCharP	[bp+arg_0], bx
	mov	gs:roster.currentHP[bx], 1
loc_1475E:
	jmp	short loc_1476C
loc_14760:
	cmp	ax, 2
	jz	short loc_14703
	cmp	ax, 6
	jz	short loc_14728
	jmp	short loc_1473B
loc_1476C:
	pop	si
	mov	sp, bp
	pop	bp
	retf
temple_clrStatAilment endp

; Attributes: bp-based frame

temple_getPoolGoldee proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aWhomShallGatherTh
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_147CD
	mov	ax, [bp+arg_0]
	cmp	[bp+var_2], ax
	jge	short loc_147CD
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr doPoolGold
	add	sp, 4
	getCharP	[bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, offset aNowHathAllTheGold
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_147CD:
	mov	sp, bp
	pop	bp
	retf
temple_getPoolGoldee endp

; Attributes: bp-based frame

getCharNumber proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_147DC:
	mov	ax, 2000h
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 1Bh
	jnz	short loc_147F5
	mov	ax, 0FFFFh
	jmp	short loc_14820
loc_147F5:
	cmp	[bp+var_2], 30h	
	jle	short loc_1481E
	cmp	[bp+var_2], 38h	
	jge	short loc_1481E
	sub	[bp+var_2], 31h	
	getCharP	[bp+var_2], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jz	short loc_1481E
	mov	ax, [bp+var_2]
	jmp	short loc_14820
loc_1481E:
	jmp	short loc_147DC
loc_14820:
	mov	sp, bp
	pop	bp
	retf
getCharNumber endp

; Attributes: bp-based frame
doPoolGold proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	sub	ax, ax
	mov	[bp+var_4], ax
	mov	[bp+var_6], ax
	mov	[bp+var_2], ax
	jmp	short loc_14840
loc_1483D:
	inc	[bp+var_2]
loc_14840:
	mov	ax, [bp+arg_2]
	cmp	[bp+var_2], ax
	jge	short loc_1487A
	getCharP	[bp+var_2], si
	cmp	byte ptr gs:roster._name[si], 0
	jz	short loc_14878
	mov	ax, word ptr gs:roster.gold[si]
	mov	dx, word ptr gs:(roster.gold+2)[si]
	add	[bp+var_6], ax
	adc	[bp+var_4], dx
	sub	ax, ax
	mov	word ptr gs:(roster.gold+2)[si], ax
	mov	word ptr gs:roster.gold[si], ax
loc_14878:
	jmp	short loc_1483D
loc_1487A:
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+arg_0], si
	mov	word ptr gs:roster.gold[si], cx
	mov	word ptr gs:(roster.gold+2)[si], bx
	pop	si
	mov	sp, bp
	pop	bp
	retf
doPoolGold endp

; This function	gets the XP requirements for a
; given	level
; Attributes: bp-based frame

getXPForLevel proc far

	var_8= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	playerNo= word ptr  6
	level= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	cmp	[bp+level], 11
	jle	short loc_148D7
	mov	ax, 1A80h
	mov	dx, 6
	push	dx
	push	ax
	mov	ax, [bp+level]
	cwd
	push	dx
	push	ax
	call	_level32bitMult
	sub	ax, 2380h
	sbb	dx, 43h	
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	[bp+level], 0Bh
	jmp	short loc_148DF
loc_148D7:
	sub	ax, ax
	mov	[bp+var_2], ax
	mov	[bp+var_4], ax
loc_148DF:
	getCharP	[bp+playerNo], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr classXPReqs[bx]
	mov	dx, word ptr (classXPReqs+2)[bx]
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], dx
	mov	bx, [bp+level]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+var_8]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	add	ax, [bp+var_4]
	adc	dx, [bp+var_2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
getXPForLevel endp

; Attributes: bp-based frame
enterBuildingMaybe proc	far
	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	_random
	test	al, 3
	jnz	short loc_14945
	mov	partyAttackFlag, 0
	call	bat_init
loc_14945:
	cmp	currentLocationMaybe, 1
	jnz	short loc_14956
	mov	ax, 32h	
	jmp	short loc_14959
loc_14956:
	mov	ax, 45h	
loc_14959:
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	mov	ax, offset aBuilding
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, offset aYouAreInAnEmpt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
enterBuildingMaybe endp

; Attributes: bp-based frame
strg_enter proc	far

	var_4= word ptr	-4

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, 32h	
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	mov	ax, offset aBuilding
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	push	cs
	call	near ptr readInventoryStf
loc_149B8:
	mov	ax, offset aThePartyIsInsi
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr getCharNumber
	mov	[bp+var_4], ax
	or	ax, ax
	jl	short loc_149DA
	push	ax
	push	cs
	call	near ptr strg_getItem
	add	sp, 2
	jmp	short loc_149F2
loc_149DA:
	push	cs
	call	near ptr writeInventoryStf
	call	clearTextWindow
	mov	buildingRvalMaybe, 2
	sub	ax, ax
	jmp	short loc_149F4
loc_149F2:
	jmp	short loc_149B8
loc_149F4:
	mov	sp, bp
	pop	bp
	retf
strg_enter endp

; Attributes: bp-based frame

strg_getItem proc far

	var_372= word ptr -372h
	var_302= word ptr -302h
	var_142= word ptr -142h
	var_140= word ptr -140h
	var_13E= word ptr -13Eh
	var_13C= word ptr -13Ch
	var_13A= word ptr -13Ah
	var_138= word ptr -138h
	var_38=	word ptr -38h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 372h
	call	someStackOperation
	push	di
	push	si
loc_14A05:
	lea	ax, [bp+var_38]
	push	ss
	push	ax
	lea	ax, [bp+var_372]
	push	ss
	push	ax
	lea	ax, [bp+var_302]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_14BD4
	add	sp, 0Ch
	mov	[bp+var_13E], ax
	or	ax, ax
	jnz	short loc_14A28
	jmp	loc_14B24
loc_14A28:
	mov	ax, offset aWould
	push	ds
	push	ax
	lea	ax, [bp+var_138]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_140]
	push	[bp+var_142]
	call	_strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	mov	ax, offset aLikeToPickup__
	push	ds
	push	ax
	push	dx
	push	[bp+var_142]
	call	_strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	push	[bp+var_13E]
	lea	ax, [bp+var_372]
	push	ss
	push	ax
	lea	ax, [bp+var_138]
	push	ss
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_13A], ax
	or	ax, ax
	jl	short loc_14B20
	mov	di, ax
	shl	di, 1
	mov	ax, [bp+di+var_38]
	mov	[bp+var_13C], ax
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, (strg_inventory+2)[si]
	sub	ah, ah
	push	ax
	mov	al, (strg_inventory+1)[si]
	push	ax
	mov	al, strg_inventory[si]
	push	ax
	push	[bp+arg_0]
	call	inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short loc_14B03
	mov	bx, [bp+var_13C]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	strg_inventory[bx], 0
	mov	ax, offset aYouPickUpTheIt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short loc_14B1E
loc_14B03:
	mov	ax, offset aAllFull
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	delayNoTable	4
	jmp	short loc_14B4E
loc_14B1E:
	jmp	short loc_14B22
loc_14B20:
	jmp	short loc_14B4E
loc_14B22:
	jmp	short loc_14B3F
loc_14B24:
	mov	ax, offset aTheBuildingIsE
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	delayNoTable	4
	jmp	short loc_14B4E
loc_14B3F:
	delayNoTable	4
	jmp	loc_14A05
loc_14B4E:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
strg_getItem endp

; Attributes: bp-based frame

writeInventoryStf proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aInventor_stf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, 54h	
	push	ax
	mov	ax, offset strg_inventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+var_2]
	call	_write
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
writeInventoryStf endp

; Attributes: bp-based frame

readInventoryStf proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aInventor_stf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, 84
	push	ax
	mov	ax, offset strg_inventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+var_2]
	call	_read
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
readInventoryStf endp

; Attributes: bp-based frame

sub_14BD4 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= dword ptr  0Eh

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	[bp+var_8], 0
	mov	ax, 46h	
	push	ax
	call	sub_19813
	add	sp, 2
	or	ax, ax
	jz	short loc_14BFA
	mov	ax, 1Ch
	jmp	short loc_14BFD
loc_14BFA:
	mov	ax, 12h
loc_14BFD:
	mov	[bp+var_6], ax
	mov	[bp+var_4], 0
	jmp	short loc_14C0A
loc_14C07:
	inc	[bp+var_4]
loc_14C0A:
	mov	ax, [bp+var_6]
	cmp	[bp+var_4], ax
	jge	short loc_14C8B
	mov	bx, [bp+var_4]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	al, strg_inventory[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_14C88
	mov	bx, [bp+var_8]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_4]
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	bx, [bp+var_2]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (itemStr+2)[bx]
	push	word ptr itemStr[bx]
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+var_8]
	inc	[bp+var_8]
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, [bp+var_4]
	mov	fs:[bx+si], ax
loc_14C88:
	jmp	loc_14C07
loc_14C8B:
	mov	ax, [bp+var_8]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_14BD4 endp

; This function	inserts	a new member into the last
; active slot in the roster. Dead, paralyzed or	stoned
; members are moved down.
; Attributes: bp-based frame

rost_insertMember proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	emptySlot= word	ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	push	cs
	call	near ptr rost_getLastActiveSlot
	mov	[bp+emptySlot],	ax
	cmp	ax, 7
	jl	short loc_14CB0
	jmp	loc_14D30
loc_14CB0:
	mov	[bp+var_4], 0
loc_14CB5:
	push	cs
	call	near ptr rost_getLastActiveSlot
	cmp	ax, [bp+var_4]
	jle	short loc_14D30
	getCharP	[bp+var_4], si
	test	gs:roster.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_14D2B
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, roster._name[si]
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	[bp+var_4]
	push	cs
	call	near ptr rost_removeMember
	add	sp, 2
	cmp	gs:newCharBuffer.class,	class_illusion
	jz	short loc_14D29
	cmp	gs:newCharBuffer.specAbil+3, 0
	jnz	short loc_14D29
	push	cs
	call	near ptr findEmptyRosterNum
	mov	[bp+var_6], ax
	getCharP	[bp+var_6], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
loc_14D29:
	jmp	short loc_14D2E
loc_14D2B:
	inc	[bp+var_4]
loc_14D2E:
	jmp	short loc_14CB5
loc_14D30:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rost_insertMember endp

; Attributes: bp-based frame

getDisk2 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_14D40:
	mov	ax, 2
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_14D81
	mov	ax, offset aPleaseInsertDi
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aDisk2
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_14D81:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_14D40
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
getDisk2 endp

seg002 ends
