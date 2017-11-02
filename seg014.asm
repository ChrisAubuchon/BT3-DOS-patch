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
	call	strcat
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
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset aInGold_WhoWill
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	call	strcat
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
