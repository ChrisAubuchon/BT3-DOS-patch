; Attributes: bp-based frame

cleanupAndExit proc far
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	call	song_endMusic
	call	sub_2800B
	sub	ax, ax
	push	ax
	call	far ptr	vid_setMode
	add	sp, 2
	mov	[bp+var_2], 0
	jmp	short loc_1051D
loc_1051A:
	inc	[bp+var_2]
loc_1051D:
	cmp	[bp+var_2], 8
	jge	short loc_10550
	mov	bx, [bp+var_2]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:musicBufs._offset[bx]
	mov	dx, gs:musicBufs._segment[bx]
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
	or	ax, dx
	jz	short loc_1054E
	push	dx
	push	[bp+var_6]
	call	_freeMaybe
	add	sp, 4
loc_1054E:
	jmp	short loc_1051A
loc_10550:
	mov	ax, 1
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
cleanupAndExit endp

; Attributes: bp-based frame

sub_10560 proc far
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	far ptr j_nullsub_3
loc_1056F:
	cmp	[bp+arg_0], 0FFh
	jz	short loc_105DE
	mov	buildingRvalMaybe, 0
	mov	ax, [bp+arg_0]
	jmp	short loc_105C6
loc_10586:
	call	camp_enter
	mov	[bp+arg_0], ax
	jmp	short loc_105DC
loc_10590:
	push	cs
	call	near ptr wildMainLoop
	mov	[bp+arg_0], ax
	jmp	short loc_105DC
loc_10599:
	mov	inDungeonMaybe, 1
	push	cs
	call	near ptr dunMainLoop
	mov	[bp+arg_0], ax
	mov	inDungeonMaybe, 0
	jmp	short loc_105DC
loc_105B8:
	call	partyDied
	mov	[bp+arg_0], ax
	jmp	short loc_105DC
loc_105C2:
	jmp	short loc_105DE
	jmp	short loc_105DC
loc_105C6:
	cmp	ax, 1
	jz	short loc_10586
	cmp	ax, 2
	jz	short loc_10590
	cmp	ax, 4
	jz	short loc_10599
	cmp	ax, 5
	jz	short loc_105B8
	jmp	short loc_105C2
loc_105DC:
	jmp	short loc_1056F
loc_105DE:
	mov	sp, bp
	pop	bp
	retf
sub_10560 endp

; Attributes: bp-based frame

dunMainLoop proc far

	var_26=	dword ptr -26h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	levP= dword ptr	-4

	func_enter
	_chkstk		26h
	push	si

	mov	word ptr [bp+levP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+levP+2], seg seg022

	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, dunLevelIndex
	add	ax, 10
	push	ax
	CALL(map_read)
	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t.levFlags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	add	ax, 3
	mov	[bp+var_22], ax
	push	ax
	CALL(map_readGraphics)
	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t.monIndex]
	sub	ah, ah
	push	ax
	CALL(map_readMonsters)

	push_ss_string	var_1E
	push_ptr_stack	levP
	std_call	unmaskString, 8

	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t._width]
	mov	g_dunWidth, al
	mov	al, fs:[bx+dun_t._height]
	mov	g_dunHeight, al
	mov	al, fs:[bx+dun_t.levelNum]
	sub	ah, ah
	mov	dunLevelNum,	ax
	mov	al, fs:[bx+dun_t.levFlags]
	mov	levFlags, al
	and	al, 7
	mov	levelNoMaybe, al
	cmp	gs:levelChangedFlag, 0
	jz	short loc_dunMainLoop_skipDeltaSQEN

	; Add deltaSqN and deltaSqE to sq_north and sq_east
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	sub	sq_north, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	sub	sq_east, ax
	mov	gs:levelChangedFlag, 0

loc_dunMainLoop_skipDeltaSQEN:
	mov	ax, bx
	mov	dx, word ptr [bp+levP+2]
	add	ax, 24h	
	mov	gs:mapDataOff, ax
	mov	gs:mapDataSeg, dx
	mov	[bp+var_C], 0
	mov	dl, g_dunHeight
	sub	dh, dh

loc_dunMainLoop_popRowLoop_enter:
	cmp	dx, [bp+var_C]
	jbe	short loc_dunMainLoop_popRowLoop_exit
	mov	ax, [bp+var_C]
	shl	ax, 1
	add	ax, gs:mapDataOff
	mov	word ptr [bp+var_26], ax
	mov	ax, gs:mapDataSeg
	mov	word ptr [bp+var_26+2],	ax
	lfs	bx, [bp+var_26]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, 0
	mov	bx, [bp+var_C]
	shl	bx, 1
	shl	bx, 1
	mov	word ptr gs:rowOffset[bx], ax
	mov	word ptr gs:(rowOffset+2)[bx], seg seg022
	inc	[bp+var_C]
	jmp	short loc_dunMainLoop_popRowLoop_enter

loc_dunMainLoop_popRowLoop_exit::
	mov	ax, word ptr [bp+levP]
	mov	dx, word ptr [bp+levP+2]
	add	ax, 22h	
	mov	gs:mapDataOff, ax
	mov	gs:mapDataSeg, dx

loc_dunMainLoop_wander_check:
	call	random
	test	al, 0FCh
	jnz	short loc_dunMainLoop_battleCheck
	call	dun_wanderingCreature

loc_dunMainLoop_battleCheck:
	cmp	partyAttackFlag, 0
	jnz	short loc_dunMainLoop_doBattle
	cmp	byte_4EECC, 0
	jnz	short loc_dunMainLoop_doBattle
	call	random
	test	al, 3Fh
	jnz	short loc_107BE
	cmp	gs:byte_42296, 0FFh
	jz	short loc_107BE
	cmp	gs:songAntiMonster, 0
	jnz	short loc_107BE

loc_dunMainLoop_doBattle:
	call	bat_init
	or	ax, ax
	jz	short loc_107B9
	mov	ax, 5
	jmp	loc_dunMainLoop_exit

loc_107B9:
	call	text_clear

loc_107BE:
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	std_call	dun_doSpecialSquare, 8

	push	seg023_x
	push	offset graphicsBuf
	push	sq_north
	push	sq_east
	std_call	dun_buildView, 8
	mov	[bp+var_E], ax

	push	dirFacing
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	std_call	sub_10B3D, 0Eh

	push	dirFacing
	push	sq_north
	push	sq_east
	std_call	dun_detectSquares,6

	push_ss_string	var_1E
	std_call	setTitle, 4

	sub	ax, ax
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	std_call	map_execute, 6
loc_10886:
	cmp	buildingRvalMaybe, 0
	jz	short loc_10899
	mov	ax, buildingRvalMaybe
	jmp	loc_dunMainLoop_exit
loc_10899:
	mov	ax, 0A000h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	push	ax
	std_call	executeKeyboardCommand, 2
	mov	[bp+var_20], ax
	or	ax, ax
	jz	short loc_1090B
	mov	byte ptr g_printPartyFlag,	0
	cmp	buildingRvalMaybe, 0
	jnz	loc_dunMainLoop_return_bldg_rval
loc_108D5:
	push	seg023_x
	mov	ax, offset graphicsBuf
	push	ax
	push	sq_north
	push	sq_east
	std_call	dun_buildView, 8
	mov	[bp+var_E], ax
	push_ss_string	var_1E
	std_call	setTitle, 4
	call	text_clear
loc_1090B:
	cmp	[bp+var_20], 0
	jnz	short loc_10886
	mov	ax, [bp+var_6]

loc_dunMainLoop_key_Q:
	cmp	ax, 'Q'
	jnz	loc_dunMainLoop_key_split

	call	quitGame
	or	ax, ax
	jz	loc_dunMainLoop_buildingRvalMaybe_check

	mov	ax, 0FFh
	jmp	loc_dunMainLoop_exit

loc_dunMainLoop_key_split:
	jg	short loc_dunMainLoop_key_W

loc_dunMainLoop_key_qmark:
	cmp	ax, '?'
	jnz	loc_dunMainLoop_key_E

	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	std_call	minimap_show, 0Ch
	jmp	loc_dunMainLoop_buildingRvalMaybe_check

loc_dunMainLoop_key_E:
	cmp	ax, 'E'
	jnz	loc_dunMainLoop_key_K

	push	sq_north
	push	sq_east
	std_call	dun_ascendPortal, 4
	jmp	loc_dunMainLoop_buildingRvalMaybe_check

loc_dunMainLoop_key_K:
	cmp	ax, 'K'
	jnz	loc_dunMainLoop_buildingRvalMaybe_check
	jmp	loc_dunMainLoop_go_forward
	
loc_dunMainLoop_key_W:
	cmp	ax, 'W'
	jnz	loc_dunMainLoop_key_upArrow

	push	sq_north
	push	sq_east
	std_call	dun_descendPortal, 4
	jmp	loc_dunMainLoop_buildingRvalMaybe_check

loc_dunMainLoop_key_upArrow:
	cmp	ax, dosKeys_upArrow
	jnz	loc_dunMainLoop_key_leftArrow
	
loc_dunMainLoop_go_forward:
	push_imm	1
	push	[bp+var_E]
	std_call	dun_goForwardCheck, 4
	or	ax, ax
	jz	loc_dunMainLoop_buildingRvalMaybe_check
	call	text_clear
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+var_8], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+var_A], ax

	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	push	[bp+var_8]
	std_call	wrapNumber, 4

	mov	sq_north, ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+var_A]
	std_call	wrapNumber ,4
	mov	sq_east, ax
	mov	gs:wallIsPhased, 0
	jmp	loc_dunMainLoop_buildingRvalMaybe_check

loc_dunMainLoop_key_leftArrow:
	cmp	ax, dosKeys_leftArrow
	jnz	loc_dunMainLoop_key_rightArrow
	mov	bx, 3
	jmp	loc_dunMainLoop_incDirFacing

loc_dunMainLoop_key_rightArrow:
	cmp	ax, dosKeys_rightArrow
	jnz	loc_dunMainLoop_key_downArrow
	mov	bx, 1
	jmp	loc_dunMainLoop_incDirFacing

loc_dunMainLoop_key_downArrow:
	cmp	ax, dosKeys_downArrow
	jnz	loc_dunMainLoop_buildingRvalMaybe_check
	mov	bx, 2

loc_dunMainLoop_incDirFacing:
	mov	ax, dirFacing
	add	ax, bx
	and	ax, 3
	mov	dirFacing, ax
	mov	gs:wallIsPhased, 0
	call	text_clear

loc_dunMainLoop_buildingRvalMaybe_check:
	cmp	buildingRvalMaybe, 0
	jz	loc_dunMainLoop_wander_check

loc_dunMainLoop_return_bldg_rval:
	mov	ax, buildingRvalMaybe

loc_dunMainLoop_exit:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dunMainLoop endp

; Attributes: bp-based frame

sub_10B3D proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	rowBuf=	dword ptr  6
	sqE= word ptr  0Ah
	sqN= word ptr  0Ch
	_width=	word ptr  0Eh
	_height= word ptr  10h
	_dirFacing= word ptr  12h

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	bx, [bp+sqE]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	or	byte ptr fs:[bx+si+4], 9
	mov	[bp+var_6], 0
	jmp	short loc_10B74
loc_10B71:
	inc	[bp+var_6]
loc_10B74:
	mov	al, lightDistance
	sub	ah, ah
	cmp	ax, [bp+var_6]
	ja	short loc_10B86
	jmp	loc_10C1E
loc_10B86:
	push	[bp+sqN]
	push	[bp+sqE]
	push	cs
	call	near ptr dun_getWalls
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, [bp+_dirFacing]
	dec	ax
	push	ax
	push	[bp+var_2]
	call	dungeon_getWallInDirection
	add	sp, 4
	mov	[bp+var_4], ax
	mov	bx, ax
	and	bx, 0Fh
	cmp	byte_44354[bx], 0
	jz	short loc_10BBC
	jmp	short loc_10C1E
loc_10BBC:
	push	[bp+_width]
	mov	bx, [bp+_dirFacing]
	shl	bx, 1
	mov	ax, dirDeltaE[bx]
	add	ax, [bp+sqE]
	push	ax
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqE], ax
	push	[bp+_height]
	mov	ax, [bp+sqN]
	mov	bx, [bp+_dirFacing]
	shl	bx, 1
	sub	ax, dirDeltaN[bx]
	push	ax
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqN], ax
	mov	bx, [bp+sqE]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	or	byte ptr fs:[bx+si+4], 1
	jmp	loc_10B71
loc_10C1E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_10B3D endp

; Attributes: bp-based frame

dun_goForwardCheck proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	func_enter

	cmp	gs:stuckFlag, 0
	jz	short loc_dun_goForwardCheck_not_stuck
	call	text_clear

	push_ds_string	aStuckElipsis
	func_printString
	jmp	loc_dun_goForwardCheck_return_zero

loc_dun_goForwardCheck_not_stuck:
	mov	ax, [bp+arg_0]
	mov	cl, 4
	shr	ax, cl
	and	ax, 0Fh
	mov	bx, ax
	mov	al, byte_44344[bx]
	sub	ah, ah

	or	ax, ax
	jz	loc_dun_goForwardCheck_success

loc_dun_goForwardCheck_not_zero:
	cmp	ax, 1
	jb	loc_dun_goForwardCheck_return_zero

	cmp	ax, 2
	jg	loc_dun_goForwardCheck_return_zero

	cmp	[bp+arg_2], 0
	jz	loc_dun_goForwardCheck_return_zero

loc_dun_goForwardCheck_success:
	mov	word_4EE66, 0
	call	text_clear
	mov	ax, 1
	jmp	loc_dun_goForwardCheck_exit
	
loc_dun_goForwardCheck_return_zero:
	xor	ax, ax

loc_dun_goForwardCheck_exit:
	func_exit
	retf
dun_goForwardCheck endp

; Attributes: bp-based frame

wildMainLoop proc far

	var_4A=	dword ptr -4Ah
	var_46=	word ptr -46h
	var_44=	word ptr -44h
	levelName= word	ptr -42h
	square=	word ptr -32h
	var_30=	dword ptr -30h
	var_2C=	word ptr -2Ch
	var_2A=	word ptr -2Ah
	var_28=	word ptr -28h
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4Ah	
	call	someStackOperation
	push	si
	mov	word ptr [bp+var_30], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_30+2],	seg seg022
	call	far ptr j_nullsub_3
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	currentLocationMaybe
	call	map_read
	add	sp, 6
	lfs	bx, [bp+var_30]
	mov	al, fs:[bx+map_t.levFlags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	mov	[bp+var_46], ax
	push	ax
	call	map_readGraphics
	add	sp, 2
	lfs	bx, [bp+var_30]
	mov	al, fs:[bx+map_t.monsterIndex]
	sub	ah, ah
	push	ax
	call	map_readMonsters
	add	sp, 2
	lea	ax, [bp+levelName]
	push	ss
	push	ax
	push	word ptr [bp+var_30+2]
	push	word ptr [bp+var_30]
	call	unmaskString
	add	sp, 8
	lfs	bx, [bp+var_30]
	mov	al, fs:[bx+map_t.levFlags]
	and	al, 7
	mov	levelNoMaybe, al
	mov	al, fs:[bx+map_t._width]
	mov	gs:mapWidth, al
	mov	al, fs:[bx+map_t._height]
	mov	gs:mapHeight, al
	mov	al, fs:[bx+map_t.wrapFlag]
	and	al, 2
	mov	gs:wildWrapFlag, al
	mov	gs:mapDataOff, map_t.rowOffset
	mov	gs:mapDataSeg, seg seg022
	mov	[bp+var_2C], 0
	mov	dl, mapHeight
	sub	dh, dh

loc_wildMainLoop_rowPopLoop_start:
	cmp	dx, [bp+var_2C]
	jbe	short loc_wildMainLoop_rowPopLoop_exit
	mov	ax, [bp+var_2C]
	shl	ax, 1
	add	ax, gs:mapDataOff
	mov	word ptr [bp+var_4A], ax
	mov	ax, gs:mapDataSeg
	mov	word ptr [bp+var_4A+2],	ax
	lfs	bx, [bp+var_4A]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, 0
	mov	bx, [bp+var_2C]
	shl	bx, 1
	shl	bx, 1
	mov	word ptr gs:rowOffset[bx], ax
	mov	word ptr gs:(rowOffset+2)[bx], seg seg022
	inc	[bp+var_2C]
	jmp	short loc_wildMainLoop_rowPopLoop_start

loc_wildMainLoop_rowPopLoop_exit:
	mov	gs:mapDataOff, map_t.dataOffset
	mov	gs:mapDataSeg, seg seg022

loc_wildMainLoop_loopStart:
	cmp	partyAttackFlag, 0
	jnz	short loc_wildMainLoop_battleCheck
	lfs	bx, [bp+var_30]
	test	byte ptr fs:[bx+12h], 1
	jz	short loc_wildMainLoop_mapExecute
	call	random
	test	al, 1Fh
	jnz	short loc_wildMainLoop_mapExecute
	cmp	gs:songAntiMonster, 0
	jnz	short loc_wildMainLoop_mapExecute

loc_wildMainLoop_battleCheck:
	call	bat_init
	or	ax, ax
	jz	short loc_10E17
	mov	ax, 5
	jmp	loc_wildMainLoop_exit

loc_10E17:
	call	text_clear

loc_wildMainLoop_mapExecute:
	sub	ax, ax
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	std_call	map_execute, 6

loc_10E48:
	cmp	buildingRvalMaybe, 0
	jnz	loc_wildMainLoop_return_bldg_rval

loc_10E5B:
	push_ss_string	levelName
	std_call	setTitle, 4

	push	sq_north
	push	sq_east
	std_call	 bigpic_buildViewMaybe, 4
	mov	[bp+square], ax

	mov	ax, 0A000h
	push	ax
	std_call	getKey, 2
	mov	[bp+var_2], ax

	push	ax
	std_call	executeKeyboardCommand, 2
	mov	[bp+var_44], ax
	or	ax, ax
	jz	short loc_10EEE
	mov	byte ptr g_printPartyFlag, 0
	cmp	buildingRvalMaybe, 0
	jnz	loc_wildMainLoop_return_bldg_rval

loc_10EC0:
	push	sq_north
	push	sq_east
	std_call	bigpic_buildViewMaybe, 4
	mov	[bp+square], ax

	push_ss_string levelName
	std_call	setTitle, 4
	call	text_clear

loc_10EEE:
	cmp	[bp+var_44], 0
	jnz	loc_10E48

	mov	ax, [bp+var_2]

loc_wildMainLoop_key_upArrow:
	cmp	ax, dosKeys_upArrow
	jnz	loc_wildMainLoop_key_split

loc_wildMainLoop_goForward:
	push	[bp+square]
	std_call	map_enterBuilding, 2
	or	ax, ax
	jz	loc_wildMainLoop_exitBuilding
	cmp	buildingRvalMaybe, 0
	jnz	loc_wildMainLoop_return_bldg_rval

loc_wildMainLoop_exitBuilding:
	push	[bp+square]
	std_call	wild_goForwardCheck, 2
	or	ax, ax
	jz	loc_wildMainLoop_loopStart

	call	text_clear
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+var_8], ax
	mov	ax, sq_east
	add	ax, dirDeltaE[si]
	mov	[bp+var_2A], ax

	test	wildWrapFlag, 2
	jz	loc_wildMainLoop_forward_nowrap

	mov	al, mapHeight
	sub	ah, ah
	push	ax
	push	[bp+var_8]
	std_call	wrapNumber, 4
	mov	sq_north, ax

	mov	al, mapWidth
	sub	ah, ah
	push	ax
	push	[bp+var_2A]
	std_call	wrapNumber, 4
	mov	sq_east, ax
	jmp	loc_wildMainLoop_loopStart

loc_wildMainLoop_forward_nowrap:
	cmp	[bp+var_8], 0
	jl	loc_wildMainLoop_loopStart

	mov	al, mapHeight
	sub	ah, ah
	cmp	ax, [bp+var_8]
	jbe	loc_wildMainLoop_loopStart

	cmp	[bp+var_2A], 0
	jl	loc_wildMainLoop_loopStart

	mov	al, mapWidth
	cmp	ax, [bp+var_2A]
	jbe	loc_wildMainLoop_loopStart

	mov	ax, [bp+var_8]
	mov	sq_north, ax
	mov	ax, [bp+var_2A]
	mov	sq_east, ax
	jmp	loc_wildMainLoop_loopStart

loc_wildMainLoop_key_split:
	jg	loc_wildMainLoop_key_center

loc_wildMainLoop_key_qmark:
	cmp	ax, '?'
	jnz	loc_wildMainLoop_key_K

	call	printLocation
	jmp	loc_wildMainLoop_loopStart

loc_wildMainLoop_key_K:
	cmp	ax, 'K'
	jz	loc_wildMainLoop_goForward

loc_wildMainLoop_key_Q:
	cmp	ax, 'Q'
	jnz	loc_wildMainLoop_loopStart

	call	quitGame
	or	ax, ax
	jz	loc_wildMainLoop_loopStart
	mov	ax, 0FFh
	jmp	loc_wildMainLoop_exit

loc_wildMainLoop_key_center:
	cmp	ax, 4C00h
	jz	loc_wildMainLoop_goForward

loc_wildMainLoop_key_leftArrow:
	cmp	ax, dosKeys_leftArrow
	jnz	loc_wildMainLoop_key_rightArrow
	mov	bx, 3
	jmp	loc_wildMainLoop_incDirFacing

loc_wildMainLoop_key_rightArrow:
	cmp	ax, dosKeys_rightArrow
	jnz	loc_wildMainLoop_key_downArrow
	mov	bx, 1
	jmp	loc_wildMainLoop_incDirFacing

loc_wildMainLoop_key_downArrow:
	cmp	ax, dosKeys_downArrow
	jnz	loc_wildMainLoop_loopStart
	mov	bx, 2

loc_wildMainLoop_incDirFacing:
	mov	ax, dirFacing
	add	ax, bx
	and	ax, 3
	mov	dirFacing, ax

	push_ds_string aFacing
	push_ss_string var_28
	STRCAT

	mov	bx, dirFacing
	shl	bx, 1
	shl	bx, 1
	push_ptr_stringList	dirStringList, bx
	push	dx
	push	ax
	STRCAT

	push_ss_string	var_28
	std_call	printStringWClear, 4
	jmp	loc_wildMainLoop_loopStart

loc_wildMainLoop_return_bldg_rval:
	mov	ax, buildingRvalMaybe

loc_wildMainLoop_exit:
	pop	si
	mov	sp, bp
	pop	bp
	retf
wildMainLoop endp

; Attributes: bp-based frame

wild_goForwardCheck proc far

	arg_0= byte ptr	 6

	func_enter

	test	[bp+arg_0], 0F0h
	jz	loc_wild_goForwardCheck_return_one

	mov	al, [bp+arg_0]
	and	al, 0F0h
	cmp	al, 0E0h
	jz	loc_wild_goForwardCheck_return_zero
	mov	al, [bp+arg_0]
	and	al, 0F0h
	cmp	al, 0F0h
	jz	loc_wild_goForwardCheck_return_one
	mov	al, [bp+arg_0]
	and	al, 0Fh
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	loc_wild_goForwardCheck_exit

loc_wild_goForwardCheck_return_zero:
	xor	ax, ax
	jmp	loc_wild_goForwardCheck_exit

loc_wild_goForwardCheck_return_one:
	mov	ax, 1

loc_wild_goForwardCheck_exit:
	func_exit
	retf

wild_goForwardCheck endp

; Attributes: bp-based frame

map_enterBuilding proc far

	square=	word ptr  6

	func_enter
	mov	ax, [bp+square]
	mov	cl, 4
	sar	ax, cl
	and	ax, 0Fh

	sub	ax, 1
	cmp	ax, 8
	ja	loc_map_enterBuilding_return_zero
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_111EF[bx]
off_111EF dw offset l_camp ; 0x10
dw offset l_tavern	; 0x20
dw offset l_temple	; 0x30
dw offset l_normalBuilding ; 0x40
dw offset loc_map_enterBuilding_return_zero	; 0x50
dw offset l_storageBuilding ; 0x60
dw offset l_reviewBoard	; 0x70
dw offset l_hallOfWizards	; 0x80
dw offset l_bards		; 0x90

l_camp:
	call	camp_enter
	jmp	loc_map_enterBuilding_turn_around
l_tavern:
	call	tav_enter
	jmp	loc_map_enterBuilding_turn_around
l_temple:
	call	temple_enter
	jmp	loc_map_enterBuilding_turn_around
l_normalBuilding:
	call	empty_enter
	jmp	loc_map_enterBuilding_turn_around
l_storageBuilding:
	call	storage_enter
	jmp	loc_map_enterBuilding_turn_around
l_reviewBoard:
	call	rev_enter
	jmp	loc_map_enterBuilding_turn_around
l_hallOfWizards:
	call	enterHallOfWizards
	jmp	loc_map_enterBuilding_turn_around
l_bards:
	call	bards_enter
	jmp	loc_map_enterBuilding_turn_around

loc_map_enterBuilding_return_zero:
	sub	ax, ax
	jmp	short loc_map_enterBuilding_exit

loc_map_enterBuilding_turn_around:
	mov	buildingRvalMaybe, ax
	call	map_turnPartyAround
	mov	ax, 1

loc_map_enterBuilding_exit:
	func_exit
	retf
map_enterBuilding endp

; Attributes: bp-based frame

bigpic_buildViewMaybe proc far

	var_3E=	dword ptr -3Eh
	var_3A=	word ptr -3Ah
	var_38=	word ptr -38h
	counter= word ptr -36h
	deltaNorth= word ptr -34h
	viewMaybe= byte	ptr -32h
	var_22=	byte ptr -22h
	deltaEast= word	ptr -1Ch
	gbuf= word ptr -1Ah
	gseg= word ptr -18h
	var_2= word ptr	-2
	sqEast=	word ptr  6
	sqNorth= word ptr  8

	func_enter
	_chkstk		3Eh
	push	si
	mov	[bp+gbuf], offset graphicsBuf
	mov	[bp+gseg], seg seg023
	mov	bx, dirFacing
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr off_44268[bx]
	mov	dx, word ptr (off_44268+2)[bx]
	mov	[bp+var_3A], ax
	mov	[bp+var_38], dx
	mov	[bp+counter], 20
	jmp	short loc_11246
loc_11243:
	dec	[bp+counter]
loc_11246:
	cmp	[bp+counter], 0
	jl	short loc_11288
	mov	ax, [bp+counter]
	shl	ax, 1
	add	ax, [bp+var_3A]
	mov	dx, [bp+var_38]
	mov	word ptr [bp+var_3E], ax
	mov	word ptr [bp+var_3E+2],	dx
	lfs	bx, [bp+var_3E]
	mov	al, fs:[bx]
	cbw
	add	ax, [bp+sqEast]
	mov	[bp+deltaEast],	ax
	mov	al, fs:[bx+1]
	cbw
	add	ax, [bp+sqNorth]
	mov	[bp+deltaNorth], ax
	push	ax
	push	[bp+deltaEast]
	push	cs
	call	near ptr wild_getSquare
	add	sp, 4
	mov	si, [bp+counter]
	mov	[bp+si+viewMaybe], al
	jmp	short loc_11243
loc_11288:
	mov	ax, 44h
	push	ax
	mov	ax, 0BBBBh
	push	ax
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	bigpicmemcpy
	add	sp, 8
	mov	[bp+counter], 0
	jmp	short loc_112AA
loc_112A7:
	inc	[bp+counter]
loc_112AA:
	cmp	[bp+counter], 17
	jge	short loc_112EB
	mov	bx, [bp+counter]
	mov	al, byte_44332[bx]
	cbw
	mov	si, ax
	mov	al, [bp+si+viewMaybe]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_112E9
	push	[bp+gseg]
	push	[bp+gbuf]
	dec	ax
	push	ax
	mov	al, byte_4464A[bx]
	cbw
	push	ax
	call	bigpic_drawTopology
	add	sp, 8
loc_112E9:
	jmp	short loc_112A7
loc_112EB:
	mov	gs:byte_422A0, 0
	cmp	gs:isNight, 0
	jz	short loc_11311
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	bigpic_makeNight
	add	sp, 4
loc_11311:
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	mov	al, [bp+var_22]
	sub	ah, ah
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bigpic_buildViewMaybe endp

; Attributes: bp-based frame

dun_buildView proc far

	var_5C=	dword ptr -5Ch
	deltaP=	dword ptr -58h
	var_54=	word ptr -54h
	counter= word ptr -52h
	var_50=	word ptr -50h
	deltaSqN= word ptr -4Eh
	var_4C=	word ptr -4Ch
	var_1E=	word ptr -1Eh
	deltaSqE= word ptr -8
	var_2= word ptr	-2
	sqE= word ptr  6
	sqN= word ptr  8
	gbufOff= word ptr  0Ah
	gbufSeg= word ptr  0Ch

	push	bp
	mov	bp, sp
	mov	ax, 5Ch	
	call	someStackOperation
	push	si
	mov	bx, dirFacing
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr off_44474[bx]
	mov	dx, word ptr (off_44474+2)[bx]
	mov	word ptr [bp+deltaP], ax
	mov	word ptr [bp+deltaP+2],	dx
	mov	[bp+counter], 24
	jmp	short loc_11372
loc_1136F:
	dec	[bp+counter]
loc_11372:
	cmp	[bp+counter], 0
	jl	short loc_113CB
	mov	ax, [bp+counter]
	shl	ax, 1
	add	ax, word ptr [bp+deltaP]
	mov	dx, word ptr [bp+deltaP+2]
	mov	word ptr [bp+var_5C], ax
	mov	word ptr [bp+var_5C+2],	dx
	lfs	bx, [bp+var_5C]
	mov	al, fs:[bx+viewStruct.deltaEast]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+deltaSqE], ax
	mov	al, fs:[bx+viewStruct.deltaNorth]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+deltaSqN], ax
	push	ax
	push	[bp+deltaSqE]
	push	cs
	call	near ptr dun_getWalls
	add	sp, 4
	mov	[bp+var_50], ax
	push	dirFacing
	push	ax
	call	dungeon_getWallInDirection
	add	sp, 4
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+var_4C],	ax
	jmp	short loc_1136F
loc_113CB:
	mov	[bp+counter], 33
	jmp	short loc_113D5
loc_113D2:
	dec	[bp+counter]
loc_113D5:
	cmp	[bp+counter], 18h
	jle	short loc_11426
	mov	si, [bp+counter]
	shl	si, 1
	lfs	bx, [bp+deltaP]
	mov	al, fs:[bx+si]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+deltaSqE], ax
	mov	al, fs:[bx+si+1]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+deltaSqN], ax
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	[bp+deltaSqN]
	push	[bp+deltaSqE]
	mov	ax, offset rowOffset
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr sub_1156E
	add	sp, 0Ch
	mov	[bp+si+var_4C],	ax
	jmp	short loc_113D2
loc_11426:
	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	call	bigpic_setBackground
	add	sp, 4
	cmp	gs:wallIsPhased, 0
	jz	short loc_11444
	and	byte ptr [bp+var_1E], 0Fh
loc_11444:
	test	levFlags, 20h
	jz	loc_dun_buildView_inDungeon

	mov	ax, 4
	jmp	loc_dun_buildView_loop_preamble

loc_dun_buildView_inDungeon:
	mov	bl, lightDistance
	sub	bh, bh

loc_dun_buildView_loop_preamble:
	mov	al, byte_44494[bx]
	sub	ah, ah
	mov	[bp+counter], ax
	jmp	short loc_11462
loc_1145F:
	inc	[bp+counter]
loc_11462:
	cmp	[bp+counter], 61
	jge	short loc_114C4
	mov	bx, [bp+counter]
	cmp	byte_4460C[bx], 0
	jz	short loc_114C2
	mov	al, byte_44516[bx]
	cbw
	mov	si, ax
	shl	si, 1
	mov	ax, [bp+si+var_4C]
	mov	[bp+var_50], ax
	mov	cl, byte_44554[bx]
	sar	ax, cl
	and	ax, 0Fh
	mov	[bp+var_54], ax
	mov	bx, ax
	mov	al, byte_44484[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_114C2
	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	dec	ax
	push	ax
	push	[bp+counter]
	call	bigpic_drawTopology
	add	sp, 8
loc_114C2:
	jmp	short loc_1145F
loc_114C4:
	mov	gs:byte_422A0, 0
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	mov	ax, [bp+var_1E]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_buildView endp

; Attributes: bp-based frame

dun_getWalls proc far

	var_4= dword ptr -4
	sqE= word ptr  6
	sqN= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqE], ax
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqN], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+sqE]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dun_getWalls endp

; Attributes: bp-based frame

sub_1156E proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	push	[bp+arg_8]
	push	[bp+arg_4]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+arg_4], ax
	push	[bp+arg_A]
	push	[bp+arg_6]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+arg_6], ax
	mov	bx, [bp+arg_4]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+arg_6]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_0]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	mov	al, fs:[bx+si+2]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	mov	cl, 5
	shr	bx, cl
	and	bx, 3
	mov	al, byte_42716[bx]
	cbw
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_1156E endp

; Returns the value at (sqNorth, sqEast)
; This is only called in the wilderness. The dungeon
; levels have 5	bytes per square, this assumes one
; byte.
; Attributes: bp-based frame

wild_getSquare proc far

	sqEast=	word ptr  6
	sqNorth= word ptr  8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	cmp	gs:wildWrapFlag, 0
	jz	short loc_1161D
	mov	al, gs:mapWidth
	sub	ah, ah
	push	ax
	push	[bp+sqEast]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqEast], ax
	mov	al, gs:mapHeight
	sub	ah, ah
	push	ax
	push	[bp+sqNorth]
	push	cs
	call	near ptr wrapNumber
	add	sp, 4
	mov	[bp+sqNorth], ax
	jmp	short loc_11649
loc_1161D:
	cmp	[bp+sqEast], 0
	jl	short loc_11645
	mov	al, gs:mapWidth
	sub	ah, ah
	cmp	ax, [bp+sqEast]
	jbe	short loc_11645
	cmp	[bp+sqNorth], 0
	jl	short loc_11645
	mov	al, gs:mapHeight
	cmp	ax, [bp+sqNorth]
	ja	short loc_11649
loc_11645:
	sub	ax, ax
	jmp	short loc_11663
loc_11649:
	mov	bx, [bp+sqNorth]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, gs:rowOffset[bx]
	mov	si, [bp+sqEast]
	mov	al, fs:[bx+si]
	sub	ah, ah
	jmp	short $+2
loc_11663:
	pop	si
	mov	sp, bp
	pop	bp
	retf
wild_getSquare endp

; This function	returns	arg_0 modd to be between
; 0 and	arg_2. This handles negative numbers
; intuitively.
; Attributes: bp-based frame
wrapNumber proc	far

	arg_0= word ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
loc_11673:
	cmp	[bp+arg_0], 0
	jge	short loc_11682
	mov	al, [bp+arg_2]
	cbw
	add	[bp+arg_0], ax
	jmp	short loc_11673
loc_11682:
	mov	al, [bp+arg_2]
	cbw
	mov	si, ax
	cmp	[bp+arg_0], si
	jl	short loc_11692
	sub	[bp+arg_0], si
	jmp	short loc_11682
loc_11692:
	mov	ax, [bp+arg_0]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
wrapNumber endp

; This function	returns	the memory address of the
; map data at *membuf.
; Attributes: bp-based frame
map_getDataOffsetP proc	far

	memBuf=	dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	lfs	bx, [bp+memBuf]
	mov	bl, fs:[bx]
	sub	bh, bh
	mov	si, word ptr [bp+memBuf]
	mov	si, fs:[si+1]
	and	si, 0FFh
	mov	cl, 8
	shl	si, cl
	lea	ax, g_rosterCharacterBuffer[bx+si]
	mov	dx, seg	seg022
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
map_getDataOffsetP endp

; Attributes: bp-based frame

sub_116CC proc far
	push	bp
	mov	bp, sp
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	dirFacing, 0
	mov	currentLocationMaybe, 0
	mov	sp, bp
	pop	bp
	retf
sub_116CC endp


sub_11706 proc far
	push	bp
	mov	bp, sp
	mov	bx, [bp+8]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+6]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_11706 endp
