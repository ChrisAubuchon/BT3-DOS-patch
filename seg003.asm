; Segment type:	Pure code
seg003 segment byte public 'CODE' use16
	assume cs:seg003
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

sub_14D90 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jz	short loc_14DA9
	lfs	bx, disk3
	mov	byte ptr fs:[bx+5], 31h	
loc_14DA9:
	mov	sp, bp
	pop	bp
locret_14DAC:
	retf
sub_14D90 endp

; Attributes: bp-based frame

getYesNo proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	di
	push	si
	push	cs
	call	near ptr txt_newLine
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	di, si
	shl	di, 1
	mov	ax, (bitMask16bit+2)[di]
	or	ax, bitMask16bit[di]
	mov	[bp+var_2], ax
	mov	[bp+var_4], si
	mov	ax, offset aYesNo
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
loc_14DEE:
	push	[bp+var_2]
	push	cs
	call	near ptr sub_14E41
	add	sp, 2
	mov	[bp+var_6], ax
	cmp	ax, 10Eh
	jl	short loc_14E0B
	cmp	ax, 119h
	jg	short loc_14E0B
	mov	ax, [bp+var_4]
	sub	[bp+var_6], ax
loc_14E0B:
	mov	ax, [bp+var_6]
	jmp	short loc_14E23
loc_14E10:
	push	cs
	call	near ptr clearTextWindow
	mov	ax, 1
	jmp	short loc_14E3B
loc_14E19:
	push	cs
	call	near ptr clearTextWindow
	sub	ax, ax
	jmp	short loc_14E3B
loc_14E21:
	jmp	short loc_14E39
loc_14E23:
	cmp	ax, 4Eh	
	jz	short loc_14E19
	cmp	ax, 59h	
	jz	short loc_14E10
	cmp	ax, 10Eh
	jz	short loc_14E10
	cmp	ax, 10Fh
	jz	short loc_14E19
	jmp	short loc_14E21
loc_14E39:
	jmp	short loc_14DEE
loc_14E3B:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
getYesNo endp

; Attributes: bp-based frame

sub_14E41 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	spell_mouseClicked, 0
	push	cs
	call	near ptr sub_1766A
loc_14E50:
	call	checkMouse
	cmp	mouse_moved, 0
	jz	short loc_14E74
	call	far ptr	sub_3E974
	push	[bp+arg_0]
	push	cs
	call	near ptr updateMouseIcon
	add	sp, 2
	push	cs
	call	near ptr sub_1766A
loc_14E74:
	push	[bp+arg_0]
	push	cs
	call	near ptr getMouseClick
	add	sp, 2
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_14E8F
	call	far ptr	sub_3E974
	mov	spell_mouseClicked, 1
	mov	ax, [bp+var_2]
	jmp	short loc_14EC8
loc_14E8F:
	call	checkKeyboard
	or	ax, ax
	jz	short loc_14EBE
	call	far ptr	sub_3E974
	call	_readChFromKeyboard
	mov	[bp+var_2], ax
	or	al, al
	jz	short loc_14EB9
	mov	al, byte ptr [bp+var_2]
	sub	ah, ah
	push	ax
	call	_str_capitalize
	add	sp, 2
	jmp	short loc_14EC8
loc_14EB9:
	mov	ax, [bp+var_2]
	jmp	short loc_14EC8
loc_14EBE:
	push	cs
	call	near ptr sub_15226
	push	cs
	call	near ptr printRoster
	jmp	short loc_14E50
loc_14EC8:
	mov	sp, bp
	pop	bp
	retf
sub_14E41 endp

; Attributes: bp-based frame

sub_14ECC proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jl	short loc_14F35
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short loc_14F35
	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jl	short loc_14F35
	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jge	short loc_14F35
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_2], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_2]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short loc_14F2D
	mov	ax, 5
	jmp	short loc_14F30
loc_14F2D:
	mov	ax, 6
loc_14F30:
	mov	[bp+var_4], ax
	jmp	short loc_14F3A
loc_14F35:
	mov	[bp+var_4], 6
loc_14F3A:
	mov	ax, [bp+var_4]
	cmp	gs:word_4241E, ax
	jz	short loc_14F55
	mov	gs:word_4241E, ax
	push	ax
	call	far ptr	vid_setMouseIcon
	add	sp, 2
loc_14F55:
	mov	sp, bp
	pop	bp
	retf
sub_14ECC endp

; Attributes: bp-based frame

updateMouseIcon proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	test	[bp+arg_0], 4000h
	jz	short loc_14F74
	mov	[bp+var_2], 5
	jmp	loc_15070
loc_14F74:
	mov	[bp+var_4], 0
	jmp	short loc_14F7E
loc_14F7B:
	inc	[bp+var_4]
loc_14F7E:
	cmp	[bp+var_4], 3
	jge	short loc_14FB7
	mov	si, [bp+var_4]
	mov	cl, 3
	shl	si, cl
	mov	ax, mouse_x
	cmp	mouseBoxes._left[si],	ax
	jg	short loc_14FB5
	cmp	mouseBoxes._right[si],	ax
	jle	short loc_14FB5
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short loc_14FB5
	cmp	mouseBoxes._bottom[si],	ax
	jle	short loc_14FB5
	jmp	short loc_14FB7
loc_14FB5:
	jmp	short loc_14F7B
loc_14FB7:
	mov	ax, [bp+var_4]
	jmp	loc_1505D
loc_14FBD:
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax
	jz	short loc_15007
	cmp	mouse_y, 2Dh 
	jge	short loc_14FDE
	mov	[bp+var_2], 1
	jmp	short loc_15005
loc_14FDE:
	cmp	mouse_y, 4Bh 
	jle	short loc_14FED
	mov	[bp+var_2], 2
	jmp	short loc_15005
loc_14FED:
	cmp	mouse_x, 4Ah 
	jge	short loc_15000
	mov	[bp+var_2], 3
	jmp	short loc_15005
loc_15000:
	mov	[bp+var_2], 4
loc_15005:
	jmp	short loc_1500C
loc_15007:
	mov	[bp+var_2], 6
loc_1500C:
	jmp	short loc_15070
loc_1500E:
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_6]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short loc_15038
	mov	ax, 5
	jmp	short loc_1503B
loc_15038:
	mov	ax, 6
loc_1503B:
	mov	[bp+var_2], ax
	jmp	short loc_15070
loc_15040:
	test	[bp+arg_0], 2000h
	jz	short loc_1504C
	mov	ax, 5
	jmp	short loc_1504F
loc_1504C:
	mov	ax, 6
loc_1504F:
	mov	[bp+var_2], ax
	jmp	short loc_15070
loc_15054:
	mov	[bp+var_2], 6
	jmp	short loc_15070
	jmp	short loc_15070
loc_1505D:
	or	ax, ax
	jnz	short loc_15064
	jmp	loc_14FBD
loc_15064:
	cmp	ax, 1
	jz	short loc_1500E
	cmp	ax, 2
	jz	short loc_15040
	jmp	short loc_15054
loc_15070:
	mov	ax, [bp+var_2]
	cmp	gs:word_4241E, ax
	jz	short loc_1508B
	mov	gs:word_4241E, ax
	push	ax
	call	far ptr	vid_setMouseIcon
	add	sp, 2
loc_1508B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
updateMouseIcon endp

; Attributes: bp-based frame

getMouseClick proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	call	checkGamePort
	or	ax, ax
	jnz	short loc_150AE
	call	checkOtherGamePort
	or	ax, ax
	jz	short loc_150B3
loc_150AE:
	mov	ax, 1
	jmp	short loc_150B5
loc_150B3:
	sub	ax, ax
loc_150B5:
	mov	[bp+var_8], ax
	mov	ax, word_440BC
	cmp	[bp+var_8], ax
	jnz	short loc_150C4
	sub	ax, ax
	jmp	short loc_150C7
loc_150C4:
	mov	ax, [bp+var_8]
loc_150C7:
	mov	[bp+var_2], ax
	mov	ax, [bp+var_8]
	mov	word_440BC, ax
	cmp	[bp+var_2], 0
	jnz	short loc_150D9
	jmp	loc_151E1
loc_150D9:
	test	[bp+arg_0], 4000h
	jz	short loc_150E9
	mov	ax, 20h	
	jmp	loc_151E5
	jmp	loc_151E1
loc_150E9:
	mov	[bp+var_4], 0
	jmp	short loc_150F3
loc_150F0:
	inc	[bp+var_4]
loc_150F3:
	cmp	[bp+var_4], 3
	jge	short loc_1512C
	mov	si, [bp+var_4]
	mov	cl, 3
	shl	si, cl
	mov	ax, mouse_x
	cmp	mouseBoxes._left[si],	ax
	jg	short loc_1512A
	cmp	mouseBoxes._right[si],	ax
	jle	short loc_1512A
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short loc_1512A
	cmp	mouseBoxes._bottom[si],	ax
	jle	short loc_1512A
	jmp	short loc_1512C
loc_1512A:
	jmp	short loc_150F0
loc_1512C:
	mov	ax, [bp+var_4]
	jmp	loc_151CE
loc_15132:
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax
	jz	short loc_1517C
	cmp	mouse_y, 2Dh 
	jge	short loc_15154
	mov	ax, 4Bh	
	jmp	loc_151E5
	jmp	short loc_1517C
loc_15154:
	cmp	mouse_y, 4Bh 
	jle	short loc_15164
	mov	ax, 5000h
	jmp	loc_151E5
	jmp	short loc_1517C
loc_15164:
	cmp	mouse_x, 4Ah 
	jge	short loc_15177
	mov	ax, 4B00h
	jmp	short loc_151E5
	jmp	short loc_1517C
loc_15177:
	mov	ax, 4D00h
	jmp	short loc_151E5
loc_1517C:
	jmp	short loc_151E1
loc_1517E:
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_6]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short loc_151AB
	mov	ax, [bp+var_6]
	add	ax, 10Eh
	jmp	short loc_151E5
loc_151AB:
	jmp	short loc_151E1
loc_151AD:
	test	[bp+arg_0], 2000h
	jz	short loc_151C8
	mov	ax, mouse_y
	sub	ax, 88h	
	mov	cl, 3
	sar	ax, cl
	add	ax, 30h	
	jmp	short loc_151E5
loc_151C8:
	jmp	short loc_151E1
loc_151CA:
	jmp	short loc_151E1
	jmp	short loc_151E1
loc_151CE:
	or	ax, ax
	jnz	short loc_151D5
	jmp	loc_15132
loc_151D5:
	cmp	ax, 1
	jz	short loc_1517E
	cmp	ax, 2
	jz	short loc_151AD
	jmp	short loc_151CA
loc_151E1:
	sub	ax, ax
	jmp	short $+2
loc_151E5:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getMouseClick endp

; Attributes: bp-based frame

sub_151EA proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr getMouseClick
	add	sp, 2
loc_151FF:
	call	checkKeyboard
	or	ax, ax
	jnz	short loc_1520A
	jmp	short loc_151FF
loc_1520A:
	call	_readChFromKeyboard
	mov	[bp+var_2], ax
	or	al, al
	jz	short loc_1521D
	mov	al, byte ptr [bp+var_2]
	sub	ah, ah
	jmp	short loc_15222
loc_1521D:
	mov	ax, [bp+var_2]
	jmp	short $+2
loc_15222:
	mov	sp, bp
	pop	bp
	retf
sub_151EA endp

; Attributes: bp-based frame

sub_15226 proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	ax, gs:word_42294
	cmp	_clockTicks, ax
	jz	short loc_15256
	mov	ax, _clockTicks
	mov	gs:word_42294, ax
	call	sub_179C4
loc_15256:
	mov	ax, _clockTicks
	mov	cl, 5
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	gs:word_42410, ax
	jz	short loc_15296
	mov	gs:word_42410, ax
	mov	si, ax
	mov	cl, 4
	sar	si, cl
	cmp	gs:word_41E6C, si
	jz	short loc_15296
	mov	gs:word_41E6C, si
	cmp	gs:advanceTimeFlag, 0
	jnz	short loc_15296
	call	bat_doPoisonEffect
loc_15296:
	cmp	gs:advanceTimeFlag, 0
	jz	short loc_152A5
	jmp	loc_1538E
loc_152A5:
	mov	si, gs:word_42410
	mov	cl, 4
	sar	si, cl
	cmp	gs:word_42456, si
	jnz	short loc_152C0
	jmp	loc_1538E
loc_152C0:
	mov	gs:word_42456, si
	cmp	byte_4EEBC, 0
	jz	short loc_152E3
	mov	al, byte_4EEBC
	dec	byte_4EEBC
	cmp	al, 1
	jnz	short loc_152E3
	call	sub_22DA1
loc_152E3:
	mov	ax, gs:word_4233E
	dec	gs:word_4233E
	cmp	ax, 1
	jg	short loc_1533E
	mov	gs:word_4233E, 0Ah
	mov	[bp+var_2], 0
	jmp	short loc_15306
loc_15303:
	inc	[bp+var_2]
loc_15306:
	cmp	[bp+var_2], 5
	jge	short loc_1533E
	mov	bx, [bp+var_2]
	cmp	lightDuration[bx], 0
	jz	short loc_1533C
	cmp	lightDuration[bx], 0FFh
	jz	short loc_1533C
	mov	al, lightDuration[bx]
	dec	lightDuration[bx]
	cmp	al, 1
	jnz	short loc_1533C
	push	[bp+var_2]
	call	sub_17920
	add	sp, 2
loc_1533C:
	jmp	short loc_15303
loc_1533E:
	cmp	inDungeonMaybe, 0
	jnz	short loc_15356
	cmp	gs:isNight, 0
	jz	short loc_15362
loc_15356:
	cmp	gs:regenSpptSq,	0
	jz	short loc_15378
loc_15362:
	call	regenSppt
	cmp	gs:songRegenSppt, 0
	jz	short loc_15378
	call	regenSppt
loc_15378:
	call	doEquipmentEffect
	cmp	gs:sqRegenHPFlag, 0
	jz	loc_sub_15226_label_1
	call	do_partyHPRegen

loc_sub_15226_label_1:
	cmp	gs:byte_41E81, 0
	jz	short loc_1538E
	call	dunsq_drainHP
loc_1538E:
	mov	ax, gs:word_42410
	mov	cl, 6
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	gs:word_42330, ax
	jz	short loc_153ED
	mov	gs:word_42330, ax
	cmp	gs:advanceTimeFlag, 0
	jnz	short loc_153ED
	mov	al, byte_4EEBA
	inc	byte_4EEBA
	cmp	al, 17h
	jb	short loc_153CF
	mov	byte_4EEBA, 0
loc_153CF:
	cmp	byte_4EEBA, 6
	jb	short loc_153DF
	cmp	byte_4EEBA, 12h
	jbe	short loc_153E3
loc_153DF:
	mov	al, 1
	jmp	short loc_153E5
loc_153E3:
	sub	al, al
loc_153E5:
	mov	gs:isNight, al
loc_153ED:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_15226 endp

; Attributes: bp-based frame

	isAlphaNum proc	far
	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, [bp+arg_0]
	cbw
	push	ax
	call	_str_capitalize
	add	sp, 2
	mov	[bp+arg_0], al
	cmp	al, 41h	
	jl	short loc_15414
	cmp	al, 5Ah	
	jle	short loc_15420
loc_15414:
	cmp	[bp+arg_0], 30h	
	jl	short loc_15425
	cmp	[bp+arg_0], 39h	
	jg	short loc_15425
loc_15420:
	mov	ax, 1
	jmp	short loc_15427
loc_15425:
	sub	ax, ax
loc_15427:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
isAlphaNum endp

; Attributes: bp-based frame

sub_1542D proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jge	short loc_15446
	push	cs
	call	near ptr sub_151EA
	jmp	short loc_15495
	jmp	short loc_15490
loc_15446:
	mov	ax, [bp+arg_0]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, _clockTicks
	mov	[bp+var_4], ax
loc_1545F:
	mov	ax, [bp+var_4]
	cmp	_clockTicks, ax
	jz	short loc_15490
	call	checkKeyboard
	or	ax, ax
	jz	short loc_1548E
	call	_readChFromKeyboard
	mov	[bp+var_2], ax
	or	al, al
	jz	short loc_15489
	mov	al, byte ptr [bp+var_2]
	sub	ah, ah
	jmp	short loc_1548C
loc_15489:
	mov	ax, [bp+var_2]
loc_1548C:
	jmp	short loc_15495
loc_1548E:
	jmp	short loc_1545F
loc_15490:
	mov	ax, 20h	
	jmp	short $+2
loc_15495:
	mov	sp, bp
	pop	bp
	ret
sub_1542D endp

; Attributes: bp-based frame
txt_delayNoTable	proc far

	arg_0= word ptr 6

	func_enter
	push_imm	0
	mov	ax, [bp+arg_0]
	shl	ax, 1
	shl	ax, 1
	push	ax
	std_call	getIOwithDelay, 4
	func_exit
	retf
txt_delayNoTable	endp

txt_delayWithTable	proc far

	func_enter
	push_imm	1
	mov	bl, txtDelayIndex
	sub	bh, bh
	mov	al, txtDelayTable[bx]
	sub	ah, ah
	push	ax
	std_call	getIOwithDelay, 4
	func_exit
	retf

txt_delayWithTable	endp
	

; This is where the print delay occurs during battle.
getIOwithDelay proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jge	short loc_154B7
	jmp	loc_15522
loc_154B7:
	mov	ax, [bp+arg_0]
	add	ax, _clockTicks
	mov	[bp+var_2], ax
	push	cs
	call	near ptr sub_1766A
loc_154D4:
	call	checkKeyboard
	or	ax, ax
	jz	short loc_154E9
	call	_readChFromKeyboard

	cmp	[bp+arg_2], 0
	jz	loc_getIOwithDelay_skipFastCheck

	sub	ah, ah
	cmp	ax, '>'
	jz	loc_getIOwithDelay_faster
	cmp	ax, '.'
	jnz	loc_getIOwithDelay_slowCheck

loc_getIOwithDelay_faster:
	mov	al, txtDelayIndex
	dec	txtDelayIndex
	or	al, al
	ja	loc_getIOwithDelay_printFaster
	mov	txtDelayIndex, 0
	jmp	loc_154D4

loc_getIOwithDelay_slowCheck:
	cmp	ax, '<'
	jz	loc_getIOwithDelay_slower
	cmp	ax, ','
	jnz	loc_getIOwithDelay_skipFastCheck

loc_getIOwithDelay_slower:
	mov	al, txtDelayIndex
	inc	txtDelayIndex
	cmp	al, 9
	jb	loc_getIOwithDelay_printSlower
	mov	txtDelayIndex, 9
	jmp	loc_154D4

loc_getIOwithDelay_printFaster:
	mov	ax, offset aFaster
	jmp	loc_getIOwithDelay_doPrint

loc_getIOwithDelay_printSlower:
	mov	ax, offset aSlower

loc_getIOwithDelay_doPrint:
	push	ds
	push	ax
	func_printString
	jmp	loc_154D4

loc_getIOwithDelay_skipFastCheck:
	call	far ptr	sub_3E974
	jmp	short loc_15522
loc_154E9:
	call	checkMouse
	push	cs
	call	near ptr sub_15226
	push	cs
	call	near ptr printRoster
	mov	ax, [bp+var_2]
	cmp	_clockTicks, ax
	jl	short loc_1550B
	call	far ptr	sub_3E974
	jmp	short loc_15522
loc_1550B:
	cmp	mouse_moved, 0
	jz	short loc_15520
	call	far ptr	sub_3E974
	push	cs
	call	near ptr sub_1766A
loc_15520:
	jmp	loc_154D4
loc_15522:
	mov	sp, bp
	pop	bp
	retf
getIOwithDelay endp

; Attributes: bp-based frame

dun_doMiniMap proc far

	var_18=	dword ptr -18h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 18h
	call	someStackOperation
	push	si
	mov	[bp+var_2], 8
	mov	[bp+var_4], 6
loc_1553C:
	mov	gs:byte_4241A, 1
	push	cs
	call	near ptr clearTextWindow
	mov	gs:byte_4241A, 1
	mov	[bp+var_10], 0
	jmp	short loc_1555E
loc_1555B:
	inc	[bp+var_10]
loc_1555E:
	cmp	[bp+var_10], 11h
	jl	short loc_15567
	jmp	loc_156FC
loc_15567:
	mov	ax, [bp+arg_4]
	sub	ax, [bp+var_2]
	add	ax, [bp+var_10]
	mov	[bp+var_C], ax
	mov	[bp+var_12], 0
	jmp	short loc_1557D
loc_1557A:
	inc	[bp+var_12]
loc_1557D:
	cmp	[bp+var_12], 0Ch
	jl	short loc_15586
	jmp	loc_156F9
loc_15586:
	mov	ax, [bp+arg_6]
	sub	ax, [bp+var_4]
	add	ax, [bp+var_12]
	mov	[bp+var_E], ax
	or	ax, ax
	jge	short loc_15599
	jmp	loc_156F6
loc_15599:
	mov	ax, [bp+arg_A]
	cmp	[bp+var_E], ax
	jl	short loc_155A4
	jmp	loc_156F6
loc_155A4:
	cmp	[bp+var_C], 0
	jl	short loc_155AF
	mov	ax, 1
	jmp	short loc_155B1
loc_155AF:
	sub	ax, ax
loc_155B1:
	mov	cx, [bp+arg_8]
	mov	si, ax
	cmp	[bp+var_C], cx
	jge	short loc_155C0
	mov	ax, 1
	jmp	short loc_155C2
loc_155C0:
	sub	ax, ax
loc_155C2:
	test	ax, si
	jnz	short loc_155C9
	jmp	loc_156F6
loc_155C9:
	mov	ax, [bp+var_12]
	mov	cl, 3
	shl	ax, cl
	sub	ax, 5Eh	
	neg	ax
	mov	[bp+var_A], ax
	mov	ax, [bp+var_10]
	shl	ax, cl
	add	ax, 0A9h 
	mov	[bp+var_8], ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E2A
	add	sp, 4
	mov	bx, [bp+var_C]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_0]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	mov	al, fs:[bx+si+4]
	sub	ah, ah
	mov	[bp+var_14], ax
	test	byte ptr [bp+var_14], 2
	jz	short loc_15621
	jmp	loc_156CC
loc_15621:
	test	byte ptr [bp+var_14], 1
	jnz	short loc_1562A
	jmp	loc_156CC
loc_1562A:
	mov	ax, [bp+var_2]
	cmp	[bp+var_10], ax
	jnz	short loc_1564E
	mov	ax, [bp+var_4]
	cmp	[bp+var_12], ax
	jnz	short loc_1564E
	mov	ax, 0Dh
	push	ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E3D
	add	sp, 6
loc_1564E:
	cmp	word_43F12, 0
	jz	short loc_15671
	test	byte ptr [bp+var_14], 8
	jz	short loc_1566F
	mov	ax, 0Ch
	push	ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E3D
	add	sp, 6
loc_1566F:
	jmp	short loc_1568B
loc_15671:
	test	byte ptr [bp+var_14], 4
	jz	short loc_1568B
	mov	ax, 0Ch
	push	ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E3D
	add	sp, 6
loc_1568B:
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_0]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+var_C]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_18], ax
	mov	word ptr [bp+var_18+2],	dx
	lfs	bx, [bp+var_18]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_6], ax
	push	ax
	push	cs
	call	near ptr sub_15766
	add	sp, 2
	jmp	short loc_156E0
loc_156CC:
	mov	ax, 0Eh
	push	ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E3D
	add	sp, 6
loc_156E0:
	mov	ax, 1
	push	ax
	mov	ax, 63h	
	push	ax
	push	[bp+var_8]
	push	[bp+var_A]
	call	far ptr	sub_3E97A
	add	sp, 8
loc_156F6:
	jmp	loc_1557A
loc_156F9:
	jmp	loc_1555B
loc_156FC:
	push	cs
	call	near ptr sub_14E41
	mov	[bp+var_6], ax
	jmp	short loc_1573F
loc_15705:
	mov	ax, [bp+arg_A]
	cmp	[bp+var_4], ax
	jge	short loc_15710
	inc	[bp+var_4]
loc_15710:
	jmp	short loc_1575A
loc_15712:
	cmp	[bp+var_4], 0
	jz	short loc_1571B
	dec	[bp+var_4]
loc_1571B:
	jmp	short loc_1575A
loc_1571D:
	cmp	[bp+var_2], 0
	jz	short loc_15726
	dec	[bp+var_2]
loc_15726:
	jmp	short loc_1575A
loc_15728:
	mov	ax, [bp+arg_8]
	cmp	[bp+var_2], ax
	jge	short loc_15733
	inc	[bp+var_2]
loc_15733:
	jmp	short loc_1575A
loc_15735:
	push	cs
	call	near ptr clearTextWindow
	jmp	short loc_15761
loc_1573B:
	jmp	short loc_1575A
	jmp	short loc_1575A
loc_1573F:
	cmp	ax, 1Bh
	jz	short loc_15735
	cmp	ax, dosKeys_upArrow
	jz	short loc_15712
	cmp	ax, dosKeys_leftArrow
	jz	short loc_15728
	cmp	ax, dosKeys_rightArrow
	jz	short loc_1571D
	cmp	ax, dosKeys_downArrow
	jz	short loc_15705
	jmp	short loc_1573B
loc_1575A:
	jmp	loc_1553C
	push	cs
	call	near ptr clearTextWindow
loc_15761:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_doMiniMap endp

; Attributes: bp-based frame

sub_15766 proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	[bp+var_4], 0
	jmp	short loc_1577B
loc_15778:
	inc	[bp+var_4]
loc_1577B:
	cmp	[bp+var_4], 4
	jge	short loc_157BF
	mov	ax, [bp+var_4]
	dec	ax
	push	ax
	push	[bp+arg_0]
	call	sub_27E13
	add	sp, 4
	and	ax, 0Fh
	mov	[bp+var_6], ax
	mov	bx, ax
	cmp	byte_43EBC[bx],	80h
	jnb	short loc_157BD
	mov	al, byte_43EBC[bx]
	sub	ah, ah
	or	ax, [bp+var_4]
	mov	[bp+var_2], ax
	push	ax
	mov	ax, offset byte_3E948
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	sub_27E3D
	add	sp, 6
loc_157BD:
	jmp	short loc_15778
loc_157BF:
	mov	sp, bp
	pop	bp
	retf
sub_15766 endp

; Attributes: bp-based frame

_mfunc_getString proc far

	memOffset= word	ptr  6
	memSegment= word ptr  8
	rbuf= dword ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+memOffset]
	mov	dx, [bp+memSegment]
	mov	dataBufOff, ax
	mov	dataBufSeg, dx
	mov	bitsLeft, 0
	mov	_str_capFlag, 0
loc_157E6:
	push	cs
	call	near ptr _mfunc_unpackChar
	lfs	bx, [bp+rbuf]
	inc	word ptr [bp+rbuf]
	mov	fs:[bx], al
	or	al, al
	jz	short loc_157F9
	jmp	short loc_157E6
loc_157F9:
	mov	ax, dataBufOff
	mov	dx, dataBufSeg
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_mfunc_getString endp

; Attributes: bp-based frame

_mfunc_unpackChar proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
loc_15811:
	mov	ax, 5
	push	ax
	push	cs
	call	near ptr _mfunc_extractCh
	add	sp, 2
	mov	[bp+var_2], ax
	jmp	short loc_15895
loc_15821:
	sub	ax, ax
	jmp	loc_158A8
	jmp	short loc_158A5
loc_15828:
	mov	_str_capFlag, 1
	jmp	short loc_158A5
loc_15830:
	mov	ax, 6
	push	ax
	push	cs
	call	near ptr _mfunc_extractCh
	add	sp, 2
	mov	[bp+var_2], ax
	mov	bx, ax
	mov	al, _str_Hialphabet[bx]
	cbw
	mov	[bp+var_4], ax
	cmp	_str_capFlag, 0
	jz	short loc_15862
	mov	_str_capFlag, 0
	push	ax
	call	_str_capitalize
	add	sp, 2
	jmp	short loc_158A8
	jmp	short loc_15867
loc_15862:
	mov	ax, [bp+var_4]
	jmp	short loc_158A8
loc_15867:
	jmp	short loc_158A5
loc_15869:
	mov	bx, [bp+var_2]
	mov	al, _str_Loalphabet[bx-1]
	cbw
	mov	[bp+var_4], ax
	cmp	_str_capFlag, 0
	jz	short loc_1588E
	mov	_str_capFlag, 0
	push	ax
	call	_str_capitalize
	add	sp, 2
	jmp	short loc_158A8
	jmp	short loc_15893
loc_1588E:
	mov	ax, [bp+var_4]
	jmp	short loc_158A8
loc_15893:
	jmp	short loc_158A5
loc_15895:
	or	ax, ax
	jz	short loc_15821
	cmp	ax, 30
	jz	short loc_15828
	cmp	ax, 31
	jz	short loc_15830
	jmp	short loc_15869
loc_158A5:
	jmp	loc_15811
loc_158A8:
	mov	sp, bp
	pop	bp
	retf
_mfunc_unpackChar endp

; Attributes: bp-based frame

_mfunc_extractCh proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
loc_158BC:
	mov	ax, [bp+arg_0]
	dec	[bp+arg_0]
	or	ax, ax
	jz	short loc_158FE
	dec	bitsLeft
	jns	short loc_158E4
	mov	bx, dataBufOff
	inc	dataBufOff
	mov	fs, dataBufSeg
	mov	al, fs:[bx]
	mov	curStrByte, al
	mov	bitsLeft, 7
loc_158E4:
	shl	[bp+var_2], 1
	cmp	curStrByte, 80h
	jb	short loc_158F3
	mov	ax, 1
	jmp	short loc_158F5
loc_158F3:
	sub	ax, ax
loc_158F5:
	or	[bp+var_2], ax
	shl	curStrByte, 1
	jmp	short loc_158BC
loc_158FE:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_mfunc_extractCh endp

; This function	copies 16 bytes	from fromBuffer	to
; toBuffer and AND's each byte with 0x7f to remove
; the "encryption"
; Attributes: bp-based frame

decryptName proc far

	var_4= byte ptr	-4
	var_2= word ptr	-2
	fromBuffer= dword ptr  6
	toBuffer= dword	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_1591C
loc_15919:
	inc	[bp+var_2]
loc_1591C:
	cmp	[bp+var_2], 16
	jge	short loc_1594A
	lfs	bx, [bp+fromBuffer]
	mov	al, fs:[bx]
	mov	[bp+var_4], al
	cmp	al, 0FFh
	jz	short loc_15946
	or	al, al
	jz	short loc_15946
	inc	word ptr [bp+fromBuffer]
	mov	al, fs:[bx]
	and	al, 7Fh
	lfs	bx, [bp+toBuffer]
	inc	word ptr [bp+toBuffer]
	mov	fs:[bx], al
	jmp	short loc_15948
loc_15946:
	jmp	short loc_1594A
loc_15948:
	jmp	short loc_15919
loc_1594A:
	lfs	bx, [bp+toBuffer]
	inc	word ptr [bp+toBuffer]
	mov	byte ptr fs:[bx], 0
	mov	sp, bp
	pop	bp
	retf
decryptName endp

; Attributes: bp-based frame

text_scrollingWindow proc far

	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 20h	
	call	someStackOperation
	push	si
	mov	[bp+var_12], 0
	mov	[bp+var_16], 0
	sub	ax, ax
	mov	[bp+var_1E], ax
	mov	[bp+var_10], ax
	mov	[bp+var_E], 1
	push	cs
	call	near ptr sub_1766A
loc_1597F:
	cmp	[bp+var_E], 0
	jnz	short loc_15988
	jmp	loc_15A61
loc_15988:
	call	far ptr	sub_3E974
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printStringWClear
	add	sp, 4
	mov	al, gs:txt_numLines
	sub	ah, ah
	inc	ax
	mov	[bp+var_A], ax
	mov	ax, 0Ah
	sub	ax, [bp+var_A]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+arg_8]
	jle	short loc_159BF
	mov	ax, [bp+arg_8]
loc_159BF:
	mov	[bp+var_1C], ax
	mov	ax, [bp+var_12]
	mov	[bp+var_1A], ax
	jmp	short loc_159CD
loc_159CA:
	inc	[bp+var_1A]
loc_159CD:
	mov	ax, [bp+var_1C]
	cmp	[bp+var_1A], ax
	jge	short loc_159EF
	mov	bx, [bp+var_1A]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_4]
	push	word ptr fs:[bx+si+2]
	push	word ptr fs:[bx+si]
	push	cs
	call	near ptr printString
	add	sp, 4
	jmp	short loc_159CA
loc_159EF:
	mov	[bp+var_4], 0
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+arg_8]
	jle	short loc_15A07
	mov	ax, [bp+arg_8]
	sub	ax, [bp+var_12]
	jmp	short loc_15A0A
loc_15A07:
	mov	ax, [bp+var_6]
loc_15A0A:
	mov	[bp+var_14], ax
	mov	[bp+var_1A], 0
	jmp	short loc_15A17
loc_15A14:
	inc	[bp+var_1A]
loc_15A17:
	mov	ax, [bp+var_14]
	cmp	[bp+var_1A], ax
	jge	short loc_15A35
	mov	bx, [bp+var_1A]
	add	bx, [bp+var_A]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_4], ax
	jmp	short loc_15A14
loc_15A35:
	mov	ax, bitMask16bit+16h
	or	[bp+var_4], ax
	push	cs
	call	near ptr sub_15D0C
	mov	ax, [bp+var_16]
	add	ax, [bp+var_A]
	sub	ax, [bp+var_12]
	push	ax
	call	far ptr	sub_3E96E
	add	sp, 2
	push	cs
	call	near ptr sub_1766A
	mov	[bp+var_E], 0
	jmp	short loc_15A65
loc_15A61:
	push	cs
	call	near ptr sub_15226
loc_15A65:
	call	checkMouse
	cmp	mouse_moved, 0
	jz	short loc_15A8E
	call	far ptr	sub_3E974
	push	[bp+var_4]
	push	cs
	call	near ptr sub_14ECC
	add	sp, 2
	mov	[bp+var_2], 1
	push	cs
	call	near ptr sub_1766A
loc_15A8E:
	push	[bp+var_4]
	push	cs
	call	near ptr sub_15D62
	add	sp, 2
	mov	[bp+var_8], ax
	or	ax, ax
	jnz	short loc_15AA2
	jmp	loc_15BA9
loc_15AA2:
	call	checkGamePort
	or	ax, ax
	jnz	short loc_15AB4
	call	checkOtherGamePort
	or	ax, ax
	jz	short loc_15AB9
loc_15AB4:
	mov	ax, 1
	jmp	short loc_15ABB
loc_15AB9:
	sub	ax, ax
loc_15ABB:
	mov	[bp+var_20], ax
	cmp	[bp+var_1E], ax
	jnz	short loc_15AC7
	sub	ax, ax
	jmp	short loc_15ACA
loc_15AC7:
	mov	ax, [bp+var_20]
loc_15ACA:
	mov	[bp+var_10], ax
	mov	ax, [bp+var_20]
	mov	word_440BC, ax
	cmp	[bp+var_8], 10Eh
	jl	short loc_15B27
	cmp	[bp+var_8], 118h
	jg	short loc_15B27
	cmp	[bp+var_2], 0
	jz	short loc_15AFB
	mov	ax, [bp+var_8]
	sub	ax, [bp+var_A]
	add	ax, [bp+var_12]
	sub	ax, 10Eh
	mov	[bp+var_16], ax
	mov	[bp+var_2], 0
loc_15AFB:
	cmp	[bp+var_10], 0
	jz	short loc_15B0C
	call	far ptr	sub_3E974
	mov	ax, [bp+var_16]
	jmp	loc_15D07
loc_15B0C:
	mov	ax, [bp+var_C]
	cmp	[bp+var_16], ax
	jz	short loc_15B19
	mov	ax, 1
	jmp	short loc_15B1B
loc_15B19:
	sub	ax, ax
loc_15B1B:
	mov	[bp+var_E], ax
	mov	ax, [bp+var_16]
	mov	[bp+var_C], ax
	jmp	loc_15BA9
loc_15B27:
	mov	ax, [bp+var_8]
	jmp	short loc_15B98
loc_15B2C:
	cmp	[bp+var_10], 0
	jz	short loc_15B5A
	mov	ax, [bp+arg_8]
	sub	ax, 5
	cmp	ax, [bp+var_12]
	jle	short loc_15B5A
	add	[bp+var_12], 5
	mov	ax, [bp+var_12]
	add	ax, 2
	mov	[bp+var_16], ax
	mov	si, [bp+arg_8]
	dec	si
	cmp	ax, si
	jle	short loc_15B55
	mov	[bp+var_16], si
loc_15B55:
	mov	[bp+var_E], 1
loc_15B5A:
	jmp	short loc_15BA9
loc_15B5C:
	cmp	[bp+var_10], 0
	jz	short loc_15B81
	cmp	[bp+var_12], 5
	jle	short loc_15B6E
	sub	[bp+var_12], 5
	jmp	short loc_15B73
loc_15B6E:
	mov	[bp+var_12], 0
loc_15B73:
	mov	ax, [bp+var_12]
	add	ax, 2
	mov	[bp+var_16], ax
	mov	[bp+var_E], 1
loc_15B81:
	jmp	short loc_15BA9
loc_15B83:
	cmp	[bp+var_10], 0
	jz	short loc_15B94
	call	far ptr	sub_3E974
	mov	ax, 0FFFFh
	jmp	loc_15D07
loc_15B94:
	jmp	short loc_15BA9
	jmp	short loc_15BA9
loc_15B98:
	cmp	ax, 1Bh
	jz	short loc_15B83
	cmp	ax, 4800h
	jz	short loc_15B5C
	cmp	ax, 5000h
	jz	short loc_15B2C
	jmp	short loc_15B94
loc_15BA9:
	call	checkKeyboard
	or	ax, ax
	jnz	short loc_15BB5
	jmp	loc_15D04
loc_15BB5:
	call	_readChFromKeyboard
	mov	[bp+var_18], ax
	or	al, al
	jz	short loc_15BD4
	mov	al, byte ptr [bp+var_18]
	sub	ah, ah
	push	ax
	call	_str_capitalize
	add	sp, 2
	mov	[bp+var_8], ax
	jmp	short loc_15BDA
loc_15BD4:
	mov	ax, [bp+var_18]
	mov	[bp+var_8], ax
loc_15BDA:
	mov	[bp+var_E], 1
	mov	ax, [bp+var_8]
	jmp	loc_15CC7
loc_15BE5:
	call	far ptr	sub_3E974
	mov	ax, [bp+var_16]
	jmp	loc_15D07
loc_15BF0:
	call	far ptr	sub_3E974
	mov	ax, 0FFFFh
	jmp	loc_15D07
loc_15BFB:
	cmp	[bp+var_16], 0
	jz	short loc_15C04
	dec	[bp+var_16]
loc_15C04:
	mov	ax, [bp+var_12]
	cmp	[bp+var_16], ax
	jge	short loc_15C0F
	dec	[bp+var_12]
loc_15C0F:
	jmp	loc_15D04
loc_15C12:
	mov	ax, [bp+arg_8]
	dec	ax
	cmp	ax, [bp+var_16]
	jle	short loc_15C1E
	inc	[bp+var_16]
loc_15C1E:
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+var_16]
	jg	short loc_15C2C
	inc	[bp+var_12]
loc_15C2C:
	jmp	loc_15D04
loc_15C2F:
	mov	ax, [bp+var_16]
	add	ax, [bp+var_6]
	mov	cx, [bp+arg_8]
	dec	cx
	cmp	ax, cx
	jge	short loc_15C48
	mov	ax, [bp+var_6]
	add	[bp+var_16], ax
	add	[bp+var_12], ax
	jmp	short loc_15C6B
loc_15C48:
	mov	ax, [bp+arg_8]
	dec	ax
	mov	[bp+var_16], ax
	mov	ax, [bp+var_6]
	cmp	[bp+var_16], ax
	jl	short loc_15C66
	mov	ax, [bp+arg_8]
	mov	cx, [bp+var_6]
	sar	cx, 1
	sub	ax, cx
	mov	[bp+var_12], ax
	jmp	short loc_15C6B
loc_15C66:
	mov	[bp+var_12], 0
loc_15C6B:
	jmp	loc_15D04
loc_15C6E:
	mov	ax, [bp+var_6]
	cmp	[bp+var_16], ax
	jg	short loc_15C82
	mov	[bp+var_16], 0
	mov	[bp+var_12], 0
	jmp	short loc_15C97
loc_15C82:
	mov	ax, [bp+var_6]
	sub	[bp+var_16], ax
	cmp	[bp+var_12], ax
	jle	short loc_15C92
	sub	[bp+var_12], ax
	jmp	short loc_15C97
loc_15C92:
	mov	[bp+var_12], 0
loc_15C97:
	jmp	short loc_15D04
loc_15C99:
	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+var_16], ax
	jmp	short loc_15D04
loc_15CA3:
	mov	ax, [bp+arg_8]
	dec	ax
	mov	[bp+var_16], ax
	mov	ax, [bp+var_6]
	cmp	[bp+var_16], ax
	jge	short loc_15CB6
	sub	ax, ax
	jmp	short loc_15CC0
loc_15CB6:
	mov	ax, [bp+var_16]
	mov	cx, [bp+var_6]
	sar	cx, 1
	sub	ax, cx
loc_15CC0:
	mov	[bp+var_12], ax
loc_15CC3:
	jmp	short loc_15D04
	jmp	short loc_15D04
loc_15CC7:
	cmp	ax, 4800h
	jnz	short loc_15CCF
	jmp	loc_15BFB
loc_15CCF:
	jg	short loc_15CE8
	cmp	ax, 0Dh
	jnz	short loc_15CD9
	jmp	loc_15BE5
loc_15CD9:
	cmp	ax, 1Bh
	jnz	short loc_15CE1
	jmp	loc_15BF0
loc_15CE1:
	cmp	ax, 4700h
	jz	short loc_15C99
	jmp	short loc_15CC3
loc_15CE8:
	cmp	ax, 4900h
	jz	short loc_15C6E
	cmp	ax, 4F00h
	jz	short loc_15CA3
	cmp	ax, 5000h
	jnz	short loc_15CFA
	jmp	loc_15C12
loc_15CFA:
	cmp	ax, 5100h
	jnz	short loc_15D02
	jmp	loc_15C2F
loc_15D02:
	jmp	short loc_15CC3
loc_15D04:
	jmp	loc_1597F
loc_15D07:
	pop	si
	mov	sp, bp
	pop	bp
	retf
text_scrollingWindow endp

; Attributes: bp-based frame

sub_15D0C proc far
	push	bp
	mov	bp, sp
	mov	ax, 1
	push	ax
	mov	ax, 61h	
	push	ax
	mov	ax, 0B2h 
	push	ax
	mov	ax, 5Eh	
	push	ax
	call	far ptr	sub_3E97A
	add	sp, 8
	mov	ax, 1
	push	ax
	mov	ax, 62h	
	push	ax
	mov	ax, 120h
	push	ax
	mov	ax, 5Eh	
	push	ax
	call	far ptr	sub_3E97A
	add	sp, 8
	mov	ax, 1
	push	ax
	mov	ax, 5Eh	
	push	ax
	mov	ax, 0E0h 
	push	ax
	mov	ax, offset aEsc
	push	ds
	push	ax
	push	cs
	call	near ptr sub_16F1E
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
sub_15D0C endp

; Attributes: bp-based frame

sub_15D62 proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+var_2], 0
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short loc_15D83
	jmp	loc_15E0B
loc_15D83:
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short loc_15E0B
	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jl	short loc_15E0B
	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jge	short loc_15E0B
	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	ax, 0Bh
	jnz	short loc_15DEB
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	add	ax, 32h	
	cmp	mouse_x, ax
	jge	short loc_15DD0
	mov	[bp+var_2], 4800h
	jmp	short loc_15DE9
loc_15DD0:
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	sub	ax, 32h	
	cmp	mouse_x, ax
	jge	short loc_15DE4
	mov	[bp+var_2], 1Bh
	jmp	short loc_15DE9
loc_15DE4:
	mov	[bp+var_2], 5000h
loc_15DE9:
	jmp	short loc_15E0B
loc_15DEB:
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_4]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short loc_15E06
	mov	ax, [bp+var_4]
	add	ax, 10Eh
	jmp	short loc_15E08
loc_15E06:
	sub	ax, ax
loc_15E08:
	mov	[bp+var_2], ax
loc_15E0B:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_15D62 endp

; Attributes: bp-based frame

_readString proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	[bp+var_6], 0
	push	cs
	call	near ptr txt_newLine
	push	cs
	call	near ptr sub_15F3F
loc_15E2D:
	push	cs
	call	near ptr sub_151EA
	mov	[bp+var_2], ax
	cmp	ax, 0Dh
	jnz	short loc_15E3C
	jmp	loc_15F0D
loc_15E3C:
	mov	[bp+var_4], ax
	push	ax
	push	cs
	call	near ptr isAlphaNum
	add	sp, 2
	or	ax, ax
	jnz	short loc_15E6F
	cmp	[bp+var_2], 20h	
	jz	short loc_15E6F
	cmp	[bp+var_2], 2Dh	
	jz	short loc_15E6F
	cmp	[bp+var_2], 2Eh	
	jz	short loc_15E6F
	cmp	[bp+var_2], 2Ch	
	jz	short loc_15E6F
	cmp	[bp+var_2], 3Ah	
	jz	short loc_15E6F
	cmp	[bp+var_2], 5Ch	
	jnz	short loc_15EAC
loc_15E6F:
	mov	ax, [bp+arg_4]
	cmp	[bp+var_6], ax
	jge	short loc_15EAA
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, byte ptr [bp+var_2]
	mov	fs:[bx+si], al
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	mov	bx, [bp+var_6]
	inc	[bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	push	cs
	call	near ptr sub_15F92
	add	sp, 2
	push	cs
	call	near ptr sub_15F3F
loc_15EAA:
	jmp	short loc_15F0A
loc_15EAC:
	cmp	[bp+var_2], 8
	jnz	short loc_15EDB
	cmp	[bp+var_6], 0
	jle	short loc_15EDB
	dec	[bp+var_6]
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	push	ax
	push	cs
	call	near ptr sub_15F5C
	add	sp, 2
	push	cs
	call	near ptr sub_15F3F
	jmp	short loc_15F0A
loc_15EDB:
	cmp	[bp+var_2], 1Bh
	jnz	short loc_15F0A
loc_15EE1:
	cmp	[bp+var_6], 0
	jle	short loc_15F06
	dec	[bp+var_6]
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	push	ax
	push	cs
	call	near ptr sub_15F5C
	add	sp, 2
	jmp	short loc_15EE1
loc_15F06:
	push	cs
	call	near ptr sub_15F3F
loc_15F0A:
	jmp	loc_15E2D
loc_15F0D:
	mov	bx, [bp+var_6]
	lfs	si, [bp+arg_0]
	mov	byte ptr fs:[bx+si], 0
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	cmp	[bp+var_6], 0
	jz	short loc_15F35
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short loc_15F3A
	jmp	short loc_15F3A
loc_15F35:
	sub	ax, ax
	cwd
	jmp	short $+2
loc_15F3A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_readString endp

; Attributes: bp-based frame

sub_15F3F proc far
	push	bp
	mov	bp, sp
	mov	ax, 1
	push	ax
	mov	ax, 60h	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_15F3F endp

; Attributes: bp-based frame

sub_15F5C proc far

	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	mov	al, [bp+arg_0]
	sub	gs:byte_42419, al
	sub	ax, ax
	push	ax
	mov	ax, 5Fh	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_15F5C endp

; Attributes: bp-based frame

sub_15F92 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	push	ax
	mov	ax, [bp+arg_0]
	sub	ax, 20h	
	push	ax
	push	cs
	call	near ptr sub_15FC5
	add	sp, 4
	push	[bp+arg_0]
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	gs:byte_42419, al
	mov	sp, bp
	pop	bp
	retf
sub_15F92 endp

; Attributes: bp-based frame

sub_15FC5 proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	mov	al, gs:byte_42419
	sub	ah, ah
	add	ax, 0A8h 
	push	ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax
	call	far ptr	sub_3E97A
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
sub_15FC5 endp

; Attributes: bp-based frame

sub_16001 proc far

	var_14=	word ptr -14h
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 14h
	call	someStackOperation
	mov	ax, 10h
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	cs
	call	near ptr _readString
	add	sp, 6
	or	dx, ax
	jz	short loc_1603F
	lea	ax, [bp+var_4]
	push	ss
	push	ax
	mov	ax, offset aU
	push	ds
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	sscanf
	add	sp, 0Ch
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	jmp	short loc_16044
loc_1603F:
	sub	ax, ax
	cwd
	jmp	short $+2
loc_16044:
	mov	sp, bp
	pop	bp
	retf
sub_16001 endp

; Attributes: bp-based frame

_strcat	proc far

	toStr= dword ptr  6
	fromStr= dword ptr  0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation

loc_16052:
	lfs	bx, [bp+fromStr]
	inc	word ptr [bp+fromStr]
	mov	al, fs:[bx]
	lfs	bx, [bp+toStr]
	inc	word ptr [bp+toStr]
	mov	fs:[bx], al
	or	al, al
	jz	short loc_1606A
	jmp	short loc_16052

loc_1606A:
	lfs	bx, [bp+toStr]
	mov	byte ptr fs:[bx], 0
	dec	word ptr [bp+toStr]
	mov	ax, word ptr [bp+toStr]
	mov	dx, word ptr [bp+toStr+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_strcat	endp

;_strncpy proc far

;	toptr=dword ptr -6
;	counter= word ptr -2
;	fromStr= dword ptr 6
;	toStr= dword ptr 0Ah
;	_len= word ptr 0Eh

;	func_enter
;	_chkstk	2

;	mov	ax, word ptr [bp+tostr]
;	mov	dx, word ptr [bp+tostr+2]
;	mov	word ptr [bp+toptr], ax
;	mov	word ptr [bp+toptr+2], dx
;	mov	[bp+counter], 0

;loc_strncpy_loop:
;	lfs	bx, [bp+fromStr]
;	mov	al, byte ptr fs:[bx]
;	inc	[bp+fromStr]
;	lfs	bx, [bp+toptr]
;	mov	byte ptr fs:[bx], al
;	inc	[bp+toptr]
;	or	al, al
;	jz	short loc_strncpy_exit
;	inc	[bp+counter]
;	mov	ax, [bp+counter]
;	cmp	ax, [bp+_len]
;	jnz	loc_strncpy_loop

;loc_strncpy_exit:
;	lfs	bx, [bp+toptr]
;	mov	byte ptr fs:[bx], 0
;	func_exit
;	retf
;_strncpy endp
	

; Attributes: bp-based frame

_itoa proc far

	var_4= word ptr	-4
	var_2= byte ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	[bp+var_2], 20h	
	cmp	[bp+arg_8], 0
	jnz	short loc_160A6
	push	[bp+arg_6]
	push	[bp+arg_4]
	push	cs
	call	near ptr sub_16185
	add	sp, 4
	mov	[bp+arg_8], ax
loc_160A6:
	cmp	[bp+arg_6], 0
	jge	short loc_160C3
	mov	ax, [bp+arg_4]
	mov	dx, [bp+arg_6]
	neg	ax
	adc	dx, 0
	neg	dx
	mov	[bp+arg_4], ax
	mov	[bp+arg_6], dx
	mov	[bp+var_2], 2Dh	
loc_160C3:
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	_32bitMod
	add	al, 30h	
	mov	si, [bp+arg_8]
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+si-1], al
	mov	ax, [bp+arg_8]
	dec	ax
	mov	[bp+var_4], ax
	jmp	short loc_160EC
loc_160E9:
	dec	[bp+var_4]
loc_160EC:
	cmp	[bp+var_4], 0
	jle	short loc_1613B
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	lea	ax, [bp+arg_4]
	push	ax
	call	_32bitDivide
	mov	ax, [bp+arg_4]
	or	ax, [bp+arg_6]
	jz	short loc_16128
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	_32bitMod
	add	al, 30h	
	mov	si, [bp+var_4]
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+si-1], al
	jmp	short loc_16139
loc_16128:
	mov	si, [bp+var_4]
	lfs	bx, [bp+arg_0]
	mov	al, [bp+var_2]
	mov	fs:[bx+si-1], al
	mov	[bp+var_2], 20h	
loc_16139:
	jmp	short loc_160E9
loc_1613B:
	cmp	[bp+arg_6], 0
	jg	short loc_1614F
	jl	short loc_16149
	cmp	[bp+arg_4], 0Ah
	jnb	short loc_1614F
loc_16149:
	cmp	[bp+var_2], 2Dh	
	jnz	short loc_16175
loc_1614F:
	mov	[bp+var_4], 0
	jmp	short loc_16159
loc_16156:
	inc	[bp+var_4]
loc_16159:
	mov	ax, [bp+arg_8]
	cmp	[bp+var_4], ax
	jge	short loc_1616D
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 2Ah
	jmp	short loc_16156
loc_1616D:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short loc_16180
loc_16175:
	mov	ax, [bp+arg_8]
	add	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
loc_16180:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_itoa endp

; Attributes: bp-based frame

sub_16185 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_2], 0
	jge	short loc_1619D
	mov	[bp+var_2], 2
	jmp	short loc_161A2
loc_1619D:
	mov	[bp+var_2], 1
loc_161A2:
	jmp	short loc_161A7
loc_161A4:
	inc	[bp+var_2]
loc_161A7:
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	lea	ax, [bp+arg_0]
	push	ax
	call	_32bitDivide
	or	dx, ax
	jz	short loc_161BC
	jmp	short loc_161A4
loc_161BC:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_16185 endp

; Attributes: bp-based frame

sub_161C5 proc far

	var_24=	word ptr -24h
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	lea	ax, [bp+var_24]
	push	ss
	push	ax
	push	cs
	call	near ptr _strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	ax, 3
	push	ax
	mov	ax, [bp+arg_4]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	push	cs
	call	near ptr _itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_24]
	push	ss
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_161C5 endp

; Attributes: bp-based frame

sub_1621C proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 64h	
	imul	[bp+arg_4]
	mov	cl, 8
	sar	ax, cl
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_161C5
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
sub_1621C endp

; Attributes: bp-based frame

str_pluralize proc far

	var_2= word ptr	-2
	srcString= dword ptr  6
	destString= dword ptr  0Ah
	value= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
loc_16252:
	mov	ax, [bp+var_2]
	jmp	loc_16328
loc_16258:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, 2Fh	
	jnz	short loc_1627B
	cmp	[bp+value], 0
	jz	short loc_16273
	mov	ax, 1
	jmp	short loc_16276
loc_16273:
	mov	ax, 2
loc_16276:
	mov	[bp+var_2], ax
	jmp	short loc_162A0
loc_1627B:
	lfs	bx, [bp+destString]
	cmp	byte ptr fs:[bx], 5Ch
	jnz	short loc_16297
	cmp	[bp+value], 0
	jz	short loc_1628F
	mov	ax, 3
	jmp	short loc_16292
loc_1628F:
	mov	ax, 4
loc_16292:
	mov	[bp+var_2], ax
	jmp	short loc_162A0
loc_16297:
	cmp	byte ptr fs:[bx], 0
	jz	short loc_162A0
	inc	word ptr [bp+destString]
loc_162A0:
	jmp	loc_16350
loc_162A3:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 5Ch
	jnz	short loc_162B1
	mov	[bp+var_2], 3
loc_162B1:
	jmp	loc_16350
loc_162B4:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, 5Ch	
	jnz	short loc_162CC
	mov	[bp+var_2], 4
	jmp	loc_16350
loc_162CC:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_162D8
	inc	word ptr [bp+destString]
loc_162D8:
	jmp	short loc_16350
loc_162DA:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, 5Ch	
	jnz	short loc_162F1
	mov	[bp+var_2], 5
	jmp	short loc_162FD
loc_162F1:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_162FD
	inc	word ptr [bp+destString]
loc_162FD:
	jmp	short loc_16350
loc_162FF:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 5Ch
	jnz	short loc_1630D
	mov	[bp+var_2], 5
loc_1630D:
	jmp	short loc_16350
loc_1630F:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_16324
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	inc	word ptr [bp+destString]
	mov	fs:[bx], al
loc_16324:
	jmp	short loc_16350
	jmp	short loc_16350
loc_16328:
	or	ax, ax
	jnz	short loc_1632F
	jmp	loc_16258
loc_1632F:
	cmp	ax, 1
	jnz	short loc_16337
	jmp	loc_162A3
loc_16337:
	cmp	ax, 2
	jnz	short loc_1633F
	jmp	loc_162B4
loc_1633F:
	cmp	ax, 3
	jz	short loc_162DA
	cmp	ax, 4
	jz	short loc_162FF
	cmp	ax, 5
	jz	short loc_1630F
	jmp	short loc_16324
loc_16350:
	lfs	bx, [bp+srcString]
	inc	word ptr [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_1635F
	jmp	loc_16252
loc_1635F:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
str_pluralize endp

; Attributes: bp-based frame

sub_1636B proc far

	var_54=	dword ptr -54h
	var_50=	word ptr -50h
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 54h	
	call	someStackOperation
	push	[bp+arg_4]
	lea	ax, [bp+var_50]
	push	ss
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_54], ax
	mov	word ptr [bp+var_54+2],	dx
	lfs	bx, [bp+var_54]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_50]
	push	ss
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_1636B endp

; Attributes: bp-based frame


printStringWClear proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	cs
	call	near ptr clearTextWindow
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printStringWClear endp

; Attributes: bp-based frame

printString proc far

	var_62=	word ptr -62h
	var_12=	dword ptr -12h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 62h	
	call	someStackOperation
	push	si
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	mov	word ptr [bp+var_12], ax
	mov	word ptr [bp+var_12+2],	dx
	mov	[bp+var_E], 0
	mov	[bp+var_A], 0
	mov	[bp+var_C], 0
loc_163EE:
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_163FA
	jmp	loc_1655B
loc_163FA:
	lfs	bx, [bp+var_12]
	inc	word ptr [bp+var_12]
	mov	al, fs:[bx]
	cbw
	mov	[bp+var_4], ax
	jmp	loc_1653E
loc_1640A:
	mov	si, [bp+var_E]
	mov	byte ptr [bp+si+var_62], 0
	cmp	[bp+var_E], 0
	jz	short loc_16423
	lea	ax, [bp+var_62]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16560
	add	sp, 4
loc_16423:
	jmp	loc_1655B
loc_16426:
	mov	si, [bp+var_E]
	mov	byte ptr [bp+si+var_62], 0
	cmp	[bp+var_E], 0
	jz	short loc_16441
	lea	ax, [bp+var_62]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16560
	add	sp, 4
loc_16441:
	push	cs
	call	near ptr txt_newLine
loc_16445:
	mov	ax, [bp+var_C]
	inc	[bp+var_C]
	cmp	ax, 32h	
	jle	short loc_16457
	push	cs
	call	near ptr _return_three
	jmp	loc_1655B
loc_16457:
	mov	ax, word ptr [bp+var_12]
	mov	dx, word ptr [bp+var_12+2]
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	mov	[bp+var_A], 0
	mov	[bp+var_E], 0
	jmp	loc_16558
loc_16470:
	cmp	[bp+var_A], 0
	jnz	short loc_16479
	jmp	loc_16558
loc_16479:
	mov	si, [bp+var_E]
	inc	[bp+var_E]
	mov	al, byte ptr [bp+var_4]
	mov	byte ptr [bp+si+var_62], al
	push	[bp+var_4]
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	[bp+var_A], ax
	cmp	[bp+var_A], 8Ah	
	jge	short loc_1649C
	jmp	loc_1653C
loc_1649C:
	mov	ax, [bp+var_C]
	inc	[bp+var_C]
	cmp	ax, 32h	
	jle	short loc_164AE
	push	cs
	call	near ptr _return_three
	jmp	loc_1655B
loc_164AE:
	mov	ax, [bp+var_E]
	mov	[bp+var_2], ax
	mov	ax, word ptr [bp+var_12]
	mov	dx, word ptr [bp+var_12+2]
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
loc_164C0:
	dec	[bp+var_E]
	mov	si, [bp+var_E]
	cmp	byte ptr [bp+si+var_62], 20h 
	jz	short loc_164D5
	or	si, si
	jl	short loc_164D5
	dec	word ptr [bp+var_12]
	jmp	short loc_164C0
loc_164D5:
	cmp	[bp+var_E], 0
	jz	short loc_16506
	mov	si, [bp+var_E]
	mov	byte ptr [bp+si+var_62], 0
	lea	ax, [bp+var_62]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16560
	add	sp, 4
	mov	[bp+var_A], 0
	mov	[bp+var_E], 0
	mov	ax, word ptr [bp+var_12]
	mov	dx, word ptr [bp+var_12+2]
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	jmp	short loc_1653C
loc_16506:
	mov	si, [bp+var_2]
	mov	byte ptr [bp+si+var_62], 6Fh 
	mov	ax, [bp+var_8]
	mov	dx, [bp+var_6]
	dec	ax
	mov	word ptr [bp+var_12], ax
	mov	word ptr [bp+var_12+2],	dx
	lea	ax, [bp+var_62]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16560
	add	sp, 4
	mov	[bp+var_A], 0
	mov	[bp+var_E], 0
	mov	ax, word ptr [bp+var_12]
	mov	dx, word ptr [bp+var_12+2]
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
loc_1653C:
	jmp	short loc_16558
loc_1653E:
	or	ax, ax
	jnz	short loc_16545
	jmp	loc_1640A
loc_16545:
	cmp	ax, 0Ah
	jnz	short loc_1654D
	jmp	loc_16426
loc_1654D:
	cmp	ax, 20h	
	jnz	short loc_16555
	jmp	loc_16470
loc_16555:
	jmp	loc_16479
loc_16558:
	jmp	loc_163EE
loc_1655B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printString endp

; Attributes: bp-based frame

sub_16560 proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	gs:byte_4241A, 1
	cmp	gs:byte_42419, 0
	jz	short loc_16584
	push	cs
	call	near ptr txt_newLine
loc_16584:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_16595
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sub_16560 endp

; Attributes: bp-based frame

sub_16595 proc far

	var_2= byte ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_165A0:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], al
	or	al, al
	jz	short loc_165FE
	mov	ax, 1
	push	ax
	mov	al, [bp+var_2]
	cbw
	sub	ax, 20h	
	push	ax
	mov	al, gs:byte_42419
	sub	ah, ah
	add	ax, 0A8h 
	push	ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax
	call	far ptr	sub_3E97A
	add	sp, 8
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	gs:byte_42419, al
	jmp	short loc_165A0
loc_165FE:
	mov	sp, bp
	pop	bp
	retf
sub_16595 endp

; Attributes: bp-based frame

txt_newLine proc far
	push	bp
	mov	bp, sp
	mov	gs:byte_42419, 0
	mov	al, gs:txt_numLines
	inc	gs:txt_numLines
	cmp	al, 0Bh
	jb	short loc_16635
	push	cs
	call	near ptr sub_16639
	mov	gs:txt_numLines, 0Bh
loc_16635:
	mov	sp, bp
	pop	bp
	retf
txt_newLine endp

; Attributes: bp-based frame

sub_16639 proc far
	push	bp
	mov	bp, sp
	mov	ax, 50h	
	push	ax
	call	far ptr	sub_3E980
	add	sp, 2
	mov	ax, 50h	
	push	ax
	call	far ptr	sub_3E980
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sub_16639 endp

; Attributes: bp-based frame

sub_1665F proc far

	var_A30= word ptr -0A30h
	var_A2E= word ptr -0A2Eh
	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	var_25A= word ptr -25Ah
	var_258= word ptr -258h
	var_256= word ptr -256h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 0A30h
	call	someStackOperation
	push	si
	lea	ax, [bp+var_258]
	push	ss
	push	ax
	lea	ax, [bp+var_A2E]
	push	ss
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_169D4
	add	sp, 0Ch
	mov	[bp+var_A30], ax
	mov	[bp+var_25A], 0FFF8h
	jmp	short loc_16694
loc_16690:
	inc	[bp+var_25A]
loc_16694:
	mov	ax, [bp+var_A30]
	sub	ax, 4
	cmp	ax, [bp+var_25A]
	jg	short loc_166A4
	jmp	loc_1672C
loc_166A4:
	sub	ax, ax
	push	ax
	mov	ax, 5Ch	
	push	ax
	mov	ax, 96h	
	push	ax
	mov	ax, 1Ch
	push	ax
	sub	ax, ax
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	[bp+var_25C], 0
	jmp	short loc_166CA
loc_166C6:
	inc	[bp+var_25C]
loc_166CA:
	cmp	[bp+var_25C], 8
	jge	short loc_16717
	mov	ax, [bp+var_25C]
	add	ax, [bp+var_25A]
	mov	[bp+var_25E], ax
	or	ax, ax
	jl	short loc_16715
	mov	ax, [bp+var_A30]
	cmp	[bp+var_25E], ax
	jge	short loc_16715
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_25C]
	mov	cl, 3
	shl	ax, cl
	add	ax, 1Ch
	push	ax
	mov	ax, 3
	push	ax
	mov	si, [bp+var_25E]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_256]
	push	[bp+si+var_258]
	push	cs
	call	near ptr sub_16F1E
	add	sp, 0Ah
loc_16715:
	jmp	short loc_166C6
loc_16717:
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr sub_1542D
	add	sp, 2
	cmp	ax, 1Bh
	jnz	short loc_16729
	jmp	short loc_1672C
loc_16729:
	jmp	loc_16690
loc_1672C:
	pop	si
	mov	sp, bp
	pop	bp
locret_16730:
	retf
sub_1665F endp

; Attributes: bp-based frame

doVictoryMaybe proc far

	var_A38= word ptr -0A38h
	var_A36= word ptr -0A36h
	var_266= word ptr -266h
	var_264= word ptr -264h
	var_262= word ptr -262h
	var_260= word ptr -260h
	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	var_25A= word ptr -25Ah
	var_258= word ptr -258h
	var_256= word ptr -256h

	push	bp
	mov	bp, sp
	mov	ax, 0A38h
	call	someStackOperation
	push	si
	mov	[bp+var_262], 0
	jmp	short loc_16749
loc_16745:
	inc	[bp+var_262]
loc_16749:
	cmp	[bp+var_262], 5
	jge	short loc_1675E
	push	[bp+var_262]
	call	sub_17920
	add	sp, 2
	jmp	short loc_16745
loc_1675E:
	mov	gs:byte_422A0, 0
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	call	_mallocMaybe
	add	sp, 4
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
loc_1677F:
	sub	ax, ax
	push	ax
	mov	ax, offset aVict
	push	ds
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_260], ax
	inc	ax
	jnz	short loc_167BC
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	push	dseg_0
	push	disk1
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_167BC:
	cmp	[bp+var_260], 0FFFFh
	jz	short loc_1677F
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_260]
	call	_read
	add	sp, 0Ah
	push	[bp+var_260]
	call	_close
	add	sp, 2
	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, [bp+var_25E]
	mov	dx, [bp+var_25C]
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	wait4IO
	mov	[bp+var_25A], 0
	jmp	short loc_16836
loc_16832:
	inc	[bp+var_25A]
loc_16836:
	cmp	[bp+var_25A], 5
	jl	short loc_16840
	jmp	loc_1690F
loc_16840:
	lea	ax, [bp+var_258]
	push	ss
	push	ax
	lea	ax, [bp+var_A36]
	push	ss
	push	ax
	mov	bx, [bp+var_25A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (someMessageList+2)[bx]
	push	word ptr someMessageList[bx]
	push	cs
	call	near ptr sub_169D4
	add	sp, 0Ch
	mov	[bp+var_A38], ax
	mov	[bp+var_262], 0FFF8h
	jmp	short loc_16879
loc_16875:
	inc	[bp+var_262]
loc_16879:
	mov	ax, [bp+var_A38]
	sub	ax, 4
	cmp	ax, [bp+var_262]
	jg	short loc_16889
	jmp	loc_1690C
loc_16889:
	mov	ax, 0Bh
	push	ax
	mov	ax, 0BEh 
	push	ax
	mov	ax, 0A1h 
	push	ax
	mov	ax, 7Eh	
	push	ax
	mov	ax, 0Ah
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	[bp+var_264], 0
	jmp	short loc_168B1
loc_168AD:
	inc	[bp+var_264]
loc_168B1:
	cmp	[bp+var_264], 8
	jge	short loc_168FE
	mov	ax, [bp+var_264]
	add	ax, [bp+var_262]
	mov	[bp+var_266], ax
	or	ax, ax
	jl	short loc_168FC
	mov	ax, [bp+var_A38]
	cmp	[bp+var_266], ax
	jge	short loc_168FC
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_264]
	mov	cl, 3
	shl	ax, cl
	add	ax, 7Eh	
	push	ax
	mov	ax, 0Dh
	push	ax
	mov	si, [bp+var_266]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_256]
	push	[bp+si+var_258]
	push	cs
	call	near ptr sub_16F1E
	add	sp, 0Ah
loc_168FC:
	jmp	short loc_168AD
loc_168FE:
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr sub_1542D
	add	sp, 2
	jmp	loc_16875
loc_1690C:
	jmp	loc_16832
loc_1690F:
	sub	ax, ax
	push	ax
	mov	ax, offset aBardscr
	push	ds
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_260], ax
	inc	ax
	jnz	short loc_1694C
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	push	dseg_0
	push	disk1
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	ax, 0FFFFh
	push	ax
	push	cs
	call	near ptr sub_1542D
	add	sp, 2
loc_1694C:
	cmp	[bp+var_260], 0FFFFh
	jz	short loc_1690F
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_260]
	call	_read
	add	sp, 0Ah
	push	[bp+var_260]
	call	_close
	add	sp, 2
	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, [bp+var_25E]
	mov	dx, [bp+var_25C]
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	push	[bp+var_25C]
	push	[bp+var_25E]
	call	_freeMaybe
	add	sp, 4
	call	sub_116CC
	mov	buildingRvalMaybe, 1
	pop	si
	mov	sp, bp
	pop	bp
	retf
doVictoryMaybe endp

; Attributes: bp-based frame

sub_169D4 proc far

	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= dword ptr  0Eh

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	push	si
	mov	[bp+var_8], 0
	mov	[bp+var_E], 0
	mov	bx, [bp+var_E]
	inc	[bp+var_E]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
loc_16A04:
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_16A10
	jmp	loc_16B01
loc_16A10:
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	cbw
	mov	[bp+var_6], ax
	jmp	loc_16AEC
loc_16A1D:
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 0
	mov	ax, [bp+var_E]
	jmp	loc_16B10
loc_16A2D:
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+var_E]
	inc	[bp+var_E]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	[bp+var_8], 0
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 20h
	jnz	short loc_16A62
	inc	word ptr [bp+arg_0]
loc_16A62:
	jmp	loc_16AFE
loc_16A65:
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	al, byte ptr [bp+var_6]
	mov	fs:[bx], al
	push	[bp+var_6]
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	[bp+var_8], ax
	cmp	[bp+var_8], 96h	
	jl	short loc_16AEA
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	dec	ax
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	mov	[bp+var_2], 0
loc_16A97:
	lfs	bx, [bp+var_C]
	cmp	byte ptr fs:[bx], 20h
	jz	short loc_16AC0
	cmp	[bp+var_8], 0
	jle	short loc_16AC0
	dec	word ptr [bp+var_C]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	mov	[bp+var_10], ax
	add	[bp+var_2], ax
	sub	[bp+var_8], ax
	jmp	short loc_16A97
loc_16AC0:
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+var_E]
	inc	[bp+var_E]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, word ptr [bp+var_C]
	mov	dx, word ptr [bp+var_C+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	ax, [bp+var_2]
	mov	[bp+var_8], ax
loc_16AEA:
	jmp	short loc_16AFE
loc_16AEC:
	or	ax, ax
	jnz	short loc_16AF3
	jmp	loc_16A1D
loc_16AF3:
	cmp	ax, 0Ah
	jnz	short loc_16AFB
	jmp	loc_16A2D
loc_16AFB:
	jmp	loc_16A65
loc_16AFE:
	jmp	loc_16A04
loc_16B01:
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 0
	mov	ax, [bp+var_E]
	jmp	short $+2
loc_16B10:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_169D4 endp

; Attributes: bp-based frame

printRoster proc far

	tmp= word ptr -32h
	counter= word ptr -30h
	charNo=	word ptr -2Eh
	var_2C=	dword ptr -2Ch
	rosterLine= word ptr -28h
	var_26=	byte ptr -26h
	var_24=	byte ptr -24h

	push	bp
	mov	bp, sp
	mov	ax, 32h	
	call	someStackOperation
	push	si
	cmp	byte ptr word_44166,	0
	jz	short loc_16B30
	jmp	loc_16DF3
loc_16B30:
	call	rost_updateParty
	mov	byte ptr word_44166,	1
	call	far ptr	sub_3E974
	mov	[bp+charNo], 0
	jmp	short loc_16B4E
loc_16B4B:
	inc	[bp+charNo]
loc_16B4E:
	cmp	[bp+charNo], 7
	jl	short loc_16B57
	jmp	loc_16DEF
loc_16B57:
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jnz	short loc_16B6E
	jmp	loc_16DD9
loc_16B6E:
	mov	[bp+counter], 0
loc_16B73:
	getCharP	[bp+charNo], bx
	add	bx, [bp+counter]
	mov	al, byte ptr gs:roster._name[bx]
	mov	si, [bp+counter]
	mov	byte ptr [bp+si+rosterLine], al
	or	al, al
	jz	short loc_16B92
	inc	[bp+counter]
	jmp	short loc_16B73
loc_16B92:
	push	[bp+charNo]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16DF8
	add	sp, 6
	mov	ax, 3
	push	ax
	getCharP	[bp+charNo], bx
	mov	al, gs:roster.ac[bx]
	cbw
	sub	ax, 10
	neg	ax
	cwd
	push	dx
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr _itoa
	add	sp, 10
	mov	word ptr [bp+var_2C], ax
	mov	word ptr [bp+var_2C+2],	dx
	lfs	bx, [bp+var_2C]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+charNo]
	mov	ax, 10h
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	cmp	gs:roster.status[bx], 0
	jz	short loc_16C7A
	mov	[bp+counter], 6
	jmp	short loc_16C0D
loc_16C0A:
	dec	[bp+counter]
loc_16C0D:
	cmp	[bp+counter], 0
	jl	short loc_16C78
	getCharP	[bp+charNo], bx
	mov	al, gs:roster.status[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, byte_43EEA[bx]
	cbw
	test	cx, ax
	jz	short loc_16C76
	mov	[bp+tmp], 0
	jmp	short loc_16C3E
loc_16C3B:
	inc	[bp+tmp]
loc_16C3E:
	cmp	[bp+tmp], 4
	jge	short loc_16C59
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+tmp]
	mov	al, byte ptr aOldPsndnutspossparade[bx+si]
	mov	si, bx
	mov	byte ptr [bp+si+rosterLine], al
	jmp	short loc_16C3B
loc_16C59:
	mov	[bp+var_24], 0
	mov	ax, 1
	push	ax
	push	[bp+charNo]
	mov	ax, 14h
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	jmp	short loc_16C78
loc_16C76:
	jmp	short loc_16C0A
loc_16C78:
	jmp	short loc_16CC2
loc_16C7A:
	mov	ax, 3
	push	ax
	getCharP	[bp+charNo], bx
	sub	ax, ax
	push	ax
	push	gs:roster.maxHP[bx]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr _itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_2C], ax
	mov	word ptr [bp+var_2C+2],	dx
	lfs	bx, [bp+var_2C]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+charNo]
	mov	ax, 14h
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
loc_16CC2:
	mov	ax, 3
	push	ax
	getCharP	[bp+charNo], bx
	sub	ax, ax
	push	ax
	push	gs:roster.currentHP[bx]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr _itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_2C], ax
	mov	word ptr [bp+var_2C+2],	dx
	lfs	bx, [bp+var_2C]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+charNo]
	mov	ax, 18h
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	mov	ax, 3
	push	ax
	getCharP	[bp+charNo], bx
	sub	ax, ax
	push	ax
	push	gs:roster.maxSppt[bx]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr _itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_2C], ax
	mov	word ptr [bp+var_2C+2],	dx
	lfs	bx, [bp+var_2C]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+charNo]
	mov	ax, 1Ch
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	mov	ax, 3
	push	ax
	getCharP	[bp+charNo], bx
	sub	ax, ax
	push	ax
	push	gs:roster.currentSppt[bx]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr _itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_2C], ax
	mov	word ptr [bp+var_2C+2],	dx
	lfs	bx, [bp+var_2C]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+charNo]
	mov	ax, 20h	
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	mov	al, gs:roster.class[bx]
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	al, byte ptr aWawisocomarobapahumoa[si]
	mov	byte ptr [bp+rosterLine], al
	mov	al, byte ptr (aWawisocomarobapahumoa+1)[si]
	mov	byte ptr [bp+rosterLine+1], al
	mov	[bp+var_26], ah
	mov	ax, 1
	push	ax
	push	[bp+charNo]
	mov	ax, 24h	
	push	ax
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16E4F
	add	sp, 0Ah
	jmp	short loc_16DEC
loc_16DD9:
	mov	byte ptr [bp+rosterLine], 0
	push	[bp+charNo]
	lea	ax, [bp+rosterLine]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_16DF8
	add	sp, 6
loc_16DEC:
	jmp	loc_16B4B
loc_16DEF:
	push	cs
	call	near ptr sub_1766A
loc_16DF3:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printRoster endp

; Attributes: bp-based frame

sub_16DF8 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, [bp+arg_4]
	mov	cl, 3
	shl	ax, cl
	mov	[bp+var_2], ax
	mov	ax, 7
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 97h	
	push	ax
	mov	ax, 13Ah
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 90h	
	push	ax
	mov	ax, 0Bh
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	ax, 1
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 90h	
	push	ax
	mov	ax, 0Ch
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_16F1E
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
sub_16DF8 endp

; Attributes: bp-based frame

sub_16E4F proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_8], 1
	sbb	ax, ax
	neg	ax
	push	ax
	mov	ax, [bp+arg_6]
	mov	cl, 3
	shl	ax, cl
	add	ax, 90h	
	push	ax
	mov	ax, [bp+arg_4]
	shl	ax, cl
	add	ax, 0Ch
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_16F67
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
sub_16E4F endp

; Attributes: bp-based frame

setTitle proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	sub	ax, ax
	push	ax
	mov	ax, 71h	
	push	ax
	mov	ax, 82h	
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, 12h
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	ax, 70h	
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_16EE0
	add	sp, 6
	mov	[bp+var_2], ax
	sub	ax, ax
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, [bp+var_2]
	add	ax, 12h
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_16F1E
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
setTitle endp

; Attributes: bp-based frame

sub_16EE0 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
loc_16EF0:
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_16F0D
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	[bp+var_2], ax
	jmp	short loc_16EF0
loc_16F0D:
	mov	ax, [bp+arg_4]
	sub	ax, [bp+var_2]
	cwd
	sub	ax, dx
	sar	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_16EE0 endp

; Attributes: bp-based frame

sub_16F1E proc far

	var_2= byte ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_16F29:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], al
	or	al, al
	jz	short loc_16F63
	push	[bp+arg_8]
	cbw
	sub	ax, 20h	
	push	ax
	push	[bp+arg_4]
	push	[bp+arg_6]
	call	far ptr	sub_3E97A
	add	sp, 8
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr txt_charSpacing
	add	sp, 2
	add	[bp+arg_4], ax
	inc	word ptr [bp+arg_0]
	jmp	short loc_16F29
loc_16F63:
	mov	sp, bp
	pop	bp
	retf
sub_16F1E endp

; Attributes: bp-based frame

sub_16F67 proc far

	var_2= byte ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
loc_16F72:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], al
	or	al, al
	jz	short loc_16F9E
	push	[bp+arg_8]
	cbw
	sub	ax, 20h	
	push	ax
	push	[bp+arg_4]
	push	[bp+arg_6]
	call	far ptr	sub_3E97A
	add	sp, 8
	add	[bp+arg_4], 8
	inc	word ptr [bp+arg_0]
	jmp	short loc_16F72
loc_16F9E:
	mov	sp, bp
	pop	bp
	retf
sub_16F67 endp

; Attributes: bp-based frame

clearTextWindow	proc far
	push	bp
	mov	bp, sp
	cmp	gs:byte_4241A, 0
	jz	short loc_16FF0
	sub	al, al
	mov	gs:txt_numLines, al
	mov	gs:byte_42419, al
	mov	ax, 0Fh
	push	ax
	mov	ax, 66h	
	push	ax
	mov	ax, 132h
	push	ax
	mov	ax, 6
	push	ax
	mov	ax, 0A7h 
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	gs:byte_4241A, 0
loc_16FF0:
	mov	sp, bp
	pop	bp
	retf
clearTextWindow	endp

; Attributes: bp-based frame

txt_charSpacing	proc far

	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	mov	al, [bp+arg_0]
	cbw
	push	ax
	push	cs
	call	near ptr isLowerAndNotM
	add	sp, 2
	or	ax, ax
	jz	short loc_17013
	mov	ax, 8
	jmp	short loc_17023
loc_17013:
	cmp	[bp+arg_0], 69h	
	jnz	short loc_1701E
	mov	ax, 3
	jmp	short loc_17023
loc_1701E:
	mov	ax, 6
	jmp	short $+2
loc_17023:
	mov	sp, bp
	pop	bp
	retf
txt_charSpacing	endp

; Attributes: bp-based frame

isLowerAndNotM proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 61h	
	jl	short loc_1703D
	cmp	[bp+arg_0], 7Ah	
	jle	short loc_17043
loc_1703D:
	cmp	[bp+arg_0], 20h	
	jnz	short loc_17049
loc_17043:
	cmp	[bp+arg_0], 6Dh	
	jnz	short loc_1704E
loc_17049:
	mov	ax, 1
	jmp	short loc_17050
loc_1704E:
	sub	ax, ax
loc_17050:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
isLowerAndNotM endp

; Attributes: bp-based frame

sub_17056 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
loc_17061:
	sub	ax, ax
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_1709E
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	push	dseg_0
	push	disk1
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_1709E:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_17061
	push	[bp+var_2]
	call	dcmp_init
	add	sp, 2
	mov	ax, 7D00h
	push	ax
	mov	ax, offset characterIOBuf
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sub_17056 endp

; Attributes: bp-based frame

configIconsBin proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
loc_170DD:
	sub	ax, ax
	push	ax
	mov	ax, offset aIcons_bin
	push	ds
	push	ax
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_17119
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	push	dseg_0
	push	disk1
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_17119:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_170DD
	push	[bp+var_2]
	call	dcmp_init
	add	sp, 2
	mov	ax, 474h
	push	ax
	mov	ax, offset iconLight
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	mov	ax, 820h
	push	ax
	mov	ax, offset iconCompass
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	mov	ax, 550h
	push	ax
	mov	ax, offset iconAreaEnchant
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	mov	ax, 1E0h
	push	ax
	mov	ax, offset iconShield
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	mov	ax, 640h
	push	ax
	mov	ax, offset iconLevitation
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	dcmp_decompress
	add	sp, 6
	push	[bp+var_2]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
configIconsBin endp

; Attributes: bp-based frame

bigpic_drawPicNumber proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	fd= word ptr -4
	var_2= word ptr	-2
	indexNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	cmp	[bp+indexNo], 0FEh
	jnz	short loc_171CF
	mov	ax, 7
	push	ax
	mov	ax, 66h	
	push	ax
	mov	ax, 7Fh	
	push	ax
	mov	ax, 0Fh
	push	ax
	mov	ax, 11h
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	jmp	loc_17362
loc_171CF:
	mov	ax, 58h
	imul	word_4414C
	mov	si, ax
	mov	bx, [bp+indexNo]
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_171E7
	xor	byte ptr word_4414C, 3
loc_171E7:
	mov	ax, 58h
	imul	word_4414C
	mov	si, ax
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_17206
	mov	ax, offset aPictureGetErro
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	jmp	loc_17362
loc_17206:
	mov	ax, 88
	imul	word_4414C
	mov	si, ax
	mov	bx, [bp+indexNo]
	mov	al, bigpicIndex[bx+si-58h]
	sub	ah, ah
	mov	[bp+var_2], ax
loc_1721B:
	sub	ax, ax
	push	ax
	mov	bx, word_4414C
	shl	bx, 1
	shl	bx, 1
	push	word ptr lowPic[bx-2]
	push	word ptr lowPic[bx-4]
	call	openFile
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_1726A
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	bx, word_4414C
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_1726A:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1721B
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	shl	ax, 1
	shl	ax, 1
	sub	cx, cx
	push	cx
	push	ax
	push	[bp+fd]
	call	_lseek
	add	sp, 8
	mov	ax, 4
	push	ax
	lea	ax, [bp+var_8]
	push	ss
	push	ax
	push	[bp+fd]
	call	_read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	[bp+fd]
	call	_lseek
	add	sp, 8
	mov	ax, 19712
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_E], ax
	mov	[bp+var_C], dx
	mov	ax, 19712
	push	ax
	push	dx
	push	[bp+var_E]
	push	[bp+fd]
	call	_read
	add	sp, 8
	push	gs:word_4240C
	push	gs:word_4240A
	push	[bp+var_C]
	push	[bp+var_E]
	call	d3comp
	add	sp, 8
	push	[bp+var_C]
	push	[bp+var_E]
	call	_freeMaybe
	add	sp, 4
	push	[bp+fd]
	call	_close
	add	sp, 2
	push	gs:word_4240C
	push	gs:word_4240A
	push	cs
	call	near ptr sub_17367
	add	sp, 4
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	push	gs:word_4240C
	push	gs:word_4240A
	call	far ptr	vid_drawBigpic
	add	sp, 8
	cmp	[bp+indexNo], 35h 
	jz	short loc_1734A
	mov	al, 1
	jmp	short loc_1734C
loc_1734A:
	sub	al, al
loc_1734C:
	mov	gs:byte_422A0, al
	mov	gs:bigpicImageNo, 0
	sub	ax, ax
	jmp	short $+2
loc_17362:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bigpic_drawPicNumber endp

; Attributes: bp-based frame

sub_17367 proc far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	si, 1340h
	jmp	short loc_17379
loc_17378:
	inc	si
loc_17379:
	cmp	si, 4D00h
	jge	short loc_1738F
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	xor	fs:[bx+1340h], al
	inc	word ptr [bp+arg_0]
	jmp	short loc_17378
loc_1738F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_17367 endp

; Attributes: bp-based frame

readLevelData proc far

	var_E= word ptr	-0Eh
	memOffset= word	ptr -0Ch
	memSegment= word ptr -0Ah
	var_6= word ptr	-6
	fd= word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	al, byte ptr stru_43F6E.fileType[bx]
	sub	ah, ah
	mov	[bp+var_E], ax
loc_173AD:
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (disk3+2)[bx]
	push	word ptr disk3[bx]
	call	openFile
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_173FA
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_173FA:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_173AD
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	al, stru_43F6E.fileIndexMaybe[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	shl	ax, 1
	cwd
	push	dx
	push	ax
	push	[bp+fd]
	call	_lseek
	add	sp, 8
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_6]
	push	ss
	push	ax
	push	[bp+fd]
	call	_read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+fd]
	call	_lseek
	add	sp, 8
	mov	ax, 4000
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+memOffset],	ax
	mov	[bp+memSegment], dx
	mov	ax, 4000
	push	ax
	push	dx
	push	[bp+memOffset]
	push	[bp+fd]
	call	_read
	add	sp, 8
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	[bp+memSegment]
	push	[bp+memOffset]
	call	d3comp
	add	sp, 8
	push	[bp+memSegment]
	push	[bp+memOffset]
	call	_freeMaybe
	add	sp, 4
	push	[bp+fd]
	call	_close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
readLevelData endp

; Attributes: bp-based frame

readGraphicsMaybe proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, word_4414E
	cmp	[bp+arg_0], ax
	jnz	short loc_174BA
	jmp	loc_17541
loc_174BA:
	sub	ax, ax
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_43F2E+2)[bx]
	push	word ptr off_43F2E[bx]
	call	openFile
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_17513
	mov	bx, [bp+arg_0]
	mov	al, byte_43F4A[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_17513:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_174BA
	mov	ax, [bp+arg_0]
	mov	word_4414E, ax
	mov	ax, 4A38h
	push	ax
	mov	ax, offset graphicsBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+var_2]
	call	_read
	add	sp, 8
	push	[bp+var_2]
	call	_close
	add	sp, 2
loc_17541:
	mov	sp, bp
	pop	bp
	retf
readGraphicsMaybe endp

; Attributes: bp-based frame

readMonsterFile	proc far

	var_A= word ptr	-0Ah
	_size= word ptr -8
	var_6= word ptr -6
	var_4= word ptr	-4
	_fd= word ptr	-2
	index= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	mov	ax, 480h
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	mov	[bp+_size], 0

	; If the index is the last index in the file, read the full 0x480 bytes.
	; Otherwise, read the index, then read the next index, subtract to get the
	; length of the monster roster for the level.
	;
	cmp	[bp+index], 17
	jz	loc_readMonsterFile_hardcode_size
	cmp	[bp+index], 40
	jnz	loc_readMonsterFile_skip_hardcode

loc_readMonsterFile_hardcode_size:
	mov	[bp+_size], 480h

loc_readMonsterFile_skip_hardcode:
	cmp	[bp+index], 11h
	jge	short loc_17571
	sub	ax, ax
	jmp	short loc_17574
loc_17571:
	mov	ax, 1
loc_17574:
	mov	[bp+var_A], ax
loc_17577:
	sub	ax, ax
	push	ax
	mov	bx, [bp+var_A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (monsterFiles+2)[bx]
	push	word ptr monsterFiles[bx]
	call	openFile
	add	sp, 6
	mov	[bp+_fd], ax
	inc	ax
	jnz	short loc_175C4
	mov	ax, offset aPleaseInsertDi
	push	ds
	push	ax
	push	cs
	call	near ptr printString
	add	sp, 4
	mov	bx, [bp+var_A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (disk2+2)[bx]
	push	word ptr disk2[bx]
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
loc_175C4:
	cmp	[bp+_fd], 0FFFFh
	jz	short loc_17577
	cmp	[bp+var_A], 0
	jz	short loc_175D4
	sub	[bp+index], 11h
loc_175D4:
	push_imm	0FFFFh
	mov	ax, [bp+index]
	shl	ax, 1
	cwd
	push_reg	dx
	push_reg	ax
	push_var_stack	_fd
	func_lseek

	push_imm	2
	push_ss_string	var_4
	push_var_stack	_fd
	func_read

	cmp		[bp+_size], 0
	jnz		loc_readMonsterFile_read_data

	push_imm	2
	push_ss_string	var_6
	push_var_stack	_fd
	func_read

	mov		ax, [bp+var_6]
	sub		ax, [bp+var_4]
	mov		[bp+_size], ax

loc_readMonsterFile_read_data:
	push_imm	0FFFFh
	mov		ax, [bp+var_4]
	cwd
	push_reg	dx
	push_reg	ax
	push_var_stack	_fd
	func_lseek

	push_var_stack	_size
	mov		ax, offset monsterBuf
	mov		dx, seg	seg023
	push_reg	dx
	push_reg	ax
	push_var_stack	_fd
	func_read

	push_var_stack	_fd
	func_close

	mov	sp, bp
	pop	bp
	retf
readMonsterFile	endp

; Attributes: bp-based frame

sub_1763A proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	cs
	call	near ptr clearTextWindow
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printString
	add	sp, 4
	wait4IO
	call	sub_104F3
	mov	sp, bp
	pop	bp
	retf
sub_1763A endp

; Attributes: bp-based frame

sub_1766A proc far
	push	bp
	mov	bp, sp
	cmp	gs:byte_422A0, 0
	jz	short loc_17688
	push	cs
	call	near ptr sub_17691
	or	ax, ax
	jz	short loc_1768D
loc_17688:
	call	far ptr	sub_3E971
loc_1768D:
	mov	sp, bp
	pop	bp
	retf
sub_1766A endp

; Attributes: bp-based frame

sub_17691 proc far
	push	bp
	mov	bp, sp
	mov	ax, mouseBoxes._left
	cmp	mouse_x, ax
	jl	short loc_176CB
	mov	ax, mouseBoxes._right
	cmp	mouse_x, ax
	jge	short loc_176CB
	mov	ax, mouseBoxes._top
	cmp	mouse_y, ax
	jl	short loc_176CB
	mov	ax, mouseBoxes._bottom
	cmp	mouse_y, ax
	jl	short loc_176D0
loc_176CB:
	mov	ax, 1
	jmp	short loc_176D2
loc_176D0:
	sub	ax, ax
loc_176D2:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_17691 endp

; This function	doesn't really do anything but
; return 3...
; Attributes: bp-based frame

_return_three proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 3
	mov	ax, 3
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_return_three endp

; Attributes: bp-based frame
_doNothing proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	sp, bp
	pop	bp
	retf
_doNothing endp

; Attributes: bp-based frame

_doNothing_0 proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	sp, bp
	pop	bp
	retf
_doNothing_0 endp

; Attributes: bp-based frame

_doNothing_1 proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	sp, bp
	pop	bp
	retf
_doNothing_1 endp

; Attributes: bp-based frame

_doNothing_2 proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	sp, bp
	pop	bp
locret_17728:
	retf
_doNothing_2 endp


sub_17729	proc far
	push	bp
	mov	bp, sp
	mov	sp, bp
	pop	bp
	retf
sub_17729	endp

seg003 ends
