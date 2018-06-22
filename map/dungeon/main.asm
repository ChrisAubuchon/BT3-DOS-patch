; Attributes: bp-based frame

dun_main proc far

	var_26=	dword ptr -24h
	var_20=	word ptr -20h
	dungeonName=	word ptr -1Eh
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	inKey= word ptr	-6
	levP= dword ptr	-4

	FUNC_ENTER(24h)
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
	push	ax
	CALL(map_readGraphics)

	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t.monIndex]
	sub	ah, ah
	push	ax
	CALL(map_readMonsters)

	PUSH_STACK_ADDRESS(dungeonName)
	PUSH_STACK_DWORD(levP)
	CALL(unmaskString)

	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t._width]
	mov	g_dunWidth, al
	mov	al, fs:[bx+dun_t._height]
	mov	g_dunHeight, al
	mov	al, fs:[bx+dun_t.levelNum]
	sub	ah, ah
	mov	g_dunLevelNum,	ax
	mov	al, fs:[bx+dun_t.levFlags]
	mov	g_levelFlags, al
	and	al, 7
	mov	g_levelNumber, al

	cmp	gs:levelChangedFlag, 0
	jz	short l_skipDeltaSQEN

	; Add deltaSqN and deltaSqE to sq_north and sq_east
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	sub	sq_north, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	sub	sq_east, ax
	mov	gs:levelChangedFlag, 0

l_skipDeltaSQEN:
	mov	ax, bx
	mov	dx, word ptr [bp+levP+2]
	add	ax, 24h	
	mov	gs:mapDataOff, ax
	mov	gs:mapDataSeg, dx
	mov	[bp+var_C], 0
	mov	dl, g_dunHeight
	sub	dh, dh

l_popRowLoop_enter:
	cmp	dx, [bp+var_C]
	jbe	short l_popRowLoop_exit
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
	jmp	short l_popRowLoop_enter

l_popRowLoop_exit::
	mov	ax, word ptr [bp+levP]
	mov	dx, word ptr [bp+levP+2]
	add	ax, 22h	
	mov	gs:mapDataOff, ax
	mov	gs:mapDataSeg, dx

l_wander_check:
	CALL(random)
	test	al, 0FCh
	jnz	short l_battleCheck
	CALL(dun_wanderingCreature)

l_battleCheck:
	cmp	g_partyAttackFlag, 0
	jnz	short l_doBattle

	cmp	byte_4EECC, 0
	jnz	short l_doBattle

	CALL(random)
	test	al, 3Fh
	jnz	short loc_107BE

	cmp	gs:byte_42296, 0FFh
	jz	short loc_107BE

	cmp	gs:songAntiMonster, 0
	jnz	short loc_107BE

l_doBattle:
	CALL(bat_init)
	or	ax, ax
	jnz	l_returnPartyDied
	CALL(text_clear)

loc_107BE:
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	CALL(dun_doSpecialSquare)

	push	seg023_x
	push	offset graphicsBuf
	push	sq_north
	push	sq_east
	CALL(dun_buildView)
	mov	[bp+var_E], ax

	push	g_direction
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	CALL(dun_setSquareField4)

	push	g_direction
	push	sq_north
	push	sq_east
	CALL(dun_detectSquares)

	PUSH_STACK_ADDRESS(dungeonName)
	CALL(setTitle)

	sub	ax, ax
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	CALL(vm_execute)

l_ioLoop:
	cmp	g_mapRval, 0
	jnz	l_returnMapValue

	mov	ax, 0A000h
	push	ax
	CALL(getKey)
	mov	[bp+inKey], ax

	push	ax
	CALL(executeKeyboardCommand)
	mov	[bp+var_20], ax

	or	ax, ax
	jz	short loc_1090B

	mov	byte ptr g_printPartyFlag,	0

	cmp	g_mapRval, 0
	jnz	l_returnMapValue

loc_108D5:
	push	seg023_x
	mov	ax, offset graphicsBuf
	push	ax
	push	sq_north
	push	sq_east
	CALL(dun_buildView)
	mov	[bp+var_E], ax

	PUSH_STACK_ADDRESS(dungeonName)
	CALL(setTitle)
	CALL(text_clear)

loc_1090B:
	cmp	[bp+var_20], 0
	jnz	short l_ioLoop
	mov	ax, [bp+inKey]

l_checkQuitKey:
	cmp	ax, 'Q'
	jnz	l_checkKeySplit

	CALL(quitGame)
	or	ax, ax
	jz	l_checkMapValue

	mov	ax, gameState_quit
	jmp	l_return

l_checkKeySplit:
	jg	short l_checkDescendKey

l_checkMinimapKey:
	cmp	ax, '?'
	jnz	l_checkAscendKey

	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	al, g_dunWidth
	push	ax
	push	sq_north
	push	sq_east
	push	seg027_x
	push	offset rowOffset
	CALL(minimap_show)
	jmp	l_checkMapValue

l_checkAscendKey:
	cmp	ax, 'E'
	jnz	l_checkKickKey

	push	sq_north
	push	sq_east
	CALL(dun_ascendPortal)
	jmp	l_checkMapValue

l_checkKickKey:
	cmp	ax, 'K'
	jnz	l_checkMapValue
	jmp	l_moveForward
	
l_checkDescendKey:
	cmp	ax, 'W'
	jnz	l_checkForwardKey

	push	sq_north
	push	sq_east
	CALL(dun_descendPortal)
	jmp	l_checkMapValue

l_checkForwardKey:
	cmp	ax, dosKeys_upArrow
	jnz	l_checkLeftArrowKey
	
l_moveForward:
	mov	ax, 1
	push	ax
	push	[bp+var_E]
	CALL(dun_canAdvance)
	or	ax, ax
	jz	l_checkMapValue

	CALL(text_clear)
	mov	si, g_direction
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
	CALL(wrapNumber)

	mov	sq_north, ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+var_A]
	CALL(wrapNumber)
	mov	sq_east, ax
	mov	gs:wallIsPhased, 0
	jmp	l_checkMapValue

l_checkLeftArrowKey:
	cmp	ax, dosKeys_leftArrow
	jnz	l_checkRightArrowKey
	mov	bx, 3
	jmp	l_incDirFacing

l_checkRightArrowKey:
	cmp	ax, dosKeys_rightArrow
	jnz	l_checkDownArrowKey
	mov	bx, 1
	jmp	l_incDirFacing

l_checkDownArrowKey:
	cmp	ax, dosKeys_downArrow
	jnz	l_checkMapValue
	mov	bx, 2

l_incDirFacing:
	mov	ax, g_direction
	add	ax, bx
	and	ax, 3
	mov	g_direction, ax
	mov	gs:wallIsPhased, 0
	CALL(text_clear)

l_checkMapValue:
	cmp	g_mapRval, 0
	jz	l_wander_check

l_returnMapValue:
	mov	ax, g_mapRval
	jmp	short l_return

l_returnPartyDied:
	mov	ax, gameState_partyDied

l_return:
	pop	si
	FUNC_EXIT
	retf
dun_main endp
