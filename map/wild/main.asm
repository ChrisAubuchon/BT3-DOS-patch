; Attributes: bp-based frame

wild_main proc far

	var_4A=	dword ptr -48h
	inKey=	word ptr -44h
	levelName= word	ptr -42h
	square=	word ptr -32h
	levelP=	dword ptr -30h
	var_2C=	word ptr -2Ch
	var_2A=	word ptr -2Ah
	var_28=	word ptr -28h
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(48h)
	push	si

	mov	word ptr [bp+levelP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+levelP+2],	seg seg022

	call	far ptr j_nullsub_3

	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	g_locationNumber
	CALL(map_read)

	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+map_t.levFlags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	push	ax
	CALL(map_readGraphics)

	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+map_t.monsterIndex]
	sub	ah, ah
	push	ax
	CALL(map_readMonsters)

	PUSH_STACK_ADDRESS(levelName)
	PUSH_STACK_DWORD(levelP)
	CALL(unmaskString)

	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+map_t.levFlags]
	and	al, 7
	mov	g_levelNumber, al
	mov	al, fs:[bx+map_t._width]
	mov	gs:mapWidth, al
	mov	al, fs:[bx+map_t._height]
	mov	gs:mapHeight, al
	mov	al, fs:[bx+map_t.wrapFlag]
	and	al, 2
	mov	gs:g_wildWrapFlag, al
	mov	gs:mapDataOff, map_t.rowOffset
	mov	gs:mapDataSeg, seg seg022
	mov	[bp+var_2C], 0
	mov	dl, mapHeight
	sub	dh, dh

l_rowPopLoop_start:
	cmp	dx, [bp+var_2C]
	jbe	short l_rowPopLoop_exit
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
	jmp	short l_rowPopLoop_start

l_rowPopLoop_exit:
	mov	gs:mapDataOff, map_t.dataOffset
	mov	gs:mapDataSeg, seg seg022

l_loopStart:
	cmp	g_partyAttackFlag, 0
	jnz	short l_battleCheck

	lfs	bx, [bp+levelP]
	test	byte ptr fs:[bx+12h], 1
	jz	short l_mapExecute

	CALL(random)
	test	al, 1Fh
	jnz	short l_mapExecute

	cmp	gs:songAntiMonster, 0
	jnz	short l_mapExecute

l_battleCheck:
	CALL(bat_init)
	or	ax, ax
	jnz	l_returnPartyDied
	CALL(text_clear)

l_mapExecute:
	sub	ax, ax
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	CALL(vm_execute)

loc_10E48:
	cmp	g_mapRval, 0
	jnz	l_returnMapValue

loc_10E5B:
	PUSH_STACK_ADDRESS(levelName)
	CALL(setTitle)

	push	g_sqNorth
	push	g_sqEast
	CALL(wild_buildView)
	mov	[bp+square], ax

	mov	ax, 0A000h
	push	ax
	CALL(getKey)
	mov	[bp+var_2], ax

	push	ax
	CALL(executeKeyboardCommand)
	mov	[bp+inKey], ax
	or	ax, ax
	jz	short loc_10EEE

	mov	byte ptr g_printPartyFlag, 0
	cmp	g_mapRval, 0
	jnz	l_returnMapValue

loc_10EC0:
	push	g_sqNorth
	push	g_sqEast
	CALL(wild_buildView)
	mov	[bp+square], ax

	PUSH_STACK_ADDRESS(levelName)
	CALL(setTitle)
	CALL(text_clear)

loc_10EEE:
	cmp	[bp+inKey], 0
	jnz	loc_10E48

	mov	ax, [bp+var_2]

l_key_upArrow:
	cmp	ax, dosKeys_upArrow
	jnz	l_key_split

l_goForward:
	push	[bp+square]
	CALL(wild_enterBuilding)
	or	ax, ax
	jz	l_noBuilding

	cmp	g_mapRval, 0
	jnz	l_returnMapValue

l_noBuilding:
	push	[bp+square]
	CALL(wild_canAdvance)
	or	ax, ax
	jz	l_loopStart

	CALL(text_clear)
	mov	si, g_direction
	shl	si, 1
	mov	ax, g_sqNorth
	sub	ax, dirDeltaN[si]
	mov	[bp+var_8], ax
	mov	ax, g_sqEast
	add	ax, dirDeltaE[si]
	mov	[bp+var_2A], ax

	test	g_wildWrapFlag, 2
	jz	l_forwardNoWrap

	mov	al, mapHeight
	sub	ah, ah
	push	ax
	push	[bp+var_8]
	CALL(wrapNumber)
	mov	g_sqNorth, ax

	mov	al, mapWidth
	sub	ah, ah
	push	ax
	push	[bp+var_2A]
	CALL(wrapNumber)
	mov	g_sqEast, ax
	jmp	l_loopStart

l_forwardNoWrap:
	cmp	[bp+var_8], 0
	jl	l_loopStart

	mov	al, mapHeight
	sub	ah, ah
	cmp	ax, [bp+var_8]
	jbe	l_loopStart

	cmp	[bp+var_2A], 0
	jl	l_loopStart

	mov	al, mapWidth
	cmp	ax, [bp+var_2A]
	jbe	l_loopStart

	mov	ax, [bp+var_8]
	mov	g_sqNorth, ax
	mov	ax, [bp+var_2A]
	mov	g_sqEast, ax
	jmp	l_loopStart

l_key_split:
	jg	l_checkCenterKey

l_checkLocationKey:
	cmp	ax, '?'
	jnz	l_checkKickKey

	CALL(printLocation)
	jmp	l_loopStart

l_checkKickKey:
	cmp	ax, 'K'
	jz	l_goForward

l_checkQuitKey:
	cmp	ax, 'Q'
	jnz	l_loopStart

	CALL(quitGame)
	or	ax, ax
	jz	l_loopStart
	mov	ax, gameState_quit
	jmp	l_return

l_checkCenterKey:
	cmp	ax, dosKeys_center
	jz	l_goForward

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
	jnz	l_loopStart
	mov	bx, 2

l_incDirFacing:
	mov	ax, g_direction
	add	ax, bx
	and	ax, 3
	mov	g_direction, ax

	PUSH_OFFSET(s_facing)
	PUSH_STACK_ADDRESS(var_28)
	STRCAT

	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	push	word ptr (dirStringList+2)[bx]
	push	word ptr (dirStringList)[bx]
	push	dx
	push	ax
	STRCAT

	PUSH_STACK_ADDRESS(var_28)
	PRINTSTRING(clear)
	jmp	l_loopStart

l_returnMapValue:
	mov	ax, g_mapRval
	jmp	short l_return

l_returnPartyDied:
	mov	ax, gameState_partyDied

l_return:
	pop	si
	FUNC_EXIT
	retf
wild_main endp
