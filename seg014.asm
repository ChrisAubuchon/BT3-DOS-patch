; Segment type:	Pure code
seg014 segment byte public 'CODE' use16
	assume cs:seg014
;org 8
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

bards_enter proc far
var_4= word ptr	-4
var_2= word ptr	-2
	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	ax, offset aBardSHall
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, 53h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
loc_25B2D:
	mov	ax, offset aWelcomeAndBeHa
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	ax, g_printPartyFlag[si]
	or	ax, bitMask16bit[si]
	mov	[bp+var_2], ax
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_4], ax
	cmp	ax, 10Eh
	jl	short loc_25B7D
	cmp	ax, 119h
	jg	short loc_25B7D
	mov	al, gs:txt_numLines
	sub	ah, ah
	dec	ax
	sub	[bp+var_4], ax
loc_25B7D:
	cmp	[bp+var_4], 'L'
	jz	short loc_25B8A
	cmp	[bp+var_4], 10Eh
	jnz	short loc_25B8E
loc_25B8A:
	push	cs
	call	near ptr bards_listen
loc_25B8E:
	cmp	[bp+var_4], 1Bh
	jz	short loc_25BA1
	cmp	[bp+var_4], 'E'
	jz	short loc_25BA1
	cmp	[bp+var_4], 10Fh
	jnz	short loc_25B2D
loc_25BA1:
	sub	ax, ax
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_enter endp

; Attributes: bp-based frame

bards_listen proc far

	var_2E=	word ptr -2Eh
	var_1A=	word ptr -1Ah
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2Eh	
	call	someStackOperation
	push	si
	lea	ax, [bp+var_C]
	push	ss
	push	ax
	cmp	currentLocationMaybe, 9
	jnz	short loc_25BCC
	mov	ax, 1
	jmp	short loc_25BCE
loc_25BCC:
	sub	ax, ax
loc_25BCE:
	push	ax
	push	cs
	call	near ptr sub_25E1B
	add	sp, 6
	call	text_clear
	lea	ax, [bp+var_2E]
	push	ss
	push	ax
	lea	ax, [bp+var_1A]
	push	ss
	push	ax
	lea	ax, [bp+var_C]
	push	ss
	push	ax
	mov	ax, offset aTheseAreTheSon
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_E], ax
loc_25BFA:
	push	[bp+var_E]
	call	getKey
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 1Bh
	jnz	short loc_25C0F
	jmp	short loc_25C6D
loc_25C0F:
	mov	[bp+var_10], 0
	jmp	short loc_25C19
loc_25C16:
	inc	[bp+var_10]
loc_25C19:
	cmp	[bp+var_10], 6
	jge	short loc_25C6B
	mov	si, [bp+var_10]
	mov	al, byte ptr [bp+si+var_1A]
	cbw
	cmp	ax, [bp+var_2]
	jz	short loc_25C35
	shl	si, 1
	mov	ax, [bp+var_2]
	cmp	[bp+si+var_2E],	ax
	jnz	short loc_25C69
loc_25C35:
	mov	bx, [bp+var_10]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongLyrics[bx]
	or	ax, word ptr (bardSongLyrics+2)[bx]
	jnz	short loc_25C5D
	cmp	[bp+var_10], 2
	jnz	short loc_25C51
	mov	ax, 1
	jmp	short loc_25C53
loc_25C51:
	sub	ax, ax
loc_25C53:
	push	ax
	push	cs
	call	near ptr bards_learnSong
	add	sp, 2
	jmp	short loc_25C67
loc_25C5D:
	push	[bp+var_10]
	push	cs
	call	near ptr sub_25C72
	add	sp, 2
loc_25C67:
	jmp	short loc_25C6D
loc_25C69:
	jmp	short loc_25C16
loc_25C6B:
	jmp	short loc_25BFA
loc_25C6D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_listen endp

; Attributes: bp-based frame

sub_25C72 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	call	text_clear
	mov	[bp+var_2], 0
	jmp	short loc_25C8D
loc_25C8A:
	inc	[bp+var_2]
loc_25C8D:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	ax, [bp+var_2]
	cmp	word_4BDC4[bx],	ax
	jle	short loc_25CC9
	mov	si, ax
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, bardSongLyrics[bx]
	push	word ptr fs:[bx+si+2]
	push	word ptr fs:[bx+si]
	call	printString
	add	sp, 4
	wait4IO
	jmp	short loc_25C8A
loc_25CC9:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_25C72 endp

; Attributes: bp-based frame

bards_learnSong	proc far

	var_108= word ptr -108h
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si
	mov	ax, offset aTheBardSmilesA
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	ax, offset aItWillCostYou
	push	ds
	push	ax
	lea	ax, [bp+var_108]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	sub	ax, ax
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (bardSongPrice+2)[bx]
	push	word ptr bardSongPrice[bx]
	push	dx
	push	[bp+var_4]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset aInGold_WhoWill
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+var_108]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_8], ax
	or	ax, ax
	jge	short loc_25D64
	jmp	loc_25E16
loc_25D64:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_8], si
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_25DA2
	jb	short loc_25D93
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_25DA2
loc_25D93:
	mov	ax, offset aNotEnoughGoldNL
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short loc_25E0A
loc_25DA2:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_8], si
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	[bp+var_6], 0
	jmp	short loc_25DD5
loc_25DD2:
	inc	[bp+var_6]
loc_25DD5:
	cmp	[bp+var_6], 7
	jge	short loc_25DFD
	getCharP	[bp+var_6], si
	cmp	gs:party.class[si], class_bard
	jnz	short loc_25DFB
	mov	bx, [bp+arg_0]
	mov	al, byte_4BDF0[bx]
	or	gs:(party.specAbil+1)[si], al
loc_25DFB:
	jmp	short loc_25DD2
loc_25DFD:
	mov	ax, offset aTheBardPlaysTh
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_25E0A:
	wait4IO
loc_25E16:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_learnSong	endp

; Attributes: bp-based frame

sub_25E1B proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_25E31
loc_25E2E:
	inc	[bp+var_2]
loc_25E31:
	cmp	[bp+var_2], 3
	jge	short loc_25E4A
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_2]
	cmp	[bp+arg_0], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+si], al
	jmp	short loc_25E2E
loc_25E4A:
	mov	[bp+var_2], 3
	jmp	short loc_25E54
loc_25E51:
	inc	[bp+var_2]
loc_25E54:
	cmp	[bp+var_2], 6
	jge	short loc_25E68
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_2]
	mov	al, byte ptr [bp+arg_0]
	mov	fs:[bx+si], al
	jmp	short loc_25E51
loc_25E68:
	pop	si
	mov	sp, bp
	pop	bp
locret_25E6C:
	retf
sub_25E1B endp

seg014 ends
