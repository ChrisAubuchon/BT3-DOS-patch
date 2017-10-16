; Attributes: bp-based frame

sp_teleport proc far

	var_116= word ptr -116h
	var_16=	dword ptr -16h
	counter= word ptr -12h
	var_10=	dword ptr -10h
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	teleDeltaList= word ptr	-6
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 116h
	call	someStackOperation
	push	di
	push	si
	mov	word ptr [bp+var_16], offset characterIOBuf
	mov	word ptr [bp+var_16+2],	seg seg022
	cmp	inDungeonMaybe, 0
	jnz	short loc_20FCB
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr printSpellFizzled
	add	sp, 4
	jmp	l_return
loc_20FCB:
	mov	word_4EE66, 0
	mov	[bp+var_A], 0
	mov	[bp+counter], 0
	jmp	short loc_20FE5
loc_20FE2:
	inc	[bp+counter]
loc_20FE5:
	cmp	[bp+counter], 3
	jge	short loc_20FF7
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+teleDeltaList], 0
	jmp	short loc_20FE2
loc_20FF7:
	call	clearTextWindow
	mov	ax, offset aTeleportUseArr
	push	ds
	push	ax
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2],	dx
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_C], ax
	mov	al, levFlags
	and	ax, 10h
	push	ax
	push	dx
	push	word ptr [bp+var_10]
	mov	ax, offset aDownUp
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2],	dx
	lfs	bx, [bp+var_10]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	al, byte ptr [bp+var_C]
	add	al, 3
	mov	gs:txt_numLines, al
	mov	[bp+counter], 0
	jmp	short loc_21071
loc_2106E:
	inc	[bp+counter]
loc_21071:
	cmp	[bp+counter], 3
	jge	short loc_210A1
	mov	ax, [bp+counter]
	cmp	[bp+var_A], ax
	jnz	short loc_21084
	mov	ax, 1
	jmp	short loc_21086
loc_21084:
	sub	ax, ax
loc_21086:
	push	ax
	mov	si, [bp+counter]
	shl	si, 1
	push	[bp+si+teleDeltaList]
	push	cs
	call	near ptr _sp_teleportPrintNum
	add	sp, 4
	inc	gs:txt_numLines
	jmp	short loc_2106E
loc_210A1:
	sub	ax, ax
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_8], ax
	jmp	short loc_210E5
loc_210B1:
	inc	[bp+var_A]
	jmp	short loc_210FB
loc_210B6:
	mov	si, [bp+var_A]
	shl	si, 1
	mov	ax, word_484CC[si]
	cmp	[bp+si+teleDeltaList], ax
	jge	short loc_210C7
	inc	[bp+si+teleDeltaList]
loc_210C7:
	jmp	short loc_210FB
loc_210C9:
	mov	si, [bp+var_A]
	shl	si, 1
	mov	ax, word_484CC[si]
	neg	ax
	cmp	[bp+si+teleDeltaList], ax
	jle	short loc_210DC
	dec	[bp+si+teleDeltaList]
loc_210DC:
	jmp	short loc_210FB
loc_210DE:
	jmp	l_return
loc_210E1:
	jmp	short loc_210FB
	jmp	short loc_210FB
loc_210E5:
	cmp	ax, dosKeys_ESC
	jz	short loc_210DE
	cmp	ax, ' '
	jz	short loc_210B1
	cmp	ax, dosKeys_upArrow
	jz	short loc_210B6
	cmp	ax, dosKeys_downArrow
	jz	short loc_210C9
	jmp	short loc_210E1
loc_210FB:
	cmp	[bp+var_A], 3
	jge	short loc_21104
	jmp	loc_20FF7
loc_21104:
	mov	ax, offset aTeleport?
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_21136
	mov	ax, offset aTeleportCancel
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	l_return
loc_21136:
	mov	ax, dunLevelNum
	add	ax, [bp+teleDeltaList+4]
	push	ax
	mov	ax, sq_east
	add	ax, [bp+teleDeltaList+2]
	push	ax
	mov	ax, sq_north
	add	ax, [bp+teleDeltaList]
	push	ax
	push	cs
	call	near ptr _sp_doTeleport
	add	sp, 6
	or	ax, ax
	jnz	short loc_21168
	jmp	loc_211F3
loc_21168:
	mov	ax, offset aTeleportSucces
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+teleDeltaList]
	add	sq_north, ax
	mov	ax, [bp+teleDeltaList+2]
	add	sq_east, ax
	mov	ax, [bp+teleDeltaList+4]
	add	dunLevelNum,	ax
	mov	di, dunLevelNum
	lfs	bx, [bp+var_16]
	mov	al, fs:[bx+di+12h]
	sub	ah, ah
	mov	si, ax
	cmp	dunLevelIndex, si
	jz	short loc_211F1
	mov	dunLevelIndex, si
	mov	buildingRvalMaybe, 4
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	sq_north, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	sq_east, ax
	mov	gs:levelChangedFlag, 1
loc_211F1:
	jmp	short l_return
loc_211F3:
	mov	ax, offset aTeleportFailed
	push	ds
	push	ax
	call	printString
	add	sp, 4
l_return:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sp_teleport endp

; Attributes: bp-based frame

_sp_doTeleport proc far

	var_1A=	dword ptr -1Ah
	var_16=	word ptr -16h
	var_14=	dword ptr -14h
	var_10=	word ptr -10h
	var_E= dword ptr -0Eh
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	sqN= word ptr  6
	sqE= word ptr  8
	level= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 1Ah
	call	someStackOperation
	push	si
	cmp	[bp+level], 0
	jl	short loc_2121E
	cmp	[bp+level], 7
	jle	short loc_21223
loc_2121E:
	sub	ax, ax
	jmp	loc_2136C
loc_21223:
	mov	word ptr [bp+var_E], offset characterIOBuf
	mov	word ptr [bp+var_E+2], seg seg022
	lfs	bx, [bp+var_E]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+var_16], ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+var_A], ax
	mov	si, [bp+level]
	test	fs:[bx+si+dun_t.dunLevel], 80h
	jz	short loc_21255
	sub	ax, ax
	jmp	loc_2136C
loc_21255:
	mov	si, [bp+level]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	cmp	ax, dunLevelIndex
	jnz	short loc_21276
	mov	ax, bx
	mov	dx, word ptr [bp+var_E+2]
	mov	word ptr [bp+var_14], ax
	mov	word ptr [bp+var_14+2],	dx
	jmp	short loc_212A2
loc_21276:
	mov	ax, 0FA0h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	word ptr [bp+var_14], ax
	mov	word ptr [bp+var_14+2],	dx
	push	dx
	push	ax
	mov	si, [bp+level]
	lfs	bx, [bp+var_E]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	add	ax, 0Ah
	push	ax
	call	readLevelData
	add	sp, 6
loc_212A2:
	lfs	bx, [bp+var_14]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	sub	[bp+var_16], ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	sub	[bp+var_A], ax
	cmp	[bp+var_16], 0
	jl	short loc_212D5
	mov	al, fs:[bx+dun_t._height]
	sub	ah, ah
	cmp	ax, [bp+var_16]
	jbe	short loc_212D5
	cmp	[bp+var_A], 0
	jl	short loc_212D5
	mov	al, fs:[bx+dun_t._width]
	cmp	ax, [bp+var_A]
	ja	short loc_212F6
loc_212D5:
	mov	ax, word ptr [bp+var_E]
	mov	dx, word ptr [bp+var_E+2]
	cmp	bx, ax
	jnz	short loc_212E4
	cmp	word ptr [bp+var_14+2],	dx
	jz	short loc_212F2
loc_212E4:
	push	word ptr [bp+var_14+2]
	push	word ptr [bp+var_14]
	call	_freeMaybe
	add	sp, 4
loc_212F2:
	sub	ax, ax
	jmp	short loc_2136C
loc_212F6:
	mov	ax, word ptr [bp+var_14]
	mov	dx, word ptr [bp+var_14+2]
	add	ax, 24h	
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	mov	ax, [bp+var_16]
	shl	ax, 1
	add	ax, [bp+var_8]
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, word ptr [bp+var_14]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	si, [bp+var_A]
	mov	ax, si
	shl	si, 1
	shl	si, 1
	add	si, ax
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+si+4]
	and	al, 20h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_10], cx
	mov	ax, word ptr [bp+var_E]
	mov	dx, word ptr [bp+var_E+2]
	cmp	word ptr [bp+var_14], ax
	jnz	short loc_21359
	cmp	word ptr [bp+var_14+2],	dx
	jz	short loc_21367
loc_21359:
	push	word ptr [bp+var_14+2]
	push	word ptr [bp+var_14]
	call	_freeMaybe
	add	sp, 4
loc_21367:
	mov	ax, [bp+var_10]
	jmp	short $+2
loc_2136C:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_doTeleport endp

; Attributes: bp-based frame

_sp_teleportPrintNum proc far

	var_24=	dword ptr -24h
	var_20=	word ptr -20h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	sub	ax, ax
	push	ax
	mov	ax, [bp+arg_0]
	cwd
	push	dx
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2],	dx
	cmp	[bp+arg_2], 0
	jz	short loc_213A8
	lfs	bx, [bp+var_24]
	inc	word ptr [bp+var_24]
	mov	byte ptr fs:[bx], '<'
loc_213A8:
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	mov	gs:byte_42419, 30h 
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	sub_16595
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_sp_teleportPrintNum endp