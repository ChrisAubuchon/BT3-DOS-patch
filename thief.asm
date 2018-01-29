include struct.h
include enums.h
include macros.h

; TODO
;
;


; Still Testing
;

; DONE
;
; Make monster breathe
; Fix monster special attack
; Divine intervention doesn't convert illusion to real monster
; Make the Up Arrow act like it should.
; Fix a bug where if a monster's attack priority is lower than all of the party's attack priorities the monster can't attack.
; Fix Horn of Gods and Wand of Fury.
; Set a maximum negative AC of -50 to match Apple II. Otherwise it can wrap.
; Fix the incorrect saving throw values for monsters in _savingThrowCheck
; Fix the groupSize when a new monster group is created by summoning
; Clear the monHostile flag after the check.
; Fix the dun_monHostile function to affect the party only when there is a monster in the party.
; Call doSummon() with 15h (Black Slayer) 10 times as Tarjan's only attack.
; COSMETIC: Print a blank line between attacks from a breath attack 
; COSMETIC: Print an '!' after the kill string
; COSMETIC: Fix the output of get_Reward if you leave the chest. It skipped over "you recieved 0 pieces of gold"
; Add text casting of spells
; Lights now stay on when hitting an anti-magic square. 
; Fixed Sorcerer Sight spell to detect more than just trap squares.
; Fixed monster rosters for levels. 
; Fizzle spells when cast on an anti-magic square like BT1 and BT2.
; Print full spell name under "Known Spells" screen of a magic user
; Removed wait4IO from dunsq_doTrap
; Made the outdoor levels outdoor. Basically just call a different setBG routine and make lightDistance 4 in dun_buildView
; COSMETIC: Clear the screen after certain actions in dunMainLoop and wildMainLoop. Messages would linger and be confusing.
; COSMETIC: Fixed the spacing of "XX points of damage" in a breath attack
; Add poison damage check to the periodic check loop
; Fixed the drop rate for Harmonic Gems
; Fix HP Regen squares
; Fixed the level of chest traps
; Fix a bug in tavern_talkToBarkeep where the top 16 bits of the gold donated were
;   ignored. So if you tipped 65537, only 1 gold was removed.

.486
;.mmx
.model large

; Segment type: Pure code
seg000 segment byte public 'CODE' use16
        assume cs:seg000
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
        ; Attributes: bp-based frame

_main proc far
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_27=	word ptr  2Dh

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	mov	ax, 55h
	push	ax
	call	bigpic_initBuffers
	add	sp, 2

	sub	ax, ax
	push	ax
	mov	ax, offset s_thiefCfg
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax

	inc	ax
	jnz	short loc_10039
	mov	ax, 4
	push	ax
	call	far ptr sub_28424
	add	sp, 2

loc_10039:
	mov	ax, 6
	push	ax
	mov	ax, offset word_4243A
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
	mov	gs, seg027_x
	push	gs:word_4243E
	call	disk1Swap
	add	sp, 2
	cmp	[bp+arg_0], 1
	jg	short loc_1007E
	cmp	gs:word_4243A, 0
	jnz	short loc_100E7
loc_1007E:
	mov	gs:word_4243A, 1
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	configureBT3
	add	sp, 6
	mov	gs:word_4243C, ax
	mov	ax, 2
	push	ax
	mov	ax, offset s_thiefCfg
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_100C5
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_100C5:
	mov	ax, 4
	push	ax
	mov	ax, offset word_4243A
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_4]
	call	write
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
loc_100E7:
	sub	ax, ax
	push	ax
	mov	bx, gs:word_4243C
	and	bx, 0Fh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (graphicsDrivers+2)[bx]
	push	word ptr graphicsDrivers[bx]
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1011C
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_1011C:
	mov	ax, 18h
	push	ax
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	mov	ax, 1068h
	push	ax
	mov	ax, offset vid_setMode
	mov	dx, seg	seg024
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
	mov	ax, 1
	push	ax
	call	far ptr	vid_setMode
	add	sp, 2
	sub	ax, ax
	push	ax
	call	far ptr j_nullsub_2
	add	sp, 2
	sub	ax, ax
	push	ax
	mov	ax, offset s_firstTitle
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1018E
	mov	ax, 4
	push	ax
	call	far ptr	sub_28424
	add	sp, 2
loc_1018E:
	mov	ax, 33000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
	mov	[bp+var_6], 0
	jmp	short loc_101BD
loc_101BA:
	inc	[bp+var_6]
loc_101BD:
	cmp	[bp+var_6], 8
	jge	short loc_101E6
	mov	ax, 3200
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	mov	word ptr gs:musicBufs._offset[bx], ax
	mov	gs:musicBufs._segment[bx], dx
	jmp	short loc_101BA
loc_101E6:
	mov	ax, 33000
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	gs:word_42562, ax
	mov	gs:word_42564, dx
	push	dx
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	sub	ax, ax
	push	ax
	mov	ax, offset s_titleScreen
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_10266
	push	gs:word_42564
	push	gs:word_42562
	call	_freeMaybe
	add	sp, 4
	push	cs
	call	near ptr cleanupAndExit
loc_10266:
	mov	ax, 33000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
	push	gs:word_42564
	push	gs:word_42562
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	sub	ax, ax
	push	ax
	mov	ax, offset s_musicAll
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_102FB
	push	gs:word_42564
	push	gs:word_42562
	call	_freeMaybe
	add	sp, 4
	push	cs
	call	near ptr cleanupAndExit
loc_102FB:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, gs:word_4243C
	mov	cl, 7
	sar	ax, cl
	add	ax, 10h
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	call	lseek
	add	sp, 8
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_2]
	push	ss
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	call	lseek
	add	sp, 8
	mov	ax, 9C4h
	push	ax
	mov	ax, 0
	mov	dx, seg	seg025
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	mov	[bp+var_6], 0
	jmp	short loc_10366
loc_10363:
	inc	[bp+var_6]
loc_10366:
	cmp	[bp+var_6], 8
	jge	short loc_103D4
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_6]
	cwd
	shl	ax, 1
	rcl	dx, 1
	push	dx
	push	ax
	push	[bp+var_4]
	call	lseek
	add	sp, 8
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_2]
	push	ss
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_2]
	cwd
	push	dx
	push	ax
	push	[bp+var_4]
	call	lseek
	add	sp, 8
	mov	ax, 3200
	push	ax
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	push	gs:musicBufs._segment[bx]
	push	word ptr gs:musicBufs._offset[bx]
	push	[bp+var_4]
	call	read
	add	sp, 8
	jmp	short loc_10363
loc_103D4:
	push	[bp+var_4]
	call	close
	add	sp, 2
	call	sub_27F63
	mov	ax, 7
	push	ax
	mov	ax, 0FFh
	push	ax
	call	song_playSong
	add	sp, 4
	call	icons_read
	call	far ptr j_nullsub_3
	mov	ax, offset s_titleText
	push	ds
	push	ax
	call	intro_scrollText
	add	sp, 4
	sub	ax, ax
	push	ax
	mov	ax, offset s_bardscr
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_4], ax
	inc	ax
	jnz	short loc_1043E
	push	gs:word_42564
	push	gs:word_42562
	call	_freeMaybe
	add	sp, 4
	push	cs
	call	near ptr cleanupAndExit
loc_1043E:
	mov	ax, 80E8h
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	read
	add	sp, 8
	push	[bp+var_4]
	call	close
	add	sp, 2
	push	gs:word_42564
	push	gs:word_42562
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, gs:word_42562
	mov	dx, gs:word_42564
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	push	gs:word_42564
	push	gs:word_42562
	call	_freeMaybe
	add	sp, 4
	mov	ax, 4D0Ah
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	gs:bigpicCellData_off, ax
	mov	gs:bigpicCellData_seg, dx
	push	cs
	call	near ptr sub_116CC
	call	restoreGame
	push	buildingRvalMaybe
	push	cs
	call	near ptr sub_10560
	add	sp, 2
	push	cs
	call	near ptr cleanupAndExit
	mov	sp, bp
	pop	bp
	retf
_main endp


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
	cmp	ax, gameState_inCamp
	jz	short loc_10586
	cmp	ax, gameState_inWilderness
	jz	short loc_10590
	cmp	ax, gameState_inDungeon
	jz	short loc_10599
	cmp	ax, gameState_partyDied
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
	call	map_read
	add	sp, 6
	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t.levFlags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	add	ax, 3
	mov	[bp+var_22], ax
	push	ax
	call	map_readGraphics
	add	sp, 2
	lfs	bx, [bp+levP]
	mov	al, fs:[bx+dun_t.monIndex]
	sub	ah, ah
	push	ax
	call	map_readMonsters
	add	sp, 2

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
	cmp	g_partyAttackFlag, 0
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
	std_call	sub_10B3D, 0Eh

	push	g_direction
	push	sq_north
	push	sq_east
	std_call	dun_detectSquares,6

	push_ss_string	var_1E
	std_call	setTitle, 4

	sub	ax, ax
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	std_call	vm_execute, 6
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
	mov	ax, g_direction
	add	ax, bx
	and	ax, 3
	mov	g_direction, ax
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
	direction= word ptr  12h

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
	mov	ax, [bp+direction]
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
	mov	bx, [bp+direction]
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
	mov	bx, [bp+direction]
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
	mov	g_sameSquareFlag, 0
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
	cmp	g_partyAttackFlag, 0
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
	std_call	vm_execute, 6

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
	mov	si, g_direction
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
	mov	ax, g_direction
	add	ax, bx
	and	ax, 3
	mov	g_direction, ax

	push_ds_string aFacing
	push_ss_string var_28
	call	strcat
	add	sp, 8

	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	push_ptr_stringList	dirStringList, bx
	push	dx
	push	ax
	call	strcat
	add	sp, 8

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
	call	map_turnAround
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
	mov	bx, g_direction
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
	mov	bx, g_direction
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
	push	g_direction
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
	mov	g_direction, 0
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


seg000 ends

; Segment type: Pure code
seg001 segment word public 'CODE' use16
        assume cs:seg001
;org 0Bh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_1173B:
align 2

; Attributes: bp-based frame

text_castSpell proc far

	_instr = word ptr -7
	counter = word ptr -2
	arg_0 = word ptr 6

	push	bp
	mov	bp, sp
	mov	ax, 7
	call	someStackOperation
	push	si

	call	text_clear

	mov	ax, offset s_spellToCast
	push	ds
	push	ax
	call	printString
	add	sp, 4

	mov	ax, 4
	push	ax
	lea	ax, [bp+_instr]
	push	ss
	push	ax
	call	readString
	add	sp, 6

	lea	ax, [bp+_instr]
	push	ss
	push	ax
	call	_strlen
	add	sp, 4
	cmp	ax, 4
	jl	l_fail_no_print

	lea	si, [bp+_instr]
	mov	[bp+counter], 0

l_toupper_start:
	cmp	[bp+counter], 4
	jge	l_toupper_exit
	mov	bx, [bp+counter]
	mov	al, ss:[si+bx]
	sub	ah, ah
	push	ax
	call	toUpper
	add	sp, 2

	mov	bx, [bp+counter]
	mov	ss:[si+bx], al
	inc	[bp+counter]
	jmp	l_toupper_start

l_toupper_exit:
	mov	[bp+counter], 0

l_spellCmp_start:
	cmp	[bp+counter], 7Eh
	jge	l_spellNotFound

	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	shl	bx, 1
	mov	si, word ptr spellString.abbreviation[bx]
	lea	di, [bp+_instr]
	push	ss
	pop	es
	mov	cx, 4
	repe	cmpsb
	jz	l_spellFound

	inc	[bp+counter]
	jmp	l_spellCmp_start

l_spellNotFound:
	mov	ax, offset s_noSpellByThatName
	push	ds
	push	ax
	jmp	l_fail

l_spellFound:
	push	[bp+counter]
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	l_notLearned
	
	mov	ax, [bp+counter]
	jmp	l_return

l_notLearned:
	mov	ax, offset s_dontKnowThatSpell
	push	ds
	push	ax

l_fail:
	call	printString
	add	sp, 4
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2

l_fail_no_print:
	mov	ax, 0FFFFh

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
text_castSpell endp

executeKeyboardCommand proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp

	cmp	[bp+arg_0], dosKeys_F1
	jl	short l_notFunctionKeySpell
	cmp	[bp+arg_0], dosKeys_F7
	jg	short l_notFunctionKeySpell
	push	[bp+arg_0]
	call	noncombatCast
	add	sp, 2
	jmp	l_success

l_notFunctionKeySpell:
	cmp	[bp+arg_0], '1'
	jl	short l_notPrintCharacter
	cmp	[bp+arg_0], '7'
	jg	short l_notPrintCharacter
	mov	ax, [bp+arg_0]
	sub	ax, '1'
	push	ax
	call	printCharacter
	add	sp, 2
	jmp	l_success
	
l_notPrintCharacter:
	mov	ax, [bp+arg_0]
	jmp	l_keySwitch

l_printHelp:
	push	cs
	call	near ptr printCommandHelp
	jmp	l_success

l_castSpell:
	sub	ax, ax
	push	ax
	call	noncombatCast
	add	sp, 2
	jmp	l_success
	
l_reorderParty:
	call	party_reorder
	jmp	l_success
	
l_saveGame:
	call	saveGame
	jmp	l_success
	
l_singBardSong:
	call	song_singNonCombat
	jmp	l_success

l_dropMember:
	call	dropPartyMember
	jmp	l_success

l_pauseGame:
	cmp	gs:byte_42296, 0FFh
	jz	l_fail
	mov	gs:advanceTimeFlag, 1
	mov	ax, offset s_pausing
	push	ds
	push	ax
	call	printStringWithWait
	add	sp, 4
	mov	gs:advanceTimeFlag, 0
	jmp	l_success

l_partyAttack:
	mov	g_partyAttackFlag, 1
	jmp	l_fail

l_useItem:
	call	useItem
	jmp	l_success

l_toggleSound:
	call	snd_toggle
	jmp	l_success

l_keySwitch:
	sub	ax, 'B'
	cmp	ax, 14h
	ja	short l_fail
	add	ax, ax
	xchg	ax, bx
	jmp	cs:keyJumpTable[bx]
keyJumpTable	dw offset l_singBardSong 
		dw offset l_castSpell	
		dw offset l_dropMember	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_printHelp	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_reorderParty	
		dw offset l_fail	
		dw offset l_partyAttack	
		dw offset l_fail	
		dw offset l_fail	
		dw offset l_saveGame	
		dw offset l_pauseGame	
		dw offset l_useItem	
		dw offset l_toggleSound	

l_fail:
	xor	ax, ax
	jmp	l_exit

l_success:
	mov	ax, 1

l_exit:
	mov	sp, bp
	pop	bp
	retf
executeKeyboardCommand endp


; DWORD - arg_0 & arg_2

; Attributes: bp-based frame
printStringWithWait proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp

	call	text_clear
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
printStringWithWait endp

; Attributes: bp-based frame

printCommandHelp proc far
	push	bp
	mov	bp, sp

	call	text_clear
	mov	ax, offset s_helpMessage1
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	call	text_clear
	mov	ax, offset s_helpMessage2
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
printCommandHelp endp

; Attributes: bp-based frame

party_reorder proc far

	emptySlot=	word ptr -24h
	var_22=	word ptr -22h
	var_14=	word ptr -14h
	loopCounter=	word ptr -12h
	slotNumberRead=	word ptr -10h
	var_E= word ptr	-0Eh

	push	bp
	mov	bp, sp
	mov	ax, 24h
	call	someStackOperation
	push	di
	push	si

	call	party_findEmptySlot
	mov	[bp+emptySlot], ax
	cmp	ax, 1
	jle	l_return

l_reorderEntry:
	call	text_clear
	mov	[bp+loopCounter], 0

; Initialize arrays:
;   var_E is initialized with 0
;   var_22 is initialized with 0FFFFh
l_listInitialization:
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	[bp+si+var_E], 0
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	[bp+si+var_22],	0FFFFh
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_listInitialization

	mov	ax, offset s_newOrder
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+loopCounter], 0

l_newOrderIoEntry:
	mov	al, byte ptr [bp+loopCounter]
	add	al, '1'
	mov	byte_42AF5, al
	mov	ax, offset s_gtChar
	push	ds
	push	ax
	call	text_nlWriteString
	add	sp, 4

l_retryReadSlot:
	call	readSlotNumber
	mov	[bp+slotNumberRead], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+emptySlot]
	cmp	[bp+slotNumberRead], ax
	jge	short l_retryReadSlot

	mov	si, [bp+slotNumberRead]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jnz	short l_retryReadSlot

	mov	si, [bp+slotNumberRead]
	shl	si, 1
	mov	[bp+si+var_E], 1
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	ax, [bp+slotNumberRead]
	mov	[bp+si+var_22],	ax
	mov	ax, charSize
	imul	[bp+slotNumberRead]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	text_writeString
	add	sp, 4
	inc	[bp+loopCounter]
	mov	ax, [bp+emptySlot]
	dec	ax
	cmp	ax, [bp+loopCounter]
	jg	short l_newOrderIoEntry

	mov	[bp+var_14], 0
l_var_EcomparisonLoopEntry:
	mov	si, [bp+var_14]
	shl	si, 1
	cmp	[bp+si+var_E], 0
	jz	short loc_119C9
	inc	[bp+var_14]
	jmp	short l_var_EcomparisonLoopEntry

loc_119C9:
	mov	si, [bp+emptySlot]
	shl	si, 1
	mov	ax, [bp+var_14]
	mov	[bp+si+emptySlot], ax
	mov	al, byte ptr [bp+emptySlot]
	add	al, '0'
	mov	byte_42AF5, al
	mov	ax, offset s_gtChar
	push	ds
	push	ax
	call	text_nlWriteString
	add	sp, 4
	mov	ax, charSize
	imul	[bp+var_14]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	text_writeString
	add	sp, 4
	mov	ax, offset s_useThisOrder
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	l_reorderEntry

	mov	[bp+loopCounter], 0
	jmp	short loc_11A27
loc_11A24:
	inc	[bp+loopCounter]
loc_11A27:
	mov	ax, [bp+emptySlot]
	dec	ax
	cmp	ax, [bp+loopCounter]
	jle	short l_updateAndReturn
	mov	di, [bp+loopCounter]
	shl	di, 1
	mov	si, [bp+di+var_22]
	cmp	[bp+loopCounter], si
	jz	short loc_11A7D
	push	si
	push	[bp+loopCounter]
	push	cs
	call	near ptr party_swapMembers
	add	sp, 4
	mov	ax, [bp+loopCounter]
	inc	ax
	mov	[bp+var_14], ax
	jmp	short loc_11A54
loc_11A51:
	inc	[bp+var_14]
loc_11A54:
	mov	ax, [bp+emptySlot]
	cmp	[bp+var_14], ax
	jge	short loc_11A6D
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+loopCounter]
	cmp	[bp+si+var_22],	ax
	jnz	short loc_11A6B
	jmp	short loc_11A6D
loc_11A6B:
	jmp	short loc_11A51
loc_11A6D:
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	ax, [bp+si+var_22]
	mov	si, [bp+var_14]
	shl	si, 1
	mov	[bp+si+var_22],	ax
loc_11A7D:
	jmp	short loc_11A24
l_updateAndReturn:
	mov	byte ptr g_printPartyFlag,	0
l_return:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
party_reorder endp

; Attributes: bp-based frame

party_swapMembers proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp

	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, charSize
	imul	[bp+arg_0]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8

	mov	ax, charSize
	imul	[bp+arg_0]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, charSize
	imul	[bp+arg_2]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8

	mov	ax, charSize
	imul	[bp+arg_2]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, offset newCharBuffer
	push	dx
	push	ax
	call	copyCharacterBuf
	add	sp, 8

	mov	sp, bp
	pop	bp
	retf
party_swapMembers endp

; Attributes: bp-based frame

saveGame proc far

	fd= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset s_confirmSave
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	l_return
loc_11B2A:
	cmp	inDungeonMaybe, 0
	jz	short loc_11B3B
	mov	ax, 4
	jmp	short loc_11B3E
loc_11B3B:
	mov	ax, 2
loc_11B3E:
	mov	buildingRvalMaybe, ax
	mov	ax, 2
	push	ax
	mov	ax, offset s_gameSav
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short l_doSave
	call	text_clear
	mov	ax, offset s_cantOpenGameSave
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	buildingRvalMaybe, 0
	jmp	short l_return

l_doSave:
	mov	ax, offset s_savingTheGame
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	mov	ax, 348h
	push	ax
	mov	ax, offset party
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+fd]
	call	write
	add	sp, 8

	mov	ax, offset byte_4EECC
	mov	cx, offset currentLocationMaybe
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+fd]
	call	write
	add	sp, 8

	push	[bp+fd]
	call	close
	add	sp, 2

	mov	ax, offset s_gameHasBeenSaved
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short loc_11BEF
	mov	ax, 0FFh
	jmp	short loc_11BF1
loc_11BEF:
	sub	ax, ax
loc_11BF1:
	mov	buildingRvalMaybe, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
saveGame endp

; Attributes: bp-based frame

restoreGame proc far

	var_4= word ptr	-4
	fd= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	buildingRvalMaybe, 1
	mov	ax, offset s_confirmRestore
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	l_return

	call	endNoncombatSong
	mov	ax, offset s_gameSav
	push	ds
	push	ax
	call	openFile
	add	sp, 4
	mov	[bp+fd], ax
	mov	ax, 348h
	push	ax
	mov	ax, offset party
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8

	mov	ax, offset byte_4EECC
	mov	cx, offset currentLocationMaybe
	mov	bx, seg	dseg
	sub	ax, cx
	push	ax
	mov	ax, cx
	mov	dx, bx
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8

	push	[bp+fd]
	call	close
	add	sp, 2

	mov	[bp+var_4], 0

l_durationSpellLoopEntry:
	mov	bx, [bp+var_4]
	cmp	lightDuration[bx], 0
	jz	short l_doNotActivate
	push	bx
	call	icon_activate
	add	sp, 2
l_doNotActivate:
	inc	[bp+var_4]
	cmp	[bp+var_4], 5
	jl	l_durationSpellLoopEntry

	cmp	g_currentHour, 6
	jb	short l_isNight
	cmp	g_currentHour, 12h
	jbe	short l_isDay
l_isNight:
	mov	al, 1
	jmp	short l_setIsNight
l_isDay:
	sub	al, al
l_setIsNight:
	mov	gs:isNight, al
	mov	byte ptr g_printPartyFlag,	0
l_return:
	mov	sp, bp
	pop	bp
	retf
restoreGame endp

; Attributes: bp-based frame

useItem	proc far

	var_FA=	word ptr -0F8h
	targetSlotNumber=	word ptr -38h
	itemSlotNumber=	word ptr -34h
	var_32=	word ptr -32h
	userSlotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0F8h
	call	someStackOperation

	mov	ax, offset s_whoUsesItem
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+userSlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	ax, charSize
	imul	[bp+userSlotNumber]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_return

	mov	ax, charSize
	imul	[bp+userSlotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster
	jnb	l_return

	lea	ax, [bp+var_32]
	push	ss
	push	ax
	lea	ax, [bp+var_FA]
	push	ss
	push	ax
	push	[bp+userSlotNumber]
	call	sub_188E8
	add	sp, 0Ah

	or	ax, ax
	jz	l_emptyPockets
loc_11D4B:
	push	ax
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	mov	ax, offset s_whichItem
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah

	mov	[bp+itemSlotNumber], ax
	or	ax, ax
	jl	l_return

	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	call	item_canBeUsed
	add	sp, 4
	or	ax, ax
	jz	short l_powerless
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+targetSlotNumber], ax
	cmp	ax, 4
	jge	short l_doUse
	mov	ax, offset s_UseOn
	push	ds
	push	ax
	push	[bp+targetSlotNumber]
	call	getTarget
	add	sp, 6
	mov	[bp+targetSlotNumber], ax
	or	ax, ax
	jl	short l_return

l_doUse:
	call	text_clear
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+targetSlotNumber]
	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	push	cs
	call	near ptr item_doSpell
	add	sp, 0Ah
	jmp	short l_waitAndReturn

l_powerless:
	mov	ax, offset s_powerless
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_waitAndReturn
l_emptyPockets:
	mov	ax, offset s_pocketsAreEmpty
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
l_waitAndReturn:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
	mov	sp, bp
	pop	bp
	retf
useItem	endp

; Attributes: bp-based frame

item_doSpell proc far

	userSlotNumber=	word ptr  6
	itemSlotNumber= word ptr	 8
	targetSlotNumber= byte ptr	 0Ah
	spellNumber= word ptr	 0Ch
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp

	mov	ax, [bp+itemSlotNumber]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:g_usedItemSlotNumber, al
	mov	al, byte ptr [bp+userSlotNumber]
	mov	gs:g_userSlotNumber, al
	mov	al, [bp+targetSlotNumber]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	push	[bp+arg_8]
	push	[bp+spellNumber]
	push	[bp+userSlotNumber]
	call	doCastSpell
	add	sp, 8
	push	[bp+itemSlotNumber]
	push	[bp+userSlotNumber]
	push	cs
	call	near ptr item_useCharge
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
item_doSpell endp

; Attributes: bp-based frame

item_useCharge proc far

	var_4= dword ptr -4
	userSlotNumber= word ptr	 6
	itemSlotNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+userSlotNumber]
	mov	bx, [bp+itemSlotNumber]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:party.inventory.itemCount[bx], 0FFh
	jz	l_returnOne
	mov	ax, charSize
	imul	[bp+userSlotNumber]
	mov	cx, [bp+itemSlotNumber]
	mov	dx, cx
	shl	cx, 1
	add	cx, dx
	add	cx, ax
	add	cx, 64h	
	mov	word ptr [bp+var_4], cx
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	dec	byte ptr fs:[bx]
	lfs	bx, [bp+var_4]
	cmp	byte ptr fs:[bx], 0
	jnz	l_returnOne
loc_11EBC:
	mov	ax, [bp+itemSlotNumber]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:g_inventoryPackStart, ax
	mov	ax, [bp+userSlotNumber]
	mov	gs:g_inventoryPackTarget, ax
	call	inven_pack
	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+userSlotNumber]
	jnz	short l_return

	; If the item used up belongs to the current singer and
	; the current singer no longer has an instrument equipped,
	; then the instrument is the item used up. Stop songs.
	mov	ax, itType_instrument
	push	ax
	push	[bp+userSlotNumber]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jnz	short l_return
	cmp	gs:byte_422A4, 0
	jz	short loc_11F12
	call	bat_endCombatSong
	jmp	short l_return
loc_11F12:
	call	endNoncombatSong
	jmp	short l_return
l_returnOne:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
item_useCharge endp

; Attributes: bp-based frame
snd_toggle proc	far
	push	bp
	mov	bp, sp

	cmp	g_soundActiveFlag, 1
	sbb	ax, ax
	neg	ax
	mov	g_soundActiveFlag, ax
	push	ax
	call	sub_27E05
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
snd_toggle endp

; This function	prints a string	based on a structure
; that is passed to it.	The optional lines are prefaced
; with a '@'
; Attributes: bp-based frame

printVarString proc far

	stringBuffer= word ptr -10Ah
	mouseBitmask= word ptr	-0Ah
	currentOptionIndex= word ptr	-8
	currentChar= word ptr	-6
	stringBufferP= dword ptr -4
	inString= dword	ptr  6
	optionList= dword ptr  0Ah
	validOptionCharacters= dword ptr  0Eh
	validOptionMouse= dword ptr  12h

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si

	sub	ax, ax
	mov	[bp+currentOptionIndex], ax
	mov	[bp+mouseBitmask], ax
	lea	ax, [bp+stringBuffer]
	mov	word ptr [bp+stringBufferP], ax
	mov	word ptr [bp+stringBufferP+2], ss
l_stringCopyLoopEntry:
	lfs	bx, [bp+inString]			; Get next char from inString
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax

	lfs	bx, [bp+stringBufferP]			; Write it to stringBuffer
	inc	word ptr [bp+stringBufferP]
	mov	al, byte ptr [bp+currentChar]
	mov	fs:[bx], al

	cmp	[bp+currentChar], 0
	jz	short l_nullOrAt
	cmp	[bp+currentChar], '@'
	jnz	short l_stringCopyLoopEntry
l_nullOrAt:
	dec	word ptr [bp+stringBufferP]
	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0			; Replace '@' with 0
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4				; and print the strint

	lea	ax, [bp+stringBuffer]			; Reset the buffer pointer to the
	mov	word ptr [bp+stringBufferP], ax		; beginning of the string buffer
	mov	word ptr [bp+stringBufferP+2], ss

	cmp	[bp+currentChar], 0
	jnz	short l_notNull
	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+validOptionCharacters]
	mov	byte ptr fs:[bx+si], 0
	mov	ax, [bp+mouseBitmask]
	jmp	l_return
l_notNull:
	cmp	[bp+currentChar], '@'
	jnz	short l_nullOrAt

	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+optionList]
	cmp	byte ptr fs:[bx+si], 0		; Check the current option
	jz	short loc_1204B

	lfs	bx, [bp+inString]		; Save the first character after '@'
	mov	al, fs:[bx]			; as the key the player can type to
	mov	bx, [bp+currentOptionIndex]	; activate the option
	lfs	si, [bp+validOptionCharacters]
	mov	fs:[bx+si], al

	cmp	gs:g_currentCharPosition, 0
	jz	short l_noNewline
	call	txt_newLine
l_noNewline:
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Eh
	mov	bx, [bp+currentOptionIndex]
	inc	[bp+currentOptionIndex]
	shl	bx, 1
	lfs	si, [bp+validOptionMouse]
	mov	fs:[bx+si], ax			; Add the option to the list of mouse
	mov	bl, gs:txt_numLines		; menu items
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+mouseBitmask], ax

l_copyStringAfterAt:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax
	lfs	bx, [bp+stringBufferP]
	inc	word ptr [bp+stringBufferP]
	mov	al, byte ptr [bp+currentChar]
	mov	fs:[bx], al
	cmp	[bp+currentChar], 0
	jz	l_nullOrAt
	cmp	[bp+currentChar], '@'
	jnz	short l_copyStringAfterAt
	jmp	l_nullOrAt

loc_1204B:
	mov	bx, [bp+currentOptionIndex]
	lfs	si, [bp+validOptionCharacters]
	mov	byte ptr fs:[bx+si], 0FFh		; Mark option as invalid
	mov	bx, [bp+currentOptionIndex]
	inc	[bp+currentOptionIndex]
	shl	bx, 1
	lfs	si, [bp+validOptionMouse]		; Mark mouse option as invalid
	mov	word ptr fs:[bx+si], 0
l_skipString:
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+currentChar], ax
	or	ax, ax
	jz	short loc_1207C
	cmp	ax, 40h	
	jnz	short l_skipString
loc_1207C:
	inc	word ptr [bp+stringBufferP]
loc_1207F:
	jmp	l_nullOrAt
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printVarString endp

; DWORD - var_108 & var_10A, var_10E & var_10C
; Attributes: bp-based frame

printLocation proc far

	pacesNorth= word ptr -126h
	unmaskedLocationName= word ptr -124h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	pacesEast= word ptr -102h
	stringBuffer= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 126h
	call	someStackOperation

	mov	[bp+var_10E], offset g_rosterCharacterBuffer
	mov	[bp+var_10C], seg seg022
	mov	ax, offset s_youreIn
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	cmp	currentLocationMaybe, 0
	jnz	short l_skipThe

	mov	ax, offset s_the
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

l_skipThe:
	lea	ax, [bp+unmaskedLocationName]
	push	ss
	push	ax
	push	[bp+var_10C]
	push	[bp+var_10E]
	call	unmaskString
	add	sp, 8

	lea	ax, [bp+unmaskedLocationName]
	push	ss
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	mov	bx, currentLocationMaybe
	mov	al, byte_428A6[bx]
	cbw
	mov	cx, sq_north
	sub	cx, ax
	mov	[bp+pacesNorth], cx
	or	cx, cx
	jz	loc_121CD

	mov	ax, offset s_spAndsp
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+pacesNorth], 0
	jge	short loc_1216A

	mov	ax, [bp+pacesNorth]
	neg	ax
	mov	[bp+pacesNorth], ax
	mov	[bp+var_106], 1
	jmp	short loc_12170
loc_1216A:
	mov	[bp+var_106], 0
loc_12170:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesNorth]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	mov	ax, [bp+pacesNorth]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	mov	ax, offset s_paces
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah

	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	mov	ax, offset s_northSouth
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

loc_121CD:
	mov	bx, currentLocationMaybe
	mov	al, byte_428B0[bx]
	cbw
	mov	cx, sq_east
	sub	cx, ax
	mov	[bp+pacesEast], cx
	or	cx, cx
	jz	loc_1228A

	mov	ax, offset s_spAndsp
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+pacesEast], 0
	jge	short loc_12227
	mov	ax, [bp+pacesEast]
	neg	ax
	mov	[bp+pacesEast], ax
	mov	[bp+var_106], 1
	jmp	short loc_1222D
loc_12227:
	mov	[bp+var_106], 0
loc_1222D:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesEast]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+pacesEast]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	mov	ax, offset s_paces
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	mov	ax, offset s_eastWest
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_1228A:
	mov	bx, currentLocationMaybe
	mov	al, byte_428BA[bx]
	cbw
	mov	[bp+var_110], ax
	mov	bl, g_currentHour
	sub	bh, bh
	mov	al, byte_428C4[bx]
	cbw
	mov	[bp+var_104], ax
	mov	ax, [bp+pacesEast]
	or	ax, [bp+pacesNorth]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_108]
	push	[bp+var_10A]
	mov	ax, offset s_ofAtThe
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_110]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (locationString+2)[bx]
	push	word ptr locationString[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_itsNow
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_104]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (timeOfDay+2)[bx]
	push	word ptr timeOfDay[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
printLocation endp

; Attributes: bp-based frame

dropPartyMember	proc far

	slotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset s_whoToDrop
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	short l_returnZero

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster
	jnb	short l_doDrop
	mov	ax, offset s_cantDropCharacter
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	l_returnZero

l_doDrop:
	push	[bp+slotNumber]
	call	party_pack
	add	sp, 2
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
dropPartyMember	endp

; Attributes: bp-based frame

quitGame proc far
	push	bp
	mov	bp, sp

	mov	ax, offset s_confirmQuit
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	call	getYesNo
	or	ax, ax
	jz	short l_returnZero
	mov	ax, offset s_loseProgressConfirm
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
quitGame endp




seg001 ends

; Segment type: Pure code
seg002 segment byte public 'CODE' use16
        assume cs:seg002
;org 6
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

camp_addMember proc far

	var_15C= word ptr -15Ch
	var_15A= word ptr -15Ah
	var_158= word ptr -158h
	var_156= word ptr -156h
	savedList= dword	ptr -154h

	push	bp
	mov	bp, sp
	mov	ax, 15Ch
	call	someStackOperation
	push	si

	call	text_clear
	push	cs
	call	near ptr roster_countCharacters
	or	ax, ax
	jz	l_noSavedCharacters
	mov	[bp+var_15A], 0
	mov	[bp+var_15C], 0
loc_12428:
	cmp	[bp+var_15A], 10
	jge	l_addCharacters
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_15C]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+si+savedList], ax
	mov	word ptr [bp+si+savedList+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+savedList]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_12428
l_addCharacters:
	dec	[bp+var_15C]
	mov	ax, [bp+var_15C]
	mov	[bp+var_156], ax
	mov	[bp+var_15A], 0
l_nextCharacter:
	cmp	[bp+var_15A], 75
	jge	l_savedListComplete
	mov	ax, [bp+var_15C]
	sub	ax, [bp+var_156]
	mov	cx, charSize
	imul	cx
	add	ax, 0
	mov	si, [bp+var_15C]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+savedList], ax
	mov	word ptr [bp+si+savedList+2], seg seg022
	mov	si, [bp+var_15C]
	inc	[bp+var_15C]
	inc	[bp+var_15A]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+savedList]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_nextCharacter
l_savedListComplete:
	dec	[bp+var_15C]

l_ioLoopEnter:
	push	[bp+var_15C]
	lea	ax, [bp+savedList]
	push	ss
	push	ax
	mov	ax, offset s_whoJoins
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_15A], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+var_15A], ax
	jge	short l_addCharacter
	push	[bp+var_15A]
	push	cs
	call	near ptr camp_insertParty
	add	sp, 2
	jmp	l_return
l_addCharacter:
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	push	cs
	call	near ptr party_nameExists
	add	sp, 4
	or	ax, ax
	jl	short l_loopContinue
	mov	si, [bp+var_15A]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+savedList+2]
	push	word ptr [bp+si+savedList]
	call	printStringWClear
	add	sp, 4
	mov	ax, offset s_alreadyInParty
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_158], 1
	jmp	short l_loopComparison
l_loopContinue:
	mov	[bp+var_158], 0
l_loopComparison:
	cmp	[bp+var_158], 0
	jnz	l_ioLoopEnter
	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+var_158], ax
	cmp	ax, 7
	jge	short l_shortReturnLabel
	mov	ax, charSize
	imul	[bp+var_158]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_15A]
	sub	ax, [bp+var_156]
	mov	cx, charSize
	imul	cx
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	cs
	call	near ptr party_addCharacter
	mov	byte ptr g_printPartyFlag,	0
l_shortReturnLabel:
	jmp	short l_return
l_noSavedCharacters:
	mov	ax, offset s_noCharsOnDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_addMember endp

; Attributes: bp-based frame

camp_insertParty proc far

	loopCounter= word ptr	-0Ah
	savedPartiesP= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	savedPartyNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si

	mov	ax, [bp+savedPartyNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+savedPartiesP], ax
	mov	word ptr [bp+savedPartiesP+2], seg seg022
	call	text_clear
	mov	[bp+loopCounter], 0
	jmp	short l_loopComparison
l_incrementCounter:
	inc	[bp+loopCounter]
l_loopComparison:
	cmp	[bp+loopCounter], 7
	jge	l_return

	mov	si, [bp+loopCounter]
	mov	cl, 4
	shl	si, cl
	lfs	bx, [bp+savedPartiesP]
	cmp	byte ptr fs:[bx+si+10h], 0
	jz	l_return
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, bx
	mov	dx, fs
	add	ax, 10h
	push	dx
	push	ax
	push	cs
	call	near ptr party_nameExists
	add	sp, 4
	or	ax, ax
	jl	short l_findEmptySlot
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset s_alreadyInParty
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	short l_incrementCounter
l_findEmptySlot:
	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+var_2], ax
	cmp	ax, 7
	jge	l_rosterFull

	; Check that the character named in the party is in the
	; list of saved characters
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	push	cs
	call	near ptr roster_nameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short l_addCharacter
	mov	ax, [bp+loopCounter]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+savedPartiesP]
	mov	dx, word ptr [bp+savedPartiesP+2]
	add	ax, 10h
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset s_noOneHereNamedThat
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	l_incrementCounter
l_addCharacter:
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, charSize
	imul	[bp+var_4]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	cs
	call	near ptr party_addCharacter
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_incrementCounter
l_rosterFull:
	mov	ax, offset s_rosterIsFull
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	l_incrementCounter
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_insertParty endp

; Attributes: bp-based frame

camp_removeMember proc far

	loopCounter=	word ptr -24h
	slotToRemove=	word ptr -22h
	partyMemberList=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah

	push	bp
	mov	bp, sp
	mov	ax, 24h
	call	someStackOperation
	push	si

	mov	[bp+loopCounter], 0
	mov	ax, offset s_removeAll
	mov	[bp+partyMemberList], ax
	mov	[bp+var_1E], ds
loc_12723:
	cmp	[bp+loopCounter], 7
	jge	short loc_1275A
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	cmp	byte ptr gs:party._name[bx], 0
	jz	short loc_1275A
	mov	ax, charSize
	imul	[bp+loopCounter]
	add	ax, offset party
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_1C],	ax
	mov	[bp+si+var_1A],	seg seg027
	inc	[bp+loopCounter]
	jmp	short loc_12723
loc_1275A:
	mov	ax, [bp+loopCounter]
	inc	ax
	push	ax
	lea	ax, [bp+partyMemberList]
	push	ss
	push	ax
	mov	ax, offset s_whichPartyMemberToRemove
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah

	mov	[bp+slotToRemove], ax
	or	ax, ax
	jl	l_return
l_removeAll:
	cmp	[bp+slotToRemove], 0
	jnz	short l_removeOneCharacter
	push	cs
	call	near ptr party_clear
	jmp	short l_saveAndReturn
l_removeOneCharacter:
	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	call	roster_writeCharacter
	add	sp, 2

	mov	ax, [bp+slotToRemove]
	dec	ax
	push	ax
	push	cs
	call	near ptr party_pack
	add	sp, 2
l_saveAndReturn:
	call	roster_countCharacters
	push	ax
	call	writeCharacterFile
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_removeMember endp


; This function	moves all of the roster	slots below
; partySlotNumber up one slot. It then zeroes the tail of the
; party. This effectively removes the character from
; the party.
; Attributes: bp-based frame

party_pack proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	push	si

loc_127AE:
	cmp	[bp+partySlotNumber], 6
	jge	short l_return
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, partySecondSlot._name[si]
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	inc	[bp+partySlotNumber]
	jmp	short loc_127AE
l_return:
	mov	gs:partyTail._name, 0
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_pack endp

; Attributes: bp-based frame

party_clear proc far

	slotNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	call	roster_writeParty
	mov	[bp+slotNo], 0
l_loopEnter:
	mov	ax, charSize
	imul	[bp+slotNo]
	mov	bx, ax
	mov	byte ptr gs:party._name[bx], 0
	inc	[bp+slotNo]
	cmp	[bp+slotNo], 7
	jl	short l_loopEnter
	mov	sp, bp
	pop	bp
	retf
party_clear endp


; Attributes: bp-based frame

camp_renameMember proc far

	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	loopCounter= word ptr -25Ah
	nameSelected= word ptr -258h
	nameBuf= word ptr -254h
	characterNameList= dword ptr -22Ch
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 25Eh
	call	someStackOperation
	push	si

	call	text_clear
	push	cs
	call	near ptr roster_countCharacters
	or	ax, ax
	jz	l_noSavedCharacters
loc_12835:
	mov	[bp+loopCounter], 0
	mov	[bp+nameSelected], 0
l_createListLoopEntry:
	cmp	[bp+nameSelected], 75
	jge	l_selectFromList
	mov	ax, charSize
	imul	[bp+loopCounter]
	add	ax, 0
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+characterNameList], ax
	mov	word ptr [bp+si+characterNameList+2], seg	seg022
	mov	si, [bp+loopCounter]
	inc	[bp+loopCounter]
	inc	[bp+nameSelected]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+characterNameList]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_createListLoopEntry
l_selectFromList:
	dec	[bp+loopCounter]
	push	[bp+loopCounter]
	lea	ax, [bp+characterNameList]
	push	ss
	push	ax
	mov	ax, offset s_renameWho
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+nameSelected], ax
	or	ax, ax
	jl	l_return

	mov	ax, offset s_whatIs
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	si, [bp+nameSelected]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+characterNameList+2]
	push	word ptr [bp+si+characterNameList]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	mov	ax, offset s_newName
	push	ds
	push	ax
	push	dx
	push	[bp+var_25E]
	call	strcat
	add	sp, 8
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+loopCounter], 0

l_clearNameLoopEntry:
	mov	si, [bp+loopCounter]
	mov	byte ptr [bp+si+nameBuf], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_clearNameLoopEntry
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	or	ax, ax
	jz	short l_return
	lea	ax, [bp+nameBuf]
	push	ss
	push	ax
	push	cs
	call	near ptr roster_nameExists
	add	sp, 4
	or	ax, ax
	jl	short l_renameCharacter
	mov	ax, offset s_nameAlreadyExists
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_return
l_renameCharacter:
	mov	[bp+loopCounter], 0
l_renameLoopEntry:
	mov	si, [bp+loopCounter]
	mov	al, byte ptr [bp+si+nameBuf]
	mov	si, [bp+nameSelected]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+characterNameList]
	mov	si, [bp+loopCounter]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_renameLoopEntry
	jmp	short l_return
l_noSavedCharacters:
	mov	ax, offset s_noCharsOnDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
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
	call	random
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
	call	random
	and	ax, 0Fh
	add	ax, 13
	mov	[bp+var_30], ax
	mov	gs:newCharBuffer.currentHP, ax
	mov	gs:newCharBuffer.maxHP,	ax
	mov	[bp+var_24], ax
	call	text_clear
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
	call	near ptr printListItem
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
	call	getKey
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
	mov	al, g_classPictureNumber[bx+di]
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
	call	random
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
	mov	ax, offset s_nameYourCharacter
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
	call	readString
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
	call	near ptr roster_nameExists
	add	sp, 4
	or	ax, ax
	jl	short loc_12D6A
	mov	ax, offset s_nameAlreadyExists
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_4], 1
	jmp	short loc_12D6F
loc_12D6A:
	mov	[bp+var_4], 0
loc_12D6F:
	cmp	[bp+var_4], 0
	jnz	short loc_12CFD
	push	cs
	call	near ptr roster_countCharacters
	mov	[bp+var_30], ax
	mov	ax, charSize
	imul	[bp+var_30]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
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
	mov	ax, charSize
	imul	[bp+var_30]
	mov	bx, ax
	mov	fs, seg022_x
	assume fs:seg022
	mov	fs:(g_rosterCharacterBuffer+78h)[bx], 0
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

loc_loop_start:
	mov	ax, offset s_genderOptions
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	mov	ax, 0Ch
	push	ax
	call	getKey
	add	sp, 2

	cmp	ax, 1Bh
	jz	loc_return_ff

	cmp	ax, 'F'
	jz	loc_return_one
	cmp	ax, 111h
	jz	loc_return_one

	cmp	ax, 'M'
	jz	loc_return_zero
	cmp	ax, 110h
	jnz	loc_loop_start
	
loc_return_zero:
	xor	ax, ax
	jmp	loc_exit

loc_return_one:
	mov	ax, 1
	jmp	loc_exit

loc_return_ff:
	mov	ax, 0FFh

loc_exit:
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

l_ioLoopEntry:
	mov	ax, offset s_raceOptions
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 1FCh
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_2], ax
	cmp	ax, 1Bh
	jnz	short l_checkMouse
	mov	ax, 0FFh
	jmp	short l_return
l_checkMouse:
	cmp	[bp+var_2], 10Fh
	jle	short l_checkKey
	cmp	[bp+var_2], 117h
	jge	short l_checkKey
	mov	ax, [bp+var_2]
	sub	ax, 110h
	jmp	short l_return
l_checkKey:
	cmp	[bp+var_2], 30h	
	jle	short l_ioLoopEntry
	cmp	[bp+var_2], 38h	
	jge	short l_ioLoopEntry
	mov	ax, [bp+var_2]
	sub	ax, 31h	
l_return:
	mov	sp, bp
	pop	bp
	retf
getCharacterRace endp

; Returns the character	number of the character	name.
; Returns -1 if	there is no character by the provided
; name in the party
;
; DWORD - _offset & _segment
;

; Attributes: bp-based frame

party_nameExists	proc far

	loopCounter= word ptr	-2
	_offset= word ptr  6
	_segment= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+_segment]
	push	[bp+_offset]
	call	strcmp
	add	sp, 8
	or	ax, ax
	jz	l_returnValue
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEntry
	mov	ax, 0FFFFh
	jmp	l_return
l_returnValue:
	mov	ax, [bp+loopCounter]
l_return:
	mov	sp, bp
	pop	bp
	retf
party_nameExists	endp

; This function	returns	the index of the character
; in the saved character list matching "name". If the
; name is not found it returns 0xffff
; Attributes: bp-based frame

roster_nameExists proc far

	counter= word ptr -2
	nameOffset= word ptr  6
	nameString= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+counter], 0
l_loopEntry:
	mov	ax, charSize
	imul	[bp+counter]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+nameString]
	push	[bp+nameOffset]
	call	strcmp
	add	sp, 8
	or	ax, ax
	jz	short l_returnValue
	inc	[bp+counter]
	cmp	[bp+counter], 75
	jl	short l_loopEntry
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnValue:
	mov	ax, [bp+counter]
l_return:
	mov	sp, bp
	pop	bp
	retf
roster_nameExists endp


; This function	prints a string	with a number in
; front	of it. e.g. 1) Wizard
; Attributes: bp-based frame

printListItem proc far

	stringBuf=	word ptr -2Ch
	stringBufP= dword ptr -4
	indexNumber= byte ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2Ch
	call	someStackOperation

	lea	ax, [bp+stringBuf]
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], ss
	lfs	bx, [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	al, [bp+indexNumber]
	add	al, '1'
	mov	fs:[bx], al
	lfs	bx, [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	byte ptr fs:[bx], ')'
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	call	strcat
	add	sp, 8
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printListItem endp

; Attributes: bp-based frame

camp_deleteMember proc far

	counter= word ptr -15Ch
	nameToDelete= word ptr -15Ah
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

	call	text_clear
	push	cs
	call	near ptr roster_countCharacters
	or	ax, ax
	jz	l_noSavedCharacters
	mov	[bp+counter], 0
	mov	[bp+nameToDelete], 0
l_partyLoopEntry:
	cmp	[bp+nameToDelete], 10
	jge	l_partyLoopExit
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+counter]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_partyLoopEntry
l_partyLoopExit:
	dec	[bp+counter]
	mov	ax, [bp+counter]
	mov	[bp+var_156], ax
	mov	[bp+nameToDelete], 0
l_characterLoopEntry:
	cmp	[bp+nameToDelete], 75
	jge	l_characterLoopExit
	mov	ax, [bp+counter]
	sub	ax, [bp+var_156]
	mov	cx, charSize
	imul	cx
	add	ax, 0
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_154], ax
	mov	word ptr [bp+si+var_154+2], seg	seg022
	mov	si, [bp+counter]
	inc	[bp+counter]
	inc	[bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	cmp	byte ptr fs:[bx], 0
	jnz	short l_characterLoopEntry
l_characterLoopExit:
	dec	[bp+counter]
	push	[bp+counter]
	lea	ax, [bp+var_154]
	push	ss
	push	ax
	mov	ax, offset s_deleteWho
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+nameToDelete], ax
	or	ax, ax
	jl	l_return
	mov	ax, [bp+var_156]
	cmp	[bp+nameToDelete], ax
	jge	short l_checkInParty
	push	[bp+nameToDelete]
	push	cs
	call	near ptr camp_deleteParty
	add	sp, 2
	jmp	l_return
l_checkInParty:
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	push	cs
	call	near ptr party_nameExists
	add	sp, 4
	or	ax, ax
	jl	short l_verifyDelete
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printStringWClear
	add	sp, 4

	mov	ax, offset s_currentlyInParty
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	l_return
l_verifyDelete:
	mov	ax, offset s_confirmDelete
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	si, [bp+nameToDelete]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_154+2]
	push	word ptr [bp+si+var_154]
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short l_return
	mov	ax, [bp+nameToDelete]
	mov	[bp+var_158], ax
l_packRoster:
	mov	ax, [bp+counter]
	cmp	[bp+var_158], ax
	jge	short l_zeroName
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
	inc	[bp+var_158]
	jmp	short l_packRoster
l_zeroName:
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_154]
	mov	byte ptr fs:[bx], 0
	jmp	short l_return
l_noSavedCharacters:
	mov	ax, offset s_noCharsOnDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_deleteMember endp


; Attributes: bp-based frame

camp_deleteParty proc far

	outputStringBufP= dword ptr -10Ah
	partyBuf= dword ptr -106h
	var_102= word ptr -102h
	outputStringBuf= word ptr -100h
	partyIndexNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si

	mov	ax, [bp+partyIndexNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+partyBuf], ax
	mov	word ptr [bp+partyBuf+2], seg seg022
	mov	ax, offset s_confirmDelete
	push	ds
	push	ax
	lea	ax, [bp+outputStringBuf]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx

	push	word ptr [bp+partyBuf+2]
	push	word ptr [bp+partyBuf]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx

	lfs	bx, dword ptr [bp+outputStringBufP]
	inc	word ptr [bp+outputStringBufP]
	mov	byte ptr fs:[bx], '?'
	lfs	bx, dword ptr [bp+outputStringBufP]
	inc	word ptr [bp+outputStringBufP]
	mov	byte ptr fs:[bx], 0

	lea	ax, [bp+outputStringBuf]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short l_return
	mov	ax, [bp+partyIndexNumber]
	mov	[bp+var_102], ax
l_packPartyBuf:
	cmp	[bp+var_102], 9
	jge	short l_zeroPartyBuf
	mov	ax, word ptr [bp+partyBuf]
	mov	dx, word ptr [bp+partyBuf+2]
	add	ax, 80h
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx
	mov	ax, 80h
	push	ax
	push	dx
	push	word ptr [bp+outputStringBufP]
	push	dx
	push	word ptr [bp+partyBuf]
	call	memcpy
	add	sp, 0Ah
	mov	ax, word ptr [bp+outputStringBufP]
	mov	dx, word ptr [bp+outputStringBufP+2]
	mov	word ptr [bp+partyBuf], ax
	mov	word ptr [bp+partyBuf+2], dx
	inc	[bp+var_102]
	jmp	short l_packPartyBuf
l_zeroPartyBuf:
	mov	word ptr [bp+partyBuf], offset g_partyBufTail
	mov	word ptr [bp+partyBuf+2], seg seg022
	mov	[bp+var_102], 0
l_zeroPartyBufLoopEntry:
	cmp	[bp+var_102], 80h
	jge	short l_return
	mov	bx, [bp+var_102]
	lfs	si, [bp+partyBuf]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_102]
	jmp	short l_zeroPartyBufLoopEntry
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_deleteParty endp

; Attributes: bp-based frame

camp_saveParty proc far

	savedPartyCount=	word ptr -18h
	partyName=	word ptr -16h
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 18h
	call	someStackOperation

	mov	ax, offset s_askPartyName
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 0Eh
	push	ax
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	or	ax, ax
	jz	short l_return
	push	cs
	call	near ptr roster_countParties
	mov	[bp+savedPartyCount], ax
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	push	cs
	call	near ptr roster_partyExists
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_13291
	mov	ax, [bp+savedPartyCount]
	mov	[bp+var_2], ax
loc_13291:
	cmp	[bp+var_2], 9
	jg	short l_return
	lea	ax, [bp+partyName]
	push	ss
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr roster_makeParty
	add	sp, 6
l_return:
	mov	sp, bp
	pop	bp
	retf
camp_saveParty endp


; Attributes: bp-based frame

roster_partyExists proc far

	loopCounter= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lea	ax, g_rosterPartyBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	strcmp
	add	sp, 8
	or	ax, ax
	jz	l_returnPartyIndex
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ah
	jl	l_loopEntry
l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return
l_returnPartyIndex:
	mov	ax, [bp+loopCounter]
l_return:
	mov	sp, bp
	pop	bp
	retf
roster_partyExists endp


; Attributes: bp-based frame

; Create the party in the roster's party buffer
;
; DWORD - arg_2 & arg_4

roster_makeParty proc far

	var_6= word ptr	-6
	partyBufP= dword ptr -4
	partyIndexNumber= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	mov	ax, [bp+partyIndexNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+partyBufP], ax
	mov	word ptr [bp+partyBufP+2], seg seg022
	lfs	bx, [bp+partyBufP]
	mov	byte ptr fs:[bx], '>'
	push	[bp+arg_4]
	push	[bp+arg_2]
	mov	ax, word ptr [bp+partyBufP]
	mov	dx, word ptr [bp+partyBufP+2]
	inc	ax
	push	dx
	push	ax
	call	_strcpy
	add	sp, 8
	mov	[bp+var_6], 0
	jmp	short loc_1333C
loc_13339:
	inc	[bp+var_6]
loc_1333C:
	cmp	[bp+var_6], 7
	jge	short loc_1336F
	mov	ax, charSize
	imul	[bp+var_6]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_6]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+partyBufP]
	mov	dx, word ptr [bp+partyBufP+2]
	add	ax, 10h
	push	dx
	push	ax
	call	_strcpy
	add	sp, 8
	jmp	short loc_13339
loc_1336F:
	mov	sp, bp
	pop	bp
	retf
roster_makeParty endp

; Attributes: bp-based frame

roster_countParties proc far

	loopCounter= word ptr	-6
	partyBufferP= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	mov	word ptr [bp+partyBufferP], offset g_rosterPartyBuffer
	mov	word ptr [bp+partyBufferP+2], seg seg022
	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+partyBufferP]
	cmp	byte ptr fs:[bx+si], 0
	jz	l_returnCounter
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ah
	jl	short l_loopEntry
	mov	ax, 0Ah			; Return maximum number of parties
	jmp	short l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
roster_countParties endp


; Attributes: bp-based frame

camp_saveAndExit proc far

	push	bp
	mov	bp, sp

	mov	ax, offset s_saveAndExit
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr roster_writeParty
	sub	ax, ax
	push	ax
	call	getKey
	add	sp, 2
	cmp	ax, 0Dh
	jnz	short loc_13412
	mov	buildingRvalMaybe, 0FFh
	push	cs
	call	near ptr roster_countCharacters
	push	ax
	push	cs
	call	near ptr writeCharacterFile
	add	sp, 2
	push	cs
	call	near ptr roster_countParties
	push	ax
	push	cs
	call	near ptr writePartyFile
	add	sp, 2
loc_13412:
	call	text_clear
	mov	sp, bp
	pop	bp
	retf
camp_saveAndExit endp

; Attributes: bp-based frame

camp_exit	proc far

	push	bp
	mov	bp, sp

	push	cs
	call	near ptr roster_writeParty
	push	cs
	call	near ptr roster_countCharacters
	push	ax
	push	cs
	call	near ptr writeCharacterFile
	add	sp, 2
	push	cs
	call	near ptr roster_countParties
	push	ax
	push	cs
	call	near ptr writePartyFile
	add	sp, 2

	mov	g_currentHour, 6
	sub	al, al
	mov	levelNoMaybe, al
	mov	gs:isNight, al
	mov	buildingRvalMaybe, 2

	mov	sp, bp
	pop	bp
	retf
camp_exit	endp

; Attributes: bp-based frame

camp_enter proc	far

	lastActiveSlot=	word ptr -58h
	loopCounter=	word ptr -56h
	mouseBitmask=	word ptr -54h
	optionKeys=	word ptr -52h
	currentKey=	word ptr -3Eh
	optionMouse=	word ptr -3Ch
	campOptionList=	word ptr -14h

	push	bp
	mov	bp, sp
	mov	ax, 58h
	call	someStackOperation
	push	si

	call	endNoncombatSong

	; End all duration spells when entering camp
	mov	[bp+loopCounter], 0
l_durationSpellLoopEntry:
	mov	bx, [bp+loopCounter]
	cmp	lightDuration[bx], 0
	jz	short l_notActive
	push	bx
	call	icon_deactivate
	add	sp, 2
l_notActive:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_durationSpellLoopEntry

	mov	gs:gl_detectSecretDoorFlag, 0
	mov	gs:songACBonus,	0
	push	cs
	call	near ptr readRosterFiles
	push	cs
	call	near ptr roster_writeParty
	mov	ax, offset s_ruinTitle
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	sub	ax, ax
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
l_mainIoLoopEntry:
	call	text_clear
	lea	ax, [bp+campOptionList]
	push	ss
	push	ax
	push	cs
	call	near ptr camp_configOptionList
	add	sp, 4
	lea	ax, [bp+optionMouse]
	push	ss
	push	ax
	lea	ax, [bp+optionKeys]
	push	ss
	push	ax
	lea	ax, [bp+campOptionList]
	push	ss
	push	ax
	mov	ax, offset s_campMenuString
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+mouseBitmask], ax
	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+lastActiveSlot], ax
	mov	ax, [bp+mouseBitmask]
	or	ah, 20h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+currentKey], ax

	cmp	ax, '0'			; Print character if 1-7
	jle	short l_checkKeyAgainstOptions
	mov	ax, [bp+lastActiveSlot]
	add	ax, '1'
	cmp	ax, [bp+currentKey]
	jle	short l_checkKeyAgainstOptions
	mov	ax, [bp+currentKey]
	sub	ax, '1'
	push	ax
	call	printCharacter
	add	sp, 2
	sub	ax, ax
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset s_ruinTitle
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_135A7

l_checkKeyAgainstOptions:
	mov	[bp+loopCounter], 0
loc_13569:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+optionKeys], 0
	jz	short loc_135A7

	mov	al, byte ptr [bp+si+optionKeys]
	cbw
	cmp	ax, [bp+currentKey]
	jz	short l_executeCampFunction
	shl	si, 1
	mov	ax, [bp+currentKey]
	cmp	[bp+si+optionMouse], ax
	jnz	short loc_135A2

l_executeCampFunction:
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_campActionFunctions[bx]
	cmp	buildingRvalMaybe, 0
	jz	short loc_135A2
	mov	ax, buildingRvalMaybe
	jmp	short loc_135AA
loc_135A2:
	inc	[bp+loopCounter]
	jmp	short loc_13569
loc_135A7:
	jmp	l_mainIoLoopEntry
loc_135AA:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_enter endp



; Attributes: bp-based frame

readRosterFiles proc far

	bufferP= dword ptr -0Ah
	loopCounter= word ptr	-6
	fileDescriptor= word ptr	-4
	characterCount= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation

	push	si
	mov	word ptr [bp+bufferP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
	jmp	short loc_135CF
loc_135CC:
	inc	[bp+loopCounter]
loc_135CF:
	cmp	[bp+loopCounter], 4Bh	
	jge	short loc_135E6
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_135CC
loc_135E6:
	mov	ax, offset s_thievesInf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+fileDescriptor], ax
	mov	ax, 9000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fileDescriptor]
	call	read
	add	sp, 8
	push	[bp+fileDescriptor]
	call	close
	add	sp, 2
	push	cs
	call	near ptr roster_countCharacters
	mov	[bp+characterCount], ax
	mov	[bp+loopCounter], ax
	jmp	short loc_13626
loc_13623:
	inc	[bp+loopCounter]
loc_13626:
	cmp	[bp+loopCounter], 75
	jge	short loc_1363D
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13623
loc_1363D:
	mov	word ptr [bp+bufferP], offset g_rosterPartyBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
	jmp	short loc_13651
loc_1364E:
	inc	[bp+loopCounter]
loc_13651:
	cmp	[bp+loopCounter], 0Ah
	jge	short loc_13667
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_1364E
loc_13667:
	mov	ax, offset s_partiesInf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+fileDescriptor], ax
	mov	ax, 500h
	push	ax
	mov	ax, offset g_rosterPartyBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fileDescriptor]
	call	read
	add	sp, 8
	push	cs
	call	near ptr roster_countParties
	mov	[bp+loopCounter], ax
	jmp	short loc_13699
loc_13696:
	inc	[bp+loopCounter]
loc_13699:
	cmp	[bp+loopCounter], 0Ah
	jge	short loc_136AF
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13696
loc_136AF:
	push	[bp+fileDescriptor]
	call	close
	add	sp, 2
	mov	ax, [bp+characterCount]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
readRosterFiles endp

; Attributes: bp-based frame

writeCharacterFile proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset s_thievesInf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, charSize
	imul	[bp+arg_0]
	inc	ax
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_2]
	call	write
	add	sp, 8
	push	[bp+var_2]
	call	close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
writeCharacterFile endp

; Attributes: bp-based frame

writePartyFile proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset s_partiesInf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	inc	ax
	push	ax
	mov	ax, offset g_rosterPartyBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_2]
	call	write
	add	sp, 8
	push	[bp+var_2]
	call	close
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
writePartyFile endp

; Attributes: bp-based frame

roster_writeParty proc far

	emptySlot= word ptr -4
	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation

	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+emptySlot],	ax
	mov	[bp+counter], 0
	jmp	short loc_13769
loc_13766:
	inc	[bp+counter]
loc_13769:
	mov	ax, [bp+emptySlot]
	cmp	[bp+counter], ax
	jge	l_return
	push	[bp+counter]
	call	roster_writeCharacter
	add	sp, 2
	jmp	loc_13766
l_return:
	mov	sp, bp
	pop	bp
	retf
roster_writeParty endp

; Attributes: bp-based frame

roster_writeCharacter proc far
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr roster_nameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short l_overwrite
	push	cs
	call	near ptr roster_countCharacters
	mov	[bp+var_2], ax
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	jmp	short l_return

l_overwrite:
	mov	ax, charSize
	imul	[bp+var_4]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8

l_return:
	mov	sp, bp
	pop	bp
	retf
roster_writeCharacter endp

; Attributes: bp-based frame

; DWORD - arg_0 & arg_2, arg_4 & arg_6

copyCharacterBuf proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp

	mov	ax, 78h	
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
copyCharacterBuf endp


; This function	counts the number of characters	in
; the ioBuffer memory area.
; Attributes: bp-based frame

roster_countCharacters	proc far

	bufferP= dword ptr -6
	loopCounter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	mov	word ptr [bp+bufferP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
loc_13842:
	cmp	[bp+loopCounter], 75
	jge	loc_13858
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	lfs	si, [bp+bufferP]
	cmp	fs:[bx+si+character_t._name], 0
	jz	short loc_13858
	inc	[bp+loopCounter]
	jmp	short loc_13842
loc_13858:
	mov	ax, [bp+loopCounter]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
roster_countCharacters	endp

; This function creates a byte array to determine what
; menu items are available in the Camp
;
; a[0] - Add a member
; a[1] - Remove a member
; a[2] - Rename a member
; a[3] - Create a member
; a[4] - Transfer characters
; a[5] - Delete a member
; a[6] - Save the party
; a[7] - Leave the game
; a[8] - Enter wilderness

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
	call	near ptr party_findEmptySlot
	cmp	ax, 7
	jge	short loc_1387B
	mov	al, 1
	jmp	short l_setElementZero
loc_1387B:
	sub	al, al
l_setElementZero:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.hasEmptySlot], al	; Add a member

	push	cs
	call	near ptr party_isNotEmpty
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.notEmpty], al		; Remove a member

	cmp	fs:[bx+campStru_t.notEmpty], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+campStru_t.isEmpty], al		; Rename a member

	push	cs
	call	near ptr roster_countCharacters
	cmp	ax, 75
	jge	short loc_138AB
	mov	al, 1
	jmp	short l_setElementThree
loc_138AB:
	sub	al, al
l_setElementThree:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+campStru_t.canSaveChar],	al	; Create a member

	mov	al, fs:[bx+campStru_t.canSaveChar]
	mov	fs:[bx+campStru_t.canSaveChar_1], al	; Transfer characters

	mov	[bp+counter], campStru_t.field_5	; Set the rest to 1
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
	mov	fs:[bx+campStru_t.field_6], al		; Save the party
	push	cs
	call	near ptr party_getLastSlot
	cmp	ax, 7
	jge	short loc_138F3
	mov	al, 1
	jmp	short loc_138F5
loc_138F3:
	sub	al, al
loc_138F5:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+8], al				; Enter Wilderness
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_configOptionList endp


; This function	searches through the roster looking
; for an entry that has	0 as the first character of
; the name field.
; Attributes: bp-based frame

party_findEmptySlot proc	far

	loopCounter= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_returnCounter
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEntry
	mov	ax, 7
	jmp	short l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	mov	sp, bp
	pop	bp
	retf
party_findEmptySlot endp

; This function	returns	1 if roster slot zero
; is occupied. Zero otherwise
; Attributes: bp-based frame

party_isNotEmpty	proc far
	push	bp
	mov	bp, sp
	cmp	gs:party._name, 1
	sbb	ax, ax
	inc	ax
	mov	sp, bp
	pop	bp
	retf
party_isNotEmpty	endp


; This function	starts at the end of the roster	and
; returns the index of the last	slot that still	has
; a character active
; Attributes: bp-based frame

party_getLastSlot proc far

	loopCounter= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 6
l_loopEntry:
	push	[bp+loopCounter]
	push	cs
	call	near ptr party_isSlotActive
	add	sp, 2
	or	ax, ax
	jnz	l_returnCounter
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	l_loopEntry
	mov	ax, 99
	jmp	l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	mov	sp, bp
	pop	bp
	retf
party_getLastSlot endp

; This function	returns	0 if the roster	slot at	slotNo
; is empty, field_67 !=	0, or field_2d & 1c
; Attributes: bp-based frame

party_isSlotActive proc	far

	slotNo=	word ptr  6

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+slotNo]
	mov	bx, ax
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_returnZero

	mov	ax, charSize
	imul	[bp+slotNo]
	mov	bx, ax
	cmp	gs:(party.specAbil+3)[bx], 0
	jnz	short l_returnZero

	mov	ax, charSize
	imul	[bp+slotNo]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
party_isSlotActive endp

; Attributes: bp-based frame

tav_enter proc far

	loopCounter= word ptr -6
	lastCharNo= word ptr -4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+lastCharNo], ax

	; Reset drunk status
	mov	[bp+loopCounter], 0
l_resetDrunkLoop:
	mov	bx, [bp+loopCounter]
	mov	tav_drunkLevel[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_resetDrunkLoop

	mov	ax, 83
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	push	cs
	call	near ptr tav_setTitle
	add	sp, 2
	mov	tavern_sayingBase, ax
l_tavernMainLoop:
	mov	ax, offset s_tavernGreeting
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 70h	
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_2], ax
	jmp	short l_optionSwitch

l_orderDrink:
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tav_orderDrink
	add	sp, 2
	or	ax, ax
	jz	short l_refreshParty
	sub	ax, ax
	jmp	short l_return
l_refreshParty:
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_talkToBarkeep:
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tavern_talkToBarkeep
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_waitAndLoop

l_exitTavern:
	call	text_clear
	sub	ax, ax
	jmp	short l_return

l_optionSwitch:
	cmp	ax, 'E'
	jz	short l_exitTavern
	cmp	ax, 'O'
	jz	short l_orderDrink
	cmp	ax, 'T'
	jz	short l_talkToBarkeep
	cmp	ax, 112h
	jz	short l_orderDrink
	cmp	ax, 113h
	jz	short l_talkToBarkeep
	cmp	ax, 114h
	jz	short l_exitTavern
	jmp	l_tavernMainLoop
l_waitAndLoop:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	l_tavernMainLoop
l_return:
	mov	sp, bp
	pop	bp
	retf
tav_enter endp

; Attributes: bp-based frame

; DWORD var_2 & var_4

tav_orderDrink proc far

	var_112= word ptr -112h
	var_12=	word ptr -12h
	drinkIndexNumber=	word ptr -10h
	var_E= word ptr	-0Eh
	orderer= word ptr	-0Ch
	inputKey= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	lastCharNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 112h
	call	someStackOperation

	mov	ax, offset s_whoWillOrder
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	push	cs
	call	near ptr readSlotNumber
	mov	[bp+orderer], ax
	or	ax, ax
	jl	l_returnZero

	mov	ax, charSize
	imul	[bp+orderer]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead or stat_stoned or stat_paralyzed
	jz	short l_orderLoopEntry

	mov	bx, [bp+orderer]
	mov	tav_drunkLevel[bx], maxDrunkLevel
	jmp	l_checkDrunkLevel

l_orderLoopEntry:
	mov	ax, offset s_seatThyself
	push	ds
	push	ax
	lea	ax, [bp+var_112]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, charSize
	imul	[bp+orderer]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	strcat
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
	mov	ax, offset s_drinkOptions
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13B8D:
	push	[bp+var_6]
	call	getKey
	add	sp, 2
	mov	[bp+inputKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_returnZero
	cmp	ax, 119h
	jz	l_returnZero
	mov	[bp+var_12], 1
	mov	[bp+var_E], 0
	jmp	short loc_13BB9
loc_13BB6:
	inc	[bp+var_E]
loc_13BB9:
	cmp	[bp+var_E], 5
	jge	short loc_13BE7
	mov	bx, [bp+var_E]
	mov	al, byte ptr s_drinkOptionKeys[bx]
	cbw
	cmp	ax, [bp+inputKey]
	jz	short loc_13BD9
	mov	ax, bx
	add	ax, [bp+var_8]
	add	ax, 10Eh
	cmp	ax, [bp+inputKey]
	jnz	short loc_13BE5
loc_13BD9:
	mov	ax, bx
	mov	[bp+drinkIndexNumber], ax
	mov	[bp+var_12], 0
	jmp	short loc_13BE7
loc_13BE5:
	jmp	short loc_13BB6
loc_13BE7:
	cmp	[bp+var_12], 0
	jnz	short loc_13B8D
l_checkDrunkLevel:
	mov	bx, [bp+orderer]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short l_payForDrink
	mov	ax, offset s_cantOrder
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	[bp+lastCharNo]
	push	cs
	call	near ptr tav_isPartyDrunk
	add	sp, 2
	or	ax, ax
	jz	l_returnZero
	mov	ax, offset s_partyIsDisgrace
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	g_currentHour, 16h
	mov	ax, 1
	jmp	l_return

l_payForDrink:
	; BUG - This should probably be [bp+drinkIndexOrder]. As it is, the amount paid
	; for the drink is dependent on which party slot the drinker is in. The character
	; in slot 7 actually pays 0 for each drink.
	;
	mov	bx, [bp+orderer]
	mov	al, g_drinkPriceList[bx]
	cbw
	cwd
	push	dx
	push	ax
	push	bx
	push	cs
	call	near ptr character_removeGold
	add	sp, 6
	or	ax, ax
	jz	short l_notEnoughGold
	mov	ax, offset s_hereOrToGo
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

l_hereToGoLoopEntry:
	mov	ax, 6
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+inputKey], ax
	jmp	short l_hereToGoSwitch

l_drinkHere:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	push	cs
	call	near ptr tavern_drink
	add	sp, 4
	jmp	l_returnZero

l_drinkToGo:
	push	[bp+drinkIndexNumber]
	push	[bp+orderer]
	push	cs
	call	near ptr tavern_getWineskin
	add	sp, 4
	jmp	short l_returnZero

l_hereToGoSwitch:
	cmp	ax, 'H'
	jz	short l_drinkHere
	cmp	ax, 'T'
	jz	short l_drinkToGo
	cmp	ax, 10Fh
	jz	short l_drinkHere
	cmp	ax, 110h
	jz	short l_drinkToGo
	jmp	short l_hereToGoLoopEntry

l_notEnoughGold:
	mov	ax, offset s_notEnoughGold
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
tav_orderDrink endp

; Attributes: bp-based frame

; DWORD: arg_2 & goldAmount

character_removeGold	proc far

	partySlotNumber= word ptr	 6
	arg_2= word ptr	 8
	goldAmount= word ptr	 0Ah

	push	bp
	mov	bp, sp
	push	si

	mov	ax, [bp+arg_2]
	mov	dx, [bp+goldAmount]
	mov	cx, ax
	mov	bx, dx
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_13CEF
	jb	short loc_13CEB
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_13CEF
loc_13CEB:
	sub	ax, ax
	jmp	short loc_13D0D
loc_13CEF:
	mov	ax, [bp+arg_2]
	mov	dx, bx
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, 1
	jmp	short $+2
loc_13D0D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
character_removeGold	endp

; Attributes: bp-based frame

tavern_drink proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	drinkIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	call	text_clear

	cmp	[bp+drinkIndexNumber], 4
	jnz	short loc_13D39
	mov	ax, offset s_thirstQuencher
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	l_return

loc_13D39:
	cmp	[bp+drinkIndexNumber], 3
	jnz	short loc_13D4E
	mov	ax, offset s_goodStuff
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_13D5B

loc_13D4E:
	mov	ax, offset s_burpNotBad
	push	ds
	push	ax
	call	printString
	add	sp, 4

loc_13D5B:
	mov	bx, [bp+arg_0]
	mov	si, [bp+drinkIndexNumber]
	mov	al, tavern_drinkStrength[si]
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

	; Restore bard songs
	mov	ax, charSize
	imul	[bp+arg_0]
	mov	si, ax
	cmp	gs:party.class[si], class_bard
	jnz	short l_return
	mov	ax, gs:party.level[si]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	mov	[bp+var_2], ax
	mov	al, gs:party.specAbil[si]
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jnb	short l_return
	inc	gs:party.specAbil[si]
l_return:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	pop	si
	mov	sp, bp
	pop	bp
	retf
tavern_drink endp

; Attributes: bp-based frame

tavern_getWineskin	proc far

	var_2= word ptr	-2
	partySlotNumber= word ptr	 6
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
	push	[bp+partySlotNumber]
	call	inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short loc_13E22
	mov	ax, offset s_barkeepFillsWineskin
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_13E55
loc_13E22:
	mov	ax, offset s_sorryBut
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset s_cantCarryAnyMore
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_13E55:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
tavern_getWineskin	endp


; Attributes: bp-based frame

tav_isPartyDrunk proc far

	lastCharNo= word ptr  6

	push	bp
	mov	bp, sp

l_loopEntry:
	cmp	[bp+lastCharNo], 0
	jl	short l_returnOne
	mov	bx, [bp+lastCharNo]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short l_returnZero
	dec	[bp+lastCharNo]
	jmp	short l_loopEntry

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
tav_isPartyDrunk endp

; Attributes: bp-based frame

tav_setTitle proc far
	deltaN=	word ptr -8
	counter= word ptr -6
	tavernIndex= word ptr	-4
	deltaE=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	[bp+tavernIndex], 4
	mov	si, g_direction
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaN], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+deltaE], ax

	mov	[bp+counter], 0
l_loopEntry:
	mov	ax, [bp+counter]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	si, ax
	mov	al, byte ptr tavCoords.sqN[si]
	cbw
	cmp	ax, [bp+deltaN]
	jnz	short l_loopIncrement

	mov	al, tavCoords.sqE[si]
	cbw
	cmp	ax, [bp+deltaE]
	jnz	short l_loopIncrement

	mov	al, tavCoords.location[si]
	cbw
	cmp	ax, currentLocationMaybe
	jnz	short l_loopIncrement

	mov	ax, cx
	mov	[bp+tavernIndex], ax
	jmp	short l_setTitleAndReturn
l_loopIncrement:
	inc	[bp+counter]
	cmp	[bp+counter], 4
	jl	l_loopEntry

l_setTitleAndReturn:
	mov	bx, [bp+tavernIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (tavernNames+2)[bx]
	push	word ptr tavernNames[bx]
	call	setTitle
	add	sp, 4
	mov	bx, [bp+tavernIndex]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	al, tavCoords.field_4[bx]
	cbw

	pop	si
	mov	sp, bp
	pop	bp
	retf
tav_setTitle endp


; Attributes: bp-based frame

; DWORD - var_2 & var_4

tavern_talkToBarkeep proc far

	var_A= word ptr	-0Ah
	talkerSlotNumber= word ptr	-8
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation

	mov	ax, offset s_whoTalksToBarkeep
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr readSlotNumber
	mov	[bp+talkerSlotNumber], ax
	or	ax, ax
	jl	l_returnZero

	call	text_clear

	; Check talker drunk level
	mov	bx, [bp+talkerSlotNumber]
	cmp	tav_drunkLevel[bx], 0Ch
	jge	l_noConditionToTalk

	mov	ax, offset s_talkAintCheap
	push	ds
	push	ax
	call	printString
	add	sp, 4

	mov	bx, [bp+talkerSlotNumber]
	cmp	tav_drunkLevel[bx], 5
	jl	short l_skipNameCalling

	mov	ax, offset s_beerBreath
	push	ds
	push	ax
	call	printString
	add	sp, 4

l_skipNameCalling:
	mov	ax, offset s_barkeepSays
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset s_howMuchWillTip
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	readGold
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	or	dx, ax
	jz	l_return
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+talkerSlotNumber]
	push	cs
	call	near ptr character_removeGold
	add	sp, 6
	or	ax, ax
	jnz	short l_hasEnoughGold

	mov	ax, offset s_notEnoughGold
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short l_return

l_hasEnoughGold:
	mov	ax, charSize
	imul	[bp+talkerSlotNumber]
	mov	bx, ax
	mov	ax, word ptr gs:party.gold[bx]
	or	ax, word ptr gs:(party.gold+2)[bx]
	jz	short l_gaveAllGold
	mov	[bp+var_A], 4

	jmp	short loc_14020
loc_1401D:
	dec	[bp+var_A]
loc_14020:
	cmp	[bp+var_A], 0
	jl	short l_return
	mov	bx, [bp+var_A]
	mov	al, byte_43876[bx]
	sub	ah, ah
	sub	dx, dx
	cmp	dx, [bp+var_2]
	ja	short loc_1401D
	jb	short loc_1403D
	cmp	ax, [bp+var_4]
	jnb	short loc_1401D
loc_1403D:
	add	bx, tavern_sayingBase
	shl	bx, 1
	shl	bx, 1
	push	word ptr (barkeepSayings+2)[bx]
	push	word ptr barkeepSayings[bx]
	call	printString
	add	sp, 4
	jmp	short l_return

l_gaveAllGold:
	mov	ax, offset s_moneyTalks
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short l_return

l_noConditionToTalk:
	mov	ax, offset s_noConditionToTalk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
tavern_talkToBarkeep endp

; Attributes: bp-based frame

temple_enter proc far

	lastSlot= word ptr	-4
	inputKey= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	call	text_clear
	mov	ax, 49
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	push	cs
	call	near ptr temple_setTitle
	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+lastSlot], ax
l_templeIoLoopEntry:
	mov	ax, offset s_templeGreeting
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

l_badKey:
	mov	ax, 70h	
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+inputKey], ax

	; Subtract 4 if selected with mouse
	cmp	ax, 10Eh
	jl	short l_skipMouseSubtract
	cmp	ax, 119h
	jg	short l_skipMouseSubtract
	sub	[bp+inputKey], 4

l_skipMouseSubtract:
	mov	ax, [bp+inputKey]
	jmp	short l_keySwitch
l_healCharacter:
	push	cs
	call	near ptr temple_getHealee
	jmp	short l_ioWaitAndLoop
l_poolGold:
	push	[bp+lastSlot]
	push	cs
	call	near ptr temple_getGoldPoolee
	add	sp, 2
l_ioWaitAndLoop:
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	l_templeIoLoopEntry
l_keySwitch:
	cmp	ax, 'E'
	jz	short l_returnZero
	cmp	ax, 'H'
	jz	short l_healCharacter
	cmp	ax, 'P'
	jz	short l_poolGold
	cmp	ax, 10Eh
	jz	short l_healCharacter
	cmp	ax, 10Fh
	jz	short l_poolGold
	cmp	ax, 110h
	jz	short l_returnZero
	jmp	l_badKey
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
temple_enter endp

; Attributes: bp-based frame

; DWORD - var_108 & var_10A

temple_getHealee proc far

	deltaHP= word ptr -112h
	payee= word ptr	-110h
	statusAilment= word ptr	-10Eh
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	stringBuffer= word ptr -104h
	healeeSlotNumber= word ptr	-4
	healCost= word ptr -2
	lastPartySlot= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 112h
	call	someStackOperation
	push	si

	mov	ax, offset s_whoNeedsHealing
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	push	cs
	call	near ptr readSlotNumber
	mov	[bp+healeeSlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+lastPartySlot]
	cmp	[bp+healeeSlotNumber], ax
	jge	l_return

	mov	ax, charSize
	imul	[bp+healeeSlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	push	[bp+healeeSlotNumber]
	push	cs
	call	near ptr temple_getStatusAilment
	add	sp, 2
	mov	[bp+statusAilment], ax
	or	ax, ax
	jz	short l_noStatusAilment
	mov	ax, offset s_isInBadShape
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_thouMustSacrifice
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+statusAilment]
	push	[bp+healeeSlotNumber]
	push	cs
	call	near ptr temple_getHealPrice
	add	sp, 4
	mov	[bp+healCost], ax
	jmp	l_getPayer
l_noStatusAilment:
	mov	ax, charSize
	imul	[bp+healeeSlotNumber]
	mov	si, ax
	mov	ax, gs:party.maxHP[si]
	sub	ax, gs:party.currentHP[si]
	mov	[bp+deltaHP], ax
	or	ax, ax
	jnz	short l_healHpAmount

	mov	ax, gs:party.maxLevel[si]
	cmp	gs:party.level[si], ax
	jnz	short l_healLevelDrain

	mov	ax, offset s_dontNeedHealing
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	l_return

l_healLevelDrain:
	mov	ax, offset s_drainedOfLife
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, 8
	push	ax
	push	[bp+healeeSlotNumber]
	push	cs
	call	near ptr temple_getHealPrice
	add	sp, 4
	mov	[bp+healCost], ax
	jmp	short l_getPayer
l_healHpAmount:
	mov	ax, offset s_hasWounds
	push	ds
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	strcat
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
	mov	ax, offset s_donationWillBe
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
l_getPayer:
	sub	ax, ax
	push	ax
	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_templeGoldForfeit
	push	ds
	push	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr readSlotNumber
	mov	[bp+payee], ax
	or	ax, ax
	jl	l_return

	mov	ax, [bp+healCost]
	cwd
	push	dx
	push	ax
	push	[bp+payee]
	push	cs
	call	near ptr character_removeGold
	add	sp, 6
	or	ax, ax
	jnz	short l_clearStatus
	mov	ax, offset s_sorryButWithoutProper
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	l_return
l_clearStatus:
	cmp	[bp+statusAilment], 0
	jz	short l_healLevel
	push	[bp+statusAilment]
	push	[bp+healeeSlotNumber]
	push	cs
	call	near ptr temple_clearStatusAilment
	add	sp, 4
	jmp	short l_layHands
l_healLevel:
	mov	ax, charSize
	imul	[bp+healeeSlotNumber]
	mov	si, ax
	mov	ax, gs:party.maxLevel[si]
	cmp	gs:party.level[si], ax
	jz	short l_healHp
	dec	ax
	push	ax
	push	[bp+healeeSlotNumber]
	push	cs
	call	near ptr getLevelXp
	add	sp, 4
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	mov	ax, charSize
	imul	[bp+healeeSlotNumber]
	mov	si, ax
	mov	ax, gs:party.maxLevel[si]
	mov	gs:party.level[si], ax
	jmp	short l_layHands
l_healHp:
	mov	ax, charSize
	imul	[bp+healeeSlotNumber]
	mov	si, ax
	mov	ax, gs:party.maxHP[si]
	mov	gs:party.currentHP[si], ax
l_layHands:
	mov	ax, offset s_layHands
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	xor	ax, ax
	push	ax
	mov	ax, 3
	push	ax
	push	[bp+healeeSlotNumber]
	push	dx
	push	[bp+var_10A]
	push	cs
	call	near ptr printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_elipsis
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_elipsisAnd
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	sub	ax, ax
	push	ax
	push	ax
	push	[bp+healeeSlotNumber]
	push	dx
	push	[bp+var_10A]
	push	cs
	call	near ptr printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, offset s_isHealed
	push	ds
	push	ax
	push	dx
	push	[bp+var_10A]
	call	strcat
	add	sp, 8
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
temple_getHealee endp

; Attributes: bp-based frame

; XXX - arg_4 should probably be a word ptr

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
	mov	cx, monStruSize
	imul	cx
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
	call	unmaskString
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
	mov	al, gs:party.gender[si]
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_2], ax
	cmp	ax, 3
	jnz	short loc_14564
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	strcat
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
	call	strcat
	add	sp, 8
loc_14586:
	cmp	[bp+arg_8], 0
	jz	printCharPronoun_exit
	mov	ax, offset s_exclBlankLine
	push	ds
	push	ax
	push	dx
	push	ax
	call	strcat
	add	sp, 8

printCharPronoun_exit:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printCharPronoun endp

; Attributes: bp-based frame

temple_setTitle	proc far

	deltaNS= word ptr	-8
	loopCounter= word ptr	-6
	templeIndex= word ptr	-4
	deltaEW= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	si, g_direction
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+deltaNS], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+deltaEW], ax
	mov	[bp+templeIndex], 3

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	si, [bp+loopCounter]
	mov	cl, 2
	shl	si, cl
	mov	al, byte ptr templeLoc.sqN[si]
	sub	ah, ah
	cmp	ax, [bp+deltaNS]
	jnz	short l_loopIncrement

	mov	al, templeLoc.sqE[si]
	cmp	ax, [bp+deltaEW]
	jnz	short l_loopIncrement

	mov	al, templeLoc.location[si]
	cmp	ax, currentLocationMaybe
	jnz	short l_loopIncrement

	mov	ax, [bp+loopCounter]
	mov	[bp+templeIndex], ax
	jmp	short l_setTitle
l_loopIncrement:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	l_loopEntry
l_setTitle:
	mov	bx, [bp+templeIndex]
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

	targetLevel= word ptr	-2
	targetSlotNumber= word ptr	 6
	ailmentIndex= word ptr	 8

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster
	jb	short loc_14656
	mov	[bp+targetLevel], 1
	jmp	short loc_14670
loc_14656:
	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	sub	ax, 13
	sbb	cx, cx
	and	ax, cx
	add	ax, 13
	mov	[bp+targetLevel], ax
loc_14670:
	mov	bx, [bp+ailmentIndex]
	shl	bx, 1
	mov	ax, temple_healPrice[bx]
	imul	[bp+targetLevel]

	mov	sp, bp
	pop	bp
	retf
temple_getHealPrice endp

; Attributes: bp-based frame

temple_getStatusAilment proc far

	counter= word ptr -4
	status=	word ptr -2
	targetSlotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	mov	al, gs:party.status[bx]
	sub	ah, ah
	mov	[bp+status], ax
	or	ax, ax
	jz	short l_returnZero
	mov	[bp+counter], 6

l_loopEntry:
	mov	bx, [bp+counter]
	mov	al, templeStatusBitmasks[bx]
	sub	ah, ah
	test	[bp+status], ax
	jnz	l_returnValue
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_loopEntry

l_returnValue:
	mov	al, templeHealPriceIndex[bx]
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
temple_getStatusAilment endp

; Attributes: bp-based frame

temple_clearStatusAilment proc far

	targetSlotNumber= word ptr	 6
	ailmentIndex= word ptr	 8

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	si, ax
	mov	bx, [bp+ailmentIndex]
	mov	al, statusHealMask[bx]
	and	gs:party.status[si], al
	mov	gs:party.hostileFlag[si], 0
	mov	ax, [bp+ailmentIndex]
	cmp	ax, 2
	jz	short l_revertAgeStatus

	cmp	ax, 6
	jz	short l_dispossess

	jmp	short l_revertDeath

l_revertAgeStatus:
	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	si, ax
	mov	ax, 5
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
	jmp	short l_return

l_dispossess:
	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	mov	gs:party.currentHP[bx], 1

l_revertDeath:
	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	cmp	gs:party.currentHP[bx], 0
	jnz	short l_return

	mov	ax, charSize
	imul	[bp+targetSlotNumber]
	mov	bx, ax
	mov	gs:party.currentHP[bx], 1

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
temple_clearStatusAilment endp

; Attributes: bp-based frame

temple_getGoldPoolee proc far

	pooleeSlotNumber= word ptr	-2
	lastSlot= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset s_whomGathersGold
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr readSlotNumber
	mov	[bp+pooleeSlotNumber], ax
	or	ax, ax
	jl	short l_return
	mov	ax, [bp+lastSlot]
	cmp	[bp+pooleeSlotNumber], ax
	jge	short l_return

	push	ax
	push	[bp+pooleeSlotNumber]
	push	cs
	call	near ptr doPoolGold
	add	sp, 4
	mov	ax, charSize
	imul	[bp+pooleeSlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, offset s_hathAllTheGold
	push	ds
	push	ax
	call	printString
	add	sp, 4

l_return:
	mov	sp, bp
	pop	bp
	retf
temple_getGoldPoolee endp

; Attributes: bp-based frame

readSlotNumber proc far

	inputKey= word ptr	-2

	push	bp
	mov	bp, sp

l_loopEntry:
	mov	ax, 2000h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+inputKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_returnMinusOne
	cmp	[bp+inputKey], '0'
	jle	short l_loopEntry
	cmp	[bp+inputKey], '8'
	jge	short l_loopEntry
	sub	[bp+inputKey], '1'	
	mov	ax, charSize
	imul	[bp+inputKey]
	mov	bx, ax
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_loopEntry
	mov	ax, [bp+inputKey]
	jmp	short l_return
l_returnMinusOne:
	mov ax, 0FFFFh
l_return:
	mov	sp, bp
	pop	bp
	retf
readSlotNumber endp

; DWORD - var_4 & var_6

; Attributes: bp-based frame

doPoolGold proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	loopCounter= word ptr	-2
	poolTarget= word ptr	 6
	lastSlot= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	sub	ax, ax
	mov	[bp+var_4], ax
	mov	[bp+var_6], ax
	mov	[bp+loopCounter], ax

l_loopEntry:
	mov	ax, [bp+lastSlot]
	cmp	[bp+loopCounter], ax
	jge	short l_giveGold

	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	si, ax
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_loopIncrement

	mov	ax, word ptr gs:party.gold[si]
	mov	dx, word ptr gs:(party.gold+2)[si]
	add	[bp+var_6], ax
	adc	[bp+var_4], dx
	sub	ax, ax
	mov	word ptr gs:(party.gold+2)[si], ax
	mov	word ptr gs:party.gold[si], ax
l_loopIncrement:
	inc	[bp+loopCounter]
	jmp	short l_loopEntry

l_giveGold:
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	cx, ax
	mov	bx, dx
	mov	ax, charSize
	imul	[bp+poolTarget]
	mov	si, ax
	mov	word ptr gs:party.gold[si], cx
	mov	word ptr gs:(party.gold+2)[si], bx
	pop	si
	mov	sp, bp
	pop	bp
	retf
doPoolGold endp


; This function	gets the XP requirements for a
; given	level
;
; XP calculation is:
;   if level > 11
;     add "(level * 400,00) - 4,400,000" to
;   the class specific values for levels 2-11

; DWORD - var_2 & var_4

; Attributes: bp-based frame

getLevelXp proc far

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

	; For levels higher than 11, the xp calculation is
	; (level * 400,000) - 4,400,000
	cmp	[bp+level], 11
	jle	short l_levelUnderTwelve
	mov	ax, 1A80h		; 400,000
	mov	dx, 6
	push	dx
	push	ax
	mov	ax, [bp+level]
	cwd
	push	dx
	push	ax
	call	_level32bitMult
	sub	ax, 2380h		; 4,400,000
	sbb	dx, 43h	
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	[bp+level], 11
	jmp	short l_classSpecificXp
l_levelUnderTwelve:
	sub	ax, ax
	mov	[bp+var_2], ax
	mov	[bp+var_4], ax
l_classSpecificXp:
	mov	ax, charSize
	imul	[bp+playerNo]
	mov	bx, ax
	mov	bl, gs:party.class[bx]
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

	pop	si
	mov	sp, bp
	pop	bp
	mov	sp, bp
	pop	bp
	retf
getLevelXp endp

; Attributes: bp-based frame

empty_enter proc	far
	push	bp
	mov	bp, sp

	call	random
	test	al, 3
	jnz	short l_noBattle

	mov	g_partyAttackFlag, 0
	call	bat_init

l_noBattle:
	cmp	currentLocationMaybe, 1
	jnz	short loc_14956
	mov	ax, 50
	jmp	short loc_14959
loc_14956:
	mov	ax, 69

loc_14959:
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset s_building
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, offset s_emptyBuilding
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	sub	ax, ax

	mov	sp, bp
	pop	bp
	retf
empty_enter endp

; Attributes: bp-based frame
storage_enter proc	far

	push	bp
	mov	bp, sp

	mov	ax, 50
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset s_building
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	push	cs
	call	near ptr readInventoryStf
l_ioLoopEntry:
	mov	ax, offset s_storageMenu
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr readSlotNumber
	or	ax, ax
	jl	short l_return

	push	ax
	push	cs
	call	near ptr storage_getItem
	add	sp, 2
	jmp	short l_ioLoopEntry
l_return:
	push	cs
	call	near ptr writeInventoryStf
	call	text_clear
	mov	buildingRvalMaybe, 2
	sub	ax, ax

	mov	sp, bp
	pop	bp
	retf
storage_enter endp

; Attributes: bp-based frame

; DWORD - var_140 & var_142

storage_getItem proc far

	itemListP= word ptr -372h
	itemList= word ptr -302h
	var_142= word ptr -142h
	var_140= word ptr -140h
	itemListLength= word ptr -13Eh
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
	lea	ax, [bp+itemListP]
	push	ss
	push	ax
	lea	ax, [bp+itemList]
	push	ss
	push	ax
	push	cs
	call	near ptr storage_createItemList
	add	sp, 0Ch
	mov	[bp+itemListLength], ax
	or	ax, ax
	jz	l_empty

	mov	ax, offset s_would
	push	ds
	push	ax
	lea	ax, [bp+var_138]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	mov	ax, charSize
	imul	[bp+arg_0]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_140]
	push	[bp+var_142]
	call	strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	mov	ax, offset s_likeToPickup
	push	ds
	push	ax
	push	dx
	push	[bp+var_142]
	call	strcat
	add	sp, 8
	mov	[bp+var_142], ax
	mov	[bp+var_140], dx
	push	[bp+itemListLength]
	lea	ax, [bp+itemListP]
	push	ss
	push	ax
	lea	ax, [bp+var_138]
	push	ss
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_13A], ax
	or	ax, ax
	jl	l_return
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
	jz	short l_allFull
	mov	bx, [bp+var_13C]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	strg_inventory[bx], 0
	mov	ax, offset s_youPickUpItem
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_delayAndLoop
l_allFull:
	mov	ax, offset s_allFull
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	short l_return
l_empty:
	mov	ax, offset s_buildingIsEmpty
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	short l_return
l_delayAndLoop:
	mov	ax, 4
	push	ax
	call	text_delayNoTable
	add	sp, 2
	jmp	loc_14A05
l_return:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
storage_getItem endp

; Attributes: bp-based frame

writeInventoryStf proc far

	fd= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset a_inventoryStf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+fd], ax
	mov	ax, 54h	
	push	ax
	mov	ax, offset strg_inventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+fd]
	call	write
	add	sp, 8
	push	[bp+fd]
	call	close
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
writeInventoryStf endp

; Attributes: bp-based frame

readInventoryStf proc far

	fd= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, offset a_inventoryStf
	push	ds
	push	ax
	push	cs
	call	near ptr openFile
	add	sp, 4
	mov	[bp+fd], ax
	mov	ax, 84
	push	ax
	mov	ax, offset strg_inventory
	mov	dx, seg	dseg
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	push	[bp+fd]
	call	close
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
readInventoryStf endp


; The state of the 0x46 progress flag determines the items
; that are in the storage building.

; itemList is a string with all of the items in the storage building
; strcat'd together separated by 0
;
; itemListP is a list of pointers to the individual item strings;

; Attributes: bp-based frame

storage_createItemList proc far

	itemListLength= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	itemNumber= word ptr	-2
	itemList= dword ptr  6
	itemListP= dword ptr  0Ah
	arg_8= dword ptr  0Eh

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	[bp+itemListLength], 0
	mov	ax, 46h	
	push	ax
	call	checkProgressFlags
	add	sp, 2
	or	ax, ax
	jz	short l_flagNotSet
	mov	ax, 28
	jmp	short l_loopEntry
l_flagNotSet:
	mov	ax, 18

l_loopEntry:
	mov	[bp+var_6], ax
	mov	[bp+var_4], 0

l_loopHead:
	mov	bx, [bp+var_4]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	al, strg_inventory[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	or	ax, ax
	jz	short l_loopTest
	mov	bx, [bp+itemListLength]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+itemListP]
	mov	ax, word ptr [bp+itemList]
	mov	dx, word ptr [bp+itemList+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	bx, [bp+itemNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (itemStr+2)[bx]
	push	word ptr itemStr[bx]
	push	word ptr [bp+itemList+2]
	push	word ptr [bp+itemList]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+itemList], ax
	mov	word ptr [bp+itemList+2], dx
	lfs	bx, dword ptr [bp+itemList]
	inc	word ptr [bp+itemList]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+itemListLength]
	inc	[bp+itemListLength]
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, [bp+var_4]
	mov	fs:[bx+si], ax

l_loopTest:
	inc	[bp+var_4]
	mov	ax, [bp+var_6]
	cmp	[bp+var_4], ax
	jl	l_loopHead

l_return:
	mov	ax, [bp+itemListLength]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
storage_createItemList endp

; This function	inserts	a new member into the last
; active slot in the party. Dead, paralyzed or	stoned
; members are moved down.
; Attributes: bp-based frame

party_addCharacter proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	emptySlot= word	ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	push	cs
	call	near ptr party_getLastSlot
	mov	[bp+emptySlot],	ax
	cmp	ax, 7
	jge	l_return
	mov	[bp+var_4], 0
loc_14CB5:
	push	cs
	call	near ptr party_getLastSlot
	cmp	ax, [bp+var_4]
	jle	short l_return
	mov	ax, charSize
	imul	[bp+var_4]
	mov	si, ax
	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_14D2B
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party._name[si]
	push	dx
	push	ax
	push	cs
	call	near ptr copyCharacterBuf
	add	sp, 8
	push	[bp+var_4]
	push	cs
	call	near ptr party_pack
	add	sp, 2
	cmp	gs:newCharBuffer.class,	class_illusion
	jz	short loc_14D29
	cmp	gs:newCharBuffer.specAbil+3, 0
	jnz	short loc_14D29
	push	cs
	call	near ptr party_findEmptySlot
	mov	[bp+var_6], ax
	mov	ax, charSize
	imul	[bp+var_6] 
	mov	bx, ax
	lea	ax, party._name[bx]
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
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_addCharacter endp

; Attributes: bp-based frame

; DWORD - arg_0 & arg_2

openFile proc far

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
	call	open
	add	sp, 6
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_14D81
	mov	ax, offset s_insertDisk
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset s_diskTwo
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
loc_14D81:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_14D40
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
openFile endp


seg002 ends

; Segment type: Pure code
seg003 segment byte public 'CODE' use16
        assume cs:seg003
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
; Attributes: bp-based frame

; This function replaces the '3' in the disk3 offset
; to a '1'. Not really useful in a hard drive installation
;

disk1Swap proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp

	cmp	[bp+arg_0], 0
	jz	short l_return
	lfs	bx, disk3
	mov	byte ptr fs:[bx+5], '1'
l_return:
	mov	sp, bp
	pop	bp
	retf
disk1Swap endp

; Attributes: bp-based frame

getYesNo proc far

	inputKey= word ptr	-6
	mouseOffset= word ptr	-4
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
	mov	[bp+mouseOffset], si
	mov	ax, offset s_yesNo
	push	ds
	push	ax
	call	printString
	add	sp, 4
l_loopEntry:
	push	[bp+var_2]
	call	getKey
	add	sp, 2
	mov	[bp+inputKey], ax
	cmp	ax, 10Eh
	jl	short loc_14E0B
	cmp	ax, 119h
	jg	short loc_14E0B
	mov	ax, [bp+mouseOffset]
	sub	[bp+inputKey], ax

loc_14E0B:
	mov	ax, [bp+inputKey]
	cmp	ax, 'N'
	jz	short l_clearAndReturnZero
	cmp	ax, 'Y'	
	jz	short l_clearAndReturnOne
	cmp	ax, 10Eh
	jz	short l_clearAndReturnOne
	cmp	ax, 10Fh
	jz	short l_clearAndReturnZero
	jmp	short l_loopEntry

l_clearAndReturnOne:
	push	cs
	call	near ptr text_clear
	mov	ax, 1
	jmp	short l_return

l_clearAndReturnZero:
	push	cs
	call	near ptr text_clear
	sub	ax, ax
	jmp	short l_return

l_return:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
getYesNo endp


; Attributes: bp-based frame
; Read a key from the user. The mouse can also be used to select an option

getKey proc far

	inputKey= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	spell_mouseClicked, 0
	push	cs
	call	near ptr sub_1766A
l_loopEntry:
	call	checkMouse
	cmp	mouse_moved, 0
	jz	short l_skipMouseUpdate
	call	far ptr	sub_3E974

	push	[bp+arg_0]
	push	cs
	call	near ptr mouse_updateIcon
	add	sp, 2
	push	cs
	call	near ptr sub_1766A

l_skipMouseUpdate:
	push	[bp+arg_0]
	push	cs
	call	near ptr mouse_getClick
	add	sp, 2
	mov	[bp+inputKey], ax
	or	ax, ax
	jz	short l_skipMouseClick
	call	far ptr	sub_3E974
	mov	spell_mouseClicked, 1
	mov	ax, [bp+inputKey]
	jmp	short l_return

l_skipMouseClick:
	call	checkKeyboard
	or	ax, ax
	jz	short loc_14EBE
	call	far ptr	sub_3E974

	call	_readChFromKeyboard
	mov	[bp+inputKey], ax
	or	al, al
	jz	short loc_14EB9
	mov	al, byte ptr [bp+inputKey]
	sub	ah, ah
	push	ax
	call	toUpper
	add	sp, 2
	jmp	short l_return
loc_14EB9:
	mov	ax, [bp+inputKey]
	jmp	short l_return
loc_14EBE:
	push	cs
	call	near ptr doRealtimeEvents
	push	cs
	call	near ptr party_print
	jmp	short l_loopEntry

l_return:
	mov	sp, bp
	pop	bp
	retf
getKey endp

; This function sets the mouse icon. It is only called from
; text_scrollingWindow
;

; Attributes: bp-based frame

mouse_setScrollingIcon proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jl	short l_notInTextWindow
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short l_notInTextWindow
	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jl	short l_notInTextWindow
	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jge	short l_notInTextWindow
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
l_notInTextWindow:
	mov	[bp+var_4], 6
loc_14F3A:
	mov	ax, [bp+var_4]
	cmp	gs:g_currentMouseIcon, ax
	jz	short l_return
	mov	gs:g_currentMouseIcon, ax
	push	ax

	call	far ptr	vid_setMouseIcon
	add	sp, 2
l_return:
	mov	sp, bp
	pop	bp
	retf
mouse_setScrollingIcon endp

; Attributes: bp-based frame

mouse_updateIcon proc far

	var_6= word ptr	-6
	loopCounter= word ptr	-4
	iconNumber= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	test	[bp+arg_0], 4000h
	jnz	l_setIconFive

	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	si, [bp+loopCounter]
	mov	cl, 3
	shl	si, cl
	mov	ax, mouse_x
	cmp	mouseBoxes._left[si],	ax
	jg	short l_loopIncrement
	cmp	mouseBoxes._right[si],	ax
	jle	short l_loopIncrement
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short l_loopIncrement
	cmp	mouseBoxes._bottom[si],	ax
	jg	short l_loopExit

l_loopIncrement:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_loopEntry

l_loopExit:
	mov	ax, [bp+loopCounter]
	or	ax, ax
	jnz	short loc_15064

	; Bitmask 8000h sets the mouse icon when the mouse is in the
	; bigpic area. This is where the direction arrow icons are
	; set
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax		; 8000h
	jz	short l_setIconSix
	cmp	mouse_y, 2Dh 
	jge	short loc_14FDE
	jmp	l_setIconOne

loc_14FDE:
	cmp	mouse_y, 4Bh 
	jle	short loc_14FED
	jmp	short l_setIconTwo

loc_14FED:
	cmp	mouse_x, 4Ah 
	jge	short l_setIconFour
	jmp	short l_setIconThree

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
	jz	short l_setIconSix
	jmp	short l_setIconFive

loc_15040:
	test	[bp+arg_0], 2000h
	jz	short l_setIconSix
	jmp	short l_setIconFive


loc_15064:
	cmp	ax, 1				; Mouse in text window
	jz	short loc_1500E
	cmp	ax, 2				; Mouse in party area
	jz	short loc_15040
	jmp	short l_setIconSix

l_setIconOne:
	mov	[bp+iconNumber], 1
	jmp	short l_setIconAndReturn

l_setIconTwo:
	mov	[bp+iconNumber], 2
	jmp	short l_setIconAndReturn

l_setIconThree:
	mov	[bp+iconNumber], 3
	jmp	short l_setIconAndReturn

l_setIconFour:
	mov	[bp+iconNumber], 4
	jmp	short l_setIconAndReturn

l_setIconFive:
	mov	[bp+iconNumber], 5
	jmp	short l_setIconAndReturn

l_setIconSix:
	mov	[bp+iconNumber], 6

l_setIconAndReturn:
	mov	ax, [bp+iconNumber]
	cmp	gs:g_currentMouseIcon, ax
	jz	short l_return
	mov	gs:g_currentMouseIcon, ax
	push	ax
	call	far ptr	vid_setMouseIcon
	add	sp, 2

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
mouse_updateIcon endp

; Attributes: bp-based frame

mouse_getClick proc far

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
	jz	l_returnZero

	test	[bp+arg_0], 4000h
	jz	short loc_150E9
	mov	ax, 20h	
	jmp	l_return
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
	jg	short loc_150F0
	cmp	mouseBoxes._right[si],	ax
	jle	short loc_150F0
	mov	ax, mouse_y
	cmp	mouseBoxes._top[si],	ax
	jg	short loc_150F0
	cmp	mouseBoxes._bottom[si],	ax
	jle	short loc_150F0
loc_1512C:
	mov	ax, [bp+var_4]
	jmp	loc_151CE
loc_15132:
	mov	ax, [bp+arg_0]
	test	bitMask16bit+1Eh, ax
	jz	short l_returnZero
	cmp	mouse_y, 2Dh 
	jge	short loc_15154
	mov	ax, dosKeys_upArrow
	jmp	l_return
loc_15154:
	cmp	mouse_y, 4Bh 
	jle	short loc_15164
	mov	ax, dosKeys_downArrow
	jmp	l_return
loc_15164:
	cmp	mouse_x, 4Ah 
	jge	short loc_15177
	mov	ax, dosKeys_leftArrow
	jmp	short l_return
loc_15177:
	mov	ax, dosKeys_rightArrow
	jmp	short l_return
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
	jz	short l_returnZero
	mov	ax, [bp+var_6]
	add	ax, 10Eh
	jmp	short l_return
loc_151AD:
	test	[bp+arg_0], 2000h
	jz	short l_returnZero
	mov	ax, mouse_y
	sub	ax, 88h	
	mov	cl, 3
	sar	ax, cl
	add	ax, 30h	
	jmp	short l_return
loc_151CE:
	or	ax, ax
	jz	loc_15132
loc_151D5:
	cmp	ax, 1
	jz	short loc_1517E
	cmp	ax, 2
	jz	short loc_151AD
l_returnZero:
	sub	ax, ax
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
mouse_getClick endp

; Attributes: bp-based frame

readChNoMouse proc far

	inputKey= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	sub	ax, ax
	push	ax
	push	cs
	call	near ptr mouse_getClick
	add	sp, 2
loc_151FF:
	call	checkKeyboard
	or	ax, ax
	jz	short loc_151FF
loc_1520A:
	call	_readChFromKeyboard
	mov	[bp+inputKey], ax
	or	al, al
	jz	short loc_1521D
	mov	al, byte ptr [bp+inputKey]
	sub	ah, ah
	jmp	short loc_15222
loc_1521D:
	mov	ax, [bp+inputKey]
	jmp	short $+2
loc_15222:
	mov	sp, bp
	pop	bp
	retf
readChNoMouse endp

; Attributes: bp-based frame

doRealtimeEvents proc far

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
	call	gfx_animate
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
	jz	loc_1538E
	mov	gs:word_42456, si

	cmp	g_songDuration, 0		; Song timer
	jz	short loc_152E3
	mov	al, g_songDuration
	dec	g_songDuration
	cmp	al, 1
	jnz	short loc_152E3
	call	endNoncombatSong

loc_152E3:
	mov	ax, gs:word_4233E
	dec	gs:word_4233E
	cmp	ax, 1
	jg	short loc_1533E
	mov	gs:word_4233E, 0Ah
	mov	[bp+var_2], 0
l_iconLoopEntry:
	mov	bx, [bp+var_2]
	cmp	lightDuration[bx], 0
	jz	short l_iconLoopIncrement
	cmp	lightDuration[bx], 0FFh
	jz	short l_iconLoopIncrement
	mov	al, lightDuration[bx]
	dec	lightDuration[bx]
	cmp	al, 1
	jnz	short l_iconLoopIncrement
	push	[bp+var_2]
	call	icon_deactivate
	add	sp, 2
l_iconLoopIncrement:
	inc	[bp+var_2]
	cmp	[bp+var_2], 5
	jl	short l_iconLoopEntry

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
	jz	loc_doRealtimeEvents_label_1
	call	party_regenHp

loc_doRealtimeEvents_label_1:
	cmp	gs:byte_41E81, 0
	jz	short loc_1538E
	call	dunsq_drainHp
loc_1538E:
	mov	ax, gs:word_42410
	mov	cl, 6
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	gs:word_42330, ax
	jz	short l_return
	mov	gs:word_42330, ax
	cmp	gs:advanceTimeFlag, 0
	jnz	short l_return

	mov	al, g_currentHour
	inc	g_currentHour
	cmp	al, 23
	jb	short loc_153CF
	mov	g_currentHour, 0		; Set to midnight
loc_153CF:
	cmp	g_currentHour, 6
	jb	short l_setIsNightTonight
	cmp	g_currentHour, 18
	jbe	short l_setIsNightToDay
l_setIsNightTonight:
	mov	al, 1
	jmp	short l_setIsNight
l_setIsNightToDay:
	sub	al, al
l_setIsNight:
	mov	gs:isNight, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
doRealtimeEvents endp

; Attributes: bp-based frame

isAlphaNum proc	far
	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp

	mov	al, [bp+arg_0]
	cbw
	push	ax
	call	toUpper
	add	sp, 2
	mov	[bp+arg_0], al
	cmp	al, 'A'
	jl	short loc_15414
	cmp	al, 'Z'
	jle	short l_returnTrue
loc_15414:
	cmp	[bp+arg_0], '0'
	jl	short l_returnFalse
	cmp	[bp+arg_0], '9'
	jg	short l_returnFalse
l_returnTrue:
	mov	ax, 1
	jmp	short l_return
l_returnFalse:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
isAlphaNum endp

; If the first argument is >=0 then this function checks for input from 
; the keyboard with the first argument as a time limit. If the time limit 
; is reached before a character is entered, the function returns a space (' ').
;
; If the first argument is <0 then this function just calls readChNoMouse
; and returns that functions return value.
;
; Attributes: bp-based frame

timedGetKey proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	timeDelay= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	cmp	[bp+timeDelay], 0
	jge	short l_getkeyWithDelay
	push	cs
	call	near ptr readChNoMouse
	jmp	short l_return
l_getkeyWithDelay:
	mov	ax, [bp+timeDelay]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, _clockTicks
	mov	[bp+var_4], ax
l_timerLoop:
	mov	ax, [bp+var_4]
	cmp	_clockTicks, ax
	jz	short l_returnSpace
	call	checkKeyboard
	or	ax, ax
	jz	short l_timerLoop
	call	_readChFromKeyboard
	mov	[bp+var_2], ax
	or	al, al
	jz	short l_returnKey
	mov	al, byte ptr [bp+var_2]
	sub	ah, ah
	jmp	short l_return
l_returnKey:
	mov	ax, [bp+var_2]
	jmp	short l_return
l_returnSpace:
	mov	ax, 20h	
l_return:
	mov	sp, bp
	pop	bp
	ret
timedGetKey endp

; Attributes: bp-based frame
text_delayNoTable	proc far

	delayTime= word ptr 6

	push	bp
	mov	bp, sp

	sub	ax, ax
	push	ax
	mov	ax, [bp+delayTime]
	shl	ax, 1
	shl	ax, 1
	push	ax
	call	getKeyWithDelay
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
text_delayNoTable	endp

text_delayWithTable	proc far

	push	bp
	mov	bp, sp

	mov	ax, 1
	push	ax
	mov	bl, txtDelayIndex
	sub	bh, bh
	mov	al, txtDelayTable[bx]
	sub	ah, ah
	push	ax
	call	getKeyWithDelay
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
text_delayWithTable	endp

; This is where the print delay occurs during battle.
getKeyWithDelay proc far

	var_2= word ptr	-2
	delayTime= word ptr	 6
	speedupFlag= word ptr 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	cmp	[bp+delayTime], 0
	jl	l_return

	mov	ax, [bp+delayTime]
	add	ax, _clockTicks
	mov	[bp+var_2], ax
	push	cs
	call	near ptr sub_1766A

l_loopEntry:
	call	checkKeyboard
	or	ax, ax
	jz	short l_doTimeEvents
	call	_readChFromKeyboard

	cmp	[bp+speedupFlag], 0
	jz	l_skipFastCheck

	sub	ah, ah
	cmp	ax, '>'
	jz	l_faster
	cmp	ax, '.'
	jnz	l_slowCheck

l_faster:
	mov	al, txtDelayIndex
	dec	txtDelayIndex
	or	al, al
	ja	l_printFaster
	mov	txtDelayIndex, 0
	jmp	l_loopEntry

l_slowCheck:
	cmp	ax, '<'
	jz	l_slower
	cmp	ax, ','
	jnz	l_skipFastCheck

l_slower:
	mov	al, txtDelayIndex
	inc	txtDelayIndex
	cmp	al, 9
	jb	l_printSlower
	mov	txtDelayIndex, 9
	jmp	l_loopEntry

l_printFaster:
	mov	ax, offset aFaster
	jmp	l_doPrint

l_printSlower:
	mov	ax, offset aSlower

l_doPrint:
	push	ds
	push	ax
	func_printString
	jmp	l_loopEntry

l_skipFastCheck:
	call	far ptr	sub_3E974
	jmp	short l_return

l_doTimeEvents:
	call	checkMouse
	push	cs
	call	near ptr doRealtimeEvents
	push	cs
	call	near ptr party_print
	mov	ax, [bp+var_2]
	cmp	_clockTicks, ax
	jl	short loc_1550B
	call	far ptr	sub_3E974
	jmp	short l_return
loc_1550B:
	cmp	mouse_moved, 0
	jz	short loc_15520
	call	far ptr	sub_3E974
	push	cs
	call	near ptr sub_1766A
loc_15520:
	jmp	l_loopEntry
l_return:
	mov	sp, bp
	pop	bp
	retf
getKeyWithDelay endp

; Attributes: bp-based frame

minimap_show proc far

	rowP=	dword ptr -16h
	squareFlags=	word ptr -12h
	nsCounter=	word ptr -10h
	ewCounter=	word ptr -0Eh
	nsValue= word ptr	-0Ch
	ewValue= word ptr	-0Ah
	screenY= word ptr	-08h
	screenX= word ptr	-6
	upDownValue= word ptr	-4
	rightLeftValue= word ptr	-2
	rowPList= dword ptr  6			; Array of points to the dungeon rows
	squareEW= word ptr	 0Ah
	squareNS= word ptr	 0Ch
	leftLimit= word ptr	 0Eh
	downLimit= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 16h
	call	someStackOperation
	push	si

	mov	[bp+rightLeftValue], 8
	mov	[bp+upDownValue], 6
l_loopEntry:
	mov	gs:g_text_clearFlag, 1
	push	cs
	call	near ptr text_clear
	mov	gs:g_text_clearFlag, 1

	mov	[bp+ewCounter], 0
	jmp	short loc_1555E
loc_1555B:
	inc	[bp+ewCounter]
loc_1555E:
	cmp	[bp+ewCounter], 11h
	jge	l_getInput
	mov	ax, [bp+squareEW]
	sub	ax, [bp+rightLeftValue]
	add	ax, [bp+ewCounter]
	mov	[bp+ewValue], ax
	mov	[bp+nsCounter], 0
	jmp	short loc_1557D
loc_1557A:
	inc	[bp+nsCounter]
loc_1557D:
	cmp	[bp+nsCounter], 0Ch
	jge	loc_1555B
loc_15586:
	mov	ax, [bp+squareNS]
	sub	ax, [bp+upDownValue]
	add	ax, [bp+nsCounter]
	mov	[bp+nsValue], ax
	or	ax, ax
	jl	loc_156F6
loc_15599:
	mov	ax, [bp+downLimit]
	cmp	[bp+nsValue], ax
	jge	loc_156F6
loc_155A4:
	cmp	[bp+ewValue], 0
	jl	short loc_155AF
	mov	ax, 1
	jmp	short loc_155B1
loc_155AF:
	sub	ax, ax
loc_155B1:
	mov	cx, [bp+leftLimit]
	mov	si, ax
	cmp	[bp+ewValue], cx
	jge	short loc_155C0
	mov	ax, 1
	jmp	short loc_155C2
loc_155C0:
	sub	ax, ax
loc_155C2:
	test	ax, si
	jz	loc_156F6
loc_155C9:
	mov	ax, [bp+nsCounter]
	mov	cl, 3
	shl	ax, cl
	sub	ax, 5Eh	
	neg	ax
	mov	[bp+screenY], ax
	mov	ax, [bp+ewCounter]
	shl	ax, cl
	add	ax, 0A9h 
	mov	[bp+screenX], ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_clearSquare
	add	sp, 4
	mov	bx, [bp+ewValue]
	mov	ax, bx
	shl	bx, 1
	shl	bx, 1
	add	bx, ax
	mov	ax, bx
	mov	bx, [bp+nsValue]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowPList]
	lfs	si, fs:[bx+si]
	mov	bx, ax
	mov	al, fs:[bx+si+4]
	sub	ah, ah
	mov	[bp+squareFlags], ax
	test	byte ptr [bp+squareFlags], 2
	jnz	l_squareUndiscovered
loc_15621:
	test	byte ptr [bp+squareFlags], 1
	jz	l_squareUndiscovered
loc_1562A:
	mov	ax, [bp+rightLeftValue]
	cmp	[bp+ewCounter], ax
	jnz	short loc_1564E
	mov	ax, [bp+upDownValue]
	cmp	[bp+nsCounter], ax
	jnz	short loc_1564E
	mov	ax, minimap_X
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_setSquare
	add	sp, 6
loc_1564E:
	cmp	word_43F12, 0
	jz	short loc_15671
	test	byte ptr [bp+squareFlags], 8
	jz	short loc_1566F
	mov	ax, minimap_dot
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_setSquare
	add	sp, 6
loc_1566F:
	jmp	short loc_1568B
loc_15671:
	test	byte ptr [bp+squareFlags], 4
	jz	short loc_1568B
	mov	ax, minimap_dot
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_setSquare
	add	sp, 6

loc_1568B:
	mov	bx, [bp+nsValue]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowPList]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+ewValue]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+rowP], ax
	mov	word ptr [bp+rowP+2],	dx
	lfs	bx, [bp+rowP]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	push	ax
	push	cs
	call	near ptr minimap_getWalls
	add	sp, 2
	jmp	short l_drawSquare

l_squareUndiscovered:
	mov	ax, minimap_undiscovered
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_setSquare
	add	sp, 6

l_drawSquare:
	mov	ax, 1
	push	ax
	mov	ax, 63h	
	push	ax
	push	[bp+screenX]
	push	[bp+screenY]
	call	far ptr	gfx_writeCharacter
	add	sp, 8
loc_156F6:
	jmp	loc_1557A

l_getInput:
	push	cs
	call	near ptr getKey
	add	sp, 2
	cmp	ax, dosKeys_ESC
	jz	short l_clearAndReturn
	cmp	ax, dosKeys_upArrow
	jz	short l_upArrow
	cmp	ax, dosKeys_leftArrow
	jz	short l_leftArrow
	cmp	ax, dosKeys_rightArrow
	jz	short l_rightArrow
	cmp	ax, dosKeys_downArrow
	jz	short l_downArrow
	jmp	l_loopEntry

l_downArrow:
	mov	ax, [bp+downLimit]
	cmp	[bp+upDownValue], ax
	jge	short l_afterDownLoop
	inc	[bp+upDownValue]
l_afterDownLoop:
	jmp	l_loopEntry

l_upArrow:
	cmp	[bp+upDownValue], 0
	jz	short l_afterUpLoop
	dec	[bp+upDownValue]
l_afterUpLoop:
	jmp	l_loopEntry

l_rightArrow:
	cmp	[bp+rightLeftValue], 0
	jz	short l_afterRightLoop
	dec	[bp+rightLeftValue]
l_afterRightLoop:
	jmp	l_loopEntry

l_leftArrow:
	mov	ax, [bp+leftLimit]
	cmp	[bp+rightLeftValue], ax
	jge	short l_afterLeftLoop
	inc	[bp+rightLeftValue]
l_afterLeftLoop:
	jmp	l_loopEntry

l_clearAndReturn:
	push	cs
	call	near ptr text_clear

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
minimap_show endp

; Attributes: bp-based frame

minimap_getWalls proc far

	directionLoopCounter= word ptr	-2
	squareWalls= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	; Loop through all of the directions getting the value
	; of the walls in each direction
	;
	mov	[bp+directionLoopCounter], 0
l_loopEntry:
	mov	ax, [bp+directionLoopCounter]
	dec	ax
	push	ax
	push	[bp+squareWalls]
	call	dungeon_getWallInDirection
	add	sp, 4
	and	ax, 0Fh
	mov	bx, ax
	cmp	minimap_bitmaskOffsetList[bx],	80h
	jnb	short l_loopIncrement
	mov	al, minimap_bitmaskOffsetList[bx]
	sub	ah, ah
	or	ax, [bp+directionLoopCounter]
	push	ax
	mov	ax, offset minimap_squareToDraw
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	minimap_setSquare
	add	sp, 6
l_loopIncrement:
	inc	[bp+directionLoopCounter]
	cmp	[bp+directionLoopCounter], 4
	jl	short l_loopEntry
l_return:
	mov	sp, bp
	pop	bp
	retf
minimap_getWalls endp

; Attributes: bp-based frame

_mfunc_getString proc far

	memOffset= word	ptr  6
	memSegment= word ptr  8
	rbuf= dword ptr	 0Ah

	push	bp
	mov	bp, sp

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
	jnz	short loc_157E6
	mov	ax, dataBufOff
	mov	dx, dataBufSeg
	jmp	short $+2

	mov	sp, bp
	pop	bp
	retf
_mfunc_getString endp

; Attributes: bp-based frame

_mfunc_unpackChar proc far

	push	bp
	mov	bp, sp

l_extractCharacter:
	mov	ax, 5
	push	ax
	push	cs
	call	near ptr _mfunc_extractCh
	add	sp, 2
	or	ax, ax
	jz	short l_return
	cmp	ax, 30
	jz	short l_setCapitalFlag
	cmp	ax, 31
	jz	short l_hialphabetChar
	jmp	short l_loalphabetChar

l_setCapitalFlag:
	mov	_str_capFlag, 1
	jmp	short l_extractCharacter

l_hialphabetChar:
	mov	ax, 6
	push	ax
	push	cs
	call	near ptr _mfunc_extractCh
	add	sp, 2
	mov	bx, ax
	mov	al, _str_Hialphabet[bx]
	cbw
	cmp	_str_capFlag, 0
	jz	short l_return
	mov	_str_capFlag, 0
	jmp	l_returnCapital

l_loalphabetChar:
	mov	bx, ax
	mov	al, _str_Loalphabet[bx-1]
	cbw
	cmp	_str_capFlag, 0
	jz	short l_return
	mov	_str_capFlag, 0
l_returnCapital:
	push	ax
	call	toUpper
	add	sp, 2
l_return:
	mov	sp, bp
	pop	bp
	retf
_mfunc_unpackChar endp

; This function extracts a number of bits from the data buffer
; 
; Attributes: bp-based frame

_mfunc_extractCh proc far

	var_2= word ptr	-2
	bitCount= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+var_2], 0
loc_158BC:
	mov	ax, [bp+bitCount]
	dec	[bp+bitCount]
	or	ax, ax
	jz	short l_return
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
l_return:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_mfunc_extractCh endp


; This function	copies 16 bytes	from fromBuffer	to
; toBuffer and ANDs each byte with 0x7f to remove
; the "encryption"
; Attributes: bp-based frame

unmaskString proc far

	loopCounter= word ptr	-2
	fromBuffer= dword ptr  6
	toBuffer= dword	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEntry:
	lfs	bx, [bp+fromBuffer]
	mov	al, fs:[bx]
	cmp	al, 0FFh
	jz	short l_return
	or	al, al
	jz	short l_return
	inc	word ptr [bp+fromBuffer]
	mov	al, fs:[bx]
	and	al, 7Fh
	lfs	bx, dword ptr [bp+toBuffer]
	inc	word ptr [bp+toBuffer]
	mov	byte ptr fs:[bx], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 16
	jl	short l_loopEntry
l_return:
	lfs	bx, dword ptr [bp+toBuffer]
	inc	word ptr [bp+toBuffer]
	mov	byte ptr fs:[bx], 0
	mov	sp, bp
	pop	bp
	retf
unmaskString endp

; DWORD - arg_0 & arg_2
; Attributes: bp-based frame

text_scrollingWindow proc far

	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_18=	word ptr -18h
	highlightedLine=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	TxtNumLines= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= dword ptr  0Ah
	itemCount= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 20h
	call	someStackOperation
	push	si

	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+highlightedLine], ax
	mov	[bp+var_1E], ax
	mov	[bp+var_10], ax
	mov	[bp+var_E], 1
	push	cs
	call	near ptr sub_1766A

loc_1597F:
	cmp	[bp+var_E], 0
	jz	l_doRealTimeEvents

loc_15988:
	call	far ptr	sub_3E974
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	printStringWClear
	add	sp, 4

	mov	al, gs:txt_numLines
	sub	ah, ah
	inc	ax
	mov	[bp+TxtNumLines], ax
	mov	ax, 0Ah
	sub	ax, [bp+TxtNumLines]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+itemCount]
	jle	short loc_159BF
	mov	ax, [bp+itemCount]
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
	call	printString
	add	sp, 4
	jmp	short loc_159CA
loc_159EF:
	mov	[bp+var_4], 0
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+itemCount]
	jle	short loc_15A07
	mov	ax, [bp+itemCount]
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
	add	bx, [bp+TxtNumLines]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_4], ax
	jmp	short loc_15A14
loc_15A35:
	mov	ax, bitMask16bit+16h
	or	[bp+var_4], ax
	push	cs
	call	near ptr scroll_printArrows
	mov	ax, [bp+highlightedLine]
	add	ax, [bp+TxtNumLines]
	sub	ax, [bp+var_12]
	push	ax
	call	far ptr	sub_3E96E			; This probably does the highlighting
	add	sp, 2
	push	cs
	call	near ptr sub_1766A
	mov	[bp+var_E], 0
	jmp	short l_getInput

l_doRealTimeEvents:
	push	cs
	call	near ptr doRealtimeEvents

l_getInput:
	call	checkMouse
	cmp	mouse_moved, 0
	jz	short l_skipMouseIcon
	call	far ptr	sub_3E974
	push	[bp+var_4]
	push	cs
	call	near ptr mouse_setScrollingIcon
	add	sp, 2
	mov	[bp+var_2], 1
	push	cs
	call	near ptr sub_1766A

l_skipMouseIcon:
	push	[bp+var_4]
	push	cs
	call	near ptr scroll_checkArrowClick
	add	sp, 2
	mov	[bp+var_8], ax
	or	ax, ax
	jz	l_checkKeyboard
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
	sub	ax, [bp+txtNumLines]
	add	ax, [bp+var_12]
	sub	ax, 10Eh
	mov	[bp+highlightedLine], ax
	mov	[bp+var_2], 0
loc_15AFB:
	cmp	[bp+var_10], 0
	jz	short loc_15B0C
	call	far ptr	sub_3E974
	mov	ax, [bp+highlightedLine]
	jmp	l_return
loc_15B0C:
	mov	ax, [bp+var_C]
	cmp	[bp+highlightedLine], ax
	jz	short loc_15B19
	mov	ax, 1
	jmp	short loc_15B1B
loc_15B19:
	sub	ax, ax
loc_15B1B:
	mov	[bp+var_E], ax
	mov	ax, [bp+highlightedLine]
	mov	[bp+var_C], ax
	jmp	l_checkKeyboard
loc_15B27:
	mov	ax, [bp+var_8]
	jmp	short loc_15B98
loc_15B2C:
	cmp	[bp+var_10], 0
	jz	short loc_15B5A
	mov	ax, [bp+itemCount]
	sub	ax, 5
	cmp	ax, [bp+var_12]
	jle	short loc_15B5A
	add	[bp+var_12], 5
	mov	ax, [bp+var_12]
	add	ax, 2
	mov	[bp+highlightedLine], ax
	mov	si, [bp+itemCount]
	dec	si
	cmp	ax, si
	jle	short loc_15B55
	mov	[bp+highlightedLine], si
loc_15B55:
	mov	[bp+var_E], 1
loc_15B5A:
	jmp	short l_checkKeyboard
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
	mov	[bp+highlightedLine], ax
	mov	[bp+var_E], 1
loc_15B81:
	jmp	short l_checkKeyboard
loc_15B83:
	cmp	[bp+var_10], 0
	jz	short loc_15B94
	call	far ptr	sub_3E974
	mov	ax, 0FFFFh
	jmp	l_return
loc_15B94:
	jmp	short l_checkKeyboard

loc_15B98:
	cmp	ax, dosKeys_ESC
	jz	short loc_15B83
	cmp	ax, dosKeys_upArrow
	jz	short loc_15B5C
	cmp	ax, dosKeys_downArrow
	jz	short loc_15B2C

l_checkKeyboard:
	call	checkKeyboard
	or	ax, ax
	jz	loc_15D04
	call	_readChFromKeyboard
	mov	[bp+var_18], ax
	or	al, al
	jz	short loc_15BD4
	mov	al, byte ptr [bp+var_18]
	sub	ah, ah
	push	ax
	call	toUpper
	add	sp, 2
	mov	[bp+var_8], ax
	jmp	short loc_15BDA
loc_15BD4:
	mov	ax, [bp+var_18]
	mov	[bp+var_8], ax
loc_15BDA:
	mov	[bp+var_E], 1
	mov	ax, [bp+var_8]
	jmp	l_keySwitch

l_enterKey:
	call	far ptr	sub_3E974
	mov	ax, [bp+highlightedLine]
	jmp	l_return

l_escapeKey:
	call	far ptr	sub_3E974
	mov	ax, 0FFFFh
	jmp	l_return

l_upArrow:
	cmp	[bp+highlightedLine], 0
	jz	short l_upArrowScroll
	dec	[bp+highlightedLine]

l_upArrowScroll:
	mov	ax, [bp+var_12]
	cmp	[bp+highlightedLine], ax
	jge	short l_upArrowDone
	dec	[bp+var_12]
l_upArrowDone:
	jmp	loc_15D04

l_downArrow:
	mov	ax, [bp+itemCount]
	dec	ax
	cmp	ax, [bp+highlightedLine]
	jle	short l_downArrowScroll
	inc	[bp+highlightedLine]
l_downArrowScroll:
	mov	ax, [bp+var_12]
	add	ax, [bp+var_6]
	cmp	ax, [bp+highlightedLine]
	jg	short l_downArrowDone
	inc	[bp+var_12]
l_downArrowDone:
	jmp	loc_15D04

l_pageDown:
	mov	ax, [bp+highlightedLine]
	add	ax, [bp+var_6]
	mov	cx, [bp+itemCount]
	dec	cx
	cmp	ax, cx
	jge	short loc_15C48
	mov	ax, [bp+var_6]
	add	[bp+highlightedLine], ax
	add	[bp+var_12], ax
	jmp	short l_pageDownDone
loc_15C48:
	mov	ax, [bp+itemCount]
	dec	ax
	mov	[bp+highlightedLine], ax
	mov	ax, [bp+var_6]
	cmp	[bp+highlightedLine], ax
	jl	short loc_15C66
	mov	ax, [bp+itemCount]
	mov	cx, [bp+var_6]
	sar	cx, 1
	sub	ax, cx
	mov	[bp+var_12], ax
	jmp	short l_pageDownDone
loc_15C66:
	mov	[bp+var_12], 0
l_pageDownDone:
	jmp	loc_15D04

l_pageUp:
	mov	ax, [bp+var_6]
	cmp	[bp+highlightedLine], ax
	jg	short loc_15C82
	mov	[bp+highlightedLine], 0
	mov	[bp+var_12], 0
	jmp	short l_pageUpDown
loc_15C82:
	mov	ax, [bp+var_6]
	sub	[bp+highlightedLine], ax
	cmp	[bp+var_12], ax
	jle	short loc_15C92
	sub	[bp+var_12], ax
	jmp	short l_pageUpDown
loc_15C92:
	mov	[bp+var_12], 0
l_pageUpDown:
	jmp	short loc_15D04

l_homeKey:
	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+highlightedLine], ax
	jmp	short loc_15D04

l_endKey:
	mov	ax, [bp+itemCount]
	dec	ax
	mov	[bp+highlightedLine], ax
	mov	ax, [bp+var_6]
	cmp	[bp+highlightedLine], ax
	jge	short loc_15CB6
	sub	ax, ax
	jmp	short loc_15CC0
loc_15CB6:
	mov	ax, [bp+highlightedLine]
	mov	cx, [bp+var_6]
	sar	cx, 1
	sub	ax, cx
loc_15CC0:
	mov	[bp+var_12], ax
	jmp	short loc_15D04

l_keySwitch:
	cmp	ax, dosKeys_upArrow
	jz	l_upArrow
	jg	short l_higherThanUpArrow
	cmp	ax, dosKeys_Enter
	jz	l_enterKey
	cmp	ax, dosKeys_ESC
	jz	l_escapeKey
	cmp	ax, dosKeys_home
	jz	short l_homeKey
	jmp	short loc_15D04

l_higherThanUpArrow:
	cmp	ax, dosKeys_pageUp
	jz	short l_pageUp
	cmp	ax, dosKeys_end
	jz	short l_endKey
	cmp	ax, dosKeys_downArrow
	jz	l_downArrow
	cmp	ax, dosKeys_pageDown
	jz	l_pageDown

loc_15D04:
	jmp	loc_1597F
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
text_scrollingWindow endp

; Attributes: bp-based frame

scroll_printArrows proc far
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
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	mov	ax, 1
	push	ax
	mov	ax, 62h	
	push	ax
	mov	ax, 120h
	push	ax
	mov	ax, 5Eh	
	push	ax
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	mov	ax, 1
	push	ax
	mov	ax, 5Eh	
	push	ax
	mov	ax, 0E0h 
	push	ax
	mov	ax, offset s_esc
	push	ds
	push	ax
	push	cs
	call	near ptr writeStringAt
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
scroll_printArrows endp


; Attributes: bp-based frame

scroll_checkArrowClick proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	[bp+var_2], 0

	; Check if the mouse is in the text window
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jl	l_return

	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	cmp	mouse_x, ax
	jge	short l_return

	mov	ax, mouseBoxes._top[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jl	short l_return

	mov	ax, mouseBoxes._bottom[1 * sizeof mouseBox_t]
	cmp	mouse_y, ax
	jge	short l_return

	mov	ax, mouse_y
	sub	ax, 4
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_4], ax
	cmp	ax, 0Bh
	jnz	short l_checkListItem

l_checkUpArrow:
	mov	ax, mouseBoxes._left[1 * sizeof mouseBox_t]
	add	ax, 32h	
	cmp	mouse_x, ax
	jge	short l_checkEsc
	mov	ax, dosKeys_upArrow
	jmp	short l_return

l_checkEsc:
	mov	ax, mouseBoxes._right[1 * sizeof mouseBox_t]
	sub	ax, 32h	
	cmp	mouse_x, ax
	jge	short l_checkDownArrow
	mov	ax, dosKeys_ESC
	jmp	short l_return

l_checkDownArrow:
	mov	ax, dosKeys_downArrow
	jmp	short l_return

l_checkListItem:
	mov	ax, [bp+arg_0]
	mov	bx, [bp+var_4]
	shl	bx, 1
	test	bitMask16bit[bx], ax
	jz	short l_returnZero
	mov	ax, [bp+var_4]
	add	ax, 10Eh
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
scroll_checkArrowClick endp

; Attributes: bp-based frame

readString proc far

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
	call	near ptr readString_insertCursor
loc_15E2D:
	push	cs
	call	near ptr readChNoMouse
	mov	[bp+var_2], ax
	cmp	ax, 0Dh
	jz	loc_15F0D

	mov	[bp+var_4], ax
	push	ax
	push	cs
	call	near ptr isAlphaNum
	add	sp, 2
	or	ax, ax
	jnz	short loc_15E6F
	cmp	[bp+var_2], ' '
	jz	short loc_15E6F
	cmp	[bp+var_2], '-'
	jz	short loc_15E6F
	cmp	[bp+var_2], '.'
	jz	short loc_15E6F
	cmp	[bp+var_2], ','
	jz	short loc_15E6F
	cmp	[bp+var_2], ':'
	jz	short loc_15E6F
	cmp	[bp+var_2], '\'
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
	call	near ptr readString_echoChar
	add	sp, 4
	mov	bx, [bp+var_6]
	inc	[bp+var_6]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	push	cs
	call	near ptr readString_printChar
	add	sp, 2
	push	cs
	call	near ptr readString_insertCursor
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
	call	near ptr text_characterWidth
	add	sp, 2
	push	ax
	push	cs
	call	near ptr readString_overwriteCursor
	add	sp, 2
	push	cs
	call	near ptr readString_insertCursor
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
	call	near ptr text_characterWidth
	add	sp, 2
	push	ax
	push	cs
	call	near ptr readString_overwriteCursor
	add	sp, 2
	jmp	short loc_15EE1
loc_15F06:
	push	cs
	call	near ptr readString_insertCursor
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
	call	near ptr readString_echoChar
	add	sp, 4
	cmp	[bp+var_6], 0
	jz	short l_returnNull
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short l_return
l_returnNull:
	sub	ax, ax
	cwd
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
readString endp

; Attributes: bp-based frame

readString_insertCursor proc far
	push	bp
	mov	bp, sp

	mov	ax, 1
	push	ax
	mov	ax, ch_InsertCursor
	push	ax
	push	cs
	call	near ptr readString_echoChar
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
readString_insertCursor endp

; Attributes: bp-based frame

readString_overwriteCursor proc far

	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp

	sub	ax, ax
	push	ax
	mov	ax, ch_OverwriteCursor
	push	ax
	push	cs
	call	near ptr readString_echoChar
	add	sp, 4
	mov	al, [bp+arg_0]
	sub	gs:g_currentCharPosition, al
	sub	ax, ax
	push	ax
	mov	ax, ch_OverwriteCursor
	push	ax
	push	cs
	call	near ptr readString_echoChar
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
readString_overwriteCursor endp

; Attributes: bp-based frame

readString_printChar proc far

	inCharacter= word ptr	 6

	push	bp
	mov	bp, sp

	mov	ax, 1
	push	ax
	mov	ax, [bp+inCharacter]
	sub	ax, ' '
	push	ax
	push	cs
	call	near ptr readString_echoChar
	add	sp, 4
	push	[bp+inCharacter]
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	gs:g_currentCharPosition, al

	mov	sp, bp
	pop	bp
	retf
readString_printChar endp


; Attributes: bp-based frame

readString_echoChar proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp

	push	[bp+arg_2]
	push	[bp+arg_0]
	mov	al, gs:g_currentCharPosition
	sub	ah, ah
	add	ax, 0A8h 
	push	ax
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax
	call	far ptr	gfx_writeCharacter
	add	sp, 8

	mov	sp, bp
	pop	bp
	retf
readString_echoChar endp

; Attributes: bp-based frame

readGold proc far

	stringBuffer=	word ptr -14h
	gold= dword ptr	-4

	push	bp
	mov	bp, sp
	mov	ax, 14h
	call	someStackOperation

	mov	ax, 10h
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	push	cs
	call	near ptr readString
	add	sp, 6
	or	dx, ax
	jz	short l_returnZero
	lea	ax, [bp+gold]
	push	ss
	push	ax
	mov	ax, offset s_u
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	sscanf
	add	sp, 0Ch
	mov	ax, word ptr [bp+gold]
	mov	dx, word ptr [bp+gold+2]
	jmp	short l_return
l_returnZero:
	sub	ax, ax
	cwd
	jmp	short $+2
l_return:
	mov	sp, bp
	pop	bp
	retf
readGold endp

; Attributes: bp-based frame

strcat	proc far

	toStr= dword ptr  6
	fromStr= dword ptr  0Ah

	push	bp
	mov	bp, sp

l_loopEntry:
	lfs	bx, [bp+fromStr]
	inc	word ptr [bp+fromStr]
	mov	al, fs:[bx]
	lfs	bx, [bp+toStr]
	inc	word ptr [bp+toStr]
	mov	fs:[bx], al
	or	al, al
	jnz	short l_loopEntry
	lfs	bx, [bp+toStr]
	mov	byte ptr fs:[bx], 0
	dec	word ptr [bp+toStr]
	mov	ax, word ptr [bp+toStr]
	mov	dx, word ptr [bp+toStr+2]

	mov	sp, bp
	pop	bp
	retf
strcat	endp

; Attributes: bp-based frame

itoa proc far

	var_4= word ptr	-4
	var_2= byte ptr	-2
	stringP= dword ptr  6
	inString= dword ptr	 0Ah
	maxDigits= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	[bp+var_2], 20h	
	cmp	[bp+maxDigits], 0
	jnz	short loc_160A6

	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	push	cs
	call	near ptr _itoa_countDigits
	add	sp, 4
	mov	[bp+maxDigits], ax

loc_160A6:
	cmp	[bp+inString+2], 0
	jge	short loc_160C3

	mov	ax, word ptr [bp+inString]
	mov	dx, word ptr [bp+inString+2]
	neg	ax
	adc	dx, 0
	neg	dx
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	mov	[bp+var_2], 2Dh	
loc_160C3:
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	call	_32bitMod
	add	al, 30h	
	mov	si, [bp+maxDigits]
	lfs	bx, [bp+stringP]
	mov	fs:[bx+si-1], al
	mov	ax, [bp+maxDigits]
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
	lea	ax, [bp+inString]
	push	ax
	call	_32bitDivide
	mov	ax, word ptr [bp+inString]
	or	ax, word ptr [bp+inString+2]
	jz	short loc_16128
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	push	word ptr [bp+inString+2]
	push	word ptr [bp+inString]
	call	_32bitMod
	add	al, 30h	
	mov	si, [bp+var_4]
	lfs	bx, [bp+stringP]
	mov	fs:[bx+si-1], al
	jmp	short loc_16139
loc_16128:
	mov	si, [bp+var_4]
	lfs	bx, [bp+stringP]
	mov	al, [bp+var_2]
	mov	fs:[bx+si-1], al
	mov	[bp+var_2], 20h	
loc_16139:
	jmp	short loc_160E9
loc_1613B:
	cmp	word ptr [bp+inString+2], 0
	jg	short loc_1614F
	jl	short loc_16149
	cmp	word ptr [bp+inString], 0Ah
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
	mov	ax, [bp+maxDigits]
	cmp	[bp+var_4], ax
	jge	short loc_1616D
	lfs	bx, [bp+stringP]
	inc	word ptr [bp+stringP]
	mov	byte ptr fs:[bx], 2Ah
	jmp	short loc_16156
loc_1616D:
	mov	ax, word ptr [bp+stringP]
	mov	dx, word ptr [bp+stringP+2]
	jmp	short l_return
loc_16175:
	mov	ax, [bp+maxDigits]
	add	ax, word ptr [bp+stringP]
	mov	dx, word ptr [bp+stringP+2]
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
itoa endp


; This function counts the digits in arg_0
;
; Attributes: bp-based frame

_itoa_countDigits proc far

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
	jnz	short loc_161A4
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_itoa_countDigits endp


; This is a convenience function for printing a string and a three digit
; number. It has a maximum size of 32 bytes for string+number
;
; Attributes: bp-based frame

printStringAndThreeDigits proc far

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
	call	strcat
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
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx

	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_24]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printStringAndThreeDigits endp


; This function takes arg_0, multiplies it by 100, shifts the lower
; 16 bits (ax) 8 bits to the right and prints that number. Weird.
;
; Attributes: bp-based frame

printThiefAbilValues proc far

	arg_0= dword ptr 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp

	mov	ax, 64h	
	imul	[bp+arg_4]
	mov	cl, 8
	sar	ax, cl
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr printStringAndThreeDigits
	add	sp, 6

	mov	sp, bp
	pop	bp
	retf
printThiefAbilValues endp

; This function copies srcString into destString depending on
; the value passed.
;
; The '/' character in srcString indicates the start of the singular
; value. The end of the singular part (and beginning of the plural)
; part is indicated by '\'. Finally, the end of the plural part is
; indicated by a '\' or NULL.
;
; E.g. 'Wol/f\ves'
;   If value
;
; The current state is saved in [bp+stringState]
; 0 - initialState: Look for '/' (singular) or '\' (plural)
; 1 - skipSingular: '/' found but value is non-zero
; 2 - copySingular: '/' found and value is zero
; 3 - copyPlural:   '\' found and value is non-zero
; 4 - skipPlural:   '\' found and value is zero
; 5 - finalState:   Copy characters until 0
;
; Attributes: bp-based frame

str_pluralize proc far

	stringState= word ptr	-2
	srcString= dword ptr  6
	destString= dword ptr  0Ah
	value= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+stringState], 0
l_stateCheck:
	mov	ax, [bp+stringState]
	or	ax, ax
	jz	l_initialSingularCheck
	cmp	ax, 1
	jz	l_skipSingular
	cmp	ax, 2
	jz	l_copySingular
	cmp	ax, 3
	jz	l_copyPlural
	cmp	ax, 4
	jz	l_skipPlural
	cmp	ax, 5
	jz	l_finalState
	jmp	l_nextCharacter

l_initialSingularCheck:
	lfs	bx, [bp+srcString]		; Copy from srcString
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]		; to destString
	mov	fs:[bx], al
	cmp	al, '/'	
	jnz	short l_initialPluralCheck

	cmp	[bp+value], 0
	jz	short loc_16273
	mov	ax, 1
	jmp	short loc_16276
loc_16273:
	mov	ax, 2
loc_16276:
	mov	[bp+stringState], ax
	jmp	l_nextCharacter

l_initialPluralCheck:
	lfs	bx, [bp+destString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_16297
	cmp	[bp+value], 0
	jz	short loc_1628F
	mov	ax, 3
	jmp	short loc_16292
loc_1628F:
	mov	ax, 4
loc_16292:
	mov	[bp+stringState], ax
	jmp	l_nextCharacter

loc_16297:
	cmp	byte ptr fs:[bx], 0
	jz	l_nextCharacter
	inc	word ptr [bp+destString]
	jmp	l_nextCharacter

l_skipSingular:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_162B1
	mov	[bp+stringState], 3
loc_162B1:
	jmp	l_nextCharacter

l_copySingular:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, '\'
	jnz	short loc_162CC
	mov	[bp+stringState], 4
	jmp	l_nextCharacter
loc_162CC:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_nextCharacter
	inc	word ptr [bp+destString]
	jmp	short l_nextCharacter

l_copyPlural:
	lfs	bx, [bp+srcString]
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	mov	fs:[bx], al
	cmp	al, '\'	
	jnz	short loc_162F1
	mov	[bp+stringState], 5
	jmp	short loc_162FD
loc_162F1:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_162FD
	inc	word ptr [bp+destString]
loc_162FD:
	jmp	short l_nextCharacter

l_skipPlural:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], '\'
	jnz	short loc_1630D
	mov	[bp+stringState], 5
loc_1630D:
	jmp	short l_nextCharacter

l_finalState:
	lfs	bx, [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_nextCharacter
	mov	al, fs:[bx]
	lfs	bx, [bp+destString]
	inc	word ptr [bp+destString]
	mov	fs:[bx], al

l_nextCharacter:
	lfs	bx, [bp+srcString]
	inc	word ptr [bp+srcString]
	cmp	byte ptr fs:[bx], 0
	jnz	l_stateCheck

l_return:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
str_pluralize endp

; Attributes: bp-based frame

stairsPluralHelper proc far

	stringBufP=	dword ptr -54h
	stringBuffer=	word ptr -50h
	arg_0= dword ptr	 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 54h
	call	someStackOperation

	push	[bp+arg_4]
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	push	[bp+arg_0]
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx
	lfs	bx, [bp+stringBufP]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
stairsPluralHelper endp

; Attributes: bp-based frame


; Attributes: bp-based frame

printStringWClear proc far

	inString= dword ptr	 6

	push	bp
	mov	bp, sp

	push	cs
	call	near ptr text_clear
	push	[bp+inString]
	call	printString
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
printStringWClear endp

; Attributes: bp-based frame

printString proc far

	lineBuffer=	word ptr -62h
	inStringP=	dword ptr -12h
	characterCount= word ptr	-0Eh
	linesPrinted= word ptr	-0Ch
	pixelsUsed= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	currentCharacter= word ptr	-4
	var_2= word ptr	-2
	inString= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 62h
	call	someStackOperation
	push	si

	mov	ax, word ptr [bp+inString]
	mov	dx, word ptr [bp+inString+2]
	mov	word ptr [bp+inStringP], ax
	mov	word ptr [bp+inStringP+2],	dx
	mov	[bp+characterCount], 0
	mov	[bp+pixelsUsed], 0
	mov	[bp+linesPrinted], 0

l_nextCharacter:
	lfs	bx, [bp+inString]
	cmp	byte ptr fs:[bx], 0
	jz	l_return
	lfs	bx, [bp+inStringP]
	inc	word ptr [bp+inStringP]
	mov	al, fs:[bx]
	cbw
	mov	[bp+currentCharacter], ax
	or	ax, ax
	jz	l_stringEnd
	cmp	ax, 0Ah
	jz	l_newline
	cmp	ax, 20h	
	jz	l_space
	jmp	l_otherCharacter

l_stringEnd:
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	cmp	[bp+characterCount], 0
	jz	l_return
	lea	ax, [bp+lineBuffer]
	push	ss
	push	ax
	push	cs
	call	near ptr text_nlWriteString
	add	sp, 4
	jmp	l_return

l_newline:
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	cmp	[bp+characterCount], 0
	jz	short loc_16441
	lea	ax, [bp+lineBuffer]
	push	ss
	push	ax
	push	cs
	call	near ptr text_nlWriteString
	add	sp, 4

loc_16441:
	push	cs
	call	near ptr txt_newLine

loc_16445:
	mov	ax, [bp+linesPrinted]
	inc	[bp+linesPrinted]
	cmp	ax, 50
	jle	short loc_16457
	mov	ax, 3
	jmp	l_return

loc_16457:
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	jmp	l_nextCharacter

l_space:
	cmp	[bp+pixelsUsed], 0			; Skip space if it's the first character
	jz	l_nextCharacter				; on the line

l_otherCharacter:
	mov	si, [bp+characterCount]
	inc	[bp+characterCount]
	mov	al, byte ptr [bp+currentCharacter]
	mov	byte ptr [bp+si+lineBuffer], al
	push	[bp+currentCharacter]
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	[bp+pixelsUsed], ax
	cmp	[bp+pixelsUsed], 138
	jl	l_nextCharacter

	mov	ax, [bp+linesPrinted]
	inc	[bp+linesPrinted]
	cmp	ax, 50
	jle	short l_wrapText
	mov	ax, 3
	jmp	l_return

l_wrapText:
	mov	ax, [bp+characterCount]
	mov	[bp+var_2], ax
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx

l_backtrackForSpace:					; Backtrack through the string looking for
	dec	[bp+characterCount]			; a space (or 0) to avoid splitting the
	mov	si, [bp+characterCount]			; last word over two lines
	cmp	byte ptr [bp+si+lineBuffer], ' '
	jz	short l_spaceFound
	or	si, si
	jl	short l_spaceFound
	dec	word ptr [bp+inStringP]
	jmp	short l_backtrackForSpace

l_spaceFound:
	cmp	[bp+characterCount], 0
	jz	short loc_16506
	mov	si, [bp+characterCount]
	mov	byte ptr [bp+si+lineBuffer], 0
	lea	ax, [bp+lineBuffer]
	push	ss
	push	ax
	push	cs
	call	near ptr text_nlWriteString
	add	sp, 4
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	jmp	l_nextCharacter

loc_16506:
	mov	si, [bp+var_2]
	mov	byte ptr [bp+si+lineBuffer], 6Fh 
	mov	ax, [bp+var_8]
	mov	dx, [bp+var_6]
	dec	ax
	mov	word ptr [bp+inStringP], ax
	mov	word ptr [bp+inStringP+2],	dx
	lea	ax, [bp+lineBuffer]
	push	ss
	push	ax
	push	cs
	call	near ptr text_nlWriteString
	add	sp, 4
	mov	[bp+pixelsUsed], 0
	mov	[bp+characterCount], 0
	mov	ax, word ptr [bp+inStringP]
	mov	dx, word ptr [bp+inStringP+2]
	mov	word ptr [bp+inString], ax
	mov	word ptr [bp+inString+2], dx
	jmp	l_nextCharacter

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printString endp

; Attributes: bp-based frame

text_nlWriteString proc far

	inString= dword ptr	 6

	push	bp
	mov	bp, sp

	mov	gs:g_text_clearFlag, 1		; Mark text window as clearable
	cmp	gs:g_currentCharPosition, 0		; If not at the beginning of the line
	jz	short l_writeString
	push	cs
	call	near ptr txt_newLine

l_writeString:
	push	[bp+inString]
	push	cs
	call	near ptr text_writeString
	add	sp, 4			; Write the string

	mov	sp, bp
	pop	bp
	retf
text_nlWriteString endp

; This function actually writes each character to the text window.
;
; Note that there is no bounds checking in this function. All bounds
; checking is assumed to have been done by the caller.
;
; Attributes: bp-based frame

text_writeString proc far

	currentCharacter= byte ptr	-2
	inString= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

l_loop:
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	mov	[bp+currentCharacter], al
	or	al, al
	jz	short l_return

	mov	ax, 1
	push	ax

	mov	al, [bp+currentCharacter]	; Get current character
	cbw
	sub	ax, 32				; Subtract ' '
	push	ax

	mov	al, gs:g_currentCharPosition	; Push horizontal position
	sub	ah, ah
	add	ax, 168
	push	ax

	mov	al, gs:txt_numLines		; Push vertical position
	sub	ah, ah
	mov	cl, 3
	shl	ax, cl
	add	ax, 6
	push	ax

	call	far ptr	gfx_writeCharacter
	add	sp, 8
	lfs	bx, [bp+inString]
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	gs:g_currentCharPosition, al
	jmp	short l_loop
l_return:
	mov	sp, bp
	pop	bp
	retf
text_writeString endp

; Attributes: bp-based frame

txt_newLine proc far
	push	bp
	mov	bp, sp

	mov	gs:g_currentCharPosition, 0		; Move position to start of line
	mov	al, gs:txt_numLines
	inc	gs:txt_numLines
	cmp	al, 0Bh
	jb	short loc_16635
	push	cs
	call	near ptr text_scroll
	mov	gs:txt_numLines, 0Bh
loc_16635:
	mov	sp, bp
	pop	bp
	retf
txt_newLine endp

; Attributes: bp-based frame

text_scroll proc far
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
text_scroll endp

; Attributes: bp-based frame

intro_scrollText proc far

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
	call	near ptr text_wrapLongString
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
	jle	l_return

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

loc_166C6:
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
	call	near ptr writeStringAt
	add	sp, 0Ah

loc_16715:
	inc	[bp+var_25C]
	cmp	[bp+var_25C], 8
	jl	short loc_166C6

loc_16717:
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr timedGetKey
	add	sp, 2
	cmp	ax, dosKeys_ESC
	jnz	loc_16690
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
intro_scrollText endp

; Attributes: bp-based frame

doVictoryMaybe proc far

	var_A38= word ptr -0A38h
	var_A36= word ptr -0A36h
	var_266= word ptr -266h
	var_264= word ptr -264h
	var_262= word ptr -262h
	fd= word ptr -260h
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
loc_16745:
	push	[bp+var_262]
	call	icon_deactivate
	add	sp, 2
	inc	[bp+var_262]
	cmp	[bp+var_262], 5
	jl	short loc_16745

loc_1675E:
	mov	gs:byte_422A0, 0
	mov	ax, 80E8h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx

loc_1677F:
	sub	ax, ax
	push	ax
	mov	ax, offset s_victory
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_167BC

	mov	ax, offset s_insertDisk
	push	ds
	push	ax		; Change disks if necessary
	call	printString
	add	sp, 4
	push	dseg_0
	push	disk1
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

loc_167BC:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1677F
	mov	ax, 80E8h
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	push	[bp+fd]
	call	close
	add	sp, 2

	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8

	mov	ax, offset g_rosterCharacterBuffer
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
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_25A], 0

	jmp	short loc_16836
loc_16832:
	inc	[bp+var_25A]
loc_16836:
	cmp	[bp+var_25A], 5
	jge	loc_1690F
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
	push	word ptr (victoryMessageList+2)[bx]
	push	word ptr victoryMessageList[bx]
	push	cs
	call	near ptr text_wrapLongString
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
	jle	loc_16832

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

loc_168AD:
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
	call	near ptr writeStringAt
	add	sp, 0Ah
loc_168FC:
	inc	[bp+var_264]
	cmp	[bp+var_264], 8
	jl	short loc_168AD

loc_168FE:
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr timedGetKey
	add	sp, 2
	jmp	loc_16875

loc_1690F:
	sub	ax, ax
	push	ax
	mov	ax, offset s_bardscr
	push	ds
	push	ax
	call	openFile
	add	sp, 4
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_1694C

	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	dseg_0
	push	disk1
	call	printString
	add	sp, 4
	mov	ax, 0FFFFh
	push	ax
	push	cs
	call	near ptr timedGetKey
	add	sp, 2

loc_1694C:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1690F
	mov	ax, 80E8h
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	push	[bp+fd]
	call	close
	add	sp, 2
	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	call	d3comp
	add	sp, 8
	mov	ax, offset g_rosterCharacterBuffer
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

text_wrapLongString proc far

	var_10=	word ptr -10h
	currentLineNumber= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	currenCharacter= word ptr	-6
	var_2= word ptr	-2
	message= dword ptr  6
	stringBuffer= dword ptr  0Ah
	linePList= dword ptr  0Eh		; A list of pointers to each line after wrapping

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	push	si

	mov	[bp+var_8], 0
	mov	[bp+currentLineNumber], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
loc_16A04:
	lfs	bx, [bp+message]
	cmp	byte ptr fs:[bx], 0
	jz	l_nullTerminateAndReturn
loc_16A10:
	inc	word ptr [bp+message]
	mov	al, fs:[bx]
	cbw
	mov	[bp+currenCharacter], ax
	or	ax, ax
	jz	l_endingNull
	cmp	ax, 0Ah
	jz	l_newLine
	jmp	l_copyCharacter

l_endingNull:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	mov	ax, [bp+currentLineNumber]
	jmp	l_return

l_newLine:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	[bp+var_8], 0
	lfs	bx, [bp+message]
	cmp	byte ptr fs:[bx], ' '
	jnz	short loc_16A62
	inc	word ptr [bp+message]
loc_16A62:
	jmp	loc_16A04

l_copyCharacter:
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	al, byte ptr [bp+currenCharacter]
	mov	fs:[bx], al
	push	[bp+currenCharacter]
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	[bp+var_8], ax
	cmp	[bp+var_8], 96h	
	jl	short loc_16AEA
	mov	ax, word ptr [bp+stringBuffer]
	mov	dx, word ptr [bp+stringBuffer+2]
	dec	ax
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	mov	[bp+var_2], 0
loc_16A97:
	lfs	bx, [bp+var_C]
	cmp	byte ptr fs:[bx], ' '
	jz	short loc_16AC0
	cmp	[bp+var_8], 0
	jle	short loc_16AC0
	dec	word ptr [bp+var_C]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	mov	[bp+var_10], ax
	add	[bp+var_2], ax
	sub	[bp+var_8], ax
	jmp	short loc_16A97
loc_16AC0:
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 0
	mov	bx, [bp+currentLineNumber]
	inc	[bp+currentLineNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+linePList]
	mov	ax, word ptr [bp+var_C]
	mov	dx, word ptr [bp+var_C+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	ax, [bp+var_2]
	mov	[bp+var_8], ax
loc_16AEA:
	jmp	loc_16A04

l_nullTerminateAndReturn:
	lfs	bx, dword ptr [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	mov	byte ptr fs:[bx], 0
	mov	ax, [bp+currentLineNumber]
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
text_wrapLongString endp

; Attributes: bp-based frame

party_print proc far

	tmp= word ptr -32h
	counter= word ptr -30h
	slotNumber=	word ptr -2Eh
	partyLineP=	dword ptr -2Ch
	partyLine= word ptr -28h
	var_26=	byte ptr -26h
	var_24=	byte ptr -24h

	push	bp
	mov	bp, sp
	mov	ax, 32h
	call	someStackOperation
	push	si

	cmp	byte ptr g_printPartyFlag,	0
	jnz	l_return

	call	rost_updateParty
	mov	byte ptr g_printPartyFlag,	1
	call	far ptr	sub_3E974

	mov	[bp+slotNumber], 0
l_charNumberLoopEntry:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	byte ptr gs:party._name[bx], 0
	jz	l_emptyPartySlot

	mov	[bp+counter], 0
l_copyCharName:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	add	bx, [bp+counter]
	mov	al, byte ptr gs:party._name[bx]
	mov	si, [bp+counter]
	mov	byte ptr [bp+si+partyLine], al
	or	al, al
	jz	short l_printAc
	inc	[bp+counter]
	jmp	short l_copyCharName

l_printAc:
	push	[bp+slotNumber]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_clearAndPrintLine
	add	sp, 6

	mov	ax, 3
	push	ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	al, gs:party.ac[bx]
	cbw
	sub	ax, 10
	neg	ax
	cwd
	push	dx
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr itoa
	add	sp, 0Ah
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2],	dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 10h
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.status[bx], 0
	jz	short l_printMaxHp

	mov	[bp+counter], 6
l_detectStatusLoop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	al, gs:party.status[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cx, ax
	mov	al, statusBitmaskList[bx]
	cbw
	test	cx, ax
	jnz	short l_hasStatus
	dec	[bp+counter]
	cmp	[bp+counter], 0
	jge	short l_detectStatusLoop
	jmp	l_printCurrentHp

l_hasStatus:
	mov	[bp+tmp], 0

l_strcpyStatusString:
	mov	si, [bp+counter]
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+tmp]
	mov	al, byte ptr s_statusAbbreviations[bx+si]
	mov	si, bx
	mov	byte ptr [bp+si+partyLine], al
	inc	[bp+tmp]
	cmp	[bp+tmp], 4
	jl	short l_strcpyStatusString

	mov	[bp+var_24], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 14h
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah
	jmp	short l_printCurrentHp

l_printMaxHp:
	mov	ax, 3
	push	ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	ax, ax
	push	ax
	push	gs:party.maxHP[bx]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2], dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 14h
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah

l_printCurrentHp:
	mov	ax, 3
	push	ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	ax, ax
	push	ax
	push	gs:party.currentHP[bx]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2], dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	mov	ax, 18h
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah

	mov	ax, 3
	push	ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	ax, ax
	push	ax
	push	gs:party.maxSppt[bx]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2], dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 1Ch
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah

	mov	ax, 3
	push	ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	ax, ax
	push	ax
	push	gs:party.currentSppt[bx]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+partyLineP], ax
	mov	word ptr [bp+partyLineP+2], dx
	lfs	bx, [bp+partyLineP]
	mov	byte ptr fs:[bx], 0
	sub	ax, ax
	push	ax
	push	[bp+slotNumber]
	mov	ax, 20h	
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	al, gs:party.class[bx]
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	al, byte ptr classAbbreviations[si]
	mov	byte ptr [bp+partyLine], al
	mov	al, byte ptr (classAbbreviations+1)[si]
	mov	byte ptr [bp+partyLine+1], al
	mov	[bp+var_26], ah
	mov	ax, 1
	push	ax
	push	[bp+slotNumber]
	mov	ax, 24h	
	push	ax
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_printAt
	add	sp, 0Ah
	jmp	short l_charNumberLoopIncrement

l_emptyPartySlot:
	mov	byte ptr [bp+partyLine], 0
	push	[bp+slotNumber]
	lea	ax, [bp+partyLine]
	push	ss
	push	ax
	push	cs
	call	near ptr party_clearAndPrintLine
	add	sp, 6

l_charNumberLoopIncrement:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	l_charNumberLoopEntry
	push	cs
	call	near ptr sub_1766A

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_print endp

; Attributes: bp-based frame

party_clearAndPrintLine proc far

	var_2= word ptr	-2
	inString= dword ptr	 6
	partySlotNumber= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	ax, [bp+partySlotNumber]
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
	push	[bp+inString]
	push	cs
	call	near ptr writeStringAt
	add	sp, 0Ah

	mov	sp, bp
	pop	bp
	retf
party_clearAndPrintLine endp

; Attributes: bp-based frame

party_printAt proc far

	inString= dword ptr	 6
	column= word ptr	 0Ah
	slotNumber= word ptr	 0Ch
	colorFlag= word ptr	 0Eh

	push	bp
	mov	bp, sp

	cmp	[bp+colorFlag], 1
	sbb	ax, ax
	neg	ax
	push	ax
	mov	ax, [bp+slotNumber]
	mov	cl, 3
	shl	ax, cl
	add	ax, 90h	
	push	ax
	mov	ax, [bp+column]
	shl	ax, cl
	add	ax, 0Ch
	push	ax
	push	[bp+inString]
	push	cs
	call	near ptr printAt
	add	sp, 0Ah

	mov	sp, bp
	pop	bp
	retf
party_printAt endp

; Attributes: bp-based frame

setTitle proc far

	startingColumn= word ptr	-2
	inString= dword ptr	 6

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
	push	[bp+inString]
	push	cs
	call	near ptr centerString
	add	sp, 6
	mov	[bp+startingColumn], ax
	sub	ax, ax
	push	ax
	mov	ax, 6Ah	
	push	ax
	mov	ax, [bp+startingColumn]
	add	ax, 12h
	push	ax
	push	[bp+inString]
	push	cs
	call	near ptr writeStringAt
	add	sp, 0Ah

	mov	sp, bp
	pop	bp
	retf
setTitle endp

; 1. Calculate the pixel maxWidth of the passed in string
; 2. Subtract half the pixel maxWidth from the maxWidth
;
; Attributes: bp-based frame

centerString proc far

	var_2= word ptr	-2
	inString= dword ptr  6
	maxWidth= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+var_2], 0
l_loop:
	lfs	bx, [bp+inString]
	cmp	byte ptr fs:[bx], 0
	jz	short l_return
	inc	word ptr [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	[bp+var_2], ax
	jmp	short l_loop

l_return:
	mov	ax, [bp+maxWidth]
	sub	ax, [bp+var_2]
	cwd
	sub	ax, dx
	sar	ax, 1

	mov	sp, bp
	pop	bp
	retf
centerString endp

; Attributes: bp-based frame

writeStringAt proc far

	var_2= byte ptr	-2
	inString= dword ptr  6
	column= word ptr	 0Ah
	row= word ptr	 0Ch
	colorFlag= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

l_loop:
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	mov	[bp+var_2], al
	or	al, al
	jz	short l_return
	push	[bp+colorFlag]
	cbw
	sub	ax, 20h	
	push	ax
	push	[bp+column]
	push	[bp+row]
	call	far ptr	gfx_writeCharacter
	add	sp, 8
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr text_characterWidth
	add	sp, 2
	add	[bp+column], ax
	inc	word ptr [bp+inString]
	jmp	short l_loop
l_return:
	mov	sp, bp
	pop	bp
	retf
writeStringAt endp

; Attributes: bp-based frame

printAt proc far

	inString= dword ptr  6
	column= word ptr	 0Ah
	row= word ptr	 0Ch
	colorFlag= word ptr	 0Eh

	push	bp
	mov	bp, sp

l_loop:
	lfs	bx, [bp+inString]
	mov	al, fs:[bx]
	or	al, al
	jz	short l_return
	push	[bp+colorFlag]
	cbw
	sub	ax, 20h	
	push	ax
	push	[bp+column]
	push	[bp+row]
	call	far ptr	gfx_writeCharacter
	add	sp, 8
	add	[bp+column], 8
	inc	word ptr [bp+inString]
	jmp	short l_loop
l_return:
	mov	sp, bp
	pop	bp
	retf
printAt endp

; Attributes: bp-based frame

text_clear	proc far
	push	bp
	mov	bp, sp
	cmp	gs:g_text_clearFlag, 0
	jz	short l_return
	sub	al, al
	mov	gs:txt_numLines, al
	mov	gs:g_currentCharPosition, al
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
	mov	gs:g_text_clearFlag, 0
l_return:
	mov	sp, bp
	pop	bp
	retf
text_clear	endp

; Attributes: bp-based frame

text_characterWidth	proc far

	inCharacter= byte ptr	 6

	push	bp
	mov	bp, sp
	mov	al, [bp+inCharacter]
	cbw

	cmp	ax, 'i'
	jz	l_returnThree
	cmp	ax, ' '
	jz	l_returnSix
	cmp	ax, 'm'
	jz	l_returnEight
	cmp	ax, 'a'
	jl	l_returnEight
	cmp	ax, 'z'
	jle	l_returnSix

l_returnEight:
	mov	ax, 8
	jmp	short l_return

l_returnThree:
	mov	ax, 3
	jmp	short l_return

l_returnSix:
	mov	ax, 6

l_return:
	mov	sp, bp
	pop	bp
	retf
text_characterWidth	endp

; Attributes: bp-based frame

icons_read proc far

	fd= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

l_retry:
	sub	ax, ax
	push	ax
	mov	ax, offset s_iconFilePath
	push	ds
	push	ax
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	cmp	ax, 0FFFFh
	jnz	l_asdf
	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	dseg_0
	push	disk1
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_asdf:
	push	[bp+fd]
	call	huf_init
	add	sp, 2
	mov	ax, 474h
	push	ax
	mov	ax, offset iconLight
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	huf_flate
	add	sp, 6
	mov	ax, 820h
	push	ax
	mov	ax, offset iconCompass
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	huf_flate
	add	sp, 6
	mov	ax, 550h
	push	ax
	mov	ax, offset iconAreaEnchant
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	huf_flate
	add	sp, 6
	mov	ax, 1E0h
	push	ax
	mov	ax, offset iconShield
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	huf_flate
	add	sp, 6
	mov	ax, 640h
	push	ax
	mov	ax, offset iconLevitation
	mov	dx, seg	seg023
	push	dx
	push	ax
	call	huf_flate
	add	sp, 6
	push	[bp+fd]
	call	close
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
icons_read endp

; Attributes: bp-based frame

bigpic_drawPictureNumber proc far

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
	jmp	l_return
loc_171CF:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	mov	bx, [bp+indexNo]
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_171E7
	xor	byte ptr bigpicIndexMultiplier, 3
loc_171E7:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	cmp	bigpicIndex[bx+si-58h],	0FFh
	jnz	short loc_17206
	mov	ax, offset s_getPictureError
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	l_return

loc_17206:
	mov	ax, 88
	imul	bigpicIndexMultiplier
	mov	si, ax
	mov	bx, [bp+indexNo]
	mov	al, bigpicIndex[bx+si-58h]
	sub	ah, ah
	mov	[bp+var_2], ax

loc_1721B:
	sub	ax, ax
	push	ax
	mov	bx, bigpicIndexMultiplier
	shl	bx, 1
	shl	bx, 1
	push	word ptr lowPic[bx-2]
	push	word ptr lowPic[bx-4]
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_1726A
	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, bigpicIndexMultiplier
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
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
	call	lseek
	add	sp, 8
	mov	ax, 4
	push	ax
	lea	ax, [bp+var_8]
	push	ss
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	[bp+fd]
	call	lseek
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
	call	read
	add	sp, 8
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	push	[bp+var_C]
	push	[bp+var_E]
	call	d3comp
	add	sp, 8
	push	[bp+var_C]
	push	[bp+var_E]
	call	_freeMaybe
	add	sp, 4
	push	[bp+fd]
	call	close
	add	sp, 2
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	push	cs
	call	near ptr bigpic_configureCells
	add	sp, 4
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	push	gs:bigpicCellData_seg
	push	gs:bigpicCellData_off
	call	far ptr	vid_drawBigpic
	add	sp, 8
	cmp	[bp+indexNo], 53
	jz	short loc_1734A
	mov	al, 1
	jmp	short loc_1734C
loc_1734A:
	sub	al, al
loc_1734C:
	mov	gs:byte_422A0, al
	mov	gs:bigpicCellNumber, 0
	sub	ax, ax
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bigpic_drawPictureNumber endp

; The bigpic data consists of "cells". The first cell is the base
; image. The remaining cells are xor'd onto the previous cell.
; This function configures the remaining cells.
;
; Attributes: bp-based frame

bigpic_configureCells proc far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	push	si

	mov	si, 1340h
l_loop:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	xor	fs:[bx+1340h], al
	inc	word ptr [bp+arg_0]
	inc	si
	cmp	si, 4D00h
	jl	short l_loop

	pop	si
	mov	sp, bp
	pop	bp
	retf
bigpic_configureCells endp


; Attributes: bp-based frame

map_read proc far

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
	mov	al, byte ptr levelPathTable.fileType[bx]
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
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_173FA
	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+var_E]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
loc_173FA:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_173AD
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	al, levelPathTable.fileIndexMaybe[bx]
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
	call	lseek
	add	sp, 8
	mov	ax, 2
	push	ax
	lea	ax, [bp+var_6]
	push	ss
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	mov	ax, 0FFFFh
	push	ax
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+fd]
	call	lseek
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
	call	read
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
	call	close
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
map_read endp

; Attributes: bp-based frame

map_readGraphics proc far

	var_4= word ptr	-4
	fd= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	ax, word_4414E
	cmp	[bp+arg_0], ax
	jz	l_return

l_retry:
	sub	ax, ax
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (map_graphicsTable+2)[bx]
	push	word ptr map_graphicsTable[bx]
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_17513
	mov	bx, [bp+arg_0]
	mov	al, byte_43F4A[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	push	dseg_0[bx]
	push	disk1[bx]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
loc_17513:
	cmp	[bp+fd], 0FFFFh
	jz	short l_retry
	mov	ax, [bp+arg_0]
	mov	word_4414E, ax
	mov	ax, 4A38h
	push	ax
	mov	ax, offset graphicsBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+fd]
	call	read
	add	sp, 8
	push	[bp+fd]
	call	close
	add	sp, 2
l_return:
	mov	sp, bp
	pop	bp
	retf
map_readGraphics endp

; Attributes: bp-based frame

map_readMonsters	proc far

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
	call	memset
	add	sp, 8
	mov	[bp+_size], 0

	; If the index is the last index in the file, read the full 0x480 bytes.
	; Otherwise, read the index, then read the next index, subtract to get the
	; length of the monster roster for the level.
	;
	cmp	[bp+index], 17
	jz	l_hardcode_size
	cmp	[bp+index], 40
	jnz	l_skip_hardcode

l_hardcode_size:
	mov	[bp+_size], 480h

l_skip_hardcode:
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
	call	open
	add	sp, 6
	mov	[bp+_fd], ax
	inc	ax
	jnz	short loc_175C4
	mov	ax, offset s_insertDisk
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+var_A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (disk2+2)[bx]
	push	word ptr disk2[bx]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
loc_175C4:
	cmp	[bp+_fd], 0FFFFh
	jz	short loc_17577
	cmp	[bp+var_A], 0
	jz	short loc_175D4
	sub	[bp+index], 11h
loc_175D4:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+index]
	shl	ax, 1
	cwd
	push	dx
	push	ax
	push		[bp+_fd]
	call	lseek
	add	sp, 8

	mov	ax, 2
	push	ax
	lea	ax, [bp+var_4]
	push	ss
	push	ax
	push	[bp+_fd]
	call	read
	add	sp, 8

	cmp	[bp+_size], 0
	jnz	l_read_data

	mov	ax, 2
	push	ax
	lea	ax, [bp+var_6]
	push	ss
	push	ax
	push	[bp+_fd]
	call	read
	add	sp, 8

	mov	ax, [bp+var_6]
	sub	ax, [bp+var_4]
	mov	[bp+_size], ax

l_read_data:
	mov	ax, 0FFFFh
	push	ax
	mov	ax, [bp+var_4]
	cwd
	push	dx
	push	ax
	push	[bp+_fd]
	call	lseek
	add	sp, 8

	push	[bp+_size]
	mov	ax, offset monsterBuf
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+_fd]
	call	read
	add	sp, 8

	push	[bp+_fd]
	call	close
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
map_readMonsters	endp

; Attributes: bp-based frame

printMessageAndExit proc far

	arg_0= dword ptr	 6

	push	bp
	mov	bp, sp

	call	text_clear
	push	[bp+arg_0]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	call	cleanupAndExit

	mov	sp, bp
	pop	bp
	retf
printMessageAndExit endp


; Attributes: bp-based frame

sub_1766A proc far
	push	bp
	mov	bp, sp
	cmp	gs:byte_422A0, 0
	jz	short loc_17688
	push	cs
	call	near ptr sub_17691
	or	ax, ax
	jz	short l_return
loc_17688:
	call	far ptr	sub_3E971
l_return:
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


seg003 ends

; Segment type: Pure code
seg004 segment word public 'CODE' use16
        assume cs:seg004
;org 7
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

; XXX - Revisit after bigpic_copyTopoElem
; Attributes: bp-based frame

bigpic_drawTopology proc far

	headerSize= word ptr -1Eh
	height=	word ptr -1Ch
	_offset= dword ptr -1Ah
	gbufOff= word ptr -12h
	gbufSeg= word ptr -10h
	row= word ptr -0Eh
	column=	word ptr -0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_2= word ptr	-2
	quadrant= word ptr  6
	sq= word ptr  8
	gbuf= dword ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 1Eh
	call	someStackOperation
	push	di
	push	si

	cmp	inDungeonMaybe, 0
	jz	short loc_17756
	mov	ax, 10h
	jmp	short loc_17759
loc_17756:
	mov	ax, 14h
loc_17759:
	mov	[bp+headerSize], ax

	mov	si, [bp+quadrant]
	shl	si, 1
	mov	al, byte ptr bigpicQuadrantCoords.column[si]
	cbw
	mov	[bp+column], ax

	mov	al, bigpicQuadrantCoords.row[si]
	cbw
	mov	[bp+row], ax

	mov	bx, [bp+quadrant]
	mov	al, byte_44278[bx]
	cbw
	mov	[bp+var_6], ax

	mov	al, byte_442F4[bx]
	cbw
	mov	cx, [bp+sq]
	shl	cx, 1
	shl	cx, 1
	add	ax, cx
	mov	[bp+var_8], ax

	mov	ax, [bp+headerSize]
	cmp	[bp+var_8], ax
	jge	loc_1786B
loc_177A8:
	mov	di, [bp+var_8]
	lfs	bx, [bp+gbuf]
	mov	ah, fs:[bx+di+1]
	sub	al, al
	mov	bx, di
	mov	di, word ptr [bp+gbuf]
	mov	cl, fs:[bx+di]
	sub	ch, ch
	add	ax, cx
	add	ax, di
	mov	dx, fs
	add	ax, 9
	mov	word ptr [bp+_offset], ax
	mov	word ptr [bp+_offset+2], dx
	lfs	bx, [bp+_offset]
	inc	word ptr [bp+_offset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+_offset]
	inc	word ptr [bp+_offset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+height], ax
	mov	ax, word ptr [bp+_offset]
	add	ax, 2
	mov	[bp+gbufOff], ax
	mov	[bp+gbufSeg], dx
	cmp	[bp+column], 0
	jge	short loc_17813
	mov	ax, [bp+column]
	sub	[bp+gbufOff], ax
	mov	ax, [bp+var_6]
	add	ax, [bp+column]
	jns	short loc_17809
	sub	ax, ax
loc_17809:
	mov	[bp+var_A], ax
	mov	[bp+column], 0
	jmp	short loc_1782F
loc_17813:
	mov	ax, [bp+column]
	add	ax, [bp+var_6]
	cmp	ax, 56
	jle	short loc_17829
	mov	ax, 55
	sub	ax, [bp+column]
	mov	[bp+var_A], ax
	jmp	short loc_1782F
loc_17829:
	mov	ax, [bp+var_6]
	mov	[bp+var_A], ax
loc_1782F:
	cmp	[bp+var_2], 0
	jz	short loc_1786B
	mov	bx, [bp+quadrant]
	mov	al, byte_444D8[bx]
	cbw
	push	ax
	mov	al, byte_442B6[bx]
	cbw
	push	ax
	push	[bp+height]
	push	[bp+var_2]
	push	[bp+var_A]
	push	[bp+row]
	push	[bp+column]
	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	call	_bigpic_copyTopoElem
	add	sp, 12h
loc_1786B:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bigpic_drawTopology endp

; Attributes: bp-based frame

bigpic_setBackground	proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	test	levFlags, 20h
	jz	l_inDungeon

	mov	ax, 44h			; Outdoor sky color
	push	ax
	mov	ax, 0BBBBh		; Outdoor ground color
	push	ax
	mov	ax, offset bigpicBuf
	mov	dx, seg seg021
	push	dx
	push	ax
	call	bigpicmemcpy
	add	sp, 8
	jmp	l_return

l_inDungeon:
	push	si
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+11h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+10h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+13h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+12h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, (offset bigpicBuf+9A0h)
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	cmp	lightDistance, 4
	jnb	short l_return
	mov	al, lightDistance
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	push	bigpicLightSize[si]
	sub	ax, ax
	push	ax
	mov	bx, bigpicLightOffset[si]
	lea	ax, bigpicBuf[bx]
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	memset
	add	sp, 8
	pop	si
l_return:
	mov	sp, bp
	pop	bp
	retf
bigpic_setBackground	endp


seg004 ends

; Segment type: Pure code
seg005 segment byte public 'CODE' use16
        assume cs:seg005
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
; Attributes: bp-based frame

icon_deactivate proc far

	iconIndex= word ptr	 6

	push	bp
	mov	bp, sp

	mov	bx, [bp+iconIndex]
	mov	al, iconClearIndex[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr icon_draw
	add	sp, 4
	mov	bx, [bp+iconIndex]
	mov	lightDuration[bx], 0
	mov	ax, [bp+iconIndex]
	or	ax, ax
	jz	short l_light
	cmp	ax, 2
	jz	short l_detect
	cmp	ax, 3
	jz	short l_shield
	jmp	short l_return

l_light:
	sub	al, al
	mov	lightDistance, al
	mov	gs:gl_detectSecretDoorFlag, al
	jmp	short l_return

l_detect:
	mov	g_detectType, 0
	jmp	short l_return

l_shield:
	mov	shieldAcBonus, 0

l_return:
	mov	sp, bp
	pop	bp
	retf
icon_deactivate endp

; Attributes: bp-based frame

icon_activate proc far

	iconIndex= word ptr	 6

	push	bp
	mov	bp, sp
	push	si

	mov	bx, [bp+iconIndex]
	mov	iconCurrentDelay[bx], 1
	mov	bx, [bp+iconIndex]
	mov	si, bx
	sub	al, al
	mov	byte_44718[si],	al
	mov	iconCurrentCell[bx],	al
	sub	ax, ax
	push	ax
	push	[bp+iconIndex]
	push	cs
	call	near ptr icon_draw
	add	sp, 4

	pop	si
	mov	sp, bp
	pop	bp
	retf
icon_activate endp

; Attributes: bp-based frame

gfx_animate proc far

	iconNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	al, byte ptr g_direction
	mov	iconCurrentCell[1], al

	cmp	gs:byte_422A0, 0
	jz	short loc_17A34

	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 3
	jnz	short loc_17A34

	inc	gs:bigpicCellNumber
	and	gs:bigpicCellNumber, 3
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicCellNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	jmp	short loc_17A9C

loc_17A34:
	cmp	gs:word_42560, 0
	jz	short loc_17A9C

	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 7
	jnz	short loc_17A9C
	inc	gs:bigpicCellNumber
	cmp	gs:bigpicCellNumber, 3
	jnz	short loc_17A6D
	mov	gs:word_42560, 0

loc_17A6D:
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicCellNumber
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:bigpicCellData_off
	mov	dx, gs:bigpicCellData_seg
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8

loc_17A9C:
	mov	[bp+iconNumber], 0
loc_17AA3:
	mov	bx, [bp+iconNumber]
	cmp	lightDuration[bx], 0
	jz	short l_increment

	; Unsure what this block does because byte_44718 and iconCurrentCell shouldn't
	; ever be different.
	mov	si, bx
	mov	al, byte_44718[si]
	cmp	iconCurrentCell[bx],	al
	jz	short loc_17AE0
	mov	al, iconCurrentCell[si]
	mov	byte_44718[bx],	al
	mov	bx, [bp+iconNumber]
	mov	al, iconCurrentCell[bx]
	cbw
	push	ax
	push	bx
	push	cs
	call	near ptr icon_draw
	add	sp, 4

loc_17AE0:
	mov	bx, [bp+iconNumber]
	cmp	iconAnimationDelay[bx],	0
	jz	short l_increment

	mov	al, iconCurrentDelay[bx]
	dec	iconCurrentDelay[bx]
	cmp	al, 1
	jnz	short l_increment

	mov	bx, [bp+iconNumber]
	mov	si, bx
	mov	al, iconAnimationDelay[si]
	mov	iconCurrentDelay[bx], al		; Set up delay for next cell

	mov	bx, [bp+iconNumber]
	inc	iconCurrentCell[bx]
	mov	al, iconCurrentCell[bx]
	mov	bx, [bp+iconNumber]
	cmp	al, iconClearIndex[bx]
	jnz	short l_increment
	mov	iconCurrentCell[bx],	0

l_increment:
	inc	[bp+iconNumber]
	cmp	[bp+iconNumber], 5
	jl	short loc_17AA3

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
gfx_animate endp

; Attributes: bp-based frame

icon_draw proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= byte ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr iconDataList[bx]
	mov	dx, word ptr (iconDataList+2)[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_17B46:
	mov	al, [bp+arg_2]
	dec	[bp+arg_2]
	or	al, al
	jz	short loc_17B60
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	mov	ax, word_4470E[bx]
	add	[bp+var_4], ax
	jmp	short loc_17B46
loc_17B60:
	mov	al, [bp+arg_0]
	sub	ah, ah
	mov	si, ax
	mov	al, iconWidth[si]
	push	ax
	mov	al, iconHeight[si]
	push	ax
	mov	al, iconXOffset[si]
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	far ptr	sub_3E986
	add	sp, 0Ah
	pop	si
	mov	sp, bp
	pop	bp
locret_17B88:
	retf
icon_draw endp


seg005 ends

include seg006.asm

; Segment type: Pure code
seg007 segment word public 'CODE' use16
        assume cs:seg007
;org 0Dh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

; This function	sets the direction facing in the
; opposite direction. Used when	exiting	buildings.
; If the party was facing north, after this function
; they would be	facing south.
; Attributes: bp-based frame

map_turnAround proc far
	push	bp
	mov	bp, sp
	mov	ax, g_direction
	add	ax, 2
	and	ax, 3
	mov	g_direction, ax
	mov	sp, bp
	pop	bp
	retf
map_turnAround endp

; Attributes: bp-based frame
map_moveOneSquare proc	far
	push	bp
	mov	bp, sp
	push	si

	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	sq_north, ax
	mov	ax, dirDeltaE[si]
	add	sq_east, ax

	pop	si
	mov	sp, bp
	pop	bp
	retf
map_moveOneSquare endp

; This function	is the mechanism behind	an if-then
; clause in the	code.
; Attributes: bp-based frame

mapvm_if	proc far

	memOff=	word ptr  6
	memSeg=	word ptr  8
	rval= word ptr	0Ah

	push	bp
	mov	bp, sp

	cmp	[bp+rval], 0
	jz	short loc_1926C

	cmp	gs:breakAfterFunc, 0
	jz	short loc_1925F

	push	[bp+memSeg]
	push	[bp+memOff]
	call	map_getDataOffsetP
	add	sp, 4
	mov	[bp+memOff], ax
	mov	[bp+memSeg], dx
	jmp	short l_return

loc_1925F:
	mov	gs:breakAfterFunc, 1
	jmp	short l_return

loc_1926C:
	cmp	gs:breakAfterFunc, 0
	jz	short l_return
	add	[bp+memOff], 2

l_return:
	mov	ax, [bp+memOff]
	mov	dx, [bp+memSeg]
	mov	sp, bp
	pop	bp
	retf
mapvm_if	endp

; Attributes: bp-based frame

dun_changeLevels proc far

	dungeonDataP= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	word ptr [bp+dungeonDataP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+dungeonDataP+2], seg seg022
	mov	si, dunLevelNum
	lfs	bx, [bp+dungeonDataP]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	mov	dunLevelIndex, ax
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	sq_north, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	sq_east, ax
	mov	gs:levelChangedFlag, 1
	mov	buildingRvalMaybe, 4

	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_changeLevels endp

; Attributes: bp-based frame

dun_setExitLocation proc far

	dungeonDataP= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	word ptr [bp+dungeonDataP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+dungeonDataP+2], seg seg022
	lfs	bx, [bp+dungeonDataP]
	mov	al, fs:[bx+dun_t.exitSqN]
	sub	ah, ah
	mov	sq_north, ax
	mov	al, fs:[bx+dun_t.exitSqE]
	mov	sq_east, ax
	mov	al, fs:[bx+dun_t.exitLocation]
	mov	currentLocationMaybe, ax
	mov	buildingRvalMaybe, 2
	mov	sp, bp
	pop	bp
	retf
dun_setExitLocation endp

; Attributes: bp-based frame

mfunc_downStairs proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp

	cmp	g_sameSquareFlag, 0
	jnz	short l_return

	mov	g_sameSquareFlag, 1
	call	text_clear
	mov	al, levFlags
	sub	ah, ah
	and	ax, 10h
	push	ax
	mov	ax, offset s_thereAreStairs
	push	ds
	push	ax
	call	stairsPluralHelper
	add	sp, 6
	call	getYesNo
	or	ax, ax
	jz	short l_return

	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_setSameSquareFlag
	add	sp, 4
	dec	dunLevelNum
	jns	short l_changeLevel

	push	cs
	call	near ptr dun_setExitLocation
	jmp	short l_return

l_changeLevel:
	push	cs
	call	near ptr dun_changeLevels

l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_downStairs endp

; Attributes: bp-based frame

mfunc_upStairs proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp

	cmp	g_sameSquareFlag, 0
	jnz	short l_return
	mov	g_sameSquareFlag, 1
	call	text_clear
	mov	al, levFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	mov	ax, offset s_thereAreStairs
	push	ds
	push	ax
	call	stairsPluralHelper
	add	sp, 6
	call	getYesNo
	or	ax, ax
	jz	short l_return
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_setSameSquareFlag
	add	sp, 4
	inc	dunLevelNum
	push	cs
	call	near ptr dun_changeLevels
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_upStairs endp

; Attributes: bp-based frame

mfunc_utility proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	cmp	ax, 3
	jz	short l_geomancer_convert
	cmp	ax, 4
	jz	short l_doScrySite
	cmp	ax, 5
	jz	short l_doVictory
	cmp	ax, 9
	jz	short l_copyProtection
	jmp	short l_notImplemented

l_geomancer_convert:
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	push	ax
	call	far ptr geomancer_convert
	add	sp, 2
	jmp	short l_returnSuccess

l_doScrySite:
	cmp	inDungeonMaybe, 0
	jz	short l_printLocation
	call	brilhasti_doBonus
	jmp	short l_returnSuccess
l_printLocation:
	call	printLocation
	jmp	short l_returnSuccess

l_doVictory:
	call	doVictoryMaybe
	jmp	short l_returnSuccess

l_copyProtection:
	call	copyProtection
	mov	gs:breakAfterFunc, ax
	jmp	short l_returnSuccess

l_notImplemented:
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_notImplemented
	add	sp, 4
	jmp	short l_return

l_returnSuccess:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]

l_return:
	mov	sp, bp
	pop	bp
	retf
mfunc_utility endp

; Attributes: bp-based frame

mfunc_teleport proc far

	destinationDungeon= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	mfunc_setSameSquareFlag
	add	sp, 4

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]

	; Set new sq_north
	mov	al, fs:[bx]
	sub	ah, ah
	mov	sq_north, ax

	; Set new sq_east
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	sq_east, ax

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+destinationDungeon], ax

	cmp	inDungeonMaybe, 0
	jz	short loc_19557

	cmp	ax, 80h
	jb	short loc_19531
	mov	buildingRvalMaybe, gameState_inWilderness
	and	ax, 7Fh
	mov	currentLocationMaybe, ax
	jmp	short loc_19555
loc_19531:
	mov	ax, [bp+destinationDungeon]
	cmp	dunLevelIndex, ax
	jz	short loc_1954A
	mov	buildingRvalMaybe, gameState_inDungeon
loc_1954A:
	mov	ax, [bp+destinationDungeon]
	mov	dunLevelIndex, ax
loc_19555:
	jmp	short l_return

loc_19557:
	cmp	[bp+destinationDungeon], 80h
	jb	short loc_19579
	mov	buildingRvalMaybe, gameState_inDungeon
	mov	ax, [bp+destinationDungeon]
	and	ax, 7Fh
	mov	dunLevelIndex, ax
	jmp	short l_return

loc_19579:
	mov	ax, [bp+destinationDungeon]
	cmp	currentLocationMaybe, ax
	jz	short loc_19592
	mov	buildingRvalMaybe, gameState_inWilderness
loc_19592:
	mov	ax, [bp+destinationDungeon]
	mov	currentLocationMaybe, ax

l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_teleport endp

; Attributes: bp-based frame

mfunc_battle proc far

	loopCounter= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	g_monsterGroupCount, al
	cmp	al, 4
	jb	short l_skipZounds
	mov	ax, offset s_zounds
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

l_skipZounds:
	mov	[bp+loopCounter], 0
l_setEncounterLoop:
	mov	al, g_monsterGroupCount
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jbe	short l_doBattle
	mov	ax, monStruSize
	imul	[bp+loopCounter]
	mov	si, ax
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	byte ptr gs:monGroups._name[si], al
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	gs:monGroups.groupSize[si], al
	inc	[bp+loopCounter]
	jmp	short l_setEncounterLoop

l_doBattle:
	mov	gs:g_nonRandomBattleFlag, 1
	mov	g_partyAttackFlag, 0
	call	bat_init
	or	ax, ax
	jz	short l_battleOver
	mov	buildingRvalMaybe, gameState_partyDied
	mov	gs:breakAfterFunc, 0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	jmp	short l_return

l_battleOver:
	cmp	gs:runAwayFlag,	1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	mapvm_if
	add	sp, 6
	jmp	short $+2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_battle endp

; Attributes: bp-based frame

mfunc_clearPrintString proc far

	arg_0= dword ptr	 6

	push	bp
	mov	bp, sp
	call	text_clear
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
mfunc_clearPrintString endp

; Replace the opcode at	*dataP with 0xff effectively
; removing the code from the level. Used so the	party
; only runs the	code at	the current square once	per
; level.
; Attributes: bp-based frame

mfunc_clearSpecial proc far

	destinationP= dword ptr -4
	dataP= dword ptr 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+destinationP], ax
	mov	word ptr [bp+destinationP+2], dx
	lfs	bx, [bp+destinationP]
	mov	byte ptr fs:[bx], 0FFh
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	add	ax, 2
	mov	sp, bp
	pop	bp
	retf
mfunc_clearSpecial endp

; This function	draws the bigpic image located at *dataP;
; Attributes: bp-based frame

mfunc_drawBigpic proc far

	picNo= word ptr	-2
	dataP=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+picNo], ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_drawBigpic endp

; This function	reads an 0x80AND'd string from *membuf
; and sets the title. The string is 0xff terminated.
; Attributes: bp-based frame

mfunc_setTitle proc far

	stringBufferP= word ptr -102h
	stringBuffer= word ptr -100h
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 102h
	call	someStackOperation
	push	si

	mov	[bp+stringBufferP], 0
l_unmaskLoop:
	lfs	bx, [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jz	short l_setTitle
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	and	al, 7Fh
	mov	si, [bp+stringBufferP]
	inc	[bp+stringBufferP]
	mov	byte ptr [bp+si+stringBuffer], al
	jmp	short l_unmaskLoop

l_setTitle:
	mov	si, [bp+stringBufferP]
	mov	byte ptr [bp+si+stringBuffer], 0
	inc	word ptr [bp+dataP]
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_setTitle endp

; Attributes: bp-based frame

mfunc_waitForIo proc far

	arg_0= dword ptr 6

	push	bp
	mov	bp, sp
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_waitForIo endp

; Attributes: bp-based frame

mfunc_clearText proc far

	dataP= dword ptr 6

	push	bp
	mov	bp, sp
	call	text_clear
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_clearText endp

; Attributes: bp-based frame

mfunc_ifFlag proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr checkProgressFlags
	add	sp, 2
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifFlag endp

; Attributes: bp-based frame

mfunc_ifNotFlag	proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr checkProgressFlags
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifNotFlag	endp

; Attributes: bp-based frame

checkProgressFlags proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	flagData= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, [bp+flagData]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_4], ax
	mov	ax, [bp+flagData]
	and	ax, 7
	mov	[bp+var_2], ax
	mov	bx, [bp+var_4]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	mov	sp, bp
	pop	bp
	retf
checkProgressFlags endp

; Attributes: bp-based frame
;
; DWORD rowOffsetSeg & rowOffsetOff, charBufOff & charBufSeg

mfunc_makeDoor proc far

	squareP=	dword ptr -1Ch
	doorData=	word ptr -18h
	squareNumber=	word ptr -14h
	var_12=	dword ptr -12h
	rowNumber= word ptr	-0Eh
	charBufOff= word ptr -0Ch
	charBufSeg= word ptr -0Ah
	var_8= word ptr	-8
	rowOffsetOff= word ptr	-6
	rowOffsetSeg= word ptr	-4
	var_2= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 1Ch
	call	someStackOperation

	mov	[bp+charBufOff], offset	g_rosterCharacterBuffer
	mov	[bp+charBufSeg], seg seg022
	mov	ax, [bp+charBufOff]
	mov	dx, [bp+charBufSeg]
	add	ax, 24h					; 24h == rowOffset
	mov	[bp+rowOffsetOff], ax
	mov	[bp+rowOffsetSeg], dx

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+rowNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+squareNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+doorData], ax

	mov	ax, [bp+rowNumber]
	shl	ax, 1
	add	ax, [bp+rowOffsetOff]
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	cx, [bp+squareNumber]
	mov	dx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, dx
	add	ax, cx
	add	ax, offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_12], ax
	mov	word ptr [bp+var_12+2],	seg seg022
	mov	ax, [bp+doorData]
	and	ax, 0Fh
	mov	[bp+var_2], ax
	mov	cl, 4
	shr	[bp+doorData], cl
	test	byte ptr [bp+doorData], 2
	jz	short loc_198EC
	inc	word ptr [bp+var_12]
loc_198EC:
	test	byte ptr [bp+doorData], 1
	jz	short loc_1990E
	lfs	bx, [bp+var_12]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 0F0h
	mov	[bp+var_8], ax
	mov	ax, [bp+var_2]
	or	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	mov	fs:[bx], al
	jmp	short loc_1992C
loc_1990E:
	lfs	bx, [bp+var_12]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_8], ax
	mov	ax, [bp+var_2]
	mov	cl, 4
	shl	ax, cl
	or	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	mov	fs:[bx], al
loc_1992C:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_makeDoor endp

; Attributes: bp-based frame

mfunc_setFlag proc far

	flagNo=	word ptr -2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+flagNo], ax
	mov	ax, 0FFh
	push	ax
	push	[bp+flagNo]
	push	cs
	call	near ptr _updateFlags
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setFlag endp

; Attributes: bp-based frame

mfunc_clearFlag	proc far

	flagNo= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+flagNo], ax
	sub	ax, ax
	push	ax
	push	[bp+flagNo]
	call	_updateFlags
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_clearFlag	endp

; Attributes: bp-based frame

_updateFlags proc far

	flagNumber=	word ptr -6
	flagMaskIndex=	word ptr -4
	flagMask=	word ptr -2
	flagData=	word ptr  6
	initialMask=	byte ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	mov	ax, [bp+flagData]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+flagNumber], ax

	mov	ax, [bp+flagData]
	and	ax, 7
	mov	[bp+flagMaskIndex], ax

	mov	bx, [bp+flagNumber]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+flagMaskIndex]
	mov	cl, flagMaskList[bx]
	sub	ch, ch
	and	ax, cx
	mov	[bp+flagMask], ax

	mov	al, byteMaskList[bx]
	and	al, [bp+initialMask]
	or	al, byte ptr [bp+flagMask]
	mov	bx, [bp+flagNumber]
	mov	g_gameProgressFlags[bx], al
	mov	sp, bp
	pop	bp
	retf
_updateFlags endp

; Attributes: bp-based frame
mfunc_ifCurSpellEQ proc	far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	cmp	ax, g_curSpellNumber
	jnz	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifCurSpellEQ endp

; Attributes: bp-based frame

mfunc_setMapRval proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	gs:mapRval, 1
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setMapRval endp

; Attributes: bp-based frame

mfunc_printString proc far

	stringBuffer= word ptr -100h
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 100h
	call	someStackOperation
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	_mfunc_getString
	add	sp, 8
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_printString endp

; Attributes: bp-based frame

mfunc_doNothing	proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_doNothing	endp

; Attributes: bp-based frame
mfunc_ifLiquid proc	far

	liquidIndex= word ptr	-4
	var_2= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+liquidIndex], ax
	mov	al, charSize
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	sar	ax, 1
	sar	ax, 1
	and	ax, 0Fh
	mov	[bp+var_2], ax
	cmp	[bp+liquidIndex], ax
	jnz	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifLiquid endp

; Attributes: bp-based frame
;
; DWORD - var_10A & var_10C

mfunc_getItem proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	stringBuffer= word ptr -106h
	var_6= word ptr	-6
	slotNumber= word ptr	-4
	var_2= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_108], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_6], ax

l_retry:
	call	text_clear
	mov	ax, offset s_whoWantsToGetThe
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	push	[bp+var_108]
	push	[bp+var_2]
	push	dx
	push	ax
	call	item_getName
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	call	readSlotNumber
	mov	[bp+slotNumber], ax
	or	ax, ax
	jge	short l_addItem
	sub	ax, ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	jmp	l_return

l_addItem:
	push	[bp+var_6]
	push	[bp+var_108]
	push	[bp+var_2]
	push	[bp+slotNumber]
	call	inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short l_inventoryFull
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	mov	ax, offset s_gotThe
	push	ds
	push	ax
	push	dx
	push	[bp+var_10C]
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	push	[bp+var_108]
	push	[bp+var_2]
	push	dx
	push	ax
	call	item_getName
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 1
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	jmp	short l_return

l_inventoryFull:
	mov	ax, offset s_sorryBut
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_10A]
	push	[bp+var_10C]
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	mov	ax, offset s_cantCarryAnyMore
	push	ds
	push	ax
	push	dx
	push	[bp+var_10C]
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	l_retry

l_return:
	mov	sp, bp
	pop	bp
	retf
mfunc_getItem endp

mfunc_ifPartyHasItem	proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr vm_findItem
	add	sp, 2
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifPartyHasItem	endp

; Attributes: bp-based frame
mfunc_ifPartyNotHasItem proc	far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr vm_findItem
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifPartyNotHasItem endp

; Attributes: bp-based frame

vm_findItem proc far

	slotNumber=	word ptr -4
	inventorySlotNumber= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+slotNumber], 0

l_characterLoop:
	mov	[bp+inventorySlotNumber], 1
l_inventoryLoop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short l_inventoryLoopNext
	mov	al, byte ptr [bp+inventorySlotNumber]
	dec	al
	mov	gs:g_usedItemSlotNumber, al
	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
	mov	ax, 1
	jmp	short l_return
l_inventoryLoopNext:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], inventorySize
	jl	short l_inventoryLoop
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_characterLoop
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
vm_findItem endp

; Attributes: bp-based frame

mfunc_ifSameSquare proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, g_sameSquareFlag
	mov	g_sameSquareFlag, 1
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifSameSquare endp

; Attributes: bp-based frame

mfunc_ifYesNo proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	call	getYesNo
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifYesNo endp

; Attributes: bp-based frame
mfunc_goto proc	far
	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	map_getDataOffsetP
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
mfunc_goto endp

; Attributes: bp-based frame

mfunc_battleNoCry proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	gs:byte_4228B, 1
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_battle
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
mfunc_battleNoCry endp

; Attributes: bp-based frame

mfunc_setSameSquareFlag	proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	g_sameSquareFlag, 0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setSameSquareFlag	endp

; Attributes: bp-based frame

mfunc_turnAround proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	push	cs
	call	near ptr map_turnAround
	push	cs
	call	near ptr map_moveOneSquare
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_turnAround endp

; Attributes: bp-based frame

mfunc_removeItem proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr vm_removeItem
	add	sp, 2
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_removeItem endp

; Attributes: bp-based frame

vm_removeItem proc far

	slotNumber=	word ptr -4
	inventorySlotNumber= word ptr	-2
	itemNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	[bp+slotNumber], 0

l_characterLoop:
	mov	[bp+inventorySlotNumber], 1

l_inventoryLoop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	add	bx, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNumber]
	jnz	short l_inventoryLoopNext
	mov	ax, [bp+inventorySlotNumber]
	dec	ax
	mov	gs:g_inventoryPackStart, ax
	mov	ax, [bp+slotNumber]
	mov	gs:g_inventoryPackTarget, ax
	call	inven_pack
	jmp	short l_characterLoopNext

l_inventoryLoopNext:
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 24h	
	jl	short l_inventoryLoop

l_characterLoopNext:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_characterLoop

l_return:
	mov	sp, bp
	pop	bp
	retf
vm_removeItem endp

; Attributes: bp-based frame

mfunc_incrementRegister proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	inc	g_vm_registers[bx]
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_incrementRegister endp

; Attributes: bp-based frame

mfunc_decrementRegister proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	dec	g_vm_registers[bx]
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_decrementRegister endp

; Attributes: bp-based frame
mfunc_ifRegisterClear proc	far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	cmp	g_vm_registers[bx], 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegisterClear endp

; Attributes: bp-based frame

mfunc_ifRegisterSet proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	push	g_vm_registers[bx]
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegisterSet endp

; Attributes: bp-based frame

mfunc_drainHp proc far

	slotNumber= word ptr	-4
	drainAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+drainAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+drainAmount], ax
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, [bp+drainAmount]
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.currentHP[bx], cx
	jbe	short l_killCharacter
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	gs:party.currentHP[bx], cx
	jmp	short l_next

l_killCharacter:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	mov	gs:party.currentHP[si], 0
	or	gs:party.status[si], 4

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop
	call	party_getLastSlot
	cmp	ax, 7
	jle	short l_return
	mov	buildingRvalMaybe, gameState_partyDied

l_return:
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_drainHp endp

; Attributes: bp-based frame

mfunc_ifInBox proc far

	sqE= word ptr	-0Ch
	sqN= word ptr	-0Ah
	northLowerBound= word ptr	-8
	eastLowerBound= word ptr	-6
	northUpperBound= word ptr	-4
	eastUpperBound= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si

	mov	ax, sq_north
	mov	[bp+sqN], ax
	mov	ax, sq_east
	mov	[bp+sqE], ax
	cmp	inDungeonMaybe, 0
	jnz	short l_skipWildernessOffset
	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	[bp+sqN], ax
	mov	ax, dirDeltaE[si]
	add	[bp+sqE], ax
l_skipWildernessOffset:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+northLowerBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+eastLowerBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+northUpperBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+eastUpperBound], ax

	mov	ax, [bp+northLowerBound]
	cmp	[bp+sqN], ax
	jl	short l_returnZero

	mov	ax, [bp+northUpperBound]
	cmp	[bp+sqN], ax
	jg	short l_returnZero

	mov	ax, [bp+eastLowerBound]
	cmp	[bp+sqE], ax
	jl	short l_returnZero

	mov	ax, [bp+eastUpperBound]
	cmp	[bp+sqE], ax
	jg	short l_returnZero

	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	fs
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_ifInBox endp

; Attributes: bp-based frame

mfunc_setLiquid proc far

	inventoryP= dword ptr -6
	liquidNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	shl	ax, 1
	shl	ax, 1
	mov	[bp+liquidNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory
	mov	word ptr [bp+inventoryP], ax
	mov	word ptr [bp+inventoryP+2], seg seg027
	lfs	bx, [bp+inventoryP]
	mov	al, fs:[bx]
	and	al, 0C3h
	or	al, byte ptr [bp+liquidNumber]
	mov	fs:[bx], al
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setLiquid endp

; Attributes: bp-based frame

mfunc_addToContainer proc far

	var_4= word ptr	-4
	addAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	si, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	si, ax
	mov	al, gs:party.inventory.itemCount[si]
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+addAmount], ax
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_4], ax
	cmp	[bp+addAmount], 0FEh 
	jle	short loc_1A1FC
	mov	[bp+addAmount], 0FEh 
loc_1A1FC:
	mov	bx, [bp+var_4]
	mov	al, g_itemBaseCount[bx]
	sub	ah, ah
	sub	ax, [bp+addAmount]
	sbb	cx, cx
	and	ax, cx
	add	ax, [bp+addAmount]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	gs:party.inventory.itemCount[bx], cl
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_addToContainer endp

; Attributes: bp-based frame

mfunc_subtractFromContainer proc far

	itemCountP= dword ptr -0Ah
	var_4= word ptr	-4
	subtractAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory.itemCount
	mov	word ptr [bp+itemCountP], ax
	mov	word ptr [bp+itemCountP+2], seg seg027
	lfs	bx, [bp+itemCountP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+subtractAmount], ax
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+var_4], ax
	cmp	[bp+subtractAmount], 0FEh 
	jz	short l_return
	cmp	[bp+subtractAmount], ax
	jl	short l_setToZero
	mov	al, byte ptr [bp+subtractAmount]
	sub	al, byte ptr [bp+var_4]
	jmp	short l_setCount
l_setToZero:
	sub	al, al
l_setCount:
	lfs	bx, [bp+itemCountP]
	mov	fs:[bx], al
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_subtractFromContainer endp

; Attributes: bp-based frame

mfunc_addToRegister proc far

	registerNumber= word ptr	-4
	addAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+addAmount], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+addAmount], ax
	mov	ax, [bp+addAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	add	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_addToRegister endp

; Attributes: bp-based frame

mfunc_subtractFromRegister proc far

	registerNumber= word ptr -4
	subtractAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+subtractAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+subtractAmount], ax

	mov	ax, [bp+subtractAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	sub	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_subtractFromRegister endp

; Attributes: bp-based frame
mfunc_setDirection proc	far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	g_direction, ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setDirection endp

; Attributes: bp-based frame

mfunc_readString proc far

	loopCounter= word ptr	-2
	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 10h
	push	ax
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	readString
	add	sp, 6

	mov	[bp+loopCounter], 0
l_loop:
	mov	bx, [bp+loopCounter]
	mov	al, gs:mfunc_ioBuf[bx]
	sub	ah, ah
	push	ax
	call	toUpper
	add	sp, 2
	mov	bx, [bp+loopCounter]
	mov	gs:mfunc_ioBuf[bx], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_loop

	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_readString endp

; Attributes: bp-based frame
vm_strcmp proc	far

	dataP= dword ptr  6
	stringBuffer= dword ptr  0Ah

	push	bp
	mov	bp, sp
l_loop:
	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	and	al, 7Fh
	lfs	bx, [bp+stringBuffer]
	inc	word ptr [bp+stringBuffer]
	cmp	al, fs:[bx]
	jnz	short l_doneComparing
	inc	word ptr [bp+dataP]
	jmp	short l_loop
l_doneComparing:
	lfs	bx, [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
vm_strcmp endp

; Attributes: bp-based frame

mfunc_ifStringEquals proc far

	rval= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr vm_strcmp
	add	sp, 8
	mov	[bp+rval], ax

l_skipString:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_skipString

	push	[bp+rval]
	push	fs
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifStringEquals endp

; Attributes: bp-based frame

mfunc_parseNumber proc far

	registerNumber= word ptr	-4
	value= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax
	lea	ax, [bp+value]
	push	ss
	push	ax
	mov	ax, offset s_percentD
	push	ds
	push	ax
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	sscanf
	add	sp, 0Ch
	mov	ax, [bp+value]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_parseNumber endp

; Attributes: bp-based frame
mfunc_getCharacter proc	far

	slotNumber= word ptr	-2
	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	readSlotNumber
	mov	[bp+slotNumber], ax
	or	ax, ax
	jl	short loc_1A4CA
	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
loc_1A4CA:
	cmp	[bp+slotNumber], 0
	jl	short l_returnZero
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_getCharacter endp

; Attributes: bp-based frame
;
; Remove an amount of gold from a player. The amount is stored
; in the register specified.
;

mfunc_ifGiveGold proc far

	registerAmountLo= word ptr	-0Ah
	registerAmountHi= word ptr	-8
	registerNumber= word ptr	-6
	memberGoldLo= word ptr	-4
	memberGoldHi= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	ax, word ptr gs:party.gold[bx]
	mov	dx, word ptr gs:(party.gold+2)[bx]
	mov	[bp+memberGoldLo], ax
	mov	[bp+memberGoldHi], dx

	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	mov	[bp+registerAmountLo], ax
	mov	[bp+registerAmountHi], dx

	mov	ax, [bp+memberGoldLo]
	mov	dx, [bp+memberGoldHi]
	cmp	[bp+registerAmountHi], dx
	ja	short l_notEnough
	jb	short l_removeGold
	cmp	[bp+registerAmountLo], ax
	ja	short l_notEnough

l_removeGold:
	mov	ax, [bp+registerAmountLo]
	mov	dx, [bp+registerAmountHi]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	sub	word ptr gs:party.gold[bx], cx
	sbb	word ptr gs:(party.gold+2)[bx], dx
	jmp	short l_setReturnValue

l_notEnough:
	mov	ax, offset s_youDontHaveEnoughGold
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 3
	push	ax
	call	text_delayNoTable
	add	sp, 2

l_setReturnValue:
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	cmp	dx, [bp+memberGoldHi]
	ja	short l_returnZero
	jb	short l_returnOne
	cmp	ax, [bp+memberGoldLo]
	ja	short l_returnZero

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifGiveGold endp

; Attributes: bp-based frame

mfunc_addGold proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	bx, ax
	shl	bx, 1
	mov	ax, g_vm_registers[bx]
	cwd
	mov	cx, ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	add	word ptr gs:party.gold[bx], cx
	adc	word ptr gs:(party.gold+2)[bx], dx
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_addGold endp

; Attributes: bp-based frame

mfunc_ifRegisterLt proc far

	registerNumber= word ptr	-4
	comparisonAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+comparisonAmount], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+comparisonAmount], ax

	mov	ax, [bp+comparisonAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	cmp	g_vm_registers[bx], ax
	jge	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegisterLt endp

; Attributes: bp-based frame

mfunc_ifRegisterEq proc far
	registerNumber= word ptr	-4
	comparisonAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+comparisonAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+comparisonAmount], ax
	mov	ax, [bp+comparisonAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	cmp	g_vm_registers[bx], ax
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegisterEq endp

; Attributes: bp-based frame

mfunc_ifRegisterGe proc far

	registerNumber= word ptr	-4
	comparisonAmount= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+comparisonAmount], ax
	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+comparisonAmount], ax
	mov	ax, [bp+comparisonAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	cmp	g_vm_registers[bx], ax
	jl	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegisterGe endp

; Attributes: bp-based frame

mfunc_learnSpell proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	mov	al, gs:g_userSlotNumber
	push	ax
	call	mage_learnSpell
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_learnSpell endp

; Attributes: bp-based frame

mfunc_setRegister proc far

	registerNumber=	word ptr -4
	setAmount= word ptr -2
	dataP=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+registerNumber], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+setAmount], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+setAmount], ax

	mov	ax, [bp+setAmount]
	mov	bx, [bp+registerNumber]
	shl	bx, 1
	mov	g_vm_registers[bx], ax
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setRegister endp

; Attributes: bp-based frame

mfunc_ifHasItem proc far

	itemNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	mov	al, 78h	
	mul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	cmp	ax, [bp+itemNumber]
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifHasItem endp

; Attributes: bp-based frame
mfunc_packInventory proc	far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	mov	gs:g_inventoryPackTarget, ax
	mov	al, gs:g_usedItemSlotNumber
	mov	gs:g_inventoryPackStart, ax
	call	inven_pack
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_packInventory endp

; Attributes: bp-based frame

mfunc_addMonster proc far

	monsterIndex= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+monsterIndex], ax

	call	party_findEmptySlot
	mov	[bp+slotNumber], ax
	cmp	ax, 7
	jge	short l_setReturnValue

	mov	ax, monStruSize
	imul	[bp+monsterIndex]
	mov	bx, ax
	lea	ax, monsterBuf[bx]
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+slotNumber]
	call	_sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr g_printPartyFlag,	0

l_setReturnValue:
	cmp	[bp+slotNumber], 7
	jge	short l_returnZero
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_addMonster endp

; Attributes: bp-based frame
mfunc_ifMonsterInParty proc	far

	rval= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	cmp	gs:party.class[si], class_monster
	jnz	short l_next
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr vm_strcmp
	add	sp, 8
	or	ax, ax
	jz	short l_next
	mov	[bp+rval], 1
	jmp	short l_skipString

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_skipString:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_skipString

	mov	al, byte ptr [bp+slotNumber]
	mov	gs:g_userSlotNumber, al
	push	[bp+rval]
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	mapvm_if
	add	sp, 6

	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_ifMonsterInParty endp

; Attributes: bp-based frame

mfunc_clearPrintOffset proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	call	text_clear
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	mfunc_printOffset
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
mfunc_clearPrintOffset endp

; Attributes: bp-based frame

mfunc_ifIsNight	proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	cmp	gs:isNight, 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifIsNight	endp

; Attributes: bp-based frame

mfunc_removeMonster proc far

	arg_0= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	push	ax
	call	party_pack
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_removeMonster endp

; Attributes: bp-based frame
;
; This function searches the party to see if a particular
; chronomancer quest flag bit is set. If the quest flag bit
; is set, then the rval local variable is set to 1. Otherwise, the
; rval variable is set to 0
;
; The bug is caused by the call to quest_partyHasFlagSet. That function
; performs the same function as this one. In fact, this entire function
; could be replaced with:
;
;	push	bp
	mov	bp, sp
;	lfs	bx, [bp+dataP]
;	mov	al, fs:[bx]
;	sub	ah, ah
;	push	ax
;	push	cs
	call	near ptr quest_partyHasFlagSet
	add	sp, 2
;	push	ax
;	push	word ptr [bp+dataP+2]
;	push	word ptr [bp+dataP]
;	mov	sp, bp
	pop	bp
;
; quest_partyHasFlagSet is called with either a 0 or 1 when it SHOULD be called
; by the questData byte from the level.
;
; I've replaced the call to this function in the vm_functionList list with a call to
; mfunc_notImplemented. From my decompiling of the levels, this opcode (3d) is never
; called so it should be safe to do this.

mfunc_buggedIfQuestFlagSet proc far

	questByteNumber= word ptr	-8
	questMaskIndex= word ptr	-6
	rval= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0
l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	add	bx, [bp+questByteNumber]
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questMaskIndex]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	mov	[bp+rval], 1
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	push	[bp+rval]
	push	cs
	call	near ptr quest_partyHasFlagSet
	add	sp, 2
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_buggedIfQuestFlagSet endp

; This function	returns	1 if there is a	character
; in the party that has	the bit	set in chronoQuest
; that matches the passed in quest mask.
; Attributes: bp-based frame
quest_partyHasFlagSet proc	far

	questMaskIndex=	word ptr -8
	rval= word ptr -6
	slotNumber=	word ptr -4
	questByteNumber= word ptr	-2
	questData= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	ax, [bp+questData]
	and	ax, 7
	mov	[bp+questMaskIndex], ax
	mov	ax, [bp+questData]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+questByteNumber], ax
	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	mov	bx, [bp+questByteNumber]
	add	bx, si
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questMaskIndex]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	mov	[bp+rval], 1
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	ax, [bp+rval]
	pop	si
	mov	sp, bp
	pop	bp
	retf
quest_partyHasFlagSet endp

; Attributes: bp-based frame

mfunc_ifQuestFlagNotSet proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr quest_partyNotHasFlagSet
	add	sp, 2
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifQuestFlagNotSet endp

; This function	returns	one if there is	a character
; in the party that does NOT have the quest mask
; set.
; Attributes: bp-based frame

quest_partyNotHasFlagSet proc far

	questMaskIndex= word ptr	-8
	rval= word ptr -6
	slotNumber=	word ptr -4
	questByteNumber= word ptr	-2
	questData= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	ax, [bp+questData]
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	mov	ax, [bp+questData]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	mov	bx, [bp+questByteNumber]
	add	bx, si
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questMaskIndex]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short l_next
	mov	[bp+rval], 1
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	ax, [bp+rval]
	pop	si
	mov	sp, bp
	pop	bp
	retf
quest_partyNotHasFlagSet endp

; Attributes: bp-based frame

mfunc_setQuestFlag	proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr quest_setFlag
	add	sp, 2
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_setQuestFlag	endp

; Attributes: bp-based frame
quest_setFlag proc	far

	questMaskIndex= word ptr	-6
	slotNumber=	word ptr -4
	questByteNumber= word ptr	-2
	questData= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	mov	ax, [bp+questData]
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	mov	ax, [bp+questData]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	bx, [bp+questMaskIndex]
	mov	al, byteMaskList[bx]
	mov	bx, [bp+questByteNumber]
	add	bx, si
	or	gs:party.chronoQuest[bx], al

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop
	pop	si
	mov	sp, bp
	pop	bp
	retf
quest_setFlag endp

; Attributes: bp-based frame

mfunc_clearQuestFlag proc far

	questMaskIndex= word ptr	-8
	rval= word ptr	-6
	questByteNumber= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
l_loop:
	mov	ax, charSize
	imul	[bp+rval]
	mov	si, ax
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	bx, [bp+questMaskIndex]
	mov	al, flagMaskList[bx]
	mov	bx, [bp+questByteNumber]
	add	bx, si
	and	gs:party.chronoQuest[bx], al

l_next:
	inc	[bp+rval]
	cmp	[bp+rval], 7
	jl	short l_loop

	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_clearQuestFlag endp

; Attributes: bp-based frame

mfunc_partyUnderLevel proc far

	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	call	vm_partyUnderLevel
	add	sp, 2
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_partyUnderLevel endp

; This function	returns	0 if there is a	character
; in the party whose level is less than	the passed
; in level. If there is	not it returns 1.
; Attributes: bp-based frame

vm_partyUnderLevel proc far

	rval= word ptr -4
	slotNumber= word ptr -2
	level= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	[bp+rval], 1
	mov	[bp+slotNumber], 0

l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	ax, [bp+level]
	cmp	gs:party.level[si], ax
	jnb	short l_next
	mov	[bp+rval], 0
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	ax, [bp+rval]
	pop	si
	mov	sp, bp
	pop	bp
	retf
vm_partyUnderLevel endp

; Attributes: bp-based frame

mfunc_ifWildFace proc far

	sqN= word ptr	-6
	mapFace= word ptr	-4
	desiredFace= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+desiredFace], ax

	mov	si, g_direction
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+sqN], ax

	mov	ax, dirDeltaE[si]
	add	ax, sq_east

	push	[bp+sqN]
	push	ax
	call	wild_getSquare
	add	sp, 4
	and	ax, 0Fh
	mov	[bp+mapFace], ax

	mov	ax, [bp+desiredFace]
	cmp	[bp+mapFace], ax
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return
l_setToZero:
	sub	ax, ax
l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_ifWildFace endp

; Attributes: bp-based frame

mfunc_setWildFace proc far

	newFace= word ptr	-6
	sqE= word ptr	-4
	sqN= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+newFace], ax

	mov	si, g_direction
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+sqN], ax

	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+sqE], ax

	cmp	gs:wildWrapFlag, 0
	jz	short l_skipWrap
	mov	al, gs:mapHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	call	wrapNumber
	add	sp, 4
	mov	[bp+sqN], ax
	mov	al, gs:mapWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	call	wrapNumber
	add	sp, 4
	mov	[bp+sqE], ax

l_skipWrap:
	cmp	[bp+sqN], 0
	jl	short l_return
	mov	al, gs:mapHeight
	sub	ah, ah
	cmp	ax, [bp+sqN]
	jb	short l_return
	cmp	[bp+sqE], 0
	jl	short l_return
	mov	al, gs:mapWidth
	cmp	ax, [bp+sqE]
	jb	short l_return
	mov	bx, [bp+sqN]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, gs:rowOffset[bx]
	mov	si, [bp+sqE]
	mov	al, byte ptr [bp+newFace]
	mov	fs:[bx+si], al
l_return:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_setWildFace endp

; Attributes: bp-based frame

mfunc_ifIsClass	proc far

	desiredClass= word ptr	-2
	dataP= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+desiredClass], ax

	mov	ax, charSize
	imul	gs:g_userSlotNumber
	mov	bx, ax
	mov	al, gs:party.class[bx]
	sub	ah, ah
	cmp	ax, [bp+desiredClass]
	jnz	short l_setToZero
	mov	ax, 1
	jmp	short l_return

l_setToZero:
	sub	ax, ax

l_return:
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mapvm_if
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
mfunc_ifIsClass	endp

; Attributes: bp-based frame
;
; DWORD var_102 & 104

mfunc_printOffset proc far

	var_104= word ptr -104h
	var_102= word ptr -102h
	stringBuffer= word ptr -100h
	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 104h
	call	someStackOperation

	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	map_getDataOffsetP
	add	sp, 4
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	add	[bp+dataP], 2
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	push	dx
	push	[bp+var_104]
	call	_mfunc_getString
	add	sp, 8
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_printOffset endp

; Attributes: bp-based frame

mfunc_clearTeleport proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0FEh
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	push	cs
	call	near ptr mfunc_teleport
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
mfunc_clearTeleport endp

; Attributes: bp-based frame
;
; This function executes the level code based on the current square
; the party is on.
;
; There are some special values that affect function execution:
;   A sqN value of 7Fh executes the function regardless of the current sq_north value
;   A sqN value of FFh executes the function regardless of the current sq_north value iff
;     the vm_execute function is called as the result of a spell being cast. (spellFlag != 0)
;   A sqE value of FFh executes the function regardless of the current sq_east value

vm_execute proc far

	dataP= dword ptr -0Ch
	opcode=	word ptr -8
	functionCount= word	ptr -6
	sqN= word ptr -4
	sqE=	word ptr -2
	squareListP=	dword ptr  6
	spellFlag= word	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation

	push	word ptr [bp+squareListP+2]
	push	word ptr [bp+squareListP]
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+squareListP], ax
	mov	word ptr [bp+squareListP+2],	dx

	lfs	bx, [bp+squareListP]
	inc	word ptr [bp+squareListP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+functionCount],	ax
	mov	gs:mapRval, 0

l_loop:
	mov	ax, [bp+functionCount]
	dec	[bp+functionCount]
	or	ax, ax
	jz	l_returnRval

	lfs	bx, [bp+squareListP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+sqN], ax

	; Remove the high bit from the sqN value if a spell is cast. This is used
	; to convert values of FFh to 7Fh to pass the check at l_compareNorthCoordinate
	;
	cmp	[bp+spellFlag],	0
	jz	short l_compareNorthCoordinate
	xor	byte ptr [bp+sqN], 80h

l_compareNorthCoordinate:
	mov	al, fs:[bx+1]
	sub	ah, ah
	mov	[bp+sqE], ax

	cmp	[bp+sqN], 7Fh 			; A sqN value of 7Fh always succeeds
	jz	short l_compareEastCoordinate	
	mov	ax, [bp+sqN]
	cmp	sq_north, ax
	jnz	l_next

l_compareEastCoordinate:
	cmp	[bp+sqE], 0FFh			; A sqE value of FFh always succeeds
	jz	short l_getCodeAddress
	mov	ax, [bp+sqE]
	cmp	sq_east, ax
	jnz	l_next

l_getCodeAddress:
	mov	ax, word ptr [bp+squareListP]
	mov	dx, word ptr [bp+squareListP+2]
	add	ax, 2
	push	dx
	push	ax
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx

l_getOpcode:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+opcode], ax
	cmp	ax, 0FFh
	jnz	short l_verifyOpcode
	mov	gs:breakAfterFunc, 0
	jmp	short l_checkReturn

l_verifyOpcode:
	mov	ax, [bp+opcode]
	and	ax, 80h
	mov	gs:breakAfterFunc, ax
	and	[bp+opcode], 7Fh
	cmp	[bp+opcode], 46h
	jbe	short l_executeOpcode
	mov	ax, offset s_badOpcode
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	short l_return

l_executeOpcode:
	mov	bx, [bp+opcode]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr vm_functionList[bx]
	mov	dx, word ptr (vm_functionList+2)[bx]
	mov	word ptr gs:g_currentVmFunction, ax
	mov	word ptr gs:g_currentVmFunction+2, dx
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	gs:g_currentVmFunction
	add	sp, 4
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx

l_checkReturn:
	cmp	gs:breakAfterFunc, 0
	jnz	l_getOpcode

	cmp	buildingRvalMaybe, 0
	jz	short l_next
	mov	ax, gs:mapRval
	jmp	short l_return

l_next:
	add	word ptr [bp+squareListP], 4
	jmp	l_loop

l_returnRval:
	mov	ax, gs:mapRval
	jmp	short $+2

l_return:
	mov	sp, bp
	pop	bp
	retf
vm_execute endp

; Attributes: bp-based frame

mfunc_notImplemented proc far

	dataP= dword ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, offset s_notImplemented
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	mov	sp, bp
	pop	bp
	retf
mfunc_notImplemented endp


seg007 ends

; Segment type:	Pure code
seg008 segment byte public 'CODE' use16
	assume cs:seg008
;org 0Ah
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Entry	point for a battle
; Attributes: bp-based frame

bat_init proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	al, gs:g_currentSongPlusOne
	mov	gs:bat_curSong,	al
	mov	al, gs:g_currentSong
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, gs:g_currentSinger
	mov	[bp+var_6], ax
	call	endNoncombatSong
	push	cs
	call	near ptr bat_getOpponents
	mov	[bp+var_8], 0
	sub	al, al
	mov	gs:partyFrozenFlag, al
	mov	gs:runAwayFlag,	al
loc_1B13D:
	push	cs
	call	near ptr bat_sortMonGroupByDist
	push	cs
	call	near ptr bat_setBigpic
	push	[bp+var_8]
	inc	[bp+var_8]
	push	cs
	call	near ptr bat_printOpponents
	add	sp, 2
	cmp	gs:partyFrozenFlag, 0
	jnz	short loc_1B18C
	push	cs
	call	near ptr bat_getPartyOptions
	cmp	gs:runAwayFlag,	0
	jz	short loc_1B18C
partyRan:
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	sub	ax, ax
	jmp	loc_1B291
loc_1B18C:
	mov	gs:txt_numLines, 0Bh
	call	bat_doCombatRound
	call	bat_partyDisbelieves
	cmp	gs:monDisbelieveFlag, 0
	jnz	short loc_1B1AF
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1B1AF
	call	bat_monDisbelieve
loc_1B1AF:
	call	bat_doPoisonEffect
	call	doEquipmentEffect
	mov	al, gs:songRegenHP
	sub	ah, ah
	push	ax
	call	bat_doHPRegen
	add	sp, 2
	mov	al, gs:monDisbelieveFlag
	sub	ah, ah
	push	ax
	call	bat_updatePartyAndMonG
	add	sp, 2
	push	cs
	call	near ptr bat_endCombatSong
	mov	byte ptr g_printPartyFlag,	0
	call	party_getLastSlot
	cmp	ax, 7
	jle	short loc_1B215
partyDied:
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	mov	ax, 1
	jmp	short loc_1B291
loc_1B215:
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1B227
	call	_return_zero
	or	ax, ax
	jz	short loc_1B28E
loc_1B227:
	cmp	g_partyAttackFlag, 0
	jz	short partyWon
	mov	ax, offset aDoYouWishToCon
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_1B266
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	sub	ax, ax
	jmp	short loc_1B291
loc_1B266:
	jmp	short loc_1B28E
partyWon:
	call	bat_getReward
	mov	[bp+var_4], ax
	push	[bp+var_2]
	push	[bp+var_6]
	mov	al, gs:bat_curSong
	sub	ah, ah
	push	ax
	call	bat_end
	add	sp, 6
	mov	ax, [bp+var_4]
	jmp	short loc_1B291
loc_1B28E:
	jmp	loc_1B13D
loc_1B291:
	mov	sp, bp
	pop	bp
	retf
bat_init endp

; Attributes: bp-based frame

bat_doCombatRound proc far

	charNo=	word ptr -0Ch
	charPri= word ptr -0Ah
	monPri=	word ptr -8
	groupNo= word ptr -4
	monNo= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	cs
	call	near ptr bat_getAttackPriority
loc_1B2A4:
	lea	ax, [bp+charNo]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getHighCharPrio
	add	sp, 4
	mov	[bp+charPri], ax
	lea	ax, [bp+groupNo]
	push	ss
	push	ax
	lea	ax, [bp+monNo]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getHighMonPriority
	add	sp, 8
	mov	[bp+monPri], ax

	cmp	[bp+charPri], 0
	jnz	short loc_comparePri
	cmp	[bp+monPri], 0
	jz	loc_doCombatRoundExit

loc_comparePri:
	cmp	[bp+charPri], ax
	jl	short loc_1B2DE
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharAttack
	add	sp, 2
	jmp	short loc_1B2EB
loc_1B2DE:
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_doMonAttack
	add	sp, 4
loc_1B2EB:
	cmp	gs:g_currentCharPosition, 0
	jz	short loc_1B2FC
	call	txt_newLine
loc_1B2FC:
	call	txt_newLine
	mov	byte ptr g_printPartyFlag,	0
	jmp	loc_1B2A4

loc_doCombatRoundExit:
	mov	sp, bp
	pop	bp
	retf
bat_doCombatRound endp

; Attributes: bp-based frame

bat_doCharAttack proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+charNo]
	mov	gs:bat_charPriority[bx], 0
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1B343
	jmp	loc_1B3FA
loc_1B343:
	getCharP	[bp+charNo], bx
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1B356
	jmp	loc_1B3FA
loc_1B356:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1B373
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summon_executeAttack
	add	sp, 2
	jmp	loc_1B3FA
loc_1B373:
	mov	bx, [bp+charNo]
	mov	al, gs:charActionList[bx]
	sub	ah, ah
	jmp	short loc_1B3DA
loc_1B383:
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 4
	jmp	short loc_1B3FA
loc_1B39C:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharCastSpell
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3A8:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharUseItem
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3B4:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_hideInShadows
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3C0:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCharSong
	add	sp, 2
	jmp	short loc_1B3FA
loc_1B3CC:
	push	[bp+charNo]
	push	cs
	call	near ptr bat_charMeleeAttack
	add	sp, 2
loc_1B3D6:
	jmp	short loc_1B3FA
	jmp	short loc_1B3FA
loc_1B3DA:
	sub	ax, 1
	cmp	ax, 7
	ja	short loc_1B3D6
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1B3EA[bx]
off_1B3EA dw offset loc_1B383
	  dw offset loc_1B3FA
	  dw offset loc_1B383
	  dw offset loc_1B39C
	  dw offset loc_1B3A8
	  dw offset loc_1B3B4
	  dw offset loc_1B3C0
	  dw offset loc_1B3CC
loc_1B3FA:
	mov	sp, bp
	pop	bp
	retf
bat_doCharAttack endp

; Attributes: bp-based frame

bat_doMonAttack	proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	monNo= word ptr	 6
	groupNo= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	bx, [bp+monNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupNo]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	call	random
	and	ax, 6
	mov	[bp+var_6], ax
	getMonP	[bp+monNo], si
	add	si, [bp+var_6]
	mov	al, gs:monGroups.attackType._type[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, gs:monGroups.attackType.damage[si]
	mov	[bp+var_4], ax

	; Jump to Tarjan's attack to test
	;jmp	loc_1B4BD

	cmp	[bp+var_2], 80h
	jge	short loc_1B468
	push	[bp+var_2]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monCastSpell
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B468:
	mov	ax, [bp+var_2]
	sub	ax, 0F0h
	and 	ax, 7Fh
	mov	[bp+var_6], ax
	cmp	[bp+var_6], 0Ah
	jge	short loc_1B494
	push	[bp+var_4]
	push	[bp+var_6]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_doMonMelee
	add	sp, 8
	jmp	short loc_1B4D6
loc_1B494:
	mov	ax, [bp+var_6]
	jmp	short loc_1B4C5
loc_1B499:
	push	[bp+var_4]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monSummonMon
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B4AB:
	push	[bp+var_4]
	push	[bp+groupNo]
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monBreathAttack
	add	sp, 6
	jmp	short loc_1B4D6
loc_1B4BD:
	push	cs
	call	near ptr bat_doTarjanAttack
loc_1B4C1:
	jmp	short loc_1B4D6
	jmp	short loc_1B4D6
loc_1B4C5:
	cmp	ax, 0Ah
	jz	short loc_1B499
	cmp	ax, 10h
	jz	short loc_1B4AB
	cmp	ax, 13h
	jz	short loc_1B4BD
	jmp	short loc_1B4C1
loc_1B4D6:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_doMonAttack	endp

; Attributes: bp-based frame

bat_monCastSpell proc far

	arg_0= word ptr	 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+arg_4]
	mov	ax, [bp+arg_0]
	or	al, 80h
	push	ax
	call	doCastSpell
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
bat_monCastSpell endp

; Attributes: bp-based frame

bat_doTarjanAttack proc far

	counter =	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0

loc_tarLoopEntry:
	inc	[bp+counter]
	mov	ax, 15h
	push	ax
	mov	ax, 80h
	push	ax
	call	far ptr summon_execute
	add	sp, 4

	cmp	[bp+counter], 0Ah
	jl	loc_tarLoopEntry

	mov	sp, bp
	pop	bp
	retf
bat_doTarjanAttack endp

; Attributes: bp-based frame

bat_monSummonMon proc far

	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 104h
	call	someStackOperation
	push	si
	push	[bp+arg_0]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	ax, offset aSummonsHelpAnd
	push	ds
	push	ax
	push	dx
	push	[bp+var_104]
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	call	random
	sub	ah, ah
	cmp	ax, [bp+arg_4]
	jnb	short loc_1B590
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 1Fh
	jz	short loc_1B590
	test	gs:disbelieveFlags, disb_nohelp
	jz	short loc_1B5B0
loc_1B590:
	mov	ax, offset aNoneAppears___
	push	ds
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	jmp	loc_1B63E
loc_1B5B0:
	mov	ax, offset aAnotherJoinsTheFray
	push	ds
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	getMonP	[bp+arg_0], si
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bl, gs:monGroups.groupSize[si]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+arg_0]
	mov	dx, cx
	mov	cl, 6
	shl	ax, cl
	add	bx, ax
	mov	gs:monHpList[bx], dx
	getMonP	[bp+arg_0], bx
	mov	bl, gs:monGroups.groupSize[bx]
	and	bx, 1Fh
	shl	bx, 1
	mov	ax, [bp+arg_0]
	shl	ax, cl
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
loc_1B63E:
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monSummonMon endp

; Attributes: bp-based frame

bat_monBreathAttack proc far

	var_114= dword ptr -114h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= byte ptr -10Ch
	var_10A= byte ptr -10Ah
	target=	word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_4= byte ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 114h
	call	someStackOperation
	push	di
	push	si
	push	[bp+arg_0]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	[bp+target], ax
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_114], ax
	mov	word ptr [bp+var_114+2], ss
	mov	[bp+var_110], 0
	jmp	short loc_1B69D
loc_1B699:
	inc	[bp+var_110]
loc_1B69D:
	cmp	[bp+var_110], 7
	jge	short loc_1B6B5
	mov	bx, [bp+var_110]
	mov	al, byte ptr breathAttack.effectStrIndex[bx]
	lfs	si, [bp+var_114]
	mov	fs:[bx+si], al
	jmp	short loc_1B699
loc_1B6B5:
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.breathFlag[bx]
	mov	[bp+var_10C], al
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	mov	ax, offset aFirBreathEs
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	lfs	bx, dword ptr [bp+var_104]
	inc	word ptr [bp+var_104]
	mov	byte ptr fs:[bx], 0

	mov	al, [bp+arg_4]
	mov	[bp+var_10A], al
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	getMonP	[bp+arg_0], bx
	mov	al, gs:monGroups.breathRange[bx]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+var_10E]
	mov	di, sp
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	push	[bp+arg_0]
	call	bat_doBreathAttack
	add	sp, 0Ch
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bat_monBreathAttack endp

; Attributes: bp-based frame

bat_doMonMelee proc far

	var_122= byte ptr -122h
	var_120= word ptr -120h
	var_11E= word ptr -11Eh
	var_11C= word ptr -11Ch
	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	var_116= word ptr -116h
	var_106= dword ptr -106h
	var_102= word ptr -102h
	var_100= word ptr -100h
	monNo= word ptr	 6
	arg_2= word ptr  8
	arg_4= word ptr  0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 122h
	call	someStackOperation
	push	si
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	getMonP	[bp+monNo], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	lea	ax, [bp+var_100]
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], ss
	getMonP	[bp+monNo], si
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short loc_1B792
	jmp	loc_1B8E8
loc_1B792:
	mov	al, gs:monGroups.packedGenAc[si]
	and	al, 0C0h
	cmp	al, 0C0h 
	jnz	short loc_1B7A5
	mov	[bp+var_11A], 0
	jmp	short loc_1B818
loc_1B7A5:
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	and	al, 1Fh
	cmp	al, 2
	jnb	short loc_1B7F5
	mov	[bp+var_11A], 0
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 'A'
	mov	al, byte ptr [bp+var_116]
	cbw
	push	ax
	push	cs
	call	near ptr str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short loc_1B7E7
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 'n'
loc_1B7E7:
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], ' '
	jmp	short loc_1B818
loc_1B7F5:
	mov	[bp+var_11A], 1
	mov	ax, offset s_the
	push	ds
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
loc_1B818:
	push	[bp+var_11A]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	push	[bp+var_11A]
	push	dx
	push	ax
	mov	ax, offset aAdvanceS
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.distance[bx]
	mov	[bp+var_122], al
	sub	ah, ah
	mov	si, ax
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_11E], ax
	mov	ax, si
	and	ax, 0Fh
	mov	[bp+var_102], ax
	mov	ax, [bp+var_11E]
	cmp	[bp+var_102], ax
	jle	short loc_1B893
	mov	ax, [bp+var_102]
	sub	ax, [bp+var_11E]
	jmp	short loc_1B896
loc_1B893:
	mov	ax, 1
loc_1B896:
	mov	[bp+var_120], ax
	mov	al, byte ptr [bp+var_120]
	mov	cl, [bp+var_122]
	and	cl, 0F0h
	add	al, cl
	mov	cx, ax
	getMonP	[bp+monNo], bx
	mov	gs:monGroups.distance[bx], cl
	mov	[bp+var_118], 0
	jmp	short loc_1B8C2
loc_1B8BE:
	inc	[bp+var_118]
loc_1B8C2:
	cmp	[bp+var_118], 20h 
	jge	short loc_1B8E5
	mov	bx, [bp+monNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+var_118]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	jmp	short loc_1B8BE
loc_1B8E5:
	jmp	loc_1BA3B
loc_1B8E8:
	push	[bp+monNo]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getMonAttackerName
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	call	random
	and	ax, 1
	mov	cx, ax
	getMonP	[bp+monNo], bx
	mov	al, gs:monGroups.flags[bx]
	sub	ah, ah
	and	ax, mon_attackStr
	shl	ax, 1
	add	ax, cx
	mov	[bp+var_11C], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (monMeleeAttString+2)[bx]
	push	word ptr monMeleeAttString[bx]
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], ' '
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	gs:bat_curTarget, al
	sub	ah, ah
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getAttackerName
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx

	; Push the special attack value
	push	[bp+arg_4]

	push	[bp+arg_6]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+monNo]
	push	cs
	call	near ptr bat_monHitChar
	add	sp, 8
	or	ax, ax
	jnz	short loc_1B9C4
	mov	ax, offset aButMisses
	push	ds
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	jmp	loc_1BA3B
loc_1B9C4:
	sub	ax, ax
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_printHitDamage
	add	sp, 6
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr bat_doHPDamage
	add	sp, 2
	or	ax, ax
	jz	short loc_1BA2F
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	push	cs
	call	near ptr bat_getKillString
	add	sp, 4
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+var_106]
	call	printCharPronoun
	add	sp, 0Ah
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
	jmp	loc_1BA3B
loc_1BA2F:
	mov	ax, offset s_periodNlNl
	push	ds
	push	ax
	push	word ptr [bp+var_106+2]
	push	word ptr [bp+var_106]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_106], ax
	mov	word ptr [bp+var_106+2], dx
loc_1BA3B:
	lfs	bx, [bp+var_106]
	inc	word ptr [bp+var_106]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	delayWithTable
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_doMonMelee endp

; Attributes: bp-based frame

bat_getMonAttackerName proc far

	var_10=	word ptr -10h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 41h
	mov	al, byte ptr [bp+var_10]
	cbw
	push	ax
	push	cs
	call	near ptr str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short loc_1BABD
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'n'
loc_1BABD:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
	sub	ax, ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getMonAttackerName endp

; Attributes: bp-based frame

bat_getRandomChar proc far

	var_4= word ptr	-4
	counter= word ptr -2
	_mask= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1BB0E
loc_1BB0B:
	inc	[bp+counter]
loc_1BB0E:
	cmp	[bp+counter], 7
	jge	short loc_1BB32
	call	random
	and	ax, [bp+_mask]
	mov	[bp+var_4], ax
	push	ax
	push	cs
	call	near ptr bat_charCanBeAttacked
	add	sp, 2
	or	ax, ax
	jz	short loc_1BB30
	mov	ax, [bp+var_4]
	jmp	short loc_1BB36
loc_1BB30:
	jmp	short loc_1BB0B
loc_1BB32:
	sub	ax, ax
	jmp	short $+2
loc_1BB36:
	mov	sp, bp
	pop	bp
	retf
bat_getRandomChar endp

; Attributes: bp-based frame

bat_monHitChar proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	monNo= word ptr	 6
	target=	word ptr  8
	field_17= word ptr  0Ah
	spAttack = word ptr 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	gs:specialAttackVal, 0
	mov	gs:damageAmount, 0
	mov	bx, [bp+target]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1BB70
	sub	ax, ax
	jmp	loc_1BC04
loc_1BB70:
	getCharP	bx, bx
	mov	al, gs:party.ac[bx]
	cbw
	mov	bx, [bp+monNo]
	mov	cl, gs:monSpellToHitPenalty[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	cmp	ax, 3Fh
	jle	short loc_1BB9E
	mov	[bp+var_2], 3Fh
loc_1BB9E:
	getMonP	bx, si
	mov	al, gs:monGroups.toHitHi[si]
	sub	ah, ah
	push	ax
	mov	al, gs:monGroups.toHitLo[si]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	[bp+var_4], cx
	mov	ax, [bp+var_2]
	cmp	cx, ax
	jge	short loc_1BBDC
	sub	ax, ax
	jmp	short loc_1BC04
loc_1BBDC:

	; Add monster special attack
	mov	ax, [bp+spAttack]
	mov	gs:specialAttackVal, ax

	push	[bp+field_17]
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	bx, [bp+monNo]
	mov	cl, gs:monAttackBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	gs:damageAmount, cx
	mov	ax, 1
	jmp	short $+2
loc_1BC04:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monHitChar endp

; Attributes: bp-based frame

bat_charCanBeAttacked proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 7
	jnz	short loc_1BC1D
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC1D:
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1BC35
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC35:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_illusion
	jnz	short loc_1BC55
	cmp	gs:monDisbelieveFlag, 0
	jnz	short loc_1BC55
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC55:
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1BC68
	sub	ax, ax
	jmp	short loc_1BC85
loc_1BC68:
	getCharP	bx, bx
	mov	al, gs:party.status[bx]
	and	al, 0Ch
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short $+2
loc_1BC85:
	mov	sp, bp
	pop	bp
	retf
bat_charCanBeAttacked endp

; Attributes: bp-based frame
bat_summon_executeAttack proc	far

	var_C= word ptr	-0Ch
	attDamage= word	ptr -0Ah
	var_8= word ptr	-8
	attType= word ptr -6
	var_4= dword ptr -4
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si

	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	cmp	fs:[bx+summonStat_t.class], class_illusion
	jnz	short loc_1BCBF
	cmp	gs:monDisbelieveFlag, 0
	jz	short loc_1BCBF
	jmp	loc_1BD50
loc_1BCBF:
	call	random
	and	ax, 6
	mov	[bp+var_8], ax
	mov	si, ax
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+si+summonStat_t.attacks._type]
	sub	ah, ah
	mov	[bp+attType], ax
	mov	al, fs:[bx+si+summonStat_t.attacks.damage]
	mov	[bp+attDamage],	ax
	cmp	[bp+attType], 80h
	jge	short loc_1BCF6
	push	ax
	push	[bp+attType]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonCastSpell
	add	sp, 6
	jmp	short loc_1BD50
loc_1BCF6:
	mov	ax, [bp+attType]
	sub	ax, 0F0h
	and	ax, 7Fh
	mov	[bp+var_C], ax
	cmp	[bp+var_C], 0Ah
	jge	short loc_1BD1F
	push	[bp+attDamage]
	push	[bp+var_C]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonMeleeAttack
	add	sp, 6
	jmp	short loc_1BD50
loc_1BD1F:
	mov	ax, [bp+var_C]
	jmp	short loc_1BD44
loc_1BD24:
	push	[bp+attDamage]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_summonBreathAttack
	add	sp, 4
	jmp	short loc_1BD50
loc_1BD33:
	push	[bp+attDamage]
	push	[bp+charNo]
	push	cs
	call	near ptr bat_doCombatSong
	add	sp, 4
loc_1BD40:
	jmp	short loc_1BD50
	jmp	short loc_1BD50
loc_1BD44:
	cmp	ax, 10h
	jz	short loc_1BD24
	cmp	ax, 11h
	jz	short loc_1BD33
	jmp	short loc_1BD40
loc_1BD50:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_summon_executeAttack endp

; Attributes: bp-based frame

bat_summonCastSpell proc far

	target=	word ptr -6
	charP= dword ptr -4
	charNo=	word ptr  6
	spellNo= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], 20h
	jz	short loc_1BD90
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	[bp+target], ax
	jmp	short loc_1BDB7
loc_1BD90:
	lfs	bx, [bp+charP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BDA7
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BDAA
loc_1BDA7:
	mov	ax, 80h
loc_1BDAA:
	mov	[bp+target], ax
	mov	ax, [bp+charNo]
	cmp	[bp+target], ax
	jnz	short loc_1BDB7
	jmp	short loc_1BDD7
loc_1BDB7:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	sub	ax, ax
	push	ax
	mov	ax, 1
	push	ax
	push	[bp+spellNo]
	push	[bp+charNo]
	call	doCastSpell
	add	sp, 8
loc_1BDD7:
	mov	sp, bp
	pop	bp
	retf
bat_summonCastSpell endp

; Attributes: bp-based frame

bat_summonMeleeAttack proc far

	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	cmp	[bp+arg_0], 4
	jl	short loc_1BDEE
	jmp	short loc_1BE3F
loc_1BDEE:
	getCharIndex	ax, [bp+arg_0]
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BE16
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BE19
loc_1BE16:
	mov	ax, 80h
loc_1BE19:
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_4]
	mov	gs:summonMeleeDamage, ax
	mov	ax, [bp+arg_2]
	mov	gs:summonMeleeType, ax
	push	[bp+var_6]
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 4
loc_1BE3F:
	mov	sp, bp
	pop	bp
	retf
bat_summonMeleeAttack endp

; Attributes: bp-based frame

bat_summonBreathAttack proc far

	var_104 = word ptr -118h
	var_102 = word ptr -116h
	var_100 = word ptr -114h
	argP= dword ptr	-14h
	counter= word ptr -10h
	argList= byte ptr -0Ch
	var_A= byte ptr	-0Ah
	var_8= byte ptr	-8
	charP= dword ptr -4
	charNo=	word ptr  6
	damage=	byte ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 118h
	call	someStackOperation
	push	di
	push	si

	; Get the breather's name
	push	[bp+charNo]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getAttackerName
	add	sp, 6
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	getCharIndex	ax, [bp+charNo]
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	lfs	bx, [bp+charP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short loc_1BE78
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	jmp	short loc_1BE7A
loc_1BE78:
	mov	al, 80h
loc_1BE7A:
	mov	gs:bat_curTarget, al
	lea	ax, [bp+argList]
	mov	word ptr [bp+argP], ax
	mov	word ptr [bp+argP+2], ss
	mov	[bp+counter], 0
	jmp	short loc_1BE95
loc_1BE92:
	inc	[bp+counter]
loc_1BE95:
	cmp	[bp+counter], 7
	jge	short loc_1BEAA
	mov	bx, [bp+counter]
	mov	al, byte ptr breathAttack.effectStrIndex[bx]
	lfs	si, [bp+argP]
	mov	fs:[bx+si], al
	jmp	short loc_1BE92
loc_1BEAA:
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.breathFlag]
	mov	[bp+var_A], al

	; Add the fire/breath string
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	push	[bp+var_102]
	push	[bp+var_104]
	mov	ax, offset aFirBreathEs
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx

	; NULL terminate the string
	lfs	bx, dword ptr [bp+var_104]
	inc	word ptr [bp+var_104]
	mov	byte ptr fs:[bx], 0

	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp,4
	
	mov	al, [bp+damage]
	mov	[bp+var_8], al

	lfs	bx, [bp+charP]

	mov	al, fs:[bx+summonStat_t.breathRange]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+argList]
	mov	di, sp
	push	ss
	pop	es
	movsw
	movsw
	movsw
	movsb
	push	[bp+charNo]
	call	bat_doBreathAttack
	add	sp, 0Ch
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bat_summonBreathAttack endp

; Attributes: bp-based frame

bat_doCharMeleeAttack proc far

	var_10C= dword ptr -10Ch
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr 6
	arg_2= word ptr 8

	func_enter
	_chkstk	10Ch

	push	si

	cmp	[bp+arg_2], 80h
	jge	short loc_1BF22

	getCharP	[bp+arg_2], si
	cmp	gs:party.class[si], class_monster
	jnz	short loc_1BF0D
	mov	gs:party.hostileFlag[si], 1

loc_1BF0D:
	getCharP	[bp+arg_2], bx
	test	gs:party.status[bx], stat_dead	or stat_stoned
	jz	short loc_1BF20
	jmp	loc_1C0F0

loc_1BF20:
	jmp	short loc_1BF3E

loc_1BF22:
	mov	ax, [bp+arg_2]
	and	ax, 3
	getMonIndex	cx, cx
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1BF3E
	jmp	loc_1C0F0

loc_1BF3E:
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_10C], ax
	mov	word ptr [bp+var_10C+2], dx
	lfs	bx, dword ptr [bp+var_10C]
	inc	word ptr [bp+var_10C]
	mov	byte ptr fs:[bx], ' '

	push_imm	1
	push	[bp+arg_0]

	std_call	sub_18077, 4

	or	ax, ax
	jz	short loc_1BF8B
	mov	[bp+var_6], 0
	jmp	short loc_1BFBF
loc_1BF8B:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1BFBA
	add	ax, offset party

	save_ptr_stack	seg seg027, ax, var_4
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+(character_t.spells+0Ah)]
	sub	ah, ah
	shl	ax, 1
	mov	[bp+var_6], ax
	jmp	short loc_1BFBF
loc_1BFBA:
	mov	[bp+var_6], 2
loc_1BFBF:
	call	random
	and	ax, 1
	add	[bp+var_6], ax
	mov	bx, [bp+var_6]
	shl	bx, 1
	shl	bx, 1
	push_ptr_stringList	monMeleeAttString, bx
	push_ptr_stack		var_10C
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_10C], ax
	mov	word ptr [bp+var_10C+2], dx
	lfs	bx, dword ptr [bp+var_10C]
	inc	word ptr [bp+var_10C]
	mov	byte ptr fs:[bx], ' '

	push	[bp+arg_2]
	push_ptr_stack	var_10C
	near_call	bat_getAttackerName, 6
	save_ptr_stack	dx,ax,var_10C

	push	[bp+arg_2]
	push	[bp+arg_0]
	near_call	bat_getCharDamage, 4
	mov	[bp+var_108], ax
	or	ax, ax
	jnz	short loc_1C04B

	push_ds_string	aButMisses
	push_ptr_stack	var_10C
	std_call	strcat, 8
	save_ptr_stack	dx,ax,var_10C

	jmp	short loc_1C0B3
loc_1C04B:
	push	[bp+var_108]
	push_ptr_stack	var_10C
	near_call	bat_printHitDamage, 6
	save_ptr_stack	dx,ax,var_10C

	push_var_stack	arg_2
	near_call	bat_doHPDamage, 2
	or	ax, ax
	jz	short loc_1C0A7

	push_ptr_stack	var_10C
	near_call	bat_getKillString,4
	save_ptr_stack	dx,ax,var_10C

	push_imm	1
	push_imm	3
	push_var_stack	arg_2
	push_reg	dx
	push	word ptr [bp+var_10C]
	std_call	printCharPronoun, 0Ah
	save_ptr_stack	dx,ax,var_10C
	jmp	short loc_1C0B3

loc_1C0A7:
	mov	ax, offset s_periodNlNl
	push	ds
	push	ax
	push	word ptr [bp+var_10C+2]
	push	word ptr [bp+var_10C]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_10C], ax
	mov	word ptr [bp+var_10C+2], dx

loc_1C0B3:
	lfs	bx, dword ptr [bp+var_10C]
	inc	word ptr [bp+var_10C]
	mov	byte ptr fs:[bx], 0
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	std_Call	printString, 4

	mov	bx, [bp+arg_0]
	mov	gs:byte_42280[bx], 0
	mov	byte ptr g_printPartyFlag,	0

	delayWithTable
loc_1C0F0:
	pop	si
	func_exit
	retf
bat_doCharMeleeAttack endp

; Attributes: bp-based frame

bat_getAttackerName proc far

	var_10=	word ptr -10h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	func_enter
	_chkstk	10h

	cmp	[bp+arg_4], 80h
	jge	short loc_1C12E
	getCharP	[bp+arg_4], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push_reg	dx
	push_reg	ax
	push_ptr_stack	arg_0
	call	strcat
	add	sp, 8
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx

	jmp	short loc_1C19A
loc_1C12E:
	and	[bp+arg_4], 3
	lfs	bx, dword ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'a'
	lea	ax, [bp+var_10]
	push_reg	ss
	push_reg	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push_reg	dx
	push_reg	ax
	std_call	unmaskString, 8
	mov	al, byte ptr [bp+var_10]
	cbw
	push_reg	ax
	near_call	str_startsWithVowel, 2
	or	ax, ax
	jz	short loc_1C174
	lfs	bx, dword ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'n'
loc_1C174:
	lfs	bx, dword ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
	sub	ax, ax
	push	ax
	push_ptr_stack	arg_0
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	std_call	str_pluralize, 0Ah
	save_ptr_stack	dx,ax,arg_0
loc_1C19A:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getAttackerName endp

; This function	returns	1 if the passed	string starts
; with a vowel.	This is	for proper use of a/an in
; strings.
; Attributes: bp-based frame

str_startsWithVowel proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	[bp+arg_0]
	call	toUpper
	add	sp, 2
	mov	[bp+arg_0], ax
	mov	[bp+var_2], 0
	jmp	short loc_1C1C9
loc_1C1C6:
	inc	[bp+var_2]
loc_1C1C9:
	cmp	[bp+var_2], 6
	jge	short loc_1C1E3
	mov	bx, [bp+var_2]
	mov	al, vowelList[bx]
	cbw
	cmp	ax, [bp+arg_0]
	jnz	short loc_1C1E1
	mov	ax, 1
	jmp	short loc_1C1E7
loc_1C1E1:
	jmp	short loc_1C1C6
loc_1C1E3:
	sub	ax, ax
	jmp	short $+2
loc_1C1E7:
	mov	sp, bp
	pop	bp
	retf
str_startsWithVowel endp

; Attributes: bp-based frame

bat_doCharCastSpell proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42276[bx]
	mov	gs:bat_curTarget, al
	mov	ax, 1
	push	ax
	push	ax
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	call	doCastSpell
	add	sp, 8
	mov	sp, bp
	pop	bp
	retf
bat_doCharCastSpell endp

; Attributes: bp-based frame

bat_doCharUseItem proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	push	ax
	mov	bx, [bp+charNo]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	mov	al, gs:byte_42276[bx]
	push	ax
	mov	al, gs:byte_42334[bx]
	push	ax
	push	bx
	call	item_doSpell
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_doCharUseItem endp

; Attributes: bp-based frame

bat_hideInShadows proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, offset aJumpsIntoTheShadows
	push	ds
	push	ax
	push	dx
	push	[bp+var_108]
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+arg_0]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_1C2DE
	call	random
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short loc_1C2F5
loc_1C2DE:
	mov	ax, offset aAndSucceeds
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	mov	bx, [bp+arg_0]
	inc	gs:byte_42280[bx]
	jmp	short loc_1C30B
loc_1C2F5:
	mov	ax, offset aButIsDiscovered
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	mov	bx, [bp+arg_0]
	mov	gs:byte_42280[bx], 0
loc_1C30B:
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+var_106]
	push	[bp+var_108]
	call	strcat
	add	sp, 8
	lea	ax, [bp+var_104]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
bat_hideInShadows endp

; Attributes: bp-based frame

bat_doCharSong proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_102= word ptr -102h
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	mov	[bp+var_2], 0
	getCharP	[bp+arg_0], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+arg_0]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1C384
	mov	[bp+var_2], 1
	jmp	short loc_1C3AA
loc_1C384:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.specAbil[bx],	0
	jz	short loc_1C3AA
	mov	[bp+var_2], 1
	getCharP	[bp+arg_0], bx
	dec	gs:party.specAbil[bx]
loc_1C3AA:
	cmp	[bp+var_2], 0
	jz	short loc_1C3F4
	mov	ax, offset aPlays___
	push	ds
	push	ax
	push	[bp+var_106]
	push	[bp+var_108]
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+arg_0]
	mov	al, gs:byte_42244[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr bat_doCombatSong
	add	sp, 4
	jmp	short loc_1C455
loc_1C3F4:
	mov	ax, offset aLost
	push	ds
	push	ax
	push	[bp+var_106]
	push	[bp+var_108]
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, 0
	push	ax
	mov	ax, 6
	push	ax
	push	[bp+arg_0]
	push	dx
	push	[bp+var_108]
	call	printCharPronoun
	add	sp, 0Ah
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	mov	ax, offset aVoice
	push	ds
	push	ax
	push	dx
	push	[bp+var_108]
	call	strcat
	add	sp, 8
	mov	[bp+var_108], ax
	mov	[bp+var_106], dx
	lea	ax, [bp+var_102]
	push	ss
	push	ax
	call	printString
	add	sp, 4
loc_1C455:
	mov	sp, bp
	pop	bp
	retf
bat_doCharSong endp

; Attributes: bp-based frame

bat_charMeleeAttack proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_nuts
	jz	short loc_1C480
	call	random
	test	al, 1
	jnz	short loc_1C494
loc_1C480:
	getCharIndex	ax, [bp+arg_0]
	mov	bx, ax
	cmp	gs:party.hostileFlag[bx], 0
	jz	short loc_1C4AD
loc_1C494:
	mov	ax, 7
	push	ax
	push	cs
	call	near ptr bat_getRandomChar
	add	sp, 2
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	jmp	short loc_1C4C8
loc_1C4AD:
	cmp	byte ptr gs:monGroups._name, 0
	jnz	short loc_1C4BB
	jmp	short loc_1C4D2
loc_1C4BB:
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], 80h
loc_1C4C8:
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_doCharMeleeAttack
	add	sp, 2
loc_1C4D2:
	mov	sp, bp
	pop	bp
	retf
bat_charMeleeAttack endp

; This function	returns	the highest priority in	the
; party. The character number with the highest
; priority is returned via membuf.
; Attributes: bp-based frame

bat_getHighCharPrio proc far

	char= word ptr -6
	charNo=	word ptr -4
	highestPriority= word ptr -2
	membuf=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	[bp+highestPriority], 0
	mov	[bp+char], 0
	mov	[bp+charNo], 0
	jmp	short loc_1C4F6
loc_1C4F3:
	inc	[bp+charNo]
loc_1C4F6:
	cmp	[bp+charNo], 7
	jge	short loc_1C51B
	mov	bx, [bp+charNo]
	mov	al, gs:bat_charPriority[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+highestPriority], si
	jnb	short loc_1C519
	mov	[bp+highestPriority], si
	mov	ax, bx
	mov	[bp+char], ax
loc_1C519:
	jmp	short loc_1C4F3
loc_1C51B:
	lfs	bx, [bp+membuf]
	mov	ax, [bp+char]
	mov	fs:[bx], ax
	mov	ax, [bp+highestPriority]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getHighCharPrio endp

; This function	returns	the highest attack priority
; in the monster groups. The monster group and
; monster index	is returned in rGroup and rMon
; respectively.
; Attributes: bp-based frame

bat_getHighMonPriority proc far

	highMon= word ptr -0Ch
	monNo= word ptr	-0Ah
	groupNo= word ptr -8
	highPri= word ptr -6
	highGroup= word	ptr -4
	var_2= word ptr	-2
	rGroup=	dword ptr  6
	rMon= dword ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	si
	sub	ax, ax
	mov	[bp+highMon], ax
	mov	[bp+highGroup],	ax
	mov	[bp+highPri], ax
	mov	[bp+groupNo], ax
	jmp	short loc_1C54D
loc_1C54A:
	inc	[bp+groupNo]
loc_1C54D:
	cmp	[bp+groupNo], 4
	jge	short loc_1C5B1
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_1C5AF
	mov	[bp+monNo], 0
	jmp	short loc_1C57A
loc_1C577:
	inc	[bp+monNo]
loc_1C57A:
	mov	ax, [bp+var_2]
	cmp	[bp+monNo], ax
	jge	short loc_1C5AF
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	mov	si, gs:bat_monPriorityList[bx]
	cmp	[bp+highPri], si
	jge	short loc_1C5AD
	mov	[bp+highPri], si
	mov	ax, [bp+groupNo]
	mov	[bp+highGroup],	ax
	mov	ax, [bp+monNo]
	mov	[bp+highMon], ax
loc_1C5AD:
	jmp	short loc_1C577
loc_1C5AF:
	jmp	short loc_1C54A
loc_1C5B1:
	lfs	bx, [bp+rGroup]
	mov	ax, [bp+highGroup]
	mov	fs:[bx], ax
	lfs	bx, [bp+rMon]
	mov	ax, [bp+highMon]
	mov	fs:[bx], ax
	mov	ax, [bp+highPri]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getHighMonPriority endp

; Attributes: bp-based frame

bat_getAttackPriority proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	cmp	gs:partyFrozenFlag, 0
	jz	short loc_1C611
	mov	[bp+var_C], 0
	jmp	short loc_1C5EF
loc_1C5EC:
	inc	[bp+var_C]
loc_1C5EF:
	cmp	[bp+var_C], 7
	jge	short loc_1C604
	mov	bx, [bp+var_C]
	mov	gs:bat_charPriority[bx], 0
	jmp	short loc_1C5EC
loc_1C604:
	mov	gs:partyFrozenFlag, 0
	jmp	loc_1C707
loc_1C611:
	mov	[bp+var_C], 0
	jmp	short loc_1C61B
loc_1C618:
	inc	[bp+var_C]
loc_1C61B:
	cmp	[bp+var_C], 7
	jl	short loc_1C624
	jmp	loc_1C707
loc_1C624:
	getCharP	[bp+var_C], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1C63B
	jmp	loc_1C707
loc_1C63B:
	getCharP	[bp+var_C], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1C67B
	add	ax, offset party
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+18h]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+17h]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+var_C]
	mov	fs:bat_charPriority[bx], al
	jmp	loc_1C704
loc_1C67B:
	mov	bx, [bp+var_C]
	cmp	gs:charActionList[bx], 6
	jnz	short loc_1C696
	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short loc_1C704
loc_1C696:
	getCharP	[bp+var_C], si
	mov	bl, gs:party.class[si]
	sub	bh, bh
	mov	al, byte_475AE[bx]
	mov	bx, [bp+var_C]
	mov	gs:bat_charPriority[bx], al
	call	rnd_2d16
	mov	cx, gs:party.level[si]
	shr	cx, 1
	mov	dl, gs:party.dexterity[si]
	shl	dl, 1
	add	cl, dl
	add	cl, al
	mov	bx, [bp+var_C]
	add	gs:bat_charPriority[bx], cl
	mov	bx, [bp+var_C]
	cmp	gs:bat_charPriority[bx], 0FFh
	jbe	short loc_1C6F3
	mov	gs:bat_charPriority[bx], 0FFh
	jmp	short loc_1C704
loc_1C6F3:
	mov	bx, [bp+var_C]
	cmp	gs:bat_charPriority[bx], 0
	jnz	short loc_1C704
	mov	gs:bat_charPriority[bx], 1
loc_1C704:
	jmp	loc_1C618
loc_1C707:
	mov	[bp+var_C], 0
	jmp	short loc_1C711
loc_1C70E:
	inc	[bp+var_C]
loc_1C711:
	cmp	[bp+var_C], 4
	jge	short loc_1C780
	getMonP	[bp+var_C], si
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_6], ax
	or	ax, ax
	jz	short loc_1C77E
	mov	al, gs:monGroups.oppPriorityLo[si]
	sub	ah, ah
	mov	[bp+var_E], ax
	mov	al, gs:monGroups.oppPriorityHi[si]
	mov	[bp+var_8], ax
	mov	[bp+var_A], 0
	jmp	short loc_1C750
loc_1C74D:
	inc	[bp+var_A]
loc_1C750:
	mov	ax, [bp+var_6]
	cmp	[bp+var_A], ax
	jge	short loc_1C77E
	push	[bp+var_8]
	push	[bp+var_E]
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	bx, [bp+var_C]
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+var_A]
	shl	cx, 1
	add	bx, cx
	mov	gs:bat_monPriorityList[bx], ax
	jmp	short loc_1C74D
loc_1C77E:
	jmp	short loc_1C70E
loc_1C780:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getAttackPriority endp

; Attributes: bp-based frame

bat_getOpponents proc far

	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	var_A= dword ptr -0Ah
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	push	cs
	call	near ptr bat_resetData
	mov	gs:byte_422A4, 1
	cmp	gs:bat_curSong,	0
	jz	short loc_1C7D3
	mov	al, gs:g_currentSong
	sub	ah, ah
	push	ax
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	push	gs:party.level[bx]
	push	cs
	call	near ptr bat_convertSongToCombat
	add	sp, 4
loc_1C7D3:
	cmp	g_partyAttackFlag, 0
	jz	short loc_1C7EC
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
	jmp	loc_1C992
loc_1C7EC:
	cmp	gs:g_nonRandomBattleFlag, 0
	jnz	short loc_1C81D
loc_1C7F8:
	call	random
	and	al, 3
	mov	g_monsterGroupCount, al
	cmp	al, levelNoMaybe
	jbe	short loc_1C814
	jmp	short loc_1C7F8
loc_1C814:
	inc	g_monsterGroupCount
loc_1C81D:
	mov	[bp+var_4], 0
	jmp	short loc_1C827
loc_1C824:
	inc	[bp+var_4]
loc_1C827:
	mov	al, g_monsterGroupCount
	sub	ah, ah
	cmp	ax, [bp+var_4]
	ja	short loc_1C839
	jmp	loc_1C978
loc_1C839:
	cmp	gs:g_nonRandomBattleFlag, ah
	jz	short loc_1C889
	getMonP	[bp+var_4], si
	mov	al, byte ptr gs:monGroups._name[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	mov	al, gs:monGroups.groupSize[si]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_C], ax
	lfs	bx, [bp+var_A]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	jmp	short loc_1C8EB
loc_1C889:
	mov	ax, 23
	push	ax
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	[bp+var_2], ax
	getMonIndex	ax, [bp+var_2]
	add	ax, offset monsterBuf
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg023
	lfs	bx, [bp+var_A]
	test	fs:[bx+mon_t.flags], mon_noSummon
	jnz	short loc_1C889
	cmp	byte ptr fs:[bx], 0
	jz	short loc_1C889
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 0E0h
	mov	[bp+var_E], ax
	test	fs:[bx+mon_t.groupSize], 1Fh
	jz	short loc_1C8E5
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	and	ax, 1Fh
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1C8E8
loc_1C8E5:
	mov	ax, 1
loc_1C8E8:
	mov	[bp+var_C], ax
loc_1C8EB:
	getMonP	[bp+var_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+var_A+2]
	push	word ptr [bp+var_A]
	push	cs
	call	near ptr mon_copyBuffer
	add	sp, 8
	mov	al, byte ptr [bp+var_E]
	or	al, byte ptr [bp+var_C]
	mov	cx, ax
	getMonP	[bp+var_4], bx
	mov	gs:monGroups.groupSize[bx], cl
	mov	[bp+var_6], 0
	jmp	short loc_1C92C
loc_1C929:
	inc	[bp+var_6]
loc_1C92C:
	mov	ax, [bp+var_C]
	cmp	[bp+var_6], ax
	jge	short loc_1C975
	getMonP	[bp+var_4], si
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+var_4]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+var_6]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	jmp	short loc_1C929
loc_1C975:
	jmp	loc_1C824
loc_1C978:
	cmp	g_monsterGroupCount, 4
	jnb	short loc_1C992
	mov	al, g_monsterGroupCount
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr bat_zeroMonGroups
	add	sp, 2
loc_1C992:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getOpponents endp

; Attributes: bp-based frame

bat_zeroMonGroups proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	[bp+var_2], ax
	jmp	short loc_1C9AD
loc_1C9AA:
	inc	[bp+var_2]
loc_1C9AD:
	cmp	[bp+var_2], 3
	jge	short loc_1C9D5
	mov	ax, monStruSize
	push	ax
	sub	ax, ax
	push	ax
	getMonP	[bp+var_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	jmp	short loc_1C9AA
loc_1C9D5:
	mov	sp, bp
	pop	bp
	retf
bat_zeroMonGroups endp

; Attributes: bp-based frame

bat_sortMonGroupByDist proc far

	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
loc_1C9E5:
	mov	[bp+var_4], 0
	mov	[bp+var_2], 3
	jmp	short loc_1C9F4
loc_1C9F1:
	dec	[bp+var_2]
loc_1C9F4:
	cmp	[bp+var_2], 0
	jle	short loc_1CA37
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1CA35
	mov	al, gs:monGroups.distance[si]-30h
	and	al, 0Fh
	mov	cl, gs:monGroups.distance[si]
	and	cl, 0Fh
	cmp	al, cl
	jbe	short loc_1CA35
	mov	[bp+var_4], 1
	mov	ax, [bp+var_2]
	dec	ax
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr bat_swapMonGroups
	add	sp, 4
loc_1CA35:
	jmp	short loc_1C9F1
loc_1CA37:
	cmp	[bp+var_4], 0
	jnz	short loc_1C9E5
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_sortMonGroupByDist endp

; Attributes: bp-based frame

bat_swapMonGroups proc far

	var_40=	word ptr -40h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 40h
	call	someStackOperation
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_0]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	bx, [bp+arg_0]
	shl	bx, cl
	lea	ax, monHpList[bx]
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, 64
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	getMonP	[bp+arg_0], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	ax, monStruSize
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	getMonP	[bp+arg_2], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
bat_swapMonGroups endp

; Attributes: bp-based frame
bat_printOpponents proc	far

	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	cmp	gs:byte_4228B, 0
	jnz	short loc_1CB98
	mov	gs:byte_4228B, 0
	cmp	[bp+arg_0], 0
	jnz	short loc_1CB89
	call	bat_isAMonGroupActive
	or	ax, ax
	jz	short loc_1CB63
	mov	ax, 6
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	jmp	short loc_1CB65
loc_1CB63:
	sub	ax, ax
loc_1CB65:
	mov	[bp+var_C], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (battleCryString+2)[bx]
	push	word ptr battleCryString[bx]
	call	printStringWClear
	add	sp, 4
	cmp	[bp+var_C], 0
	jnz	short loc_1CB87
	jmp	loc_1CC83
loc_1CB87:
	jmp	short loc_1CB96
loc_1CB89:
	mov	ax, offset aYouStillFace
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_1CB96:
	jmp	short loc_1CBA2
loc_1CB98:
	mov	gs:byte_4228B, 0
loc_1CBA2:
	lea	ax, [bp+var_10C]
	mov	[bp+var_8], ax
	mov	[bp+var_6], ss
	test	gs:monGroups.groupSize,	1Fh
	jnz	short loc_1CBCA
	mov	ax, offset aHostilePartyMembers
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1CC83
	jmp	short loc_1CBE0
loc_1CBCA:
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
loc_1CBE0:
	mov	[bp+var_A], 1
	jmp	short loc_1CBEA
loc_1CBE7:
	inc	[bp+var_A]
loc_1CBEA:
	cmp	[bp+var_A], 4
	jle	short loc_1CBF3
	jmp	loc_1CC83
loc_1CBF3:
	getMonP	[bp+var_A], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short loc_1CC0D
	cmp	[bp+var_A], 4
	jnz	short loc_1CC30
loc_1CC0D:
	mov	ax, offset a__1
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	strcat
	add	sp, 8
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1CC83
loc_1CC30:
	getMonP	[bp+var_A], bx
	test	gs:stru_42372.groupSize[bx], 1Fh
	jz	short loc_1CC4A
	cmp	[bp+var_A], 2
	jnz	short loc_1CC4F
loc_1CC4A:
	mov	ax, offset aAnd_1
	jmp	short loc_1CC52
loc_1CC4F:
	mov	ax, offset asc_473AE
loc_1CC52:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	push	[bp+var_6]
	push	[bp+var_8]
	call	strcat
	add	sp, 8
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	push	[bp+var_A]
	push	dx
	push	ax
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	jmp	loc_1CBE7
loc_1CC83:
	mov	sp, bp
	pop	bp
	retf
bat_printOpponents endp

; This function	prints a group that the	party faces
; in combat. The format	is:
; XX Name (YY')
; Where:
;   XX - Number	of monsters in the group
;   YY - Distance to the group
; Attributes: bp-based frame

bat_printOpponentGroup proc far

	var_16=	word ptr -16h
	var_14=	word ptr -14h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 16h
	call	someStackOperation
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_16], ax
	mov	ax, 2
	push	ax
	mov	ax, [bp+var_16]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_16]
	dec	ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h ;	' '
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 28h
	mov	ax, 2
	push	ax
	getMonP	[bp+arg_4], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	sub	dx, dx
	mov	cx, ax
	mov	bx, dx
	shl	ax, 1
	rcl	dx, 1
	shl	ax, 1
	rcl	dx, 1
	add	ax, cx
	adc	dx, bx
	shl	ax, 1
	rcl	dx, 1
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 27h
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 29h
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_printOpponentGroup endp

; Attributes: bp-based frame

bat_setBigpic proc far

	var_26=	word ptr -26h
	var_24=	dword ptr -24h
	var_20=	word ptr -20h
	var_10=	word ptr -10h

	push	bp
	mov	bp, sp
	mov	ax, 26h	
	call	someStackOperation
	mov	al, gs:monGroups.groupSize
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+var_26], ax
	or	ax, ax
	jnz	short loc_1CDC3
	mov	ax, 21h	
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aParty
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	jmp	short loc_1CE1C
loc_1CDC3:
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	mov	ax, offset monGroups
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, [bp+var_26]
	dec	ax
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2],	dx
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	al, gs:monGroups.picIndex
	sub	ah, ah
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
loc_1CE1C:
	mov	sp, bp
	pop	bp
	retf
bat_setBigpic endp

; Attributes: bp-based frame

mon_copyBuffer proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, monStruSize
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_6]
	push	[bp+arg_4]
	call	memcpy
	add	sp, 0Ah
	mov	sp, bp
	pop	bp
	retf
mon_copyBuffer endp

; Attributes: bp-based frame

bat_convertSongToCombat	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_2]
	jmp	short loc_1CEC0
loc_1CE55:
	mov	gs:songCanRun, 1
	or	gs:disbelieveFlags, disb_nohelp
	jmp	short loc_1CEDA
loc_1CE6B:
	cmp	[bp+arg_0], 60
	jle	short loc_1CE75
	mov	al, 0Fh
	jmp	short loc_1CE7C
loc_1CE75:
	mov	ax, [bp+arg_0]
	sar	ax, 1
	sar	ax, 1
loc_1CE7C:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short loc_1CE8D
	inc	gs:songACBonus
loc_1CE8D:
	jmp	short loc_1CEDA
loc_1CE8F:
	mov	ax, [bp+arg_0]
	cmp	ax, 0Fh
	jle	short loc_1CE9E
	mov	ax, 0Fh
loc_1CE9E:
	mov	gs:songRegenHP,	al
	jmp	short loc_1CEDA
loc_1CEA4:
	mov	gs:songExtraAttack, 1
	jmp	short loc_1CEDA
loc_1CEB0:
	mov	gs:songHalfDamage, 1
	jmp	short loc_1CEDA
loc_1CEBC:
	jmp	short loc_1CEDA
	jmp	short loc_1CEDA
loc_1CEC0:
	or	ax, ax
	jz	short loc_1CE55
	cmp	ax, song_sanctuary
	jz	short loc_1CE6B
	cmp	ax, song_bringaround
	jz	short loc_1CE8F
	cmp	ax, song_duotime
	jz	short loc_1CEA4
	cmp	ax, song_shield
	jz	short loc_1CEB0
	jmp	short loc_1CEBC
loc_1CEDA:
	mov	sp, bp
	pop	bp
	retf
bat_convertSongToCombat	endp

; Attributes: bp-based frame

bat_doCombatSong proc far

	l_songLevel= word ptr	-2
	partySlotNumber= word ptr	 6
	songNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	call	song_playSong
	add	sp, 4

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster
	jb	short l_getCharSongLevel		; If singer is not a character
	mov	[bp+l_songLevel], 1			; set song level to 1
	jmp	short loc_1CF2C

l_getCharSongLevel:
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax	; Song level is
	mov	ax, gs:party.level[bx]			; character level
	sub	ax, 15
	sbb	cx, cx
	and	ax, cx
	add	ax, 15			; with a max value of 15
	mov	[bp+l_songLevel], ax
loc_1CF2C:
	mov	ax, [bp+songNumber]
	jmp	l_songSwitch

l_sirrobin:
	mov	gs:songCanRun, 1
	or	gs:disbelieveFlags, disb_nohelp
	jmp	l_return

l_sanctuary:
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	cmp	gs:party.level[bx], 60
	jnb	short loc_1CF7E
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short loc_1CF80
loc_1CF7E:
	mov	al, 0Fh
loc_1CF80:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short loc_1CF91
	inc	gs:songACBonus
loc_1CF91:
	jmp	short l_return

l_bringaround:
	mov	al, byte ptr [bp+l_songLevel]
	mov	gs:songRegenHP,	al
	or	al, al
	jnz	short loc_1CFA7
	inc	gs:songRegenHP
loc_1CFA7:
	jmp	short l_return

l_duotime:
	mov	gs:songExtraAttack, 1
	jmp	short l_return

l_overture:
	mov	gs:bat_curTarget, 80h
	mov	ax, 237
	push	ax
	push	[bp+partySlotNumber]
	call	_batchSpellCast
	add	sp, 4
	jmp	short l_return

l_shield:
	mov	gs:songHalfDamage, 1
	mov	al, byte ptr [bp+l_songLevel]
	mov	gs:partySpellAcBonus, al

l_songSwitch:
	or	ax, ax
	jz	l_sirrobin
	cmp	ax, song_sanctuary
	jz	l_sanctuary
	cmp	ax, song_bringaround
	jz	short l_bringaround
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_doCombatSong endp


; Attributes: bp-based frame

bat_endCombatSong proc far
	push	bp
	mov	bp, sp

	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	mov	gs:g_currentSongPlusOne, 0
	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	short l_songSwitch
l_sirrobin:
	and	gs:disbelieveFlags, 0FDh
	jmp	short l_endAndReturn
l_shield:
	mov	gs:songHalfDamage, 0
	mov	gs:partySpellAcBonus, 0
	jmp	short l_endAndReturn
l_sanctuary:
	mov	gs:songACBonus,	0
l_bringaround:
	mov	gs:songRegenHP,	0
	jmp	short l_endAndReturn
l_duotime:
	mov	gs:songExtraAttack, 0
	jmp	short l_endAndReturn
l_songSwitch:
	or	ax, ax
	jz	short l_sirrobin
	cmp	ax, song_sanctuary
	jz	short l_sanctuary
	cmp	ax, song_bringaround
	jz	short l_bringaround
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_shield
	jz	short l_shield
l_endAndReturn:
	call	song_endMusic
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_endCombatSong endp


; Attributes: bp-based frame

bat_resetData proc far

	counter= word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1D0B8
loc_1D0B5:
	inc	[bp+counter]
loc_1D0B8:
	cmp	[bp+counter], 4
	jge	short loc_1D130
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, monHpList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	mov	ax, 40h	
	push	ax
	sub	ax, ax
	push	ax
	mov	bx, [bp+counter]
	mov	cl, 6
	shl	bx, cl
	lea	ax, bat_monPriorityList[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:g_monFreezeAcPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_41E50[bx], al
	mov	bx, [bp+counter]
	mov	gs:monSpellToHitPenalty[bx], al
	mov	bx, [bp+counter]
	mov	gs:monAttackBonus[bx], al
	jmp	short loc_1D0B5
loc_1D130:
	mov	[bp+counter], 0
	jmp	short loc_1D13A
loc_1D137:
	inc	[bp+counter]
loc_1D13A:
	cmp	[bp+counter], 7
	jge	short loc_1D18D
	mov	bx, [bp+counter]
	mov	gs:charActionList[bx], 2
	sub	al, al
	mov	bx, [bp+counter]
	mov	gs:[bx+8], al
	mov	bx, [bp+counter]
	mov	gs:strengthBonus[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+counter]
	mov	gs:byte_42280[bx], al
	mov	bx, [bp+counter]
	mov	gs:bat_charPriority[bx], al
	jmp	short loc_1D137
loc_1D18D:
	sub	al, al
	mov	gs:byte_42440, al
	mov	gs:byte_41E70, al
	mov	gs:g_charFreezeAcPenalty, al
	mov	gs:partySpellAcBonus, al
	mov	gs:byte_42567, al
	mov	gs:monFrozenFlag, al
	mov	gs:byte_422A4, al
	mov	gs:byte_41E63, al
	mov	gs:disbelieveFlags, al
	mov	gs:monDisbelieveFlag, al
	mov	gs:antiMagicFlag, al
	mov	gs:partyFrozenFlag, al
	mov	gs:songHalfDamage, al
	mov	gs:songCanRun, al
	mov	gs:songExtraAttack, al
	mov	gs:byte_4229A, al
	mov	gs:songRegenHP,	al
	sub	ax, ax
	mov	gs:batRewardHi,	ax
	mov	gs:batRewardLo,	ax
	mov	sp, bp
	pop	bp
	retf
bat_resetData endp

; This function	returns	a random number	between	the
; low and the high
;
; Attributes: bp-based frame
randomBetweenXandY proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	_mask= word ptr	-2
	_low= word ptr	6
	_high= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+_high]
	sub	ax, [bp+_low]
	mov	[bp+var_4], ax
	or	ax, ax
	jg	short loc_1D246
	mov	ax, [bp+_low]
	jmp	short loc_1D26E
loc_1D246:
	push	[bp+var_4]
	push	cs
	call	near ptr getRndDiceMask
	add	sp, 2
	mov	[bp+_mask], ax
loc_1D253:
	call	random
	and	ax, [bp+_mask]
	mov	[bp+var_6], ax
	mov	ax, [bp+var_4]
	cmp	[bp+var_6], ax
	jg	short loc_1D253
	mov	ax, [bp+var_6]
	add	ax, [bp+_low]
	jmp	short $+2
loc_1D26E:
	mov	sp, bp
	pop	bp
	retf
randomBetweenXandY endp

; Attributes: bp-based frame

getRndDiceMask proc far

	var_2= word ptr	-2
	arg_1= byte ptr	 7

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+arg_1], 0
	mov	[bp+var_2], 0
	jmp	short loc_1D2D2
loc_1D2CF:
	inc	[bp+var_2]
loc_1D2D2:
	cmp	[bp+var_2], 8
	jge	short loc_1D2F1
	mov	bx, [bp+var_2]
	mov	al, diceMaskList[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+6],	si
	ja	short loc_1D2EF
	jmp	short loc_1D2FE
loc_1D2EF:
	jmp	short loc_1D2CF
loc_1D2F1:
	mov	ax, offset aBadDiceMaskRange
	push	ds
	push	ax
	call	printMessageAndExit
	add	sp, 4
loc_1D2FE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getRndDiceMask endp

; This function	unpacks	a single byte into the number
; of dice to roll and the sides	of the dice. A random
; number between 1DX and YDX is	returned
; Attributes: bp-based frame
dice_doYDX proc	far

	rval= word ptr -8
	counter= word ptr -6
	ndice= word ptr	-4
	dieval=	word ptr -2
	die= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	[bp+rval], 0
	mov	ax, [bp+die]
	mov	cl, 5
	sar	ax, cl
	and	ax, 7
	mov	[bp+dieval], ax
	mov	ax, [bp+die]
	and	ax, 1Fh
	mov	[bp+ndice], ax
	mov	[bp+counter], 0
	jmp	short loc_1D333
loc_1D330:
	inc	[bp+counter]
loc_1D333:
	mov	ax, [bp+ndice]
	cmp	[bp+counter], ax
	jg	short loc_1D356
	call	random
	mov	bx, [bp+dieval]
	mov	cl, diceMaskList[bx]
	sub	ch, ch
	and	cx, ax
	inc	cx
	add	[bp+rval], cx
	jmp	short loc_1D330
loc_1D356:
	mov	ax, [bp+rval]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
dice_doYDX endp

; Attributes: bp-based frame

party_fight proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	sub	ax, ax
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
party_fight endp

; Attributes: bp-based frame

party_advance proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 0
	jmp	short loc_1D387
loc_1D384:
	inc	[bp+var_2]
loc_1D387:
	cmp	[bp+var_2], 4
	jge	short loc_1D3A8
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1D3A6
	dec	gs:monGroups.distance[si]
loc_1D3A6:
	jmp	short loc_1D384
loc_1D3A8:
	mov	ax, offset aThePartyAdvances
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	[bp+var_2], 0
	jmp	short loc_1D3BF
loc_1D3BC:
	inc	[bp+var_2]
loc_1D3BF:
	cmp	[bp+var_2], 7
	jge	short loc_1D3D4
	mov	bx, [bp+var_2]
	mov	gs:charActionList[bx], 2
	jmp	short loc_1D3BC
loc_1D3D4:
	mov	ax, 1
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
party_advance endp

; Attributes: bp-based frame

party_run proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	gs:songCanRun, 0
	jz	short loc_1D404
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D404:
	mov	[bp+var_2], 0
	jmp	short loc_1D40E
loc_1D40B:
	inc	[bp+var_2]
loc_1D40E:
	cmp	[bp+var_2], 7
	jge	short loc_1D44C
	getCharP	[bp+var_2], bx
	cmp	byte ptr gs:party._name[bx], 0
	jz	short loc_1D44A
	mov	ax, itemEff_alwaysRunAway
	push	ax
	push	[bp+var_2]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1D44A
	mov	gs:runAwayFlag,	1
	mov	ax, 1
	jmp	short loc_1D46D
loc_1D44A:
	jmp	short loc_1D40B
loc_1D44C:
	call	random
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0C0h 
	jg	short loc_1D45F
	mov	al, 1
	jmp	short loc_1D461
loc_1D45F:
	sub	al, al
loc_1D461:
	mov	gs:runAwayFlag,	al
	sub	ah, ah
	jmp	short $+2
loc_1D46D:
	mov	sp, bp
	pop	bp
	retf
party_run endp

; Attributes: bp-based frame

bat_attackOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aAttack
	push	ds
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D4A2
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D4A2:
	cmp	[bp+var_2], 0
	jl	short loc_1D4AD
	mov	ax, 1
	jmp	short loc_1D4AF
loc_1D4AD:
	sub	ax, ax
loc_1D4AF:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_attackOpt endp

; Attributes: bp-based frame

bat_defendOpt proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_defendOpt endp

; Attributes: bp-based frame

bat_castOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, 1
	push	ax
	push	[bp+arg_0]
	call	getSpellNumber
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1D4ED
	sub	ax, ax
	jmp	short loc_1D541
loc_1D4ED:
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	cmp	[bp+var_2], 4
	jg	short loc_1D52D
	mov	ax, offset s_castAt
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr getTarget
	add	sp, 6
	or	ax,ax
	jge	l_bat_castOpt_gotTarget

	mov	ax, 0				; Return 0 if no target selected.
	jmp	loc_1D541

l_bat_castOpt_gotTarget:
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D541
loc_1D52D:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D53C:
	mov	ax, 1
	jmp	short $+2
loc_1D541:
	mov	sp, bp
	pop	bp
	retf
bat_castOpt endp

; Attributes: bp-based frame

bat_useItemOpt proc far

	var_F8=	word ptr -0F8h
	var_36=	word ptr -36h
	var_34=	word ptr -34h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F8h 
	call	someStackOperation
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	lea	ax, [bp+var_F8]
	push	ss
	push	ax
	push	[bp+arg_0]
	call	sub_188E8
	add	sp, 0Ah
	mov	[bp+var_36], ax
	or	ax, ax
	jnz	short loc_1D570
	jmp	loc_1D643
loc_1D570:
	push	ax
	lea	ax, [bp+var_34]
	push	ss
	push	ax
	mov	ax, offset s_whichItem
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_1D58F
	sub	ax, ax
	jmp	loc_1D663
loc_1D58F:
	push	[bp+var_4]
	push	[bp+arg_0]
	call	item_canBeUsed
	add	sp, 4
	or	ax, ax
	jz	short loc_1D61F
	mov	al, byte ptr g_curSpellNumber
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
	mov	al, byte ptr [bp+var_4]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42334[bx], al
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_2], ax
	cmp	ax, 4
	jge	short loc_1D609
	mov	ax, offset s_nlUseOn
	push	ds
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr getTarget
	add	sp, 6

	or	ax, ax
	jl	l_bat_useItem_opt_return_zero

	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
	mov	ax, 1
	jmp	short loc_1D605
	sub	ax, ax
loc_1D605:
	jmp	short loc_1D663
	jmp	short loc_1D618
loc_1D609:
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42276[bx], al
loc_1D618:
	mov	ax, 1
	jmp	short loc_1D663
loc_1D61F:
	mov	ax, offset aYouCanTUseThatItem_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	call	text_clear
	sub	ax, ax
	jmp	short loc_1D663
loc_1D641:
	jmp	short loc_1D663
loc_1D643:
	mov	ax, offset s_pocketsAreEmpty
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
l_bat_useItem_opt_return_zero:
	sub	ax, ax
	jmp	short $+2
loc_1D663:
	mov	sp, bp
	pop	bp
	retf
bat_useItemOpt endp

; Attributes: bp-based frame

bat_hideOpt proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_hideOpt endp

; Attributes: bp-based frame

bat_songOpt proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	text_clear
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	call	song_getSong
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D6AE
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D6AE:
	cmp	[bp+var_2], 0
	jl	short loc_1D6B9
	mov	ax, 1
	jmp	short loc_1D6BB
loc_1D6B9:
	sub	ax, ax
loc_1D6BB:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_songOpt endp

; Attributes: bp-based frame
bat_partyAttackOpt proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aAttack
	push	ds
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1D6F2
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+arg_0]
	mov	gs:byte_42244[bx], al
loc_1D6F2:
	cmp	[bp+var_2], 0
	jl	short loc_1D6FD
	mov	ax, 1
	jmp	short loc_1D6FF
loc_1D6FD:
	sub	ax, ax
loc_1D6FF:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_partyAttackOpt endp

; Attributes: bp-based frame

bat_getPartyOptions proc far

	charNo=	word ptr -138h
	var_136= word ptr -136h
	var_36=	word ptr -36h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 138h
	call	someStackOperation
	push	si
	cmp	g_partyAttackFlag, 0
	jz	short loc_1D720
	jmp	loc_1D7BE
loc_1D720:
	call	bat_isAMonGroupActive
	or	ax, ax
	jnz	short loc_1D72C
	jmp	loc_1D7BE
loc_1D72C:
	call	_return_zero
	or	ax, ax
	jz	short loc_1D738
	jmp	loc_1D7BE
loc_1D738:
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getFightRunOpt
	add	sp, 4
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	mov	ax, offset aWillYourGallantBand
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
loc_1D763:
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D77B:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D7B8
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D797
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D7B3
loc_1D797:
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475D0[bx]
	mov	[bp+var_12], ax
	or	ax, ax
	jz	short loc_1D7AE
	jmp	loc_1D996
	jmp	short loc_1D7B3
loc_1D7AE:
	mov	[bp+var_22], 0
loc_1D7B3:
	inc	[bp+var_16]
	jmp	short loc_1D77B
loc_1D7B8:
	cmp	[bp+var_22], 0
	jnz	short loc_1D763
loc_1D7BE:
	mov	[bp+charNo], 0
	jmp	short loc_1D7CA
loc_1D7C6:
	inc	[bp+charNo]
loc_1D7CA:
	cmp	[bp+charNo], 7
	jl	short loc_1D7D4
	jmp	loc_1D97D
loc_1D7D4:
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1D7EC
	jmp	loc_1D97D
loc_1D7EC:
	call	text_clear
	getCharP	[bp+charNo], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1D809
	jmp	loc_1D97A
loc_1D809:
	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1D814
	jmp	loc_1D97A
loc_1D814:
	test	gs:party.status[si], stat_possessed or	stat_nuts
	jz	short loc_1D827
	cmp	gs:(party.specAbil+3)[si], 0
	jz	short loc_1D827
	jmp	loc_1D96C
loc_1D827:
	call	text_clear
	getCharP	[bp+charNo], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	ax, offset aHasTheseOptionsThisBa
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	bx, [bp+charNo]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1D89A
	mov	al, gs:byte_42280[bx]
	add	al, '1'
	mov	byte_4724A, al
	mov	ax, offset byte_4724A
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
loc_1D89A:
	mov	ax, offset a@defend@partyAttack@c
	push	ds
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	byte ptr fs:[bx], 0
	push	[bp+charNo]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	push	cs
	call	near ptr bat_getCharOptions
	add	sp, 6
	lea	ax, [bp+var_36]
	push	ss
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	lea	ax, [bp+var_136]
	push	ss
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_14], ax
	mov	ax, offset aSelectAnOption_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_22], 1
	push	[bp+var_14]
	call	getKey
	add	sp, 2
	mov	[bp+var_6], ax
	mov	[bp+var_16], 0
loc_1D912:
	mov	si, [bp+var_16]
	cmp	byte ptr [bp+si+var_20], 0
	jz	short loc_1D961
	mov	al, byte ptr [bp+si+var_20]
	cbw
	cmp	ax, [bp+var_6]
	jz	short loc_1D92E
	shl	si, 1
	mov	ax, [bp+var_6]
	cmp	[bp+si+var_36],	ax
	jnz	short loc_1D95C
loc_1D92E:
	mov	al, byte ptr [bp+var_16]
	inc	al
	mov	bx, [bp+charNo]
	mov	gs:charActionList[bx], al
	push	[bp+charNo]
	mov	bx, [bp+var_16]
	shl	bx, 1
	shl	bx, 1
	call	off_475DC[bx]
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_22], cx
loc_1D95C:
	inc	[bp+var_16]
	jmp	short loc_1D912
loc_1D961:
	cmp	[bp+var_22], 0
	jz	short loc_1D96A
	jmp	loc_1D827
loc_1D96A:
	jmp	short loc_1D97A
loc_1D96C:
	mov	bx, [bp+charNo]
	mov	gs:charActionList[bx], 8
loc_1D97A:
	jmp	loc_1D7C6
loc_1D97D:
	mov	ax, offset s_useTheseCommands?
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_1D996
	jmp	loc_1D7BE
loc_1D996:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getPartyOptions endp

; Attributes: bp-based frame
bat_getFightRunOpt proc	far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	push	cs
	call	near ptr bat_monInMeleeRange
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+1], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+2], 1
	mov	sp, bp
	pop	bp
	retf
bat_getFightRunOpt endp

; This function	returns	0 if there is a	monster
; group	in melee range.	1 otherwise. This is used
; to determine whether the party should	be given
; the "Advance"	option in battle.
; Attributes: bp-based frame

bat_monInMeleeRange proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	[bp+var_2], 3
	jmp	short loc_1D9D9
loc_1D9D6:
	dec	[bp+var_2]
loc_1D9D9:
	cmp	[bp+var_2], 0
	jl	short loc_1DA04
	getMonP	[bp+var_2], si
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_1DA02
	mov	al, gs:monGroups.distance[si]
	and	al, 0Fh
	cmp	al, 2
	jnb	short loc_1DA02
	sub	ax, ax
	jmp	short loc_1DA09
loc_1DA02:
	jmp	short loc_1D9D6
loc_1DA04:
	mov	ax, 1
	jmp	short $+2
loc_1DA09:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_monInMeleeRange endp

; Attributes: bp-based frame
bat_getCharOptions proc	far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	g_partyAttackFlag, 0
	jnz	short loc_1DA49
	test	gs:monGroups.groupSize,	1Fh
	jz	short loc_1DA49
	cmp	[bp+arg_4], 4
	jl	short loc_1DA45
	mov	bx, [bp+arg_4]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1DA49
loc_1DA45:
	mov	al, 1
	jmp	short loc_1DA4B
loc_1DA49:
	sub	al, al
loc_1DA4B:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+1], 1
	mov	byte ptr fs:[bx+2], 1
	getCharP	[bp+arg_4], bx
	mov	ax, gs:party.currentSppt[bx]
	lfs	bx, [bp+arg_0]
	or	ax, ax
	jz	l_bat_getCharOptions_sppts
	mov	al, 1

l_bat_getCharOptions_sppts:
	mov	fs:[bx+3], al
	mov	byte ptr fs:[bx+4], 1
	mov	bx, [bp+arg_4]
	cmp	gs:byte_42280[bx], 9
	jnb	short loc_1DAA7
	getCharP	bx, bx
	cmp	gs:party.class[bx], class_rogue
	jnz	short loc_1DAA7
	mov	al, 1
	jmp	short loc_1DAA9
loc_1DAA7:
	sub	al, al
loc_1DAA9:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+5], al
	getCharP	[bp+arg_4], bx
	cmp	gs:party.class[bx], class_bard
	jnz	short loc_1DADB
	mov	ax, itType_instrument
	push	ax
	push	[bp+arg_4]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_1DADB
	mov	al, 1
	jmp	short loc_1DADD
loc_1DADB:
	sub	al, al
loc_1DADD:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+6], al
	mov	sp, bp
	pop	bp
	retf
bat_getCharOptions endp

; Attributes: bp-based frame

getTarget proc far

	var_228= byte ptr -228h
	var_11E= byte ptr -11Eh
	var_11C= word ptr -11Ch
	var_11A= byte ptr -11Ah
	var_119= byte ptr -119h
	var_10E= word ptr -10Eh
	var_E= word ptr	-0Eh
	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	stringOff= word	ptr  8
	stringSeg= word	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 11Eh
	call	someStackOperation
	push	si
	mov	ax, 0FFFFh
	mov	[bp+var_8], ax
	mov	[bp+var_2], ax
	mov	[bp+var_6], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB0E
loc_1DB0A:
	inc	[bp+var_11C]
loc_1DB0E:
	cmp	[bp+var_11C], 0Ch
	jge	short loc_1DB20
	mov	si, [bp+var_11C]
	mov	[bp+si+var_11A], 20h 
	jmp	short loc_1DB0A
loc_1DB20:
	push	[bp+stringSeg]
	push	[bp+stringOff]
	call	printStringWClear
	add	sp, 4
	mov	ax, [bp+arg_0]
	jmp	loc_1DD02
loc_1DB34:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	cmp	ax, 1
	jg	short loc_1DB46
	sub	ax, ax
	jmp	loc_1DD93
loc_1DB46:
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_4], 2000h
	jmp	loc_1DD20
loc_1DB63:
	push	cs
	call	near ptr bat_cntActiveMonGroups
	mov	[bp+var_2], ax
	cmp	ax, 1
	jg	short loc_1DB75
	mov	ax, 80h
	jmp	loc_1DD93
loc_1DB75:
	mov	[bp+var_4], 0
	mov	[bp+var_11C], 0
	jmp	short loc_1DB86
loc_1DB82:
	inc	[bp+var_11C]
loc_1DB86:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DC09
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DB82
loc_1DC09:
	jmp	loc_1DD20
loc_1DC0C:
	call	party_findEmptySlot
	mov	[bp+var_8], ax
	push	cs
	call	near ptr bat_cntActiveMonGroups
	mov	[bp+var_2], ax
	mov	[bp+var_4], 2000h
	mov	[bp+var_11C], 0
	jmp	short loc_1DC2C
loc_1DC28:
	inc	[bp+var_11C]
loc_1DC2C:
	mov	ax, [bp+var_2]
	cmp	[bp+var_11C], ax
	jge	short loc_1DCAF
	lea	ax, [bp+var_10E]
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], ss
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	bx, si
	shl	bx, 1
	mov	ax, (bitMask16bit+2)[bx]
	or	[bp+var_4], ax
	mov	al, byte ptr [bp+var_11C]
	add	al, 41h	
	mov	[bp+var_11E], al
	mov	[bp+si+var_119], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	al, [bp+var_11E]
	mov	fs:[bx], al
	lfs	bx, [bp+var_C]
	inc	word ptr [bp+var_C]
	mov	byte ptr fs:[bx], 29h
	push	[bp+var_11C]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr bat_printOpponentGroup
	add	sp, 6
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	lfs	bx, [bp+var_C]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_10E]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	jmp	loc_1DC28
loc_1DCAF:
	cmp	[bp+var_2], 0
	jz	short loc_1DCCE
	mov	ax, offset aOr
	push	ds
	push	ax
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
loc_1DCCE:
	cmp	[bp+var_8], 1
	jle	short loc_1DCEB
	mov	al, byte ptr [bp+var_8]
	add	al, monStruSize
	mov	byte ptr aMember17+0Bh,	al
	mov	ax, offset aMember17
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_1DCF8
loc_1DCEB:
	mov	ax, offset aMember1
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_1DCF8:
	jmp	short loc_1DD20
loc_1DCFA:
	mov	ax, 80h
	jmp	loc_1DD93
	jmp	short loc_1DD20
loc_1DD02:
	or	ax, ax
	jl	short loc_1DCFA
	cmp	ax, target_partyMember
	jg	short loc_1DD0E
	jmp	loc_1DB34
loc_1DD0E:
	cmp	ax, 2
	jnz	short loc_1DD16
	jmp	loc_1DB63
loc_1DD16:
	cmp	ax, 3
	jnz	short loc_1DD1E
	jmp	loc_1DC0C
loc_1DD1E:
	jmp	short loc_1DCFA
loc_1DD20:
	push	[bp+var_4]
	call	getKey
	add	sp, 2
	mov	[bp+var_E], ax
	cmp	ax, 10Eh
	jl	short loc_1DD43
	cmp	ax, 119h
	jg	short loc_1DD43
	mov	si, ax
	mov	al, [bp+si+var_228]
	sub	ah, ah
	mov	[bp+var_E], ax
loc_1DD43:
	cmp	[bp+var_6], 0
	jz	short loc_1DD54
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD54
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD54:
	cmp	[bp+var_E], 30h	
	jle	short loc_1DD6D
	mov	ax, [bp+var_8]
	add	ax, 31h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD6D
	mov	ax, [bp+var_E]
	sub	ax, 31h	
	jmp	short loc_1DD93
loc_1DD6D:
	cmp	[bp+var_E], 41h	
	jl	short loc_1DD86
	mov	ax, [bp+var_2]
	add	ax, 41h	
	cmp	ax, [bp+var_E]
	jle	short loc_1DD86
	mov	ax, [bp+var_E]
	add	ax, 3Fh	
	jmp	short loc_1DD93
loc_1DD86:
	cmp	[bp+var_E], 1Bh
	jnz	short loc_1DD91
	mov	ax, 0FFFFh
	jmp	short loc_1DD93
loc_1DD91:
	jmp	short loc_1DD20
loc_1DD93:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getTarget endp

; Attributes: bp-based frame

bat_cntActiveMonGroups proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_1DDAD
loc_1DDAA:
	inc	[bp+var_2]
loc_1DDAD:
	cmp	[bp+var_2], 4
	jge	short loc_1DDCE
	getMonP	[bp+var_2], bx
	test	gs:monGroups.groupSize[bx], 1Fh
	jnz	short loc_1DDCC
	mov	ax, [bp+var_2]
	jmp	short loc_1DDD3
loc_1DDCC:
	jmp	short loc_1DDAA
loc_1DDCE:
	mov	ax, 4
	jmp	short $+2
loc_1DDD3:
	mov	sp, bp
	pop	bp
	retf
bat_cntActiveMonGroups endp

; Attributes: bp-based frame

bat_getCharDamage proc far

	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	dword ptr -1Eh
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

	push	bp
	mov	bp, sp
	mov	ax, 22h	
	call	someStackOperation
	push	si
	cmp	[bp+arg_2], 80h
	jge	short loc_1DED6
	getCharP	[bp+arg_2], bx
	mov	al, gs:party.ac[bx]
	cbw
	mov	[bp+var_4], ax
	jmp	loc_1DF74
loc_1DED6:
	mov	ax, [bp+arg_2]
	and	ax, 3
	mov	[bp+var_E], ax
	getMonP	[bp+var_E], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_C], ax
	or	ax, ax
	jz	short loc_1DF17
	mov	bx, [bp+arg_0]
	mov	al, gs:byte_42280[bx]
	sub	ah, ah
	mov	cx, [bp+var_C]
	dec	cx
	cmp	ax, cx
	jnb	short loc_1DF17
	sub	ax, ax
	jmp	loc_1E277
loc_1DF17:
	getMonP	[bp+var_E], si
	mov	al, gs:monGroups.packedGenAc[si]
	sub	ah, ah
	and	ax, 3Fh
	mov	[bp+var_4], ax
	mov	al, gs:monGroups.flags[si]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	ax, 3
	mov	[bp+var_22], ax
	mov	bx, ax
	mov	al, byte_47606[bx]
	cbw
	add	[bp+var_4], ax
	mov	al, gs:monGroups.distance[si]
	sub	ah, ah
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_8], ax
	mov	bx, ax
	mov	al, byte_4760A[bx]
	cbw
	add	[bp+var_4], ax
	mov	bx, [bp+var_E]
	mov	al, gs:g_monFreezeAcPenalty[bx]
	sub	ah, ah
	sub	[bp+var_4], ax
loc_1DF74:
	mov	ax, itType_weapon
	push	ax
	push	[bp+arg_0]
	call	inven_getTypeEqSlot
	add	sp, 4
	mov	[bp+var_6], ax
	or	ax, ax
	jl	short loc_1DFB8
	mov	bx, ax
	mov	al, itemTypeList[bx]
	sub	ah, ah
	mov	cl, 4
	shr	ax, cl
	mov	gs:specialAttackVal, ax
	mov	al, item_acBonWeapDam[bx]
	sub	ah, ah
	shr	ax, cl
	mov	[bp+var_10], ax
	sub	[bp+var_4], ax
	jmp	short loc_1DFC8
loc_1DFB8:
	mov	[bp+var_10], 0
	mov	gs:specialAttackVal, 0
loc_1DFC8:
	mov	al, gs:byte_42567
	sub	ah, ah
	add	ax, [bp+var_4]
	mov	[bp+var_18], ax
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monster
	jb	short loc_1E01B
	add	ax, offset party
	mov	word ptr [bp+var_1E], ax
	mov	word ptr [bp+var_1E+2],	seg seg027
	lfs	bx, [bp+var_1E]
	mov	al, fs:[bx+summonStat_t.toHitHi]
	sub	ah, ah
	push	ax
	mov	al, fs:[bx+summonStat_t.toHitLo]
	push	ax
	push	cs
	call	near ptr randomBetweenXandY
	add	sp, 4
	mov	[bp+var_12], ax
	mov	ax, [bp+var_4]
	sub	ax, [bp+var_12]
	mov	[bp+var_A], ax
	jmp	short loc_1E059
loc_1E01B:
	getCharP	[bp+arg_0], bx
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1
	mov	[bp+var_12], ax
	cmp	ax, 0FFh
	jle	short loc_1E03D
	mov	[bp+var_12], 0FFh
loc_1E03D:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.strength[bx]
	sub	ah, ah
	shr	ax, 1
	mov	cx, [bp+var_4]
	sub	cx, ax
	sub	cx, [bp+var_12]
	mov	[bp+var_A], cx
loc_1E059:
	call	rnd_2d8
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	mov	al, byte_475F8[bx]
	cbw
	mov	bx, [bp+arg_0]
	mov	dl, gs:strengthBonus[bx]
	sub	dh, dh
	add	ax, dx
	add	ax, cx
	mov	cl, gs:byte_41E70
	sub	ch, ch
	add	ax, cx
	sub	[bp+var_A], ax
	cmp	[bp+var_A], 0
	jle	short loc_1E0A5
	sub	ax, ax
	jmp	loc_1E277
loc_1E0A5:
	getCharP	bx, bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E0D5
	mov	ax, gs:summonMeleeType
	mov	gs:specialAttackVal, ax
	mov	ax, gs:summonMeleeDamage
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E0D5:
	cmp	[bp+var_6], 0
	jl	short loc_1E0EE
	mov	bx, [bp+var_6]
	mov	al, itemDamageDice[bx]
	sub	ah, ah
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E0EE:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_monk
	jnz	short loc_1E126
	mov	ax, gs:party.level[si]
	shr	ax, 1
	shr	ax, 1
	mov	[bp+var_20], ax
	cmp	ax, 0Fh
	jle	short loc_1E118
	mov	[bp+var_20], 0Fh
loc_1E118:
	mov	bx, [bp+var_20]
	mov	al, byte_47412[bx]
	sub	ah, ah
	mov	[bp+var_16], ax
	jmp	short loc_1E12B
loc_1E126:
	mov	[bp+var_16], 20h 
loc_1E12B:
	getCharP	[bp+arg_0], bx
	cmp	gs:party.class[bx], class_rogue
	jnz	short loc_1E152
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jnz	short loc_1E152
	sub	ax, ax
	jmp	short loc_1E165
loc_1E152:
	getCharP	[bp+arg_0], bx
	mov	al, gs:party.numAttacks[bx]
	sub	ah, ah
loc_1E165:
	mov	[bp+var_2], ax
	mov	al, gs:songExtraAttack
	sub	ah, ah
	add	[bp+var_2], ax
	inc	[bp+var_2]
	mov	ax, [bp+var_2]
	mov	[bp+var_1A], ax
	mov	gs:damageAmount, 0
	jmp	short loc_1E18E
loc_1E18B:
	dec	[bp+var_2]
loc_1E18E:
	cmp	[bp+var_2], 0
	jle	short loc_1E1F8
	push	[bp+var_16]
	push	cs
	call	near ptr dice_doYDX
	add	sp, 2
	mov	bx, [bp+arg_0]
	mov	cl, gs:strengthBonus[bx]
	sub	ch, ch
	add	cx, ax
	mov	al, gs:byte_42440
	sub	ah, ah
	add	cx, ax
	add	cx, [bp+var_10]
	add	gs:damageAmount, cx
	mov	[bp+var_14], 0
	jmp	short loc_1E1D0
loc_1E1CD:
	inc	[bp+var_14]
loc_1E1D0:
	mov	bx, [bp+arg_0]
	mov	al, gs:vorpalPlateBonus[bx]
	sub	ah, ah
	cmp	ax, [bp+var_14]
	jbe	short loc_1E1F6
	call	random
	and	ax, 4
	add	gs:damageAmount, ax
	jmp	short loc_1E1CD
loc_1E1F6:
	jmp	short loc_1E18B
loc_1E1F8:
	mov	bx, [bp+arg_0]
	cmp	gs:byte_42280[bx], 0
	jz	short loc_1E232
	call	random
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:(party.specAbil+2)[bx], cl
	jbe	short loc_1E226
	mov	ax, speAtt_criticalHit
	jmp	short loc_1E228
loc_1E226:
	sub	ax, ax
loc_1E228:
	mov	gs:specialAttackVal, ax
	jmp	short loc_1E272
loc_1E232:
	getCharP	[bp+arg_0], si
	cmp	gs:party.class[si], class_hunter
	;;jnz	short loc_1E267
	jnz	short loc_1E272
	call	random
	cmp	gs:party.specAbil[si],	al
	jbe	short loc_1E25B
	mov	ax, speAtt_criticalHit
	jmp	short loc_1E25D
loc_1E25B:
	sub	ax, ax
loc_1E25D:
	mov	gs:specialAttackVal, ax
	jmp	short loc_1E272
;;loc_1E267:
;;	mov	gs:specialAttackVal, 0
loc_1E272:
	mov	ax, [bp+var_1A]
	jmp	short $+2
loc_1E277:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_getCharDamage endp

; Attributes: bp-based frame
bat_printHitDamage proc	far

	dmgLo= word ptr	 6
	dmgHi= word ptr	 8
	multiAttackFlag= word ptr  0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+multiAttackFlag], 1
	jg	short loc_1E2A7
	mov	ax, offset aAndHitsFor
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short loc_1E2F4
loc_1E2A7:
	mov	ax, offset aAndHits
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+multiAttackFlag]
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, offset aTimesFor
	push	ds
	push	ax
	push	dx
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
loc_1E2F4:
	sub	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	[bp+dmgLo]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_printHitDamage endp

; Attributes: bp-based frame

bat_getKillString proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, gs:specialAttackVal
	shl	bx, 1
	shl	bx, 1
	push	word ptr (specialAttString+2)[bx]
	push	word ptr specialAttString[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	strcat
	add	sp, 8
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_getKillString endp

; Attributes: bp-based frame

bat_doHPDamage proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jge	short loc_1E3A1
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_charAfterDmgCheck
	add	sp, 2
	jmp	short loc_1E3B1
	jmp	short loc_1E3B1
loc_1E3A1:
	mov	ax, [bp+arg_0]
	and	ax, 7Fh
	push	ax
	push	cs
	call	near ptr bat_doMonHPDamage
	add	sp, 2
	jmp	short $+2
loc_1E3B1:
	mov	sp, bp
	pop	bp
	retf
bat_doHPDamage endp

; Attributes: bp-based frame

bat_doMonHPDamage proc far

	monNo= word ptr	-4
	groupSize= word	ptr -2
	groupNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	or	ax, ax
	jnz	short loc_1E3E1
	sub	ax, ax
	jmp	short loc_1E459
loc_1E3E1:
	mov	[bp+monNo], 0
	jmp	short loc_1E3EB
loc_1E3E8:
	inc	[bp+monNo]
loc_1E3EB:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E41E
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	test	byte ptr gs:bat_monPriorityList[bx], 1
	jz	short loc_1E41C
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monAfterDmgCheck
	add	sp, 4
	jmp	short loc_1E459
loc_1E41C:
	jmp	short loc_1E3E8
loc_1E41E:
	mov	[bp+monNo], 0
	jmp	short loc_1E428
loc_1E425:
	inc	[bp+monNo]
loc_1E428:
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jge	short loc_1E44A
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	or	byte ptr gs:bat_monPriorityList[bx], 1
	jmp	short loc_1E425
loc_1E44A:
	sub	ax, ax
	push	ax
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_monAfterDmgCheck
	add	sp, 4
	jmp	short $+2
loc_1E459:
	mov	sp, bp
	pop	bp
	retf
bat_doMonHPDamage endp

; Attributes: bp-based frame

bat_monAfterDmgCheck proc far

	var_4= dword ptr -4
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	and	gs:bat_monPriorityList[bx], 0FEh
	cmp	gs:specialAttackVal, speAtt_stoning
	jz	short loc_1E495
	cmp	gs:specialAttackVal, speAtt_criticalHit
	jnz	short loc_1E4A7
loc_1E495:
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_killMon
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4A7:
	mov	ax, [bp+groupNo]
	mov	cl, 6
	shl	ax, cl
	mov	cx, [bp+monNo]
	shl	cx, 1
	add	ax, cx
	add	ax, offset monHpList
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg027
	mov	ax, gs:damageAmount
	lfs	bx, [bp+var_4]
	sub	fs:[bx], ax
	lfs	bx, [bp+var_4]
	cmp	word ptr fs:[bx], 0
	jg	short loc_1E4E9
	push	[bp+monNo]
	push	[bp+groupNo]
	push	cs
	call	near ptr bat_killMon
	add	sp, 4
	mov	ax, 1
	jmp	short loc_1E4ED
loc_1E4E9:
	sub	ax, ax
	jmp	short $+2
loc_1E4ED:
	mov	sp, bp
	pop	bp
	retf
bat_monAfterDmgCheck endp

; Attributes: bp-based frame

bat_killMon proc far

	mon= word ptr -2
	groupNo= word ptr  6
	monNo= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, [bp+monNo]
	mov	[bp+mon], ax
	jmp	short loc_1E508
loc_1E505:
	inc	[bp+mon]
loc_1E508:
	getMonP	[bp+groupNo], bx
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	cmp	ax, [bp+mon]
	jb	short loc_1E54F
	mov	si, [bp+groupNo]
	mov	cl, 6
	shl	si, cl
	mov	ax, [bp+mon]
	shl	ax, 1
	add	si, ax
	mov	ax, gs:(monHpList+2)[si]
	mov	gs:monHpList[si], ax
	mov	ax, gs:(bat_monPriorityList+2)[si]
	mov	gs:bat_monPriorityList[si], ax
	jmp	short loc_1E505
loc_1E54F:
	getMonP	[bp+groupNo], si
	dec	gs:monGroups.groupSize[si]
	test	gs:monGroups.groupSize[si], 1Fh
	jnz	short loc_1E56E
	and	gs:monGroups.flags[si],	0FEh
loc_1E56E:
	getMonP	[bp+groupNo], si
	mov	ah, gs:monGroups.rewardMid[si]
	sub	al, al
	mov	dl, gs:monGroups.rewardHi[si]
	sub	dh, dh
	mov	cl, 10h
	shl	dx, cl
	add	ax, dx
	mov	cl, gs:monGroups.rewardLo[si]
	sub	ch, ch
	add	ax, cx
	sub	dx, dx
	add	gs:batRewardLo,	ax
	adc	gs:batRewardHi,	dx
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_killMon endp

; Attributes: bp-based frame

bat_charAfterDmgCheck proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	cmp	byte ptr gs:party._name[bx], 0
	jnz	short loc_1E5CC
	sub	ax, ax
	jmp	loc_1E66E
loc_1E5CC:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_dead
	jz	short loc_1E5FA
	cmp	gs:specialAttackVal, speAtt_possess
	jnz	short loc_1E5F6
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_inflictStatus
	add	sp, 2
	jmp	short loc_1E66E
	jmp	short loc_1E5FA
loc_1E5F6:
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E5FA:
	getCharP	[bp+arg_0], bx
	test	gs:party.status[bx], stat_stoned
	jz	short loc_1E612
	sub	ax, ax
	jmp	short loc_1E66E
loc_1E612:
	getCharP	[bp+arg_0], si
	mov	ax, gs:damageAmount
	cmp	gs:party.currentHP[si], ax
	jnb	short loc_1E647
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	short loc_1E66E
	jmp	short loc_1E662
loc_1E647:
	mov	ax, gs:damageAmount
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	sub	gs:party.currentHP[bx], cx
loc_1E662:
	push	[bp+arg_0]
	push	cs
	call	near ptr bat_inflictStatus
	add	sp, 2
	jmp	short $+2
loc_1E66E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_charAfterDmgCheck endp

; Attributes: bp-based frame

bat_inflictStatus proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	ax, gs:specialAttackVal
	jmp	loc_1E869
loc_1E68A:
	sub	ax, ax
	jmp	loc_1E88A
poisonChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_poisoned
	mov	ax, 1
	jmp	loc_1E88A
levelDrainChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E6C2
	sub	ax, ax
	jmp	loc_1E88A
	jmp	short loc_1E70E
loc_1E6C2:
	getCharP	[bp+charNo], bx
	cmp	gs:party.level[bx], 1
	jbe	short loc_1E6DF
	getCharP	[bp+charNo], bx
	dec	gs:party.level[bx]
loc_1E6DF:
	getCharP	[bp+charNo], si
	mov	ax, gs:party.level[si]
	dec	ax
	push	ax
	push	[bp+charNo]
	call	getLevelXp
	add	sp, 4
	cwd
	mov	word ptr gs:party.experience[si], ax
	mov	word ptr gs:(party.experience+2)[si], dx
	mov	ax, 1
	jmp	loc_1E88A
loc_1E70E:
	sub	ax, ax
	jmp	loc_1E88A
nutsifyChar:
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_nuts
	mov	ax, 1
	jmp	loc_1E88A
oldifyChar:
	getCharP	[bp+charNo], bx
	cmp	gs:party.class[bx], class_monster
	jb	short loc_1E744
	sub	ax, ax
	jmp	loc_1E88A
loc_1E744:
	getCharP	[bp+charNo], bx
	test	gs:party.status[bx], stat_old
	jz	short loc_1E759
	sub	ax, ax
	jmp	loc_1E88A
loc_1E759:
	getCharP	[bp+charNo], si
	mov	ax, 5
	push	ax
	lea	ax, party.savedST[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.strength[si]
	push	dx
	push	ax
	push	cs
	call	near ptr _doAgeStatus
	add	sp, 0Ah
	getCharP	[bp+charNo], bx
	or	gs:party.status[bx], stat_old
	mov	ax, 1
	jmp	loc_1E88A
possessChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 64h 
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	mov	ax, 1
	jmp	loc_1E88A
stoneChar:
	getCharP	[bp+charNo], si
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	or	gs:party.status[si], stat_stoned
	mov	ax, 1
	jmp	loc_1E88A
killChar:
	getCharP	[bp+charNo], si
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	mov	gs:party.hostileFlag[si], 0
	mov	ax, 1
	jmp	loc_1E88A
loc_1E802:
	mov	[bp+var_4], 0
	jmp	short loc_1E80D
loc_1E809:
	add	[bp+var_4], 3
loc_1E80D:
	cmp	[bp+var_4], 24h	
	jge	short loc_1E846
	getCharP	[bp+charNo], si
	add	si, [bp+var_4]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	cmp	itemTypeList[bx], 1
	jnz	short loc_1E844
	and	gs:party.inventory.itemFlags[si], 0FCh
loc_1E844:
	jmp	short loc_1E809
loc_1E846:
	mov	ax, 1
	jmp	short loc_1E88A
consumeSppt:
	getCharP	[bp+charNo], bx
	mov	gs:party.currentSppt[bx], 0
	mov	ax, 1
	jmp	short loc_1E88A
loc_1E863:
	sub	ax, ax
	jmp	short loc_1E88A
	jmp	short loc_1E88A
loc_1E869:
	cmp	ax, 9
	ja	short loc_1E863
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_1E876[bx]
off_1E876 dw offset loc_1E68A
dw offset poisonChar
dw offset levelDrainChar
dw offset nutsifyChar
dw offset oldifyChar
dw offset possessChar
dw offset stoneChar
dw offset killChar
dw offset loc_1E802
dw offset consumeSppt
loc_1E88A:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bat_inflictStatus endp

; Attributes: bp-based frame

_doAgeStatus proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	jmp	short loc_1E89E
loc_1E89B:
	dec	[bp+arg_8]
loc_1E89E:
	cmp	[bp+arg_8], 0
	jl	short loc_1E8BF
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 1
	jmp	short loc_1E89B
loc_1E8BF:
	mov	sp, bp
	pop	bp
	retf
_doAgeStatus endp

; Attributes: bp-based frame

partyDied proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	byte ptr g_printPartyFlag,	0
	mov	gs:byte_42296, 0FFh
	mov	ax, 57
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, offset aSorryBud
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, offset aAlasYourPartyHasExp
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	g_partyAttackFlag, al
	sub	ah, ah
	mov	currentLocationMaybe, ax
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	g_direction, 0
	mov	ax, 1
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_1E958:
	retf
partyDied endp

seg008 ends

include seg009.asm

; Segment type: Pure code
seg010 segment word public 'CODE' use16
        assume cs:seg010
;org 9
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_1FC89:
align 2

noncombatCast proc far

	castSlotNumber= word ptr	-6
	spellTargetFlag= word ptr	-4
	var_2= word ptr	-2
	inFunctionKey= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	cmp	[bp+inFunctionKey], 0
	jz	short l_askForCaster
	mov	ax, [bp+inFunctionKey]
	sub	ax, dosKeys_F1
	mov	cl, 8
	sar	ax, cl
	mov	[bp+castSlotNumber], ax
	jmp	short l_checkCaster
l_askForCaster:
	mov	ax, offset s_whoWillCast
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	readSlotNumber
	mov	[bp+castSlotNumber], ax
l_checkCaster:
	cmp	[bp+castSlotNumber], 0
	jl	l_returnOne

	mov	ax, charSize
	imul	[bp+castSlotNumber]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_returnZero

	mov	ax, charSize
	imul	[bp+castSlotNumber]
	mov	bx, ax
	mov	bl, gs:party.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short l_isSpellCaster

	mov	ax, offset s_notSpellcaster
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	short l_returnZero
l_isSpellCaster:
	sub	ax, ax
	push	ax
	push	[bp+castSlotNumber]
	push	cs
	call	near ptr getSpellNumber
	add	sp, 4
	mov	[bp+spellTargetFlag], ax
	or	ax, ax
	jl	l_returnZero

	cmp	[bp+spellTargetFlag], 4
	jge	short l_doCast
	mov	ax, offset s_castAt
	push	ds
	push	ax
	push	[bp+spellTargetFlag]
	call	getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jl	l_returnZero
	mov	al, byte ptr [bp+var_2]
	mov	gs:bat_curTarget, al
l_doCast:
	call	text_clear
	mov	ax, 1
	push	ax
	sub	ax, ax
	push	ax
	push	g_curSpellNumber
	push	[bp+castSlotNumber]
	push	cs
	call	near ptr doCastSpell
	add	sp, 8
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2
l_returnOne:
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
noncombatCast endp

; Attributes: bp-based frame

; Returns:
;   0FFFFh if failed
;   spell targeting flag if successful

getSpellNumber proc far

	var_306= word ptr -306h
	var_304= word ptr -304h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 306h
	call	someStackOperation
	push	si

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	l_returnFailed

	mov	al, spell_mouseClicked
	sub	ah, ah
	or	ax, ax
	jnz	loc_mouse_spell_select

	push	[bp+partySlotNumber]
	call	text_castSpell
	add	sp, 2
	cmp	ax, 0FFFFh
	jz	l_return
	jmp	l_spellFound

loc_mouse_spell_select:
	mov	[bp+var_106], 0
	mov	[bp+var_104], 0
	jmp	short loc_1FDC6
loc_1FDC2:
	inc	[bp+var_104]
loc_1FDC6:
	cmp	[bp+var_104], 7Eh
	jge	short loc_1FE1A
	push	[bp+var_104]
	push	[bp+partySlotNumber]
	call	mage_hasLearnedSpell
	add	sp, 4

	or	ax, ax
	jz	short loc_1FE18
	mov	si, [bp+var_106]
	shl	si, 1
	mov	ax, [bp+var_104]
	mov	[bp+si+var_100], ax
	mov	bx, [bp+var_104]
	mov	cl, 3
	shl	bx, cl
	mov	ax, word ptr spellString.fullName[bx]
	mov	dx, word ptr (spellString.fullName+2)[bx]
	mov	si, [bp+var_106]
	inc	[bp+var_106]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_306], ax
	mov	[bp+si+var_304], dx
loc_1FE18:
	jmp	short loc_1FDC2
loc_1FE1A:
	cmp	[bp+var_106], 0
	jz	short loc_1FE3E
	push	[bp+var_106]
	lea	ax, [bp+var_306]
	push	ss
	push	ax
	mov	ax, offset s_spellToCast
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_102], ax
	jmp	short loc_1FE5F
loc_1FE3E:
	mov	ax, offset s_dontKnowAnySpells
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	short l_returnFailed
loc_1FE5F:
	cmp	[bp+var_102], 0
	jl	short l_returnFailed
	mov	si, [bp+var_102]
	shl	si, 1
	mov	ax, [bp+si+var_100]

l_spellFound:
	mov	g_curSpellNumber, ax
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr getSpptRequired
	add	sp, 4
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.currentSppt[bx], cx
	jnb	short l_enoughSppt

	mov	ax, offset s_notEnoughSppt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	short l_returnFailed

l_enoughSppt:
	mov	bx, g_curSpellNumber
	mov	al, spellCastFlags[bx]
	sub	ah, ah
	and	ax, 7
	jmp	short l_return
l_returnFailed:
	mov	ax, 0FFFFh
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getSpellNumber endp

; This function	gets the spell points required for
; a particular spell. It takes into account equipment
; that the player has equipped.

; Attributes: bp-based frame

getSpptRequired	proc far

	sppt= word ptr	-2
	partySlotNumber= word ptr  6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	bx, [bp+spellIndexNumber]
	mov	al, spptRequired[bx]
	sub	ah, ah
	mov	[bp+sppt], ax
	mov	ax, itemEff_quaterSpptUse
	push	ax
	push	[bp+partySlotNumber]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short l_checkHalf
	mov	ax, [bp+sppt]
	sar	ax, 1
	sar	ax, 1
	jmp	short l_return
l_checkHalf:
	mov	ax, itemEff_halfSpptUsage
	push	ax
	push	[bp+partySlotNumber]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short l_returnSppt
	mov	ax, [bp+sppt]
	sar	ax, 1
	jmp	short l_return
l_returnSppt:
	mov	ax, [bp+sppt]
	jmp	short $+2
l_return:
	mov	sp, bp
	pop	bp
	retf
getSpptRequired	endp

; Attributes: bp-based frame

doCastSpell proc far

	stringBuf= word ptr -108h
	stringBufP= dword ptr -8
	partySlotNumber=	word ptr  6
	spellNumber= word ptr  8
	itemUsedFlag= word ptr	 0Ah
	useSppt= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation

	push	[bp+partySlotNumber]
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	bat_getAttackerName
	add	sp, 6
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx
	lfs	bx, dword ptr [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	byte ptr fs:[bx], ' '

	cmp	[bp+spellNumber], 7Eh 
	jge	short l_spptCheck

	mov	ax, offset s_castsASpell
	push	ds
	push	ax
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx
	lfs	bx, dword ptr [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	byte ptr fs:[bx], ' '

	; Append full spell name to output string
	mov	bx, [bp+spellNumber]
	mov	cl, 3
	shl	bx, cl
	push	word ptr (spellString.fullName+2)[bx]
	push	word ptr spellString.fullName[bx]
	push	word ptr [bp+stringBufP+2]
	push	word ptr [bp+stringBufP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx

l_spptCheck:
	cmp	[bp+useSppt], 0
	jz	short l_castIt
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _sp_checkSPPT
	add	sp, 4
	or	ax, ax
	jz	short l_fizzled
	mov	al, gs:sq_antiMagicFlag
	sub	ah, ah
	or	ax, ax
	jz	short l_castIt

l_fizzled:
	lfs	bx, dword ptr [bp+stringBufP]
	inc	word ptr [bp+stringBufP]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4

	call	printSpellFizzled

	sub	ax, ax
	jmp	short l_return
l_castIt:
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	push	[bp+itemUsedFlag]
	push	[bp+spellNumber]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr spell_cast
	add	sp, 6
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
doCastSpell endp

; Attributes: bp-based frame

sp_lightSpell proc far

	spellEffect= word ptr	-2
	spellNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	bx, [bp+spellNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+spellEffect], ax
	mov	bx, ax
	mov	al, lightDistList[bx]
	mov	lightDistance, al
	mov	al, lightDurList[bx]
	mov	lightDuration, al
	sub	ax, ax
	push	ax
	call	icon_activate
	add	sp, 2
	mov	bx, [bp+spellEffect]
	mov	al, lightDetectList[bx]
	mov	gs:gl_detectSecretDoorFlag, al
	mov	ax, offset s_elipsisNl
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 2
	push	ax
	call	text_delayNoTable
	add	sp, 2

	mov	sp, bp
	pop	bp
	retf
sp_lightSpell endp

; Attributes: bp-based frame

sp_possessChar proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	ax, charSize
	imul	[bp+var_2]
	mov	si, ax
	test	gs:party.status[si], stat_dead
	jz	short l_return
	and	gs:party.status[si], stat_poisoned or stat_old	or stat_stoned or stat_paralyzed or stat_possessed or stat_nuts	or stat_unknown
	or	gs:party.status[si], stat_possessed
	mov	gs:party.currentHP[si], 100
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_possessChar endp

; Attributes: bp-based frame

sp_damageSpell proc far

	attP= word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	counter= word ptr -0Ah
	attStru= byte ptr -8
	partySlotNumber=	word ptr  6
	spellNumber= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	push	di
	push	si

	mov	bx, [bp+spellNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_C], ax
	lea	ax, [bp+attStru]
	mov	[bp+attP], ax
	mov	[bp+var_E], ss
	mov	[bp+counter], 0
	jmp	short loc_20100
loc_200FD:
	inc	[bp+counter]
loc_20100:
	cmp	[bp+counter], 7
	jge	short loc_20118
	mov	si, [bp+var_C]
	mov	bx, [bp+counter]
	mov	al, byte ptr damageSpellData.effectStrIndex[bx+si]
	lfs	si, dword ptr [bp+attP]
	mov	fs:[bx+si], al
	jmp	short loc_200FD
loc_20118:
	mov	bx, [bp+spellNumber]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+attStru]
	mov	di, sp
	push	ss
	pop	es
	movsw
	movsw
	movsw
	movsb
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr bat_doBreathAttack
	add	sp, 0Ch
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sp_damageSpell endp

; Attributes: bp-based frame

bat_doBreathAttack proc	far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	outputStringP= dword ptr -116h
	counter= word ptr -112h
	var_110= word ptr -110h
	target=	word ptr -10Eh
	var_10C= word ptr -10Ch
	partyAttackRval= word ptr -10Ah
	var_108= word ptr -108h
	stringBuf= word ptr -106h
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	specialAttackIndex= byte ptr	 8
	arg_3= byte ptr	 9
	arg_4= byte ptr	 0Ah
	arg_5= byte ptr	 0Bh
	arg_6= byte ptr	 0Ch
	breathFlags= byte ptr	 0Dh
	levelMultiplier= byte ptr	 0Eh
	spellRange= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 11Ah
	call	someStackOperation

	cmp	[bp+levelMultiplier], 0
	jnz	short l_allFoesCheck

	; Set levelMultiplier to 1 if source is an enemy
	cmp	[bp+partySlotNumber], 80h 
	jl	short l_partyMultiplier
	mov	[bp+levelMultiplier], 1
	jmp	short l_allFoesCheck

l_partyMultiplier:
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	push	gs:party.level[bx]
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	mov	[bp+levelMultiplier], al

l_allFoesCheck:
	mov	[bp+partyAttackRval], 0
	test	[bp+breathFlags], breath_allFoes		; if breathFlags & breathAllFoes
	jz	short l_oneGroupCheck
	cmp	[bp+partySlotNumber], 80h 			;   if source.isEnemy
	jge	short l_stripAllFoesFlag			;     breathFlags &= !breathAllFoes
	mov	gs:bat_curTarget, 80h				;   else
	jmp	short l_oneGroupCheck				;     currentTarget = first enemy group
l_stripAllFoesFlag:
	and	[bp+breathFlags], 7Fh

l_oneGroupCheck:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	or	ax, [bp+partySlotNumber]
	cmp	ax, 80h
	jnb	short loc_201B9
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201B9
	mov	ax, [bp+partySlotNumber]
	jmp	short loc_201BC
loc_201B9:
	mov	ax, 0FFh
loc_201BC:
	mov	[bp+var_11A], ax

	mov	[bp+var_110], 0
loc_201C6:
	cmp	gs:bat_curTarget, 80h
	jnb	l_targetIsEnemy
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_201E0
	mov	ax, 6
	jmp	short loc_201E6
loc_201E0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
loc_201E6:
	mov	[bp+target], ax
	mov	ax, offset s_atTheParty
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	inc	[bp+partyAttackRval]
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr bat_isPartyInRange
	add	sp, 4
	or	ax, ax
	jnz	loc_20324
	mov	ax, offset s_partyTooFarAway
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	call	text_delayWithTable
	mov	ax, [bp+partyAttackRval]
	dec	ax
	jmp	bat_doBreathAttack_exit

l_targetIsEnemy:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	l_enemyGroupGone
loc_20289:
	test	[bp+breathFlags], breath_oneGroup
	jz	short loc_202B1
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	dec	ax
	jmp	short loc_202B3
loc_202B1:
	sub	ax, ax
loc_202B3:
	mov	[bp+target], ax

	; strcat(stringBuf, "at")
	mov	ax, offset s_at
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx

	push	[bp+target]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	push	cs
	call	near ptr strcatTargetName
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, offset s_elipsisNl
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	jmp	short loc_20324
l_enemyGroupGone:
	mov	[bp+target], 0FFFFh
	cmp	[bp+breathFlags], breath_allFoes
	jnb	short loc_20324
	mov	ax, [bp+partyAttackRval]
	jmp	bat_doBreathAttack_exit

loc_20324:
	cmp	[bp+target], 0
	jl	loc_2086F
loc_2032E:
	mov	gs:damageAmount, 0
	mov	[bp+counter], 0
	jmp	short loc_20345
loc_20341:
	inc	[bp+counter]
loc_20345:
	mov	al, [bp+levelMultiplier]
	sub	ah, ah
	cmp	ax, [bp+counter]
	jbe	short loc_20379
	mov	al, [bp+arg_6]
	push	ax
	call	dice_doYDX
	add	sp, 2
	add	gs:damageAmount, ax
	cmp	gs:damageAmount, 20000
	jle	short loc_20377
	mov	gs:damageAmount, 20000
	jmp	short loc_20379
loc_20377:
	jmp	short loc_20341
loc_20379:
	cmp	gs:bat_curTarget, 80h
	jb	short loc_203AA

	mov	ax, offset s_one
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	[bp+var_2], 1
	jmp	loc_2047F
loc_203AA:
	mov	ax, [bp+target]
	cmp	[bp+var_11A], ax
	jz	loc_2047A
	mov	bx, ax
	cmp	gs:byte_42280[bx], 0
	jnz	loc_2047A
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr _canAttackChar
	add	sp, 4
	or	ax, ax
	jz	loc_2047A
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	lfs	bx, dword ptr [bp+outputStringP]
	inc	word ptr [bp+outputStringP]
	mov	byte ptr fs:[bx], ' '
	mov	ax, itemEff_breathDefense
	push	ax
	push	[bp+target]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jl	short loc_20467
	test	[bp+breathFlags], breath_isBreath
	jz	short loc_20467
	mov	ax, offset s_repelledAttack
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	byte ptr g_printPartyFlag,	0
	mov	[bp+var_2], 0
	jmp	short loc_20478
loc_20467:
	mov	al, byte ptr [bp+target]
	mov	gs:bat_curTarget, al
	mov	[bp+var_2], 1
loc_20478:
	jmp	short loc_2047F
loc_2047A:
	mov	[bp+var_2], 0
loc_2047F:
	cmp	[bp+var_2], 0
	jnz	short loc_20488
	jmp	loc_2050C
loc_20488:
	cmp	[bp+arg_5], 0
	jz	short loc_2050C
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_204B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.repelFlags[bx]
	sub	ah, ah
	jmp	short loc_204CF
loc_204B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 7Fh
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.repelFlags[bx]
	sub	ah, ah
loc_204CF:
	mov	[bp+var_10C], ax
	mov	al, [bp+arg_5]
	sub	ah, ah
	test	[bp+var_10C], ax
	jnz	short loc_2050C
	mov	ax, offset s_repelledAttack
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	[bp+var_2], 0
loc_2050C:
	cmp	[bp+var_2], 0
	jnz	short loc_20515
	jmp	loc_20810
loc_20515:
	push	[bp+spellRange]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr bat_isPartyInRange
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jz	loc_207F3
	cmp	ax, 2
	jnz	short loc_2053B
	mov	gs:byte_41E63, 4
loc_2053B:
	mov	al, [bp+breathFlags]
	sub	ah, ah
	and	ax, 2
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
	mov	[bp+var_118], ax
	or	ax, ax
	jnz	short loc_20559
	jmp	loc_207D4
loc_20559:
	cmp	ax, 1
	jnz	short loc_20567
	sar	gs:damageAmount, 1
loc_20567:
	test	[bp+breathFlags], 3
	jz	short loc_2058E
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_2058E
	cmp	gs:songHalfDamage, 0
	jz	short loc_2058E
	sar	gs:damageAmount, 1
loc_2058E:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_205B0
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.strongElement[bx]
	sub	ah, ah
	jmp	short loc_205CF
loc_205B0:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.strongElement[bx]
	sub	ah, ah
loc_205CF:
	mov	[bp+var_108], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_108], ax
	mov	[bp+counter], 0
	jmp	short loc_205E8
loc_205E4:
	inc	[bp+counter]
loc_205E8:
	cmp	[bp+counter], 7
	jge	short loc_2060F
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_108], ax
	jz	short loc_2060D
	sar	gs:damageAmount, 1
loc_2060D:
	jmp	short loc_205E4
loc_2060F:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20631
	mov	al, charSize
	mul	gs:bat_curTarget
	mov	bx, ax
	mov	al, gs:party.weakElement[bx]
	sub	ah, ah
	jmp	short loc_20650
loc_20631:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.weakElement[bx]
	sub	ah, ah
loc_20650:
	mov	[bp+var_6], ax
	mov	al, [bp+arg_3]
	sub	ah, ah
	and	[bp+var_6], ax
	mov	[bp+counter], 0
	jmp	short loc_20667
loc_20663:
	inc	[bp+counter]
loc_20667:
	cmp	[bp+counter], 7
	jge	short loc_2068D
	mov	bx, [bp+counter]
	mov	al, byteMaskList[bx]
	sub	ah, ah
	test	[bp+var_6], ax
	jz	short loc_2068B
	shl	gs:damageAmount, 1
loc_2068B:
	jmp	short loc_20663
loc_2068D:
	mov	ax, gs:damageAmount
	mov	cl, [bp+specialAttackIndex]
	sub	ch, ch
	or	ax, cx
	jnz	short loc_206A1
	jmp	loc_207B5
loc_206A1:
	mov	ax, offset s_is
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	bl, [bp+arg_4]
	sub	bh, bh
	and	bl, 0FEh
	shl	bx, 1
	push	word ptr (breathEffectStr+2)[bx]
	push	word ptr breathEffectStr[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, offset a_for
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	xor	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	al, [bp+specialAttackIndex]
	sub	ah, ah
	mov	gs:specialAttackVal, ax
	mov	al, gs:bat_curTarget
	push	ax
	call	bat_doHPDamage
	add	sp, 2
	or	ax, ax
	jz	short loc_207A7
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	bat_getKillString
	add	sp, 4
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	mov	ax, 1
	push	ax
	mov	ax, 3
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	dx
	push	word ptr [bp+outputStringP]
	call	printCharPronoun
	add	sp, 0Ah
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	jmp	short loc_207D2
loc_207A7:
	mov	ax, offset s_periodNlNl
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
	jmp	short loc_207D2
loc_207B5:
	mov	ax, offset s_repelledAttack
	push	ds
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
loc_207D2:
	jmp	short loc_207F1
loc_207D4:
	mov	ax, offset s_repelledAttack
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
loc_207F1:
	jmp	short loc_20810
loc_207F3:
	mov	ax, offset s_wasTooFarAway
	push	ds
	push	ax
	push	word ptr [bp+outputStringP+2]
	push	word ptr [bp+outputStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], dx
loc_20810:
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0
	call	text_delayWithTable
	lea	ax, [bp+stringBuf]
	mov	word ptr [bp+outputStringP], ax
	mov	word ptr [bp+outputStringP+2], ss
	lfs	bx, [bp+outputStringP]
	mov	byte ptr fs:[bx], 0
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_20868
	test	[bp+breathFlags], 40h
	jnz	short loc_20868
	mov	[bp+target], 0FFFFh
loc_20868:
	dec	[bp+target]
	jmp	loc_20324
loc_2086F:
	test	[bp+breathFlags], breath_allFoes
	jz	short loc_20896
	test	gs:bat_curTarget, 80h
	jz	short loc_20896
	cmp	gs:bat_curTarget, 83h
	jz	short loc_20896
	mov	[bp+var_110], 1
	inc	gs:bat_curTarget
	jmp	short loc_2089C
loc_20896:
	mov	[bp+var_110], 0
loc_2089C:
	cmp	[bp+var_110], 0
	jnz	loc_201C6
bat_doBreathAttack_exit:
	mov	sp, bp
	pop	bp
	retf
bat_doBreathAttack endp

; Attributes: bp-based frame

_canAttackChar proc far
        partySlotNumber=        word ptr  6
        specialAttackIndex= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax

        cmp     byte ptr gs:party._name[bx], 0			; if partySlot.isEmpty
	jz	l_return_zero					;   return 0
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
        test    gs:party.status[bx], stat_dead or stat_stoned	; if !partySlot.isDead and !partySlot.isStoned
	jz	l_return_one					;   return 1

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax		; Character is either dead or stoned
        test    gs:party.status[bx], stat_stoned		; if partySlot.isStoned
	jnz	l_return_zero					;   return 0

								; Character is dead
        cmp     [bp+specialAttackIndex], speAtt_possess		; if specialAttackIndex != speAtt_possess
        jnz     short l_return_zero				;   return 0
l_return_one:
	mov	ax, 1
	jmp	l_return
l_return_zero:
        sub     ax, ax
l_return:
	mov	sp, bp
	pop	bp
        retf
_canAttackChar endp

; Attributes: bp-based frame
sp_trapZap proc	far

	_sq_east= word ptr -0Ah
	loopCounter= word ptr	-8
	_sq_north= word	ptr -6
	dungeonSquareP= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation

	mov	ax, sq_north
	mov	[bp+_sq_north],	ax
	mov	ax, sq_east
	mov	[bp+_sq_east], ax
	cmp	inDungeonMaybe, 0
	jz	l_return
	mov	[bp+loopCounter], 4
l_loop:
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	mov	ax, [bp+_sq_north]
	mov	bx, g_direction
	shl	bx, 1
	sub	ax, dirDeltaN[bx]
	push	ax
	call	wrapNumber
	add	sp, 4
	mov	[bp+_sq_north],	ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	mov	bx, g_direction
	shl	bx, 1
	mov	ax, dirDeltaE[bx]
	add	ax, [bp+_sq_east]
	push	ax
	call	wrapNumber
	add	sp, 4
	mov	[bp+_sq_east], ax
	mov	bx, [bp+_sq_north]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+_sq_east]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+dungeonSquareP], ax
	mov	word ptr [bp+dungeonSquareP+2], dx
	lfs	bx, [bp+dungeonSquareP]
	and	byte ptr fs:[bx], 0EFh
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	l_loop
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_trapZap endp

; Attributes: bp-based frame

sp_freezeFoes proc far

	spellCaster=	word ptr  6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	push	[bp+spellCaster]
	push	cs
	call	near ptr spellSavingThrowHelper
	add	sp, 2
	or	ax, ax
	jz	short l_return

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 3
	add	gs:g_monFreezeAcPenalty[bx], al
	add	gs:byte_41E70, 2
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:g_charFreezeAcPenalty, al
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_freezeFoes endp


; Attributes: bp-based frame

spellSavingThrowHelper proc far

        spellCaster= word ptr  6

	push	bp
	mov	bp, sp

        cmp     [bp+spellCaster], 80h
        jl      short l_partyCaster

        mov     gs:bat_curTarget, 0		; Saving throw target is first party slot
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
        or      ax, ax
        jnz     short l_firstCharFailedSave
        sub     ax, ax
        jmp     short l_return
l_firstCharFailedSave:
        cmp     gs:partySecondSlot._name, 0
        jnz     short l_secondCharExists
        mov     ax, 1
        jmp     short l_return
l_secondCharExists:
        mov     gs:bat_curTarget, 1
l_partyCaster:
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
        retf
spellSavingThrowHelper endp

; Attributes: bp-based frame

; Returns:
;   0 - saving throw succeeded
;   1 - saving throw failed
;   2 - saving throw failed badly
;

savingThrowCheck proc far

	targetSaveValue= word ptr	-6
	sourceSaveValue= word ptr	-4
	saveDifference= word ptr	-2
	saveSource= word ptr	 6
	saveType= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	sub	ax, ax
	push	ax
	push	[bp+saveSource]
	push	cs
	call	near ptr _savingThrowCheck
	add	sp, 4
	mov	[bp+sourceSaveValue], ax

	mov	gs:byte_4228E, 0			; Doesnt seem to do anything

	push	[bp+saveType]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr _savingThrowCheck
	add	sp, 4
	mov	[bp+targetSaveValue], ax

	; Always seems to be zero. byte_41E63 isnt set anywhere
	mov	al, gs:byte_41E63
	sub	ah, ah

	add	ax, [bp+targetSaveValue]
	push	ax
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	mov	[bp+targetSaveValue], ax
	mov	gs:byte_41E63, 0
	mov	ax, [bp+sourceSaveValue]
	sub	ax, [bp+targetSaveValue]
	mov	[bp+saveDifference], ax
	or	ax, ax
	jge	short l_saveFailed
	sub	ax, ax
	jmp	short l_return
l_saveFailed:
	cmp	[bp+saveDifference], 4
	jle	short l_return_one
	mov	ax, 2
	jmp	short l_return
l_return_one:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
savingThrowCheck endp

; Attributes: bp-based frame

_savingThrowCheck proc far

	saveHi= word ptr	-0Ah
	partySaveValue= word ptr	-8
	saveLo= word ptr	-6
	charP= dword ptr -4
	indexNo= word ptr  6
	savingThrowType= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si

	cmp	[bp+indexNo], 80h
	jl	short l_isPartyMember
	and	[bp+indexNo], 7Fh

	; This block looks to be useless. byte_4228E doesnt have any
	; value besides 0 written to it. Might be a bug.
	cmp	gs:byte_4228E, 0
	jz	short l_enemySave
	mov	al, gs:byte_4228E
	sub	ah, ah
	jmp	l_return

l_enemySave:
	cmp	[bp+savingThrowType], 0

	; FIXED - This was "jz short l_monSpellSave". This matches behavior on the
	; Apple II. The function was using the wrong hi/lo values for spells.
	; This pretty much made the final battles with Rock Demons impossible.
	;
	jnz	short l_monSpellSave
	mov	ax, monStruSize
	imul	[bp+indexNo]
	mov	si, ax
	mov	al, gs:monGroups.breathSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:monGroups.breathSaveHi[si]
	mov	[bp+saveHi], ax
	jmp	short loc_20B8D
l_monSpellSave:
	mov	ax, monStruSize
	imul	[bp+indexNo]
	mov	si, ax
	mov	al, gs:monGroups.spellSaveLo[si]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, gs:monGroups.spellSaveHi[si]
	mov	[bp+saveHi], ax
loc_20B8D:
	push	[bp+saveHi]
	push	[bp+saveLo]
	call	randomBetweenXandY
	add	sp, 4
	jmp	l_return

	; This line is unreachable in the code. It might be correct
	; to check for an antimagic square. 
	; jmp	l_antiMagicCheck

l_isPartyMember:
	mov	ax, charSize
	imul	[bp+indexNo]
	mov	si, ax
	cmp	gs:party.class[si], class_monster
	jb	short l_partyMemberNotMonster
	add	ax, offset party
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	cmp	[bp+savingThrowType], 0
	jnz	short l_partyMonSpellSave
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.breathSaveLo]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, fs:[bx+summonStat_t.breathSaveHi]
	mov	[bp+saveHi], ax
	jmp	short l_partyMonRandomSaveValue
l_partyMonSpellSave:
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.spellSaveLo]
	sub	ah, ah
	mov	[bp+saveLo], ax
	mov	al, fs:[bx+summonStat_t.spellSaveHi]
	mov	[bp+saveHi], ax
l_partyMonRandomSaveValue:
	push	[bp+saveHi]
	push	[bp+saveLo]
	call	randomBetweenXandY
	add	sp, 4
	mov	[bp+partySaveValue], ax
	jmp	short l_antiMagicCheck
l_partyMemberNotMonster:
	mov	ax, charSize
	imul	[bp+indexNo]
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	mov	[bp+partySaveValue], ax
	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+indexNo]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short l_noLuckBonus
	add	[bp+partySaveValue], 2
l_noLuckBonus:
	mov	ax, charSize
	imul	[bp+indexNo]
	mov	si, ax
	mov	ax, 41h	
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	bl, gs:party.class[si]
	sub	bh, bh
	mov	cl, classSavingBonus[bx]
	sub	ch, ch
	mov	dl, gs:party.luck[si]
	sub	dh, dh
	add	cx, dx
	add	cx, ax
	add	[bp+partySaveValue], cx
l_antiMagicCheck:
	mov	al, gs:antiMagicFlag
	sub	ah, ah
	add	ax, [bp+partySaveValue]
	push	ax
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_savingThrowCheck endp

; This function	returns	the passed value or 255
; depending on which is	lower. This is equivalent
; to the C statement:
; (val)	<= 255 ? (val) : 255
; Attributes: bp-based frame

_returnXor255 proc far

	val= word ptr  6

	push	bp
	mov	bp, sp

	mov	ax, [bp+val]
	cmp	ax, 255
	jle	short l_return
	mov	ax, 255
l_return:
	mov	sp, bp
	pop	bp
	retf
_returnXor255 endp

; Attributes: bp-based frame

sp_compassSpell	proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	compassDuration, al
	mov	ax, icon_compass
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_compassSpell	endp


; Attributes: bp-based frame

sp_healSpell proc far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8

	push	bp
	mov	bp, sp

	cmp	[bp+partySlotNumber], 80h
	jge	short l_return
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	cmp	ax, heal_allFlag
	jge	short l_healAll
	push	bx
	mov	al, gs:bat_curTarget
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _doHeal
	add	sp, 6
	jmp	short l_return
l_healAll:
	mov	gs:bat_curTarget, 0
l_healAllLoop:
	push	[bp+spellNo]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _doHeal
	add	sp, 6
	inc	gs:bat_curTarget
	cmp	gs:bat_curTarget, 7
	jb	short l_healAllLoop
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_healSpell endp

; Attributes: bp-based frame

_doHeal	proc far

	hpToHeal= word ptr -4
	effectFlag= word ptr -2
	partySlotNumber=	word ptr  6
	target=	word ptr  8
	spellNo= word ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	mov	bx, [bp+spellNo]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+effectFlag], ax
	mov	[bp+hpToHeal], 0

	cmp	ax, heal_fullHeal	; effectFlag < 0xfd means to heal effectFlagd4
					; hit points.
	jge	short l_quickFixCheck
	push	ax
	push	cs
	call	near ptr rnd_Xd4
	add	sp, 2
	mov	[bp+hpToHeal], ax
	jmp	short l_healHp

l_quickFixCheck:
	; Heal 8 points of damage. This is the magician spell
	; quick fix
	cmp	[bp+effectFlag], 0FEh 
	jnz	short l_healTimesLevel
	mov	[bp+hpToHeal], 8
	jmp	short l_healHp

l_healTimesLevel:
	; Heal Xd4 where X is the casters level
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	push	ax
	push	cs
	call	near ptr rnd_Xd4
	add	sp, 2
	mov	[bp+hpToHeal], ax

l_healHp:
	mov	ax, charSize
	imul	[bp+target]
	mov	si, ax
	mov	ax, [bp+hpToHeal]
	add	gs:party.currentHP[si], ax
	mov	ax, gs:party.maxHP[si]
	cmp	gs:party.currentHP[si], ax
	ja	short l_setToMaxHp
	cmp	[bp+effectFlag], heal_fullHeal
	jnz	short l_cureStatus
l_setToMaxHp:
	mov	ax, charSize
	imul	[bp+target]
	mov	si, ax
	mov	ax, gs:party.maxHP[si]
	mov	gs:party.currentHP[si], ax
l_cureStatus:
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	jmp	l_switchStatus

l_fleshrestore:
	; Clears stat_poisoned, state_paralyzed, and stat_nuts
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	and	gs:party.status[bx], 0AEh
	jmp	l_return

l_cureStoned:
	; Clears stat_dead and stat_stoned if not stoned
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	test	gs:party.status[bx], stat_stoned
	jz	short l_stonedReturn
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	and	gs:party.status[bx], 0F3h
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
l_stonedReturn:
	jmp	l_return

l_curePossession:
	; Clears stat_possessed
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	test	gs:party.status[bx], stat_possessed
	jz	short l_curePossessionReturn
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	and	gs:party.status[bx], 0DFh
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
l_curePossessionReturn:
	jmp	l_return

l_cureDeath:
	; Clears stat_dead if dead
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead
	jz	short l_cureDeathReturn
	mov	ax, charSize
	imul	[bp+target]
	mov	bx, ax
	and	gs:party.status[bx], 0FBh
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
l_cureDeathReturn:
	jmp	short l_return

l_cureOld:
	; Clears stat_old if old
	mov	ax, charSize
	imul	[bp+target]
	mov	si, ax
	test	gs:party.status[si], stat_old
	jz	short l_cureOldReturn
	and	gs:party.status[si], 0FDh
	mov	ax, 5
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, party.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
l_cureOldReturn:
	jmp	short l_return

l_healall:
	; Clears stat_nuts, stat_paralyzed, stat_dead and stat_poisoned
	mov	ax, charSize
	imul	[bp+target]
	mov	si, ax
	and	gs:party.status[si], 0AAh
	mov	gs:party.hostileFlag[si], 0
	jmp	short l_return

	; Following two lines were unreachable. 
	;mov	byte ptr g_printPartyFlag,	0
	;jmp	short l_return
l_switchStatus:
	cmp	ax, 6
	ja	short l_return
	add	ax, ax
	xchg	ax, bx
	jmp	cs:statusJumpTable[bx]
statusJumpTable	dw offset l_return
		dw offset l_fleshrestore
		dw offset l_cureStoned
		dw offset l_curePossession
		dw offset l_cureDeath
		dw offset l_cureOld
		dw offset l_healall
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_doHeal	endp

; This function	does some standard cleanup after
; healing. If currentHP	is zero	then it	sets it
; to one like after a Beyond Death spell. It
; calms	summoned members and sets the attack priority
; for the round	to zero.
; Attributes: bp-based frame

_sp_postHeal proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.currentHP[bx], 0
	jnz	short l_notDead
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	mov	gs:party.currentHP[bx], 1
l_notDead:
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	mov	gs:party.hostileFlag[bx], 0
	mov	bx, [bp+partySlotNumber]
	mov	gs:charActionList[bx], 0
	mov	sp, bp
	pop	bp
	retf
_sp_postHeal endp


; Attributes: bp-based frame

sp_levitation proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	levitationDuration, al
	mov	ax, icon_levitation
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_levitation endp

; Attributes: bp-based frame

sp_summonSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+spellCaster]
	call	summon_execute
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
sp_summonSpell endp

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

	mov	word ptr [bp+var_16], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_16+2],	seg seg022
	cmp	inDungeonMaybe, 0
	jnz	short loc_20FCB
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr printSpellFizzled
	jmp	l_return
loc_20FCB:
	mov	g_sameSquareFlag, 0
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
	call	text_clear
	mov	ax, offset s_teleportMenu
	push	ds
	push	ax
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2], dx
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_C], ax
	mov	al, levFlags
	and	ax, 10h
	push	ax
	push	dx
	push	word ptr [bp+var_10]
	mov	ax, offset s_downUp
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2], dx
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
	push	cs
	call	near ptr _sp_teleportPrintNum
	add	sp, 4
	inc	gs:txt_numLines
	jmp	short loc_2106E
loc_210A1:
	sub	ax, ax
	push	ax
	call	getKey
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
	mov	ax, offset s_confirmTeleport
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_21136
	mov	ax, offset s_cancelTeleport
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
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
	jz	loc_211F3
loc_21168:
	mov	ax, offset s_successfulTeleport
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
	mov	ax, offset s_failedTeleport
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

	mov	sp, bp
	pop	bp
	push	si

	cmp	[bp+level], 0
	jl	short loc_2121E
	cmp	[bp+level], 7
	jle	short loc_21223
loc_2121E:
	sub	ax, ax
	jmp	loc_2136C
loc_21223:
	mov	word ptr [bp+var_E], offset g_rosterCharacterBuffer
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
	call	map_read
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
	call	itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2], dx
	cmp	[bp+arg_2], 0
	jz	short loc_213A8
	lfs	bx, [bp+var_24]
	inc	word ptr [bp+var_24]
	mov	byte ptr fs:[bx], '<'
loc_213A8:
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	mov	gs:g_currentCharPosition, 30h 
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	text_writeString
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
_sp_teleportPrintNum endp

; Attributes: bp-based frame
sp_farFoes proc	far

	stringBuf= word ptr	-58h
	loopCounter= word ptr	-8
	stringBufP= dword ptr	-6
	newDistance= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 5Ah
	call	someStackOperation

	push	[bp+spellCaster]
	push	cs
	call	near ptr spellSavingThrowHelper
	add	sp, 2
	or	ax, ax
	jz	l_return
	test	byte ptr [bp+spellCaster], 80h
	jz	short l_monCaster

	mov	[bp+loopCounter], 0
l_loopEnter:
	mov	ax, monStruSize
	imul	[bp+loopCounter]
	mov	bx, ax
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_notTooFar
	mov	[bp+newDistance], 9
l_notTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 4
	jl	short l_loopEnter
	jmp	short l_outputString
l_monCaster:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+loopCounter], ax
	mov	ax, monStruSize
	imul	[bp+loopCounter]
	mov	bx, ax
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+spellIndexNumber]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+newDistance], ax
	cmp	ax, 9
	jle	short l_partyNotTooFar
	mov	[bp+newDistance], 9
l_partyNotTooFar:
	push	[bp+newDistance]
	push	[bp+loopCounter]
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
l_outputString:
	mov	ax, offset s_andTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx

	mov	ax, offset s_fartherAway
	push	ds
	push	ax
	push	dx
	push	word ptr [bp+stringBufP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+stringBufP], ax
	mov	word ptr [bp+stringBufP+2], dx

	lea	ax, [bp+stringBuf]
	push	ss
	push	ax
	call	printString
	add	sp, 4
l_return:
	call	text_delayWithTable
	mov	sp, bp
	pop	bp
	retf
sp_farFoes endp

; Attributes: bp-based frame
_sp_setMonDistance proc	far

	monsterGroupIndex= word ptr	 6
	newDistance= byte ptr	 8

	push	bp
	mov	bp, sp
	push	si

	mov	ax, monStruSize
	imul	[bp+monsterGroupIndex]
	mov	si, ax
	cmp	byte ptr gs:monGroups._name[si], 0
	jz	short l_return
	mov	al, gs:monGroups.distance[si]
	and	al, 0F0h
	or	al, [bp+newDistance]
	mov	gs:monGroups.distance[si], al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_setMonDistance endp


; Attributes: bp-based frame

sp_vorpalPlating proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7Fh
	add	gs:vorpalPlateBonus[bx], al

	mov	sp, bp
	pop	bp
	retf
sp_vorpalPlating endp

; Attributes: bp-based frame

sp_areaEnchant proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	detectDuration, al
	mov	al, spellExtraFlags[bx]
	mov	g_detectType, al
	mov	ax, icon_areaEnchant
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_areaEnchant endp

; Attributes: bp-based frame

sp_shieldSpell proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	cmp	[bp+spellCaster], 80h
	jl	short l_partyCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellExtraFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
	jmp	short loc_215BE
l_partyCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	shieldDuration, al
	mov	al, spellExtraFlags[bx]
	mov	shieldAcBonus, al
	mov	ax, icon_shield
	push	ax
	call	icon_activate
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
loc_215BE:
	mov	sp, bp
	pop	bp
	retf
sp_shieldSpell endp

; Attributes: bp-based frame

sp_strengthBonus proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	test	byte ptr [bp+spellCaster], 80h
	jz	short l_partCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	mov	gs:monAttackBonus[bx], al
	jmp	short l_return
l_partCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7
	mov	gs:strengthBonus[bx], al
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_strengthBonus endp

; Attributes: bp-based frame
;
; XXX - Revisit

sp_phaseDoor proc far

	var_8= word ptr	-8
	var_6= dword ptr -6
	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation

	cmp	inDungeonMaybe, 0
	jz	loc_216E2
	push	sq_north
	push	sq_east
	call	dun_getWalls
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, g_direction
	dec	ax
	push	ax
	push	[bp+var_2]
	call	dungeon_getWallInDirection
	add	sp, 4
	mov	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	and	al, 0Fh
	cmp	al, 9
	jb	short loc_21671
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr printSpellFizzled
	jmp	short l_return
loc_21671:
	mov	gs:wallIsPhased, 1
	mov	bx, [bp+spellIndexNumber]
	cmp	spellEffectFlags[bx], 80h
	jb	short loc_216E0
	mov	bx, sq_north
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, sq_east
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	test	byte ptr g_direction, 2
	jz	short loc_216C8
	inc	word ptr [bp+var_6]
loc_216C8:
	test	byte ptr g_direction, 1
	jz	short loc_216D9
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0F0h
	jmp	short loc_216E0
loc_216D9:
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0Fh
loc_216E0:
	jmp	short l_return
loc_216E2:
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr printSpellFizzled
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_phaseDoor endp


; Attributes: bp-based frame
sp_acBonus proc	far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:partySpellAcBonus, al
	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+spellCaster]
	and	bx, 3
	sub	gs:g_monFreezeAcPenalty[bx], al
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_acBonus endp


; Attributes: bp-based frame

sp_disbelieve proc far

	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	or	gs:disbelieveFlags, al

	cmp	gs:disbelieveFlags, disb_disruptill
	jb	l_return

	mov	[bp+var_2], 0
l_loopEnter:
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	si, ax
	cmp	gs:(party.specAbil+3)[si], 0
	jz	short l_nextChar
	mov	ax, 0Ch
	push	ax
	mov	ax, offset s_dopplganger
	push	ds
	push	ax
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah
l_nextChar:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_loopEnter
	jmp	short l_return

l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	test	spellEffectFlags[bx], disb_nosummon
	jz	short l_monDisbelieve
	or	gs:disbelieveFlags, disb_nosummon
	jmp	short l_return
l_monDisbelieve:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:monDisbelieveFlag, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_disbelieve endp


; Attributes: bp-based frame

; XXX - Not low hanging fruit
; DWORD - var_114 & var_116
; UNUSED - var_A & var_C

sp_scrySight proc far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	var_116= word ptr -116h
	var_114= word ptr -114h
	var_112= word ptr -112h
	var_110= dword ptr -110h
	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 11Ah
	call	someStackOperation
	push	si

	mov	[bp+var_6], 0
	mov	word ptr [bp+var_110], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_110+2], seg seg022
	lfs	bx, [bp+var_110]
	mov	al, fs:(g_rosterCharacterBuffer+11h)[bx]
	sub	ah, ah
	mov	[bp+var_118], ax
	mov	ax, offset s_youFace
	push	ds
	push	ax
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	push	word ptr (dirStringList+2)[bx]
	push	word ptr dirStringList[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_118], 0
	jz	loc_218D5
loc_21840:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	mov	ax, offset s_andAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_118]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_118]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset s_levels
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	al, levFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	mov	ax, offset s_aboveBelow
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_218D5:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, sq_north
	mov	[bp+var_2], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47EDC[bx]
	cbw
	mov	cx, [bp+var_2]
	sub	cx, ax
	mov	[bp+var_11A], cx
	or	cx, cx
	jz	loc_219BD
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset s_andAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jl	short loc_21945
	mov	ax, [bp+var_11A]
	jmp	short loc_2194B
loc_21945:
	mov	ax, [bp+var_11A]
	neg	ax
loc_2194B:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset s_paces
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jge	short loc_2199D
	mov	ax, 1
	jmp	short loc_2199F
loc_2199D:
	sub	ax, ax
loc_2199F:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset s_northSouth
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_219BD:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, sq_east
	mov	[bp+var_8], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47F1A[bx]
	cbw
	mov	cx, [bp+var_8]
	sub	cx, ax
	mov	[bp+var_4], cx
	or	cx, cx
	jnz	short loc_219F4
	jmp	loc_21AA0
loc_219F4:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset s_andAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jl	short loc_21A2A
	mov	ax, [bp+var_4]
	jmp	short loc_21A2F
loc_21A2A:
	mov	ax, [bp+var_4]
	neg	ax
loc_21A2F:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset s_paces
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jge	short loc_21A80
	mov	ax, 1
	jmp	short loc_21A82
loc_21A80:
	sub	ax, ax
loc_21A82:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset s_eastWest
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_21AA0:
	cmp	[bp+var_6], 0
	jz	short loc_21AAB
	mov	ax, offset s_of
	jmp	short loc_21AAE
loc_21AAB:
	mov	ax, offset s_andAreAt
loc_21AAE:
	mov	[bp+var_C], ax
	mov	[bp+var_A], ds
	push	ds
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	si, [bp+var_118]
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+si+12h]
	sub	ah, ah
	mov	[bp+var_112], ax
	mov	bx, ax
	mov	al, byte_47F58[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (scryBaseStringList+2)[bx]
	push	word ptr scryBaseStringList[bx]
	push	dx
	push	[bp+var_116]
	call	strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2

	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_scrySight endp

; Attributes: bp-based frame

sp_antiMagic proc far

	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:antiMagicFlag, al
	mov	sp, bp
	pop	bp
	retf
sp_antiMagic endp

; Attributes: bp-based frame

sp_wordOfFear proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	push	si

	push	[bp+spellCaster]
	push	cs
	call	near ptr spellSavingThrowHelper
	add	sp, 2
	or	ax, ax
	jz	short l_return
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	si, 3
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:monSpellToHitPenalty[si], al
	mov	bx, [bp+spellIndexNumber]

	; byte_41E50 isn't used anywhere else
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E50[si], al

	jmp	short l_return
l_monCaster:
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_42567, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_wordOfFear endp


; Attributes: bp-based frame

sp_spellbind proc far

	partySlotNumber= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	sub	ax, ax
	push	ax
	push	[bp+spellCaster]
	or	ax, ax
	jz	l_printNoEffect

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster

	; Set hostile flag to 0 when cast by party
	sub	al, al
	jmp	short l_setHostileFlag
l_monCaster:
	; Set hostfile flag to 1 when cast by enemy
	mov	al, 1
l_setHostileFlag:
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	mov	gs:party.hostileFlag[bx], cl
	jmp	short l_return
l_monTarget:
	call	party_findEmptySlot
	mov	[bp+partySlotNumber], ax
	cmp	ax, 7
	jge	short l_printNoEffect
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, 30h	
	mul	cx
	mov	si, ax
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short l_printNoEffect

	test	gs:monGroups.flags[si],	10h
	jz	short l_printNoEffect

	dec	gs:monGroups.groupSize[si]
	lea	ax, monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_return
l_printNoEffect:
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr printNoEffect
	add	sp, 4
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_spellbind endp

; This function	takes the data from the	mon_t data
; type and converts it to the summonStat_t data	type.
; Attributes: bp-based frame

_sp_convertMonToSummon proc far

	partySlotP=	dword ptr -1Ah
	counter= word ptr -16h
	var_14=	word ptr -14h
	singularName= dword ptr -4
	partySlotNumber= word ptr	 6
	monBufferP= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 1Ah
	call	someStackOperation
	push	si

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	add	ax, offset party
	mov	word ptr [bp+partySlotP], ax
	mov	word ptr [bp+partySlotP+2],	seg seg027
	mov	ax, charSize
	push	ax
	sub	ax, ax
	push	ax
	push	word ptr [bp+partySlotP+2]
	push	word ptr [bp+partySlotP]
	call	memset
	add	sp, 8
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	word ptr [bp+monBufferP+2]
	push	word ptr [bp+monBufferP]
	call	unmaskString
	add	sp, 8
	sub	ax, ax
	push	ax
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+singularName], ax
	mov	word ptr [bp+singularName+2], dx
	lfs	bx, [bp+singularName]
	mov	byte ptr fs:[bx], 0
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathSaveLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathSaveLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathSaveHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathSaveHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.oppPriorityLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.priorityLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.oppPriorityHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.priorityHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.picIndex]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.picIndex], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathFlag]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathFlag], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.breathRange]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.breathRange], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.toHitLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.toHitLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.toHitHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.toHitHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.spellSaveLo]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.spellSaveLo], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.spellSaveHi]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.spellSaveHi], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.strongElement]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.strongElement], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.weakElement]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.weakElement], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.repelFlags]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.repelFlags], al
	mov	[bp+counter], 0
l_attackLoopEnter:
	mov	si, [bp+counter]
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+si+mon_t.attackType._type]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+si+summonStat_t.attacks._type], al
	inc	[bp+counter]
	cmp	[bp+counter], 8
	jl	short l_attackLoopExit
	jmp	short l_attackLoopEnter
l_attackLoopExit:
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.packedGenAc]
	and	al, 3Fh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.acBase], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.packedGenAc]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.pronoun], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	mov	cl, 5
	shr	ax, cl
	and	al, 7
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.numAttacks], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 0Fh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.field_5E], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.field_5F], al
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	inc	cx
	add	cl, 0Dh
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.class], cl
	lfs	bx, [bp+monBufferP]
	mov	al, fs:[bx+mon_t.hpDice]
	sub	ah, ah
	push	ax
	call	dice_doYDX
	add	sp, 2
	lfs	bx, [bp+monBufferP]
	mov	cx, fs:[bx+mon_t.hpBase]
	add	cx, ax
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+summonStat_t.curHP], cx
	lfs	bx, [bp+partySlotP]
	mov	ax, fs:[bx+summonStat_t.curHP]
	mov	fs:[bx+summonStat_t.maxHP], ax
	mov	[bp+counter], 0
l_questFlagLoopEnter:
	mov	si, [bp+counter]
	lfs	bx, [bp+partySlotP]
	mov	fs:[bx+si+summonStat_t.chronoQuest], 0FFh
	inc	[bp+counter]
	cmp	[bp+counter], 6
	jl	short l_questFlagLoopEnter

	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_convertMonToSummon endp


; Attributes: bp-based frame
sp_haltFoe proc	far

	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp

	push	[bp+spellCaster]
	push	cs
	call	near ptr spellSavingThrowHelper
	add	sp, 2
	or	ax, ax
	jz	short l_return
	cmp	[bp+spellCaster], 80h
	jge	short l_monCaster
	inc	gs:monFrozenFlag
	jmp	short l_return
l_monCaster:
	inc	gs:partyFrozenFlag
	mov	ax, offset s_partyFreezes
	push	ds
	push	ax
	call	printString
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_haltFoe endp

; Attributes: bp-based frame

; DWORD - var_2 & var_4

sp_meleeMen proc far

	stringBuffer=	word ptr -56h
	var_4= word ptr	-4
	var_2= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 56h
	call	someStackOperation

	push	[bp+spellCaster]
	push	cs
	call	near ptr spellSavingThrowHelper
	add	sp, 2
	or	ax, ax
	jz	short l_return

	test	byte ptr [bp+spellCaster], 80h
	jz	short l_partyCaster
	mov	ax, 1
	push	ax
	mov	ax, [bp+spellCaster]
	and	ax, 3
	push	ax
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
	jmp	short l_printMessage
l_partyCaster:
	mov	ax, 1
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	push	ax
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
l_printMessage:
	mov	ax, offset s_andTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset s_closer
	push	ds
	push	ax
	push	ax
	push	dx
	push	[bp+var_4]
	call	strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_meleeMen endp

; Attributes: bp-based frame

sp_batchspell proc far

	batchListIndex= word ptr	-4
	var_2= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+batchListIndex], ax
l_loopEnter:
	mov	bx, [bp+batchListIndex]
	inc	[bp+batchListIndex]
	mov	al, batchSpellList[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short l_return
	push	ax
	push	[bp+spellCaster]
	push	cs
	call	near ptr _batchSpellCast
	add	sp, 4
	jmp	short l_loopEnter
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_batchspell endp

; Attributes: bp-based frame

sp_camaraderie proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEnter:
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	cmp	gs:party.hostileFlag[bx], 0
	jz	short l_loopNext
	call	random
	and	al, 1
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	mov	gs:party.hostileFlag[bx], cl
l_loopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEnter
	mov	sp, bp
	pop	bp
	retf
sp_camaraderie endp

printSpellFizzled proc far
	push	bp
	mov	bp, sp

	mov	ax, offset s_butItFizzled
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printSpellFizzled endp

; Attributes: bp-based frame

sp_luckSpell proc far

	spellCaster= word ptr	 6
	spelIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	bx, [bp+spelIndexNumber]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E70, al
	push	bx
	push	[bp+spellCaster]
	push	cs
	call	near ptr sp_antiMagic
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sp_luckSpell endp

; Attributes: bp-based frame

sp_identifySpell proc far

	var_F4=	word ptr -0F4h
	var_34=	word ptr -34h
	var_32=	word ptr -32h
	var_2= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F4h
	call	someStackOperation

	call	text_clear
	and	[bp+spellCaster], 7Fh
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	lea	ax, [bp+var_F4]
	push	ss
	push	ax
	push	[bp+spellCaster]
	call	sub_188E8
	add	sp, 0Ah
	mov	[bp+var_34], ax
	or	ax, ax
	jnz	short loc_22080
	mov	ax, offset s_pocketsAreEmpty
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	[bp+var_2], 0FFFFh
	jmp	short loc_22098
loc_22080:
	push	[bp+var_34]
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	mov	ax, offset s_whichItem
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_2], ax
loc_22098:
	cmp	[bp+var_2], 0
	jge	short loc_220AD
	mov	ax, offset s_spellAborted
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_return
loc_220AD:
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, [bp+var_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	byte ptr gs:[bx+62h], 3Fh
	mov	ax, offset s_itemIdentified
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_identifySpell endp


; Attributes: bp-based frame

; DWORD var_104 & var_106

sp_earthMaw proc far

	loopCounter= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si

	mov	ax, offset s_earthSwallows
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx

	cmp	gs:bat_curTarget, 80h
	jnb	short l_monTarget

	; Kill all party members
	mov	[bp+loopCounter], 0
l_partyLoopEnter:
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	si, ax
	or	gs:party.status[si], stat_dead
	mov	gs:party.currentHP[si], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_partyLoopEnter

	call	endNoncombatSong
	mov	ax, offset s_theParty
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	jmp	l_return

l_monTarget:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	ax, 3
	mov	cx, monStruSize
	imul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Eh
	dec	ax
	push	ax
	push	si
	push	[bp+var_104]
	push	[bp+var_106]
	push	cs
	call	near ptr strcatTargetName
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_102], ax
	mov	ax, monStruSize
	imul	[bp+var_102]
	mov	bx, ax
	and	gs:monGroups.groupSize[bx], 0E0h
	mov	[bp+loopCounter], 0
l_monLoopEnter:
	jge	short l_return
	mov	bx, [bp+var_102]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+loopCounter]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 32
	jl	short l_monLoopEnter
l_return:
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_earthMaw endp

; Attributes: bp-based frame

printNoEffect proc far
	push	bp
	mov	bp, sp

	mov	ax, offset s_butItHadNoEffect
	push	ds
	push	ax
	call	printString
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
printNoEffect endp

; Attributes: bp-based frame

sp_divineIntervention proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+loopCounter], 0
l_loopEnter:
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	cmp	gs:party.class[bx], class_illusion
	jnz	short l_notIllusion

	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	mov	gs:party.class[bx], class_monster
l_notIllusion:
	mov	ax, charSize
	imul	[bp+loopCounter]
	mov	bx, ax
	and	gs:party.status[bx], stat_old or stat_unknown
	mov	ax, gs:party.maxHP[bx]
	mov	gs:party.currentHP[bx], ax
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loopEnter
	cmp	gs:byte_422A4, 0
	jz	short l_return
	mov	al, 14h
	mov	gs:byte_42440, al
	mov	gs:byte_41E70, al
	mov	gs:antiMagicFlag, al
	mov	gs:partySpellAcBonus, al
	mov	gs:songExtraAttack, 8
	mov	gs:bat_curTarget, 80h
	mov	ax, 0CEh 
	push	ax
	push	[bp+spellCaster]
	push	cs
	call	near ptr _batchSpellCast
	add	sp, 4
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_divineIntervention endp

; Attributes: bp-based frame

spGeo_removeTrap proc far

	squareP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	and	byte ptr fs:[bx], 0EFh

	mov	sp, bp
	pop	bp
	retf
spGeo_removeTrap endp

dun_maskSquare proc far

	squareP=	dword ptr -4
	row=	word ptr 6
	column=	word ptr 8
	_byte=	word ptr 0Ah
	_mask=  byte ptr 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, [bp+_byte]
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	mov	al, [bp+_mask]
	lfs	bx, [bp+squareP]
	and	byte ptr fs:[bx], al

	mov	sp, bp
	pop	bp
	retf
dun_maskSquare endp

; Attributes: bp-based frame

spGeo_revealSquare proc far

	squareP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 4
	mov	word ptr [bp+squareP], ax
	mov	word ptr [bp+squareP+2], dx
	lfs	bx, [bp+squareP]
	or	byte ptr fs:[bx], 1

	mov	sp, bp
	pop	bp
	retf
spGeo_revealSquare endp

; Attributes: bp-based frame
dun_revealSpSquare proc	far

	sqP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8
	geoSpMaskIndex= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	push	si
	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+sqP], ax
	mov	word ptr [bp+sqP+2], dx
	mov	bx, [bp+geoSpMaskIndex]
	mov	bl, geoSpMasks[bx-2]._byte
	sub	bh, bh
	lfs	si, [bp+sqP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+geoSpMaskIndex]
	mov	cl, geoSpMasks[bx-2].bitmask
	sub	ch, ch
	test	ax, cx
	jz	short l_nextSquare
	mov	bx, si
	or	byte ptr fs:[bx+4], 4
	jmp	short l_return
l_nextSquare:
	lfs	bx, [bp+sqP]
	and	byte ptr fs:[bx+4], 0FBh
l_return:
	pop	si

	mov	sp, bp
	pop	bp
	retf
dun_revealSpSquare endp

; Attributes: bp-based frame

sp_geomancerSpell proc far

	row= word ptr -8
	var_6= word ptr	-6
	geoSpellNumber= word ptr	-4
	column=	word ptr -2
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation

	cmp	inDungeonMaybe, 0
	jz	short l_return
	mov	bx, [bp+spellIndexNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	sar	ax, 1
	mov	[bp+geoSpellNumber], ax
	mov	[bp+row], 0
	jmp	short loc_223DB
loc_223D8:
	inc	[bp+row]
loc_223DB:
	mov	al, g_dunHeight
	sub	ah, ah
	cmp	ax, [bp+row]
	jbe	short l_return
	mov	[bp+column], 0
	jmp	short loc_223F4
loc_223F1:
	inc	[bp+column]
loc_223F4:
	mov	al, g_dunWidth
	sub	ah, ah
	cmp	ax, [bp+column]
	jbe	short loc_2241C
	push	[bp+var_6]
	push	[bp+column]
	push	[bp+row]
	mov	bx, [bp+geoSpellNumber]
	shl	bx, 1
	shl	bx, 1
	call	geoSpList[bx]
	add	sp, 6
	jmp	short loc_223F1
loc_2241C:
	jmp	short loc_223D8

l_return:
	mov	sp, bp
	pop	bp
	retf
sp_geomancerSpell endp


; Attributes: bp-based frame

_sp_useLightObj	proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	mov	ax, offset s_makesLight
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	call	sp_lightSpell
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
_sp_useLightObj	endp

; Attributes: bp-based frame

_sp_useAcorn proc far

	spellCaster= byte ptr	 6

	push	bp
	mov	bp, sp

	mov	ax, offset s_ateIt
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	al, [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	word ptr [bp+spellCaster]
	call	_batchSpellCast
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_sp_useAcorn endp


; Attributes: bp-based frame

; DWORD - var_102 & var_104

_sp_useWineskin	proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 106h
	call	someStackOperation
	push	si

	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	shr	ax, 1
	shr	ax, 1
	and	ax, 7
	mov	[bp+var_106], ax
	mov	ax, offset s_drinksAndFeels
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, [bp+var_106]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drinkStringList+2)[bx]
	push	word ptr drinkStringList[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	cmp	[bp+var_106], 1
	jnz	short loc_2252F

	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	si, ax
	cmp	gs:party.class[si], class_bard
	jnz	short loc_2252F
	push	gs:party.level[si]
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	mov	gs:party.specAbil[si],	al
	jmp	short l_return
loc_2252F:
	mov	al, byte ptr [bp+spellCaster]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	[bp+spellCaster]
	push	cs
	call	near ptr _batchSpellCast
	add	sp, 4
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_useWineskin	endp

; Attributes: bp-based frame

printCantFindUse proc far
	push	bp
	mov	bp, sp

	mov	ax, offset s_cantFindUse
	push	ds
	push	ax
	call	printString
	add	sp, 4

	mov	sp, bp
	pop	bp
	retf
printCantFindUse endp


; Attributes: bp-based frame

; UNUSED - var_2 & var_4

_sp_useWeapon proc far

	var_10=	word ptr -10h
	var_E= byte ptr	-0Eh
	var_D= byte ptr	-0Dh
	var_C= byte ptr	-0Ch
	var_B= byte ptr	-0Bh
	var_A= byte ptr	-0Ah
	var_9= byte ptr	-9
	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	spellCaster=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	push	di
	push	si

	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	mov	[bp+var_6], ax
	mov	[bp+var_10], 31
	jmp	short loc_2259F
loc_2259C:
	dec	[bp+var_10]
loc_2259F:
	cmp	[bp+var_10], 0
	jge	short loc_225A8
	jmp	loc_22632
loc_225A8:
	mov	bx, [bp+var_10]
	mov	al, byte_48382[bx]
	sub	ah, ah
	cmp	ax, [bp+var_6]
	jnz	short loc_2262F
	cmp	bx, 17h
	jge	short loc_225C0
	mov	ax, offset s_castsWeapon
	jmp	short loc_225C3
loc_225C0:
	mov	ax, offset s_breathes
loc_225C3:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+var_10]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	si, ax
	mov	al, byte ptr weaponDamageList.effectStrIndex[si]
	mov	[bp+var_E], al
	mov	al, weaponDamageList.elements[si]
	mov	[bp+var_D], al
	mov	[bp+var_C], 10h
	mov	[bp+var_B], 0
	mov	al, weaponDamageList.repelFlags[si]
	mov	[bp+var_A], al
	mov	al, weaponDamageList.damage[si]
	mov	[bp+var_9], al
	mov	al, weaponDamageList.targetFlags[si]
	mov	[bp+var_8], al
	mov	al, weaponDamageList.levelMult[si]
	sub	ah, ah
	push	ax
	sub	sp, 8
	push	si
	lea	si, [bp+var_E]
	mov	di, sp
	add	di, 2
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	pop	si
	push	[bp+spellCaster]
	push	cs
	call	near ptr bat_doBreathAttack
	add	sp, 0Ch
loc_2262F:
	jmp	loc_2259C
loc_22632:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
_sp_useWeapon endp

; Attributes: bp-based frame
_sp_reenergizeMage proc	far

	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	push	si

	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	si, ax
	mov	ax, gs:party.maxSppt[si]
	mov	gs:party.currentSppt[si], ax
	mov	ax, offset s_isReenergized
	push	ds
	push	ax
	call	printString
	add	sp, 4

	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_reenergizeMage endp

; Attributes: bp-based frame

_sp_useFigurine	proc far

	loopCounter= word ptr -4
	itemNo=	word ptr -2
	spellCaster=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	ax, offset s_invokesFigurine
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	mov	[bp+itemNo], ax

	mov	[bp+loopCounter], 8
l_loopEnter:
	mov	bx, [bp+loopCounter]
	mov	al, figurineItemNo[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNo]
	jnz	short l_loopEnter
	mov	al, byte_483AC[bx]
	push	ax
	push	[bp+spellCaster]
	call	summon_execute
	add	sp, 4
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	l_loopEnter

	mov	sp, bp
	pop	bp
	retf
_sp_useFigurine	endp

; Attributes: bp-based frame

rnd_Xd4	proc far

	rval= word ptr -2
	numOfDice= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+rval], 0
l_loopEnter:
	call	random
	and	ax, 3
	inc	ax
	add	[bp+rval], ax
	dec	[bp+numOfDice]
	cmp	[bp+numOfDice],	0
	jg	short l_loopEnter
	mov	ax, [bp+rval]

	mov	sp, bp
	pop	bp
	retf
rnd_Xd4	endp

; Attributes: bp-based frame
bat_isPartyInRange proc	far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	source=	word ptr  6
	range= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation

	; Return success if party attack
	cmp	gs:bat_curTarget, 80h
	jnb	short l_notPartyAttack
	cmp	[bp+source], 80h
	jl	l_returnOne

l_notPartyAttack:
	test	byte ptr [bp+range], 80h
	jz	short loc_22744
	mov	ax, [bp+range]
	and	ax, 7Fh
	mov	[bp+var_8], ax
	shl	ax, 1
	mov	[bp+var_2], ax
	jmp	short loc_2274F
loc_22744:
	mov	ax, [bp+range]
	mov	[bp+var_8], ax
	mov	[bp+var_2], 0

loc_2274F:
	cmp	gs:bat_curTarget, 80h
	jb	short l_monSource
	mov	al, gs:bat_curTarget
	sub	ah, ah
	jmp	short l_checkDistance
l_monSource:
	mov	ax, [bp+source]
l_checkDistance:
	mov	[bp+var_6], ax
	and	ax, 3
	mov	cx, monStruSize
	imul	cx
	mov	bx, ax
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_4], ax
	mov	ax, [bp+var_8]
	cmp	[bp+var_4], ax
	jle	l_returnOne

	mov	ax, [bp+var_2]
	cmp	[bp+var_4], ax
	jg	short loc_returnZero
	mov	ax, 2
	jmp	short l_return 
loc_returnZero:
	sub	ax, ax
	jmp	l_return
l_returnOne:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
bat_isPartyInRange endp

; Attributes: bp-based frame
spell_cast proc	far

	partySlotNumber=	word ptr  6
	spellNo= word ptr  8
	itemUsedFlag= word ptr	 0Ah

	push	bp
	mov	bp, sp

	cmp	[bp+itemUsedFlag], 0
	jnz	short l_notMapSpell

	; Spell is from an item. Pass the spell through vm_execute to
	; see if it triggers a map function.
	mov	ax, [bp+spellNo]
	mov	g_curSpellNumber, ax
	mov	ax, 1
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	call	vm_execute
	add	sp, 6
	or	ax, ax
	jnz	l_return

l_notMapSpell:
	cmp	[bp+itemUsedFlag], 0
	jz	short l_combatCheck

	; I think this checks for spells that shouldn't be able
	; to be cast from items
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], spellcast_spellOnly
	jz	l_returnZero
	jmp	short l_callSpellFunction

l_combatCheck:
	mov	bx, [bp+spellNo]
	test	spellCastFlags[bx], spellcast_combatOnly
	jz	l_returnZero

l_callSpellFunction:
	push	[bp+spellNo]
	push	[bp+partySlotNumber]
	mov	bx, [bp+spellNo]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	jmp	l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
spell_cast endp

; Attributes: bp-based frame

; byte_4EEC3 and byte_4EEC4 don't seem to be
; used for anything.

_batchSpellCast proc far

	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp

	and	[bp+spellIndexNumber], 7Fh
	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	mov	bx, [bp+spellIndexNumber]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_batchSpellCast endp


; Attributes: bp-based frame

_sp_checkSPPT proc far

	requiredSppt= word ptr	-2
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	cmp	[bp+spellCaster], 80h
	jge	short l_returnOne

	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	push	cs
	call	near ptr getSpptRequired
	add	sp, 4
	mov	[bp+requiredSppt], ax
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	cmp	gs:party.currentSppt[bx], cx
	jb	short l_returnZero

	mov	ax, [bp+requiredSppt]
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+spellCaster]
	mov	bx, ax
	sub	gs:party.currentSppt[bx], cx
l_returnOne:
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
_sp_checkSPPT endp

; Attributes: bp-based frame

strcatTargetName proc far

	monName=	word ptr -10h
	destString= dword ptr  6
	targetIndexNumber= word ptr	 0Ah
	targetCount= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation

	cmp	[bp+targetIndexNumber], 80h
	jge	short l_monTarget
	mov	ax, charSize
	imul	[bp+targetIndexNumber]
	mov	bx, ax
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+destString+2]
	push	word ptr [bp+destString]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+destString], ax
	mov	word ptr [bp+destString+2], dx
	jmp	l_return

l_monTarget:
	and	[bp+targetIndexNumber], 3
	lea	ax, [bp+monName]
	push	ss
	push	ax
	mov	ax, monStruSize
	imul	[bp+targetIndexNumber]
	mov	bx, ax
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8

	cmp	[bp+targetCount], 0
	jz	short l_monSingular
	mov	ax, offset s_some
	push	ds
	push	ax
	call	strcat
	add	sp, 8
	mov	word ptr [bp+destString], ax
	mov	word ptr [bp+destString+2], dx
	jmp	short l_pluralize

l_monSingular:
	lfs	bx, dword ptr [bp+destString]
	inc	word ptr [bp+destString]
	mov	byte ptr fs:[bx], 'a'
	mov	al, byte ptr [bp+monName]
	cbw
	push	ax
	call	str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short l_appendSpace
	lfs	bx, dword ptr [bp+destString]
	inc	word ptr [bp+destString]
	mov	byte ptr fs:[bx], 'n'

l_appendSpace:
	lfs	bx, dword ptr [bp+destString]
	inc	word ptr [bp+destString]
	mov	byte ptr fs:[bx], ' '

l_pluralize:
	push	[bp+targetCount]
	push	word ptr [bp+destString+2]
	push	word ptr [bp+destString]
	lea	ax, [bp+monName]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+destString], ax
	mov	word ptr [bp+destString+2], dx
l_return:
	mov	ax, word ptr [bp+destString]
	mov	dx, word ptr [bp+destString+2]

	mov	sp, bp
	pop	bp
	retf
strcatTargetName endp


seg010 ends

; Segment type: Pure code
seg011 segment word public 'CODE' use16
        assume cs:seg011
;org 1
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
algn_229C1:
align 2

; Attributes: bp-based frame

song_singNonCombat	proc far

	partySlotNumber= word ptr	-6
	subtractor= word ptr	-4
	songNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	call	text_clear
	mov	ax, offset s_whoWillPlay
	push	ds
	push	ax
	call	printString
	add	sp, 4

	call	readSlotNumber
	mov	[bp+partySlotNumber], ax
	or	ax, ax
	jl	short l_return

	push	ax
	push	cs
	call	near ptr sing_getSongSubtractor
	add	sp, 2
	mov	[bp+subtractor], ax

	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _canSingSong
	add	sp, 2
	or	ax, ax
	jz	short l_waitAndReturn

	cmp	[bp+subtractor], 0
	jl	short l_waitAndReturn

	call	text_clear
	sub	ax, ax
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr song_getSong
	add	sp, 4
	mov	[bp+songNumber], ax
	or	ax, ax
	jl	short l_waitAndReturn

	; End currently playing song
	push	cs
	call	near ptr endNoncombatSong

	push	[bp+songNumber]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr song_playSong
	add	sp, 4

	push	cs
	call	near ptr song_doNoncombatEffect
	mov	al, byte ptr [bp+subtractor]
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	sub	gs:party.specAbil[bx],	cl
l_waitAndReturn:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
	call	text_clear
	mov	sp, bp
	pop	bp
	retf
song_singNonCombat	endp

; Attributes: bp-based frame

_canSingSong proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	test	gs:party.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_bard
	jz	short l_checkInstrument
	mov	ax, offset s_notBard
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_returnZero

l_checkInstrument:
	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_noInstrument

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.specAbil[bx],	0
	jnz	l_returnOne
	mov	ax, offset s_dryThroat
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_returnZero

l_noInstrument:
	mov	ax, offset s_notUsingInstrument
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

l_returnZero:
	sub	ax, ax
	jmp	l_return

l_returnOne:
	mov	ax, 1

l_return:
	mov	sp, bp
	pop	bp
	retf
_canSingSong endp


; This function	returns	1 if the character is active,
; a bard and has an instrument equipped. 0 otherwise.
; Attributes: bp-based frame

_charCanPlaySong proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	push	si

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax

	test	gs:party.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short l_returnZero

	cmp	gs:party.class[si], class_bard
	jnz	short l_returnZero

	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	call	inven_hasTypeEquipped
	add	sp, 4
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_charCanPlaySong endp


; This function	returns	the amount of songs that
; should be subtracted from the	bards songsLeft
; field. If an item with itemEff_freeSinging is
; equipped, return 0. If the bard has songs left,
; return 1. Otherwise return -1.
; Attributes: bp-based frame

sing_getSongSubtractor proc far

	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp

	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+partySlotNumber]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_returnZero

	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	cmp	gs:party.specAbil[bx],	0
	jz	short l_returnMinusOne
	mov	ax, 1
	jmp	short l_return

l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
sing_getSongSubtractor endp

; Attributes: bp-based frame

song_getSong proc far

	var_22C= word ptr -22Ch
	var_72=	word ptr -72h
	songListString=	word ptr -34h
	counter= word ptr -1Ch
	songListStringP= dword ptr -1Ah
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	optionLetters=	word ptr -10h
	partySlotNumber=	word ptr  6
	songPlayingFlag= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 34h
	call	someStackOperation
	push	si

	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+var_16], ax
	mov	[bp+counter], ax
l_loopEnter:
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	bx, ax
	mov	al, gs:(party.specAbil+1)[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	lea	ax, [bp+songListString]
	mov	word ptr [bp+songListStringP], ax
	mov	word ptr [bp+songListStringP+2], ss

	mov	si, [bp+var_16]
	shl	si, 1
	mov	ax, bx
	mov	[bp+si+optionLetters],	ax
	lfs	bx, [bp+songListStringP]
	inc	word ptr [bp+songListStringP]
	mov	ax, [bp+var_16]
	inc	[bp+var_16]
	add	al, '1'
	mov	fs:[bx], al

	lfs	bx, [bp+songListStringP]
	inc	word ptr [bp+songListStringP]
	mov	byte ptr fs:[bx], ')'
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (songNames+2)[bx]
	push	word ptr songNames[bx]
	push	word ptr [bp+songListStringP+2]
	push	word ptr [bp+songListStringP]
	call	strcat
	add	sp, 8
	mov	word ptr [bp+songListStringP], ax
	mov	word ptr [bp+songListStringP+2], dx
	lea	ax, [bp+songListString]
	push	ss
	push	ax
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_12], ax
l_next:
	inc	[bp+counter]
	cmp	[bp+counter], 8
	jge	l_loopEnter

	mov	ax, bitMask16bit+16h
	or	[bp+var_12], ax
	cmp	[bp+songPlayingFlag], 0
	jz	short l_getUserInput
	mov	ax, offset s_stopPlayingSong
	push	ds
	push	ax
	call	printString
	add	sp, 4
l_getUserInput:
	push	[bp+var_12]
	call	getKey
	add	sp, 2
	mov	[bp+var_14], ax
	cmp	ax, 1Bh
	jz	short loc_22C76
	cmp	ax, 119h
	jnz	short loc_22C7B
loc_22C76:
	mov	ax, 0FFFFh
	jmp	short l_return
loc_22C7B:
	cmp	[bp+songPlayingFlag], 0
	jz	short loc_22C96
	cmp	[bp+var_14], 'S'
	jnz	short loc_22C96
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr song_stopPlaying
	add	sp, 2
	mov	ax, 0FFFFh
	jmp	short l_return
loc_22C96:
	cmp	[bp+var_14], 10Eh
	jl	short loc_22CB3
	mov	ax, [bp+var_16]
	add	ax, 10Eh
	cmp	ax, [bp+var_14]
	jl	short loc_22CB3
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_22C]
	jmp	short l_return
loc_22CB3:
	cmp	[bp+var_14], '0'
	jle	short l_badInput
	mov	ax, [bp+var_16]
	add	ax, '0'
	cmp	ax, [bp+var_14]
	jl	short l_badInput
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_72]
	jmp	short l_return
l_badInput:
	jmp	short l_getUserInput
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
song_getSong endp


; Attributes: bp-based frame

song_playSong proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber= word ptr	 6
	songNumber= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	al, byte ptr [bp+partySlotNumber]
	mov	gs:g_currentSinger, al
	mov	g_songDuration, 5
	mov	al, [bp+songNumber]
	inc	al
	mov	gs:g_currentSongPlusOne, al
	mov	al, [bp+songNumber]
	mov	gs:g_currentSong, al
	call	song_endMusic

	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	mov	bx, word ptr [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	push	gs:musicBufs._segment[bx]
	push	word ptr gs:musicBufs._offset[bx]
	call	d3comp
	add	sp, 8

	mov	ax, itType_instrument
	push	ax
	push	[bp+partySlotNumber]
	call	inven_getTypeEqSlot
	add	sp, 4
	mov	[bp+var_4], ax
	inc	ax
	jz	short loc_22D59
	mov	bx, [bp+var_4]
	mov	al, g_instrumentType[bx]
	cbw
	mov	[bp+var_2], ax
	jmp	short loc_22D5E
loc_22D59:
	mov	[bp+var_2], 0
loc_22D5E:
	push	[bp+var_2]
	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	call	song_initSound
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
song_playSong endp


; Attributes: bp-based frame

song_stopPlaying proc far

	partySlotNumber= word ptr	 6

	push	bp
	mov	bp, sp

	mov	al, gs:g_currentSinger
	sub	ah, ah
	cmp	ax, [bp+partySlotNumber]
	jnz	short l_return			; Not the current singer
	cmp	gs:g_currentSongPlusOne, ah
	jz	short l_return			; No song playing
	push	cs
	call	near ptr endNoncombatSong
l_return:
	mov	sp, bp
	pop	bp
	retf
song_stopPlaying endp


; Attributes: bp-based frame

endNoncombatSong proc far
	push	bp
	mov	bp, sp

	push	cs
	call	near ptr song_endNoncombatEffect
	call	song_endMusic
	mov	sp, bp
	pop	bp
	retf
endNoncombatSong endp


; Attributes: bp-based frame

song_doNoncombatEffect proc far
	push	bp
	mov	bp, sp

	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	l_songSwitch
l_safety:
	mov	gs:songAntiMonster, 1
	jmp	l_return
l_sanctuary:
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	cmp	gs:party.level[bx], 60
	jnb	short l_maxFifteen
	mov	al, charSize
	mul	gs:g_currentSinger
	mov	bx, ax
	mov	ax, gs:party.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short l_setBonus
l_maxFifteen:
	mov	al, 15
l_setBonus:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short l_setBonusIfZero
	inc	gs:songACBonus
l_setBonusIfZero:
	mov	byte ptr g_printPartyFlag,	0
	jmp	l_return
l_duotime:
	mov	gs:songRegenSppt, 1
	jmp	l_return
l_watchwood:
	mov	lightDistance, 5
	mov	lightDuration, 0FFh
	mov	gs:gl_detectSecretDoorFlag, 0FFh
	sub	ax, ax
	push	ax
	call	icon_activate
	add	sp, 2
	jmp	short l_return
l_overture:
	mov	compassDuration, 0FFh
	mov	ax, 1
	push	ax
	call	icon_activate
	add	sp, 2
	jmp	short l_return
l_shield:
	mov	gs:songHalfDamage, 1
	mov	shieldDuration, 0FFh
	mov	ax, 3
	push	ax
	call	icon_activate
	add	sp, 2
	jmp	short l_return
l_songSwitch:
	cmp	ax, song_safety
	jz	l_safety
	cmp	ax, song_sanctuary
	jz	l_sanctuary
	cmp	ax, song_duotime
	jz	l_duotime
	cmp	ax, song_watchwood
	jz	l_watchwood
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
l_return:
	mov	sp, bp
	pop	bp
	retf
song_doNoncombatEffect endp


; Attributes: bp-based frame

song_endNoncombatEffect	proc far
	push	bp
	mov	bp, sp

	cmp	gs:g_currentSongPlusOne, 0
	jz	l_return

	mov	gs:g_currentSongPlusOne, 0
	cmp	gs:g_currentSinger, 7
	jnb	l_return
loc_22F03:
	mov	al, gs:g_currentSong
	sub	ah, ah
	jmp	short l_songSwitch
l_safety:
	mov	gs:songAntiMonster, 0
	jmp	short l_return
l_sanctuary:
	mov	gs:songACBonus,	0
	mov	byte ptr g_printPartyFlag,	0
	jmp	short l_return
l_duotime:
	mov	gs:songRegenSppt, 0
	jmp	short l_return
l_watchwood:
	mov	lightDistance, 0
	sub	ax, ax
	push	ax
	call	icon_deactivate
	add	sp, 2
	mov	gs:gl_detectSecretDoorFlag, 0
	jmp	short l_return
l_overture:
	mov	ax, 1
	push	ax
	call	icon_deactivate
	add	sp, 2
	jmp	short l_return
l_shield:
	mov	gs:songHalfDamage, 0
	jmp	short l_return
l_songSwitch:
	cmp	ax, song_safety
	jz	short l_safety
	cmp	ax, song_sanctuary
	jz	short l_sanctuary
	cmp	ax, song_duotime
	jz	short l_duotime
	cmp	ax, song_watchwood
	jz	short l_watchwood
	cmp	ax, song_overture
	jz	short l_overture
	cmp	ax, song_shield
	jz	short l_shield
l_return:
	mov	sp, bp
	pop	bp
	retf
song_endNoncombatEffect	endp



seg011 ends

include seg012.asm

; Segment type: Pure code
seg013 segment byte public 'CODE' use16
        assume cs:seg013
;org 4
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

; Attributes: bp-based frame

dunsq_battleCheck proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	call	random
	and	ax, 80h
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_24DA7
	inc	byte_4EECC

	; Add code to mask the encounter out
	mov	ax, 7Fh
	push	ax
	mov	ax, 2
	push	ax
	push	sq_east
	push	sq_north
	call	dun_maskSquare
	add	sp, 8

loc_24DA7:
	mov	ax, [bp+var_2]
	mov	sp, bp
	pop	bp
	retf
dunsq_battleCheck endp


; Attributes: bp-based frame

dunsq_doTrap proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	stringBuffer= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	push	si

	push	cs
	call	near ptr trap_levitationCheck
	mov	[bp+var_102], ax
	or	ax, ax
	jz	l_return

loc_24DCB:
	call	random
	and	ax, 3
	mov	[bp+var_10A], ax
	cmp	ax, 3
	jz	short loc_24DCB

	mov	al, levelNoMaybe
	sub	ah, ah
	and	ax, 7
	shl	ax, 1
	shl	ax, 1
	or	ax, [bp+var_10A]
	mov	gs:trapIndex, ax
	mov	ax, offset s_hitTrap
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, g_trapIndexByLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapTypeString+2)[bx]
	push	word ptr trapTypeString[bx]
	push	dx
	push	[bp+var_106]
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	bx, gs:trapIndex
	mov	al, byte_4B258[bx]
	cbw
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	[bp+var_10C], ax

	mov	si, gs:trapIndex
	shl	si, 1
	mov	al, trapSaveList._low[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, trapSaveList._high[si]
	mov	gs:monGroups.breathSaveHi, al

	mov	[bp+var_108], 0
loc_24E97:
	push	[bp+var_10C]
	push	[bp+var_108]
	call	trap_doDamage
	add	sp, 4
	inc	[bp+var_108]
	cmp	[bp+var_108], 7
	jl	short loc_24E97

l_return:
	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax
	push	ax
	push	sq_east
	push	sq_north
	call	spGeo_removeTrap
	add	sp, 6
	mov	ax, [bp+var_102]

	pop	si
	mov	sp, bp
	pop	bp
	retf
dunsq_doTrap endp

; Attributes: bp-based frame

trap_doDamage proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	ax, charSize
	imul	[bp+arg_0]
	mov	si, ax
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_return
	test	gs:party.status[si], stat_dead
	jnz	short l_return
	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	bx, gs:trapIndex
	mov	al, trapSpecialAttackValue[bx]
	and	ax, 7Fh
	mov	gs:specialAttackVal, ax
	mov	ax, [bp+arg_2]
	mov	gs:damageAmount, ax
	sub	ax, ax
	push	ax
	mov	ax, 80h
	push	ax
	call	savingThrowCheck
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short l_return
	mov	ax, 1
	mov	[bp+var_2], ax
	sar	gs:damageAmount, 1
	push	[bp+arg_0]
	call	bat_doHPDamage
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
trap_doDamage endp


; Attributes: bp-based frame

trap_levitationCheck proc far
	push	bp
	mov	bp, sp

	cmp	levitationDuration, 0
	jz	short l_returnOne

	call	random
	and	al, 3
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short l_return
l_returnOne:
	mov	ax, 1
l_return:
	mov	sp, bp
	pop	bp
	retf
trap_levitationCheck endp

; Attributes: bp-based frame

dunsq_doDarkness proc far
	push	bp
	mov	bp, sp

	cmp	lightDuration, 0
	jz	short l_checkLightSong
	sub	ax, ax
	push	ax
	call	icon_deactivate
	add	sp, 2
l_checkLightSong:
	mov	lightDistance, 0
	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	cmp	gs:g_currentSong, 5
	jnz	short l_return
	call	endNoncombatSong

l_return:
	mov	ax, offset s_darkness
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax

	mov	sp, bp
	pop	bp
	retf
dunsq_doDarkness endp

; Attributes: bp-based frame

dunsq_doSpinner	proc far

	slotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+slotNumber], 0
l_loop:
	mov	ax, itemEff_noSpin
	push	ax
	push	[bp+slotNumber]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_returnOne
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	l_loop

	call	random
	and	ax, 3
	mov	g_direction, ax
	sub	ax, ax
	jmp	short l_return

l_returnOne:
	mov	ax, 1

l_return:
	mov	sp, bp
	pop	bp
	retf
dunsq_doSpinner	endp

; Attributes: bp-based frame

dunsq_antiMagic	proc far

	l_effectIndex= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	inc	gs:sq_antiMagicFlag

	; Change to 1 to skip over lightDuration
	mov	[bp+l_effectIndex], 1
l_loop:
	mov	bx, [bp+l_effectIndex]
	cmp	lightDuration[bx], 0
	jz	short l_next
	push	[bp+l_effectIndex]
	call	icon_deactivate
	add	sp, 2

l_next:
	inc	[bp+l_effectIndex]
	cmp	[bp+l_effectIndex], 5
	jl	short l_loop


	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_antiMagic	endp

; Attributes: bp-based frame

dunsq_drainHp proc far

	slotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	di
	push	si

	mov	[bp+slotNumber], 0
l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	test	gs:party.status[si], stat_dead	or stat_stoned
	jnz	short l_next
	mov	al, levelNoMaybe
	sub	ah, ah
	mov	di, ax
	cmp	gs:party.currentHP[si], di
	jbe	short l_killCharacter
	sub	gs:party.currentHP[si], di
	jmp	short l_next
l_killCharacter:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	mov	gs:party.currentHP[si], 0
	or	gs:party.status[si], stat_dead
l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	call	party_getLastSlot
	cmp	ax, 7
	jle	short l_return
	mov	buildingRvalMaybe, 5
l_return:
	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax

	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
dunsq_drainHp endp

party_regenHp	proc far
	push		cx
	xor		cx, cx

l_loop:
	mov	ax, charSize
	imul	cx
	mov	bx, ax
	test		gs:party.status[si], stat_dead or stat_stoned
	jnz		l_next
	mov		al, levelNoMaybe
	sub		ah, ah
	add		gs:party.currentHP[bx], ax
	mov		ax, gs:party.maxHP[bx]
	cmp		party.currentHP[bx], ax
	jbe		l_next
	mov		gs:party.currentHP[bx], ax

l_next:
	inc		cx
	cmp		cx, 7
	jl		l_loop

	pop		cx
	retf
party_regenHp	endp

; Attributes: bp-based frame
dunsq_somethingOdd proc	far
	push	bp
	mov	bp, sp
	sub	al, al
	mov	g_detectType, al
	mov	gs:gl_detectSecretDoorFlag, al
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_somethingOdd endp

; Attributes: bp-based frame

dunsq_doSilence	proc far
	push	bp
	mov	bp, sp

	cmp	gs:g_currentSongPlusOne, 0
	jz	short l_return
	mov	ax, offset s_soundOfSilence
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	endNoncombatSong
l_return:
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_doSilence	endp


; Attributes: bp-based frame

dunsq_regenSppt	proc far
	push	bp
	mov	bp, sp
	inc	gs:regenSpptSq
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_regenSppt	endp

; Attributes: bp-based frame

dunsq_drainSppt	proc far

	slotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+slotNumber], 0
l_loop:
	call	random
	and	ax, 3
	mov	cl, levelNoMaybe
	sub	ch, ch
	add	ax, cx
	mov	cx, ax

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.currentSppt[bx], cx
	jbe	short l_zeroSppt

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	sub	gs:party.currentSppt[bx], cx
	jmp	short l_next

l_zeroSppt:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	gs:party.currentSppt[bx], 0

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	mov	byte ptr g_printPartyFlag,	0
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_drainSppt	endp

; Attributes: bp-based frame

dunsq_monHostile proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+var_2], 0
l_checkEffectLoop:
	mov	ax, itemEff_calmMonster
	push	ax
	push	[bp+var_2]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jz	short l_returnOne
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_checkEffectLoop

	mov	[bp+var_2], 0
l_makeHostileLoop:
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster

	; FIXED - Was jz. This activated the square when there were no monsters
	; in the party.
	jnz	short l_makeHostileNext

	call	random
	test	al, 3
	jnz	short l_makeHostileNext
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	mov	gs:party.hostileFlag[bx], 1
	mov	byte_4EECC, 1

l_makeHostileNext:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_makeHostileLoop

l_returnOne:
	mov	ax, 1
l_return:
	mov	ax, 7Fh
	push	ax
	mov	ax, 3
	push	ax
	push	sq_east
	push	sq_north
	call	dun_maskSquare
	add	sp, 8

	mov	sp, bp
	pop	bp
	retf
dunsq_monHostile endp

; Attributes: bp-based frame

dunsq_doStuck proc far
	push	bp
	mov	bp, sp
	call	random
	and	al, 3
	mov	gs:stuckFlag, al
	sub	ax, ax
	mov	sp, bp
	pop	bp
	retf
dunsq_doStuck endp

; Attributes: bp-based frame

dunsq_regenHP proc far
	push	bp
	mov	bp, sp
	inc	gs:sqRegenHPFlag
	mov	sp, bp
	pop	bp
	retf
dunsq_regenHP endp

; Attributes: bp-based frame

dunsq_explosion proc far
	push	bp
	mov	bp, sp
	cmp	lightDuration, 0
	jz	short l_return
	mov	ax, offset s_explosion
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	push	cs
	call	near ptr dunsq_drainHp
l_return:
	mov	ax, 1
	mov	sp, bp
	pop	bp
	retf
dunsq_explosion endp

; Attributes: bp-based frame

dunsq_portalAbove proc far
	push	bp
	mov	bp, sp
	mov	ax, offset s_portalAbove
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
dunsq_portalAbove endp

; Attributes: bp-based frame

dunsq_portalBelow proc far
	push	bp
	mov	bp, sp
	mov	ax, offset s_portalBelow
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
dunsq_portalBelow endp


; Attributes: bp-based frame

dun_doSpecialSquare proc far

	counter= word ptr -6
	squareDataP= dword ptr -4
	rowBuf=	dword ptr  6
	sqEast=	word ptr  0Ah
	sqNorth= word ptr  0Ch

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	sub	al, al
	mov	gs:sqRegenHPFlag, al
	mov	gs:stuckFlag, al
	mov	gs:sq_antiMagicFlag, al
	mov	gs:regenSpptSq,	al
	mov	byte_4EECC, al
	mov	bx, [bp+sqNorth]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+rowBuf]
	mov	ax, fs:[bx+si]
	mov	dx, fs:[bx+si+2]
	mov	cx, [bp+sqEast]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+squareDataP], ax
	mov	word ptr [bp+squareDataP+2], dx

	mov	[bp+counter], 0
l_loop:
	mov	bx, [bp+counter]
	mov	bl, specialSquareByteIndexList[bx]
	sub	bh, bh
	lfs	si, [bp+squareDataP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, specialSquareMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	shl	bx, 1
	shl	bx, 1
	call	specialSquareFunctionList[bx]

l_next:
	inc	[bp+counter]
	cmp	[bp+counter], 10h
	jl	short l_loop

	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_doSpecialSquare endp

; Attributes: bp-based frame

brilhasti_doBonus proc far

	slotNumber= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	[bp+slotNumber], 0
l_loop:
	push	[bp+slotNumber]
	push	cs
	call	near ptr brilhasti_checkQuest
	add	sp, 2
	or	ax, ax
	jz	short l_next

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	al, gs:party.class[bx]

	or	al, al
	jz	short l_nonMagicUser

	cmp	al, 5
	jnb	short l_nonMagicUser

	push	[bp+slotNumber]
	call	brilhasti_levelMagicUser
	add	sp, 2
	jmp	short l_next

l_nonMagicUser:
	mov	ax, 34
	push	ax
	push	[bp+slotNumber]
	call	getLevelXp
	add	sp, 4
	mov	cx, ax
	mov	bx, dx
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	mov	word ptr gs:party.experience[si], cx
	mov	word ptr gs:(party.experience+2)[si], bx
l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	pop	si
	mov	sp, bp
	pop	bp
	retf
brilhasti_doBonus endp

; Attributes: bp-based frame

brilhasti_checkQuest proc far

	slotNumber= word ptr	 6

	push	bp
	mov	bp, sp

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	test	gs:(party.chronoQuest+1)[bx], 1
	jnz	short l_returnZero

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.class[bx], class_monster
	jnb	short l_returnZero

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.level[bx], 35
	jnb	short l_returnZero

	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	mov	sp, bp
	pop	bp
	retf
brilhasti_checkQuest endp

; Attributes: bp-based frame

brilhasti_levelMagicUser proc far

	spellIndex= word ptr	-2
	slotNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	[bp+spellIndex], 0
l_loop:
	push	[bp+spellIndex]
	push	[bp+slotNumber]
	call	mage_learnSpell
	add	sp, 4
	inc	[bp+spellIndex]
	cmp	[bp+spellIndex], 74
	jl	short l_loop

loc_254C9:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	mov	gs:party.class[si], class_archmage
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	ax, 14h
	push	ax
	lea	ax, party.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr brilhasti_setAttributes
	add	sp, 6

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.maxHP[bx], 375
	jnb	short l_setSppt
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	gs:party.maxHP[bx], 375

l_setSppt:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	cmp	gs:party.maxSppt[bx], 350
	jnb	short l_return
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	gs:party.maxSppt[bx], 350

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
brilhasti_levelMagicUser endp

; Attributes: bp-based frame

brilhasti_setAttributes proc far

	attributeIndex= word ptr	-2
	attributeP= dword ptr  6
	attributeValue= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	[bp+attributeIndex], 0
l_loop:
	mov	bx, [bp+attributeIndex]
	lfs	si, [bp+attributeP]
	mov	al, fs:[bx+si]
	cbw
	cmp	ax, [bp+attributeValue]
	jge	short l_next
	mov	al, byte ptr [bp+attributeValue]
	mov	fs:[bx+si], al
l_next:
	inc	[bp+attributeIndex]
	cmp	[bp+attributeIndex], 5
	jl	short l_loop

	pop	si
	mov	sp, bp
	pop	bp
	retf
brilhasti_setAttributes endp

; Attributes: bp-based frame
geomancer_convert proc	far

	slotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	push	si

	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	mov	gs:party.class[si], class_geomancer
	sub	ax, ax
	mov	word ptr gs:(party.experience+2)[si], ax
	mov	word ptr gs:party.experience[si], ax
	mov	gs:party.level[si], 1
	mov	gs:party.maxLevel[si],	1
	mov	gs:party.currentSppt[si], 25
	mov	gs:party.maxSppt[si], 25
	mov	ax, 0Ch
	push	ax
	push	[bp+slotNumber]
	push	cs
	call	near ptr geomancer_convertEquipment
	add	sp, 4
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	bx, ax
	mov	gs:party.numAttacks[bx], 0
	mov	ax, 106
	push	ax
	push	[bp+slotNumber]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 107
	push	ax
	push	[bp+slotNumber]
	call	mage_learnSpell
	add	sp, 4
	mov	ax, 108
	push	ax
	push	[bp+slotNumber]
	call	mage_learnSpell
	add	sp, 4
	mov	byte ptr g_printPartyFlag,	0

	pop	si
	mov	sp, bp
	pop	bp
	retf
geomancer_convert endp

; Attributes: bp-based frame

geomancer_convertEquipment proc far

	inventorySlotNumber= word ptr	-4
	newEquipableFlags= word ptr	-2
	slotNumber= word ptr	 6
	classNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	[bp+inventorySlotNumber], 0
l_loop:
	mov	ax, charSize
	imul	[bp+slotNumber]
	mov	si, ax
	add	si, [bp+inventorySlotNumber]
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	bx, ax
	mov	al, itemEquipMask[bx]
	mov	bx, [bp+classNumber]
	mov	cl, classEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_setUnequipable
	sub	ax, ax
	jmp	short l_setItemFlags
l_setUnequipable:
	mov	ax, 2
l_setItemFlags:
	mov	[bp+newEquipableFlags], ax
	mov	al, gs:party.inventory.itemFlags[si]
	and	al, 0FCh
	or	al, byte ptr [bp+newEquipableFlags]
	mov	gs:party.inventory.itemFlags[si], al
	add	[bp+inventorySlotNumber], 3
	cmp	[bp+inventorySlotNumber], 24h	
	jl	short l_loop

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
geomancer_convertEquipment endp

; Attributes: bp-based frame

dun_detectSquares proc far

	aheadFlags= word ptr -6
	detectIndex= word ptr	-2
	sqE= word ptr  6
	sqN= word ptr  8
	direction= word ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si

	; Return if detect spell not active
	cmp	detectDuration, 0
	jz	l_return

	; Return if current square and direction are the same as
	; the last time this function was run.
	;
	mov	al, gs:g_lastDetectSqE
	sub	ah, ah
	cmp	ax, [bp+sqE]
	jnz	short loc_256DB
	mov	al, gs:g_lastDetectSqN
	cmp	ax, [bp+sqN]
	jnz	short loc_256DB
	mov	al, gs:g_lastDetectDirection
	cmp	ax, [bp+direction]
	jz	l_return

loc_256DB:
	; Set the last detection variables
	mov	al, byte ptr [bp+sqE]
	mov	gs:g_lastDetectSqE, al
	mov	al, byte ptr [bp+sqN]
	mov	gs:g_lastDetectSqN, al
	mov	al, byte ptr [bp+direction]
	mov	gs:g_lastDetectDirection, al

	lea	ax, [bp+aheadFlags]
	push	ss
	push	ax
	push	[bp+sqN]
	push	[bp+sqE]
	push	cs
	call	near ptr detect_getSquares
	add	sp, 8
	mov	bl, g_detectType
	sub	bh, bh
	mov	al, detectByteStartList[bx]
	cbw
	mov	[bp+detectIndex], ax

l_loop:
	mov	bx, [bp+detectIndex]
	mov	al, detectByte[bx]
	sub	ah, ah
	cmp	ax, 0FFh
	jge	short l_return
	mov	si, ax
	mov	al, byte ptr [bp+si+aheadFlags]
	cbw
	mov	cl, detectMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next

	mov	bx, [bp+detectIndex]
	mov	al, detectMsgIndex[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (detectMessages+2)[bx]
	push	word ptr detectMessages[bx]
	call	printString
	add	sp, 4
l_next:
	inc	[bp+detectIndex]
	jmp	short l_loop

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_detectSquares endp

; This function	returns	a list of the square flags
; for the three	squares	ahead.
; Attributes: bp-based frame

detect_getSquares proc far

	sqFlagP= dword ptr -8
	counter= word ptr -4
	deltaSq= word ptr -2
	sqE= word ptr  6
	sqN= word ptr  8
	rSqList= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	[bp+deltaSq], 0
l_zeroRvalLoop:
	mov	bx, [bp+deltaSq]
	lfs	si, [bp+rSqList]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+deltaSq]
	cmp	[bp+deltaSq], 3
	jl	short l_zeroRvalLoop

	mov	[bp+deltaSq], 0
l_outerLoop:
	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaE[si]
	add	[bp+sqE], ax
	mov	al, g_dunWidth
	sub	ah, ah
	push	ax
	push	[bp+sqE]
	call	wrapNumber
	add	sp, 4
	mov	[bp+sqE], ax
	mov	ax, dirDeltaN[si]
	sub	[bp+sqN], ax
	mov	al, g_dunHeight
	sub	ah, ah
	push	ax
	push	[bp+sqN]
	call	wrapNumber
	add	sp, 4
	mov	[bp+sqN], ax
	mov	bx, [bp+sqN]
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
	add	ax, 2
	mov	word ptr [bp+sqFlagP], ax
	mov	word ptr [bp+sqFlagP+2], dx

	mov	[bp+counter], 0
l_copyBytesLoop:
	mov	bx, [bp+counter]
	lfs	si, [bp+sqFlagP]
	mov	al, fs:[bx+si]
	lfs	si, [bp+rSqList]
	or	fs:[bx+si], al
	inc	[bp+counter]
	cmp	[bp+counter], 3
	jl	short l_copyBytesLoop

	inc	[bp+deltaSq]
	cmp	[bp+deltaSq], 3
	jl	l_outerLoop

	pop	si
	mov	sp, bp
	pop	bp
	retf
detect_getSquares endp

; Attributes: bp-based frame

dun_ascendPortal proc far

	var_4= dword ptr -4
	sqE= word ptr	 6
	sqN= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	bx, [bp+sqN]
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
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	test	byte ptr fs:[bx], 40h		; 40h == portal above
	jz	short l_return
	cmp	levitationDuration, 0
	jz	short l_return
	test	levFlags, 10h
	jz	short loc_25878
	push	cs
	call	near ptr portal_incrementLevel
	jmp	short l_return
loc_25878:
	push	cs
	call	near ptr portal_decrementLevel
l_return:
	mov	sp, bp
	pop	bp
	retf
dun_ascendPortal endp

; Attributes: bp-based frame

dun_descendPortal proc far

	var_4= dword ptr -4
	sqE= word ptr	 6
	sqN= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+sqN]
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
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	test	byte ptr fs:[bx], 20h			; 20h == portal below
	jz	short loc_258E5
	cmp	levitationDuration, 0
	jnz	short loc_258CF
	call	dunsq_drainHp
loc_258CF:
	test	levFlags, 10h
	jz	short loc_258E1
	call	portal_decrementLevel
	jmp	short loc_258E5
loc_258E1:
	call	portal_incrementLevel
loc_258E5:
	mov	sp, bp
	pop	bp
	retf
dun_descendPortal endp

; Attributes: bp-based frame

portal_decrementLevel proc far
	push	bp
	mov	bp, sp
	dec	dunLevelNum
	jns	short l_changeLevel
	call	dun_setExitLocation
	jmp	short l_return
l_changeLevel:
	call	dun_changeLevels
l_return:
	mov	sp, bp
	pop	bp
	retf
portal_decrementLevel endp

; Attributes: bp-based frame

portal_incrementLevel proc far
	push	bp
	mov	bp, sp
	inc	dunLevelNum
	call	dun_changeLevels
	mov	sp, bp
	pop	bp
	retf
portal_incrementLevel endp

; Attributes: bp-based frame

wanderer_join proc far

	emptySlotNumber= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	call	party_findEmptySlot
	mov	[bp+emptySlotNumber], ax

	cmp	ax, 7					; no empty slot number?
	jl	short loc_25963
	call	dropPartyMember
	or	ax, ax
	jz	short l_returnZero			; return if not dropping
	call	party_findEmptySlot
	mov	[bp+emptySlotNumber], ax
	mov	byte ptr g_printPartyFlag, 0

loc_25963:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+emptySlotNumber]
	call	_sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr g_printPartyFlag, 0
	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
wanderer_join endp

; Attributes: bp-based frame
wanderer_fight proc	far
	push	bp
	mov	bp, sp
	mov	g_monsterGroupCount, 1
	mov	gs:g_nonRandomBattleFlag, 1
	mov	byte_4EECC, 1
	mov	ax, 1
	mov	sp, bp
	pop	bp
	retf
wanderer_fight endp

; Attributes: bp-based frame
wanderer_leave proc	far
	push	bp
	mov	bp, sp
	mov	ax, 1
	mov	sp, bp
	pop	bp
	retf
wanderer_leave endp

; Attributes: bp-based frame

dun_wanderingCreature proc far

	pluralizedNameP=	dword ptr -46h
	loopCounter=	word ptr -42h
	pluralizedName=	word ptr -40h
	monsterBufferP=	dword ptr -30h
	unmaskedName=	word ptr -2Ch
	validOptionCharacters=	word ptr -1Ch
	inKey=	word ptr -16h
	validOptionMouse=	word ptr -14h
	optionList= word ptr	-8
	monsterIndex= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 46h
	call	someStackOperation
	push	si

l_selectMonsterRetry:
	mov	ax, 17h
	push	ax
	sub	ax, ax
	push	ax
	call	randomBetweenXandY
	add	sp, 4			; Pick a random monster to wander
	mov	[bp+monsterIndex], ax
	mov	ax, monStruSize
	imul	[bp+monsterIndex]
	add	ax, offset monsterBuf
	mov	word ptr [bp+monsterBufferP], ax
	mov	word ptr [bp+monsterBufferP+2],	seg seg023
	lfs	bx, [bp+monsterBufferP]			; Retry if
	test	fs:[bx+mon_t.flags], mon_noSummon	;	monster can't be summoned
	jnz	short l_selectMonsterRetry		; or
	cmp	byte ptr fs:[bx], 0			; 	no monster at that index
	jz	short l_selectMonsterRetry

	; Draw monster image
	mov	al, fs:[bx+mon_t.picIndex]
	sub	ah, ah
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2

	; Set title with properly pluralized name
	lea	ax, [bp+unmaskedName]
	push	ss
	push	ax
	push	word ptr [bp+monsterBufferP+2]
	push	word ptr [bp+monsterBufferP]
	call	unmaskString
	add	sp, 8
	sub	ax, ax
	push	ax
	lea	ax, [bp+pluralizedName]
	push	ss
	push	ax
	lea	ax, [bp+unmaskedName]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+pluralizedNameP], ax
	mov	word ptr [bp+pluralizedNameP+2], dx
	lfs	bx, [bp+pluralizedNameP]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+pluralizedName]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4

	mov	gs:monGroups.groupSize,	1
	mov	al, byte ptr [bp+monsterIndex]
	mov	byte ptr gs:monGroups._name, al

	mov	[bp+loopCounter], 0
l_setOptionListLoop:
	mov	si, [bp+loopCounter]
	mov	byte ptr [bp+si+optionList],	1
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 5
	jl	short l_setOptionListLoop

l_ioLoop:
	call	text_clear
	lea	ax, [bp+validOptionMouse]
	push	ss
	push	ax
	lea	ax, [bp+validOptionCharacters]
	push	ss
	push	ax
	lea	ax, [bp+optionList]
	push	ss
	push	ax
	mov	ax, offset s_wandererText
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+loopCounter], 0
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+inKey], ax
	cmp	ax, dosKeys_ESC
	jz	short l_return

loc_25AC1:
	mov	si, [bp+loopCounter]
	cmp	byte ptr [bp+si+validOptionCharacters], 0
	jz	short l_ioLoop
	mov	al, byte ptr [bp+si+validOptionCharacters]
	cbw
	cmp	ax, [bp+inKey]
	jz	short l_callWandererFunction
	shl	si, 1
	mov	ax, [bp+inKey]
	cmp	[bp+si+validOptionMouse],	ax
	jnz	short l_optionCheckNext

l_callWandererFunction:
	push	word ptr [bp+monsterBufferP+2]
	push	word ptr [bp+monsterBufferP]
	mov	bx, [bp+loopCounter]
	shl	bx, 1
	shl	bx, 1
	call	g_wandererFunctionTable[bx]
	add	sp, 4
	or	ax, ax
	jz	short l_return
	call	text_clear
	jmp	short l_return

l_optionCheckNext:
	inc	[bp+loopCounter]
	jmp	short loc_25AC1

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_wanderingCreature endp


seg013 ends

; Segment type: Pure code
seg014 segment byte public 'CODE' use16
        assume cs:seg014
;org 8
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

; Attributes: bp-based frame

bards_enter proc far
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si

	mov	ax, offset s_bardsHall
	push	ds
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, 83
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
l_loop:
	mov	ax, offset s_bardHallGreeting
	call	printStringWClear
	add	sp, 4
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	ax, g_printPartyFlag[si]
	or	ax, bitMask16bit[si]
	mov	[bp+var_2], ax
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
	jz	short l_listen
	cmp	[bp+var_4], 10Eh
	jnz	short loc_25B8E
l_listen:
	push	cs
	call	near ptr bards_listen
loc_25B8E:
	cmp	[bp+var_4], dosKeys_ESC
	jz	short l_return
	cmp	[bp+var_4], 'E'
	jz	short l_return
	cmp	[bp+var_4], 10Fh
	jnz	short l_loop

l_return:
	sub	ax, ax
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_enter endp

; Attributes: bp-based frame

bards_listen proc far

	validMouseKeys=	word ptr -2Eh
	validKeys=	word ptr -1Ah
	loopCounter=	word ptr -10h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	inKey= word ptr	-2

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
	call	near ptr bards_configOptionList
	add	sp, 6
	call	text_clear
	lea	ax, [bp+validMouseKeys]
	push	ss
	push	ax
	lea	ax, [bp+validKeys]
	push	ss
	push	ax
	lea	ax, [bp+var_C]
	push	ss
	push	ax
	mov	ax, offset s_songTitleList
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_E], ax
l_readKey:
	push	[bp+var_E]
	call	getKey
	add	sp, 2
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
	push	cs
	call	near ptr bards_learnSong
	add	sp, 2
	jmp	short l_return

loc_25C5D:
	push	[bp+loopCounter]
	push	cs
	call	near ptr bards_printLyrics
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_listen endp

; Attributes: bp-based frame

bards_printLyrics proc far

	loopCounter= word ptr	-2
	songNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	call	text_clear
	mov	[bp+loopCounter], 0
l_loop:
	mov	si, [bp+loopCounter]
	shl	si, 1
	shl	si, 1
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, bardSongLyrics[bx]
	push	word ptr fs:[bx+si+2]
	push	word ptr fs:[bx+si]
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	inc	[bp+loopCounter]
	mov	bx, [bp+songNumber]
	shl	bx, 1
	mov	ax, [bp+loopCounter]
	cmp	bardSongLineCount[bx],	ax
	jg	short l_loop

	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_printLyrics endp

; DWORD - var_2 & var_4
; Attributes: bp-based frame

bards_learnSong	proc far

	stringBuffer= word ptr -108h
	partySlotNumber= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	songNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si

	mov	ax, offset s_bardSmiles
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	mov	ax, offset s_itWillCostYou
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	sub	ax, ax
	push	ax
	mov	bx, [bp+songNumber]
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
	mov	ax, offset s_bardInGold
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	call	strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	call	readSlotNumber
	mov	[bp+partySlotNumber], ax
	or	ax, ax
	jl	l_return

	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_25DA2
	jb	short loc_25D93
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_25DA2
loc_25D93:
	mov	ax, offset s_notEnoughGoldNl
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short l_waitAndReturn

loc_25DA2:
	mov	bx, [bp+songNumber]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr bardSongPrice[bx]
	mov	dx, word ptr (bardSongPrice+2)[bx]
	mov	cx, ax
	mov	bx, dx
	mov	ax, charSize
	imul	[bp+partySlotNumber]
	mov	si, ax
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	[bp+var_6], 0
l_loop:
	mov	ax, charSize
	imul	[bp+var_6]
	mov	si, ax
	cmp	gs:party.class[si], class_bard
	jnz	short l_increment
	mov	bx, [bp+songNumber]
	mov	al, byte_4BDF0[bx]
	or	gs:(party.specAbil+1)[si], al
l_increment:
	inc	[bp+var_6]
	cmp	[bp+var_6], 7
	jl	short l_loop

l_playSong:
	mov	ax, offset s_bardPlaysSong
	push	ds
	push	ax
	call	printString
	add	sp, 4
l_waitAndReturn:
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_learnSong	endp

; Set up the song list that you can learn from the Bard's Hall
;
; optionList[0] = !locationFlag
; optionList[1] = !locationFlag
; optionList[2] = !locationFlag
; optionList[3] = locationFlag
; optionList[4] = locationFlag
; optionList[5] = locationFlag
;

; Attributes: bp-based frame

bards_configOptionList proc far

	loopCounter= word ptr	-2
	locationFlag= word ptr	 6
	optionList= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	[bp+loopCounter], 0
loc_25E2E:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+optionList]
	cmp	[bp+locationFlag], 1
	sbb	ax, ax
	neg	ax
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short loc_25E2E

	mov	[bp+loopCounter], 3
loc_25E51:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+optionList]
	mov	al, byte ptr [bp+locationFlag]
	mov	fs:[bx+si], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short loc_25E51

	pop	si
	mov	sp, bp
	pop	bp
	retf
bards_configOptionList endp


seg014 ends

; Segment type: Pure code
seg015 segment word public 'CODE' use16
        assume cs:seg015
;org 0Dh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

; Attributes: bp-based frame

summon_execute proc far

	spellCaster= byte ptr	 6
	spellNumber= word ptr	 8

	push	bp
	mov	bp, sp

	test	gs:disbelieveFlags, disb_nosummon
	jz	short loc_25E96
	mov	ax, offset s_butItFizzledNl
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short l_return

loc_25E96:
	test	[bp+spellCaster], 80h
	jz	short loc_25EA8
	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_monSummon
	add	sp, 2
	jmp	short l_return

loc_25EA8:
	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_partySummon
	add	sp, 2

l_return:
	mov	sp, bp
	pop	bp
	retf
summon_execute endp

; Attributes: bp-based frame

summon_partySummon proc far

	skipNoRoomFlag= word ptr	-4
	emptySlot= word ptr	-2
	summonIndex= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	mov	[bp+skipNoRoomFlag], 0
l_loop:
	call	party_findEmptySlot
	mov	[bp+emptySlot], ax
	cmp	ax, 7
	jge	short l_noRoom
	mov	ax, [bp+summonIndex]
	and	ax, 1Fh
	mov	cx, monStruSize
	imul	cx
	add	ax, offset summonData
	push	ds
	push	ax
	push	[bp+emptySlot]
	call	_sp_convertMonToSummon
	add	sp, 6
	test	byte ptr [bp+summonIndex], 80h
	jz	short loc_25EF8
	mov	al, class_illusion
	jmp	short loc_25EFA
loc_25EF8:
	mov	al, class_monster
loc_25EFA:
	mov	cx, ax
	mov	ax, charSize
	imul	[bp+emptySlot]
	mov	bx, ax
	mov	gs:party.class[bx], cl
	mov	byte ptr g_printPartyFlag, 0
	mov	[bp+skipNoRoomFlag], 1
	cmp	g_curSpellNumber, 77			; Kringle Bros spell
	jz	short l_loop

l_noRoom:
	push	[bp+skipNoRoomFlag]
	push	cs
	call	near ptr summon_printNoRoom
	add	sp, 2

l_return:
	mov	sp, bp
	pop	bp
	retf
summon_partySummon endp


; Attributes: bp-based frame

summon_monSummon proc far

	groupNo= word ptr -6
	skipNoRoomFlag= word ptr	-4
	spellNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation

	mov	[bp+skipNoRoomFlag], 0

l_entry:
	mov	[bp+groupNo], 0

l_searchForEmptyGroup:
	mov	ax, monStruSize
	imul	[bp+groupNo]
	mov	bx, ax
	test	gs:monGroups.groupSize[bx], 1Fh
	jz	short l_makeNewMonsterGroup
	inc	[bp+groupNo]
	cmp	[bp+groupNo], 4
	jl	short l_searchForEmptyGroup

l_makeNewMonsterGroup:
	cmp	[bp+groupNo], 4				; If no empty groups,
	jge	short l_findMatchingGroup		;   Try to find a matching group
	push	[bp+groupNo]
	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_newMonGroup
	add	sp, 4			; Create new group
	push	[bp+groupNo]
	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_addMonToGroup
	add	sp, 4			; Add monster to group
	or	[bp+skipNoRoomFlag], ax
	jmp	short l_kringleBrosCheck

l_findMatchingGroup:
	cmp	g_curSpellNumber, 77			; Skip if kringle bros spell
	jz	l_printNoRoom

	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_getMatchMonGroup
	add	sp, 2
	mov	[bp+groupNo], ax
	or	ax, ax
	jl	short l_kringleBrosCheck
	push	ax
	push	[bp+spellNumber]
	push	cs
	call	near ptr summon_addMonToGroup
	add	sp, 4
	or	[bp+skipNoRoomFlag], ax
	jmp	l_printNoRoom

l_kringleBrosCheck:
	cmp	g_curSpellNumber, 77			; Kringle Bros
	jnz	l_entry

l_printNoRoom:
	push	[bp+skipNoRoomFlag]
	call	summon_printNoRoom
	add	sp, 2
	
l_return:
	mov	sp, bp
	pop	bp
	retf
summon_monSummon endp

; This function	looks for a monster group that matches
; the summonData.name given by summonNo. It returns
; the matching group number. If	not found, it returns
; 0xffff
;
; Attributes: bp-based frame

summon_getMatchMonGroup proc far

	groupCounter= word ptr	-2
	summonNo= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

	mov	[bp+groupCounter], 0
loc_2600B:
	mov	ax, monStruSize
	imul	[bp+summonNo]
	add	ax, offset summonData
	push	ds
	push	ax
	mov	ax, monStruSize
	imul	[bp+groupCounter]
	mov	bx, ax
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	vm_strcmp
	add	sp, 8
	or	ax, ax
	jnz	l_returnValue
	inc	[bp+groupCounter]
	cmp	[bp+groupCounter], 4
	jl	short loc_2600B

l_returnValue:
	mov	ax, [bp+groupCounter]
	jmp	short l_return

l_returnFail:
	mov	ax, 0FFFFh

l_return:
	mov	sp, bp
	pop	bp
	retf
summon_getMatchMonGroup endp

; DWORD - stringBuffer & var_104
;
; Attributes: bp-based frame

summon_addMonToGroup proc far

	var_116= word ptr -116h
	var_106= word ptr -106h
	var_104= word ptr -104h
	stringBuffer= word ptr -102h
	groupSize= word	ptr -2
	arg_0= byte ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 116h
	call	someStackOperation
	push	si

	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize],	ax
	cmp	ax, 1Fh
	jnz	short loc_2607B
	sub	ax, ax
	jmp	l_return
loc_2607B:
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	si, ax
	inc	gs:monGroups.groupSize[si]
	mov	al, gs:monGroups.hpDice[si]
	sub	ah, ah
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	cx, gs:monGroups.hpBase[si]
	add	cx, ax
	mov	bx, [bp+arg_2]
	mov	ax, cx
	mov	cl, 6
	shl	bx, cl
	mov	cx, [bp+groupSize]
	shl	cx, 1
	add	bx, cx
	mov	gs:monHpList[bx], ax
	mov	bx, [bp+arg_2]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+groupSize]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	test	[bp+arg_0], 80h
	jz	short loc_260EF
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	or	gs:monGroups.flags[bx],	10h
	jmp	short loc_26101
loc_260EF:
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	and	gs:monGroups.flags[bx],	0EFh
loc_26101:
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	unmaskString
	add	sp, 8
	mov	ax, offset s_andA
	push	ds
	push	ax
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	sub	ax, ax
	push	ax
	push	dx
	push	[bp+var_106]
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	ax, offset s_appears
	push	ds
	push	ax
	push	dx
	push	[bp+var_106]
	call	strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	lea	ax, [bp+stringBuffer]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 1
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
summon_addMonToGroup endp

; Attributes: bp-based frame

summon_newMonGroup proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp

	and	[bp+arg_0], 1Fh
	mov	ax, monStruSize
	imul	[bp+arg_0]
	add	ax, offset summonData
	push	ds
	push	ax
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr summon_maskSummonName
	add	sp, 8
	mov	ax, 20h
	push	ax
	mov	ax, monStruSize
	imul	[bp+arg_0]
	add	ax, offset summonHpDice
	push	ds
	push	ax
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	lea	ax, monGroups.hpDice[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	memcpy
	add	sp, 0Ah

	; FIXED: Set the group size to 0. 
	mov	ax, monStruSize
	imul	[bp+arg_2]
	mov	bx, ax
	mov	monGroups.groupSize[bx], 0

	mov	sp, bp
	pop	bp
	retf
summon_newMonGroup endp

; Attributes: bp-based frame

summon_maskSummonName proc far

	loopCounter= word ptr	-2
	destAddress= dword ptr  6
	srcAddress= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	[bp+loopCounter], 0
l_zeroLoop:
	mov	bx, [bp+loopCounter]
	lfs	si, [bp+destAddress]
	mov	byte ptr fs:[bx+si], 0FFh
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 10h
	jl	short l_zeroLoop

l_copyLoop:
	lfs	bx, [bp+srcAddress]
	cmp	byte ptr fs:[bx], 0
	jz	short l_return
	inc	word ptr [bp+srcAddress]
	mov	al, fs:[bx]
	or	al, 80h
	lfs	bx, [bp+destAddress]
	inc	word ptr [bp+destAddress]
	mov	fs:[bx], al
	jmp	short l_copyLoop

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
summon_maskSummonName endp

; Attributes: bp-based frame

summon_printNoRoom	proc far

	noRoomFlag= word ptr	 6

	push	bp
	mov	bp, sp

	cmp	[bp+noRoomFlag], 0
	jnz	short l_return
	mov	ax, offset s_noRoomForSummon
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	text_delayWithTable

l_return:
	mov	sp, bp
	pop	bp
	retf
summon_printNoRoom	endp



seg015 ends

; Segment type: Pure code
seg016 segment byte public 'CODE' use16
        assume cs:seg016
;org 0Eh
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

; Attributes: bp-based frame

configureBT3 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation

	cmp	[bp+arg_0], 1
	jle	short loc_2627C
	lfs	bx, [bp+arg_2]
	lfs	bx, fs:[bx+4]
	mov	al, fs:[bx]
	cbw
	jmp	short loc_2627F
loc_2627C:
	mov	ax, 0FFh
loc_2627F:
	mov	[bp+var_4], ax
	cmp	ax, '1'
	jl	short loc_2628C
	cmp	ax, '4'
	jle	short loc_2630B
loc_2628C:

	mov	[bp+var_8], 0
l_clearScreenLoop:
	mov	ax, offset s_nl
	push	ds
	push	ax
	call	printf
	add	sp, 4
	inc	[bp+var_8]
	cmp	[bp+var_8], 25
	jl	short l_clearScreenLoop

loc_262AB:
	mov	ax, offset s_displayQuestion
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_videoOption1
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_videoOption2
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_videoOption3
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_videoOption4
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_videoQuestion
	push	ds
	push	ax
	call	printf
	add	sp, 4
	call	sub_2A9D4
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	short loc_2628C
	cmp	ax, '4'	
	jg	short loc_2628C
loc_2630B:
	mov	ax, [bp+var_4]
	sub	ax, '1'	
	mov	[bp+var_6], ax
	cmp	[bp+arg_0], 2
	jle	short loc_26327
	lfs	bx, [bp+arg_2]
	lfs	bx, fs:[bx+8]
	mov	al, fs:[bx]
	cbw
	jmp	short loc_2632A
loc_26327:
	mov	ax, 0FFh
loc_2632A:
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	short loc_2633A
	cmp	ax, '4'	
	jle	l_return

loc_2633A:
	mov	[bp+var_8], 0
loc_26341:
	mov	ax, offset s_nl
	push	ds
	push	ax
	call	printf
	add	sp, 4
	inc	[bp+var_8]
	cmp	[bp+var_8], 25
	jl	short loc_26341

loc_26359:
	mov	ax, offset s_soundQuestion
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundOption1
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundOption2
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundOption3
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundOption4
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundOption5
	push	ds
	push	ax
	call	printf
	add	sp, 4
	mov	ax, offset s_soundPrompt
	push	ds
	push	ax
	call	printf
	add	sp, 4
	call	sub_2A9D4
	mov	[bp+var_4], ax
	cmp	ax, '1'	
	jl	loc_2633A
	cmp	ax, '5'	
	jg	loc_2633A
l_return:
	mov	ax, [bp+var_4]
	sub	ax, '1'	
	mov	[bp+var_2], ax
	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	or	ax, [bp+var_6]
	jmp	short $+2

	mov	sp, bp
	pop	bp
	retf
configureBT3 endp


seg016 ends



; Segment type: Pure code
seg017 segment word public 'CODE' use16
        assume cs:seg017
;org 3
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027
align 2

; Attributes: bp-based frame

transferCharacter proc far

	inKey= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation

l_entry:
	mov	ax, offset s_transferVersionPrompt
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 3Ch	
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+inKey], ax
	cmp	ax, 110h
	jl	short loc_2641A
	cmp	ax, 112h
	jg	short loc_2641A
	sub	[bp+inKey], 0DFh 
loc_2641A:
	mov	ax, [bp+inKey]
	cmp	ax, dosKeys_ESC
	jz	short l_return
	cmp	ax, '1'	
	jz	short l_bt1
	cmp	ax, '2'	
	jz	short l_bt2
	cmp	ax, '3'	
	jz	short l_bt3
	cmp	ax, 'E'	
	jz	short l_return
	cmp	ax, 113h
	jz	short l_return
	jmp	short l_entry

l_bt3:
	push	cs
	call	near ptr getTransferCharacters
	add	sp, 4
	jmp	short l_entry

l_bt2:
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr importCharacter
	jmp	short l_entry

l_bt1:
	sub	ax, ax
	push	ax
	push	cs
	call	near ptr importCharacter
	jmp	short l_entry

l_return:
	mov	sp, bp
	pop	bp
	retf
transferCharacter endp

; DWORD - 1C4 & 1C6, 17E & 180, 24 & 26
; Attributes: bp-based frame

getTransferCharacters proc far

	var_1CA= dword ptr -1CAh
	var_1C6= word ptr -1C6h
	var_1C4= word ptr -1C4h
	var_1C2= word ptr -1C2h
	var_1C0= word ptr -1C0h
	var_1BC= word ptr -1BCh
	var_1BA= dword ptr -1BAh
	var_1B6= word ptr -1B6h
	var_1B4= word ptr -1B4h
	fd= word ptr -182h
	var_180= word ptr -180h
	var_17E= word ptr -17Eh
	var_17C= word ptr -17Ch
	var_17A= dword ptr -17Ah
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh

	push	bp
	mov	bp, sp
	mov	ax, 1CAh
	call	someStackOperation
	push	si

	mov	ax, 9000
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_1C6], ax
	mov	[bp+var_1C4], dx

	mov	ax, 500h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_180], ax
	mov	[bp+var_17E], dx

loc_2649C:
	mov	ax, offset s_diskToTransferFrom
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1B4]
	mov	[bp+var_26], ax
	mov	[bp+var_24], ss
	mov	ax, 18h
	push	ax
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	or	ax, ax
	jz	short loc_264E1
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	push	[bp+var_24]
	push	[bp+var_26]
	call	strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

loc_264E1:
	mov	ax, offset s_thievesInf
	push	ds
	push	ax
	push	[bp+var_24]
	push	[bp+var_26]
	call	strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_2653C
	mov	ax, offset s_noCharactersFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4

	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	loc_2649C

loc_2653C:
	mov	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx

	mov	[bp+var_1C2], 0
loc_26554:
	mov	ax, charSize
	imul	[bp+var_1C2]
	mov	bx, ax
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_1C2]
	cmp	[bp+var_1C2], 75
	jl	short loc_26554

	mov	ax, 9000
	push	ax
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	[bp+fd]
	call	read
	add	sp, 8

	push	[bp+fd]
	call	close
	add	sp, 2

	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	mov	ax, offset s_partiesInf
	push	ds
	push	ax
	push	dx
	push	[bp+var_26]
	call	strcat
	add	sp, 8
	mov	[bp+var_26], ax
	mov	[bp+var_24], dx

	mov	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+var_1BA], ax
	mov	word ptr [bp+var_1BA+2], dx

	mov	[bp+var_1C2], 0
loc_265DE:
	mov	bx, [bp+var_1C2]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+var_1BA]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_1C2]
	cmp	[bp+var_1C2], 0Ah
	jl	short loc_265DE

	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	open
	add	sp, 6
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_2663C
	mov	ax, offset s_noPartiesFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1B4]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
	jmp	short loc_26654

loc_2663C:
	mov	ax, 500h
	push	ax
	push	[bp+var_17E]
	push	[bp+var_180]
	push	[bp+fd]
	call	read
	add	sp, 8

loc_26654:
	mov	[bp+var_1C2], 0
	mov	[bp+var_1C0], 0
loc_2665A:
	cmp	[bp+var_1C0], 10
	jge	l_partyLimitReached
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	ax, [bp+var_1C2]
	mov	cl, 7
	shl	ax, cl
	add	ax, [bp+var_180]
	mov	dx, [bp+var_17E]
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2665A

l_partyLimitReached:
	dec	[bp+var_1C2]
	mov	ax, [bp+var_1C2]
	mov	[bp+var_1BC], ax
	mov	[bp+var_1C0], 0
loc_2669C:
	cmp	[bp+var_1C0], 75
	jge	l_charLimitReached

	mov	ax, [bp+var_1C2]
	sub	ax, [bp+var_1BC]
	mov	cx, charSize
	imul	cx
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	mov	si, [bp+var_1C2]
	shl	si, 1
	shl	si, 1
	mov	word ptr [bp+si+var_17A], ax
	mov	word ptr [bp+si+var_17A+2], dx
	mov	si, [bp+var_1C2]
	inc	[bp+var_1C2]
	inc	[bp+var_1C0]
	shl	si, 1
	shl	si, 1
	lfs	bx, [bp+si+var_17A]
	cmp	byte ptr fs:[bx], 0
	jnz	short loc_2669C
l_charLimitReached:
	dec	[bp+var_1C2]

l_askWhoTransfers:
	push	[bp+var_1C2]
	lea	ax, [bp+var_17A]
	push	ss
	push	ax
	mov	ax, offset s_whoShallTransfer
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_1C0], ax
	or	ax, ax
	jge	short loc_2671D
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	call	_freeMaybe
	add	sp, 4
	push	[bp+var_17E]
	push	[bp+var_180]
	call	_freeMaybe
	add	sp, 4
	jmp	l_return
loc_2671D:
	mov	ax, [bp+var_1BC]
	cmp	[bp+var_1C0], ax
	jge	l_transferCharacter

l_transferParty:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	mov	ax, word ptr [bp+si+var_17A]
	mov	dx, word ptr [bp+si+var_17A+2]
	mov	[bp+var_22], ax
	mov	[bp+var_20], dx

	mov	[bp+var_17C], 0
loc_26748:
	mov	ax, [bp+var_17C]
	mov	cl, 4
	shl	ax, cl
	add	ax, [bp+var_22]
	mov	dx, [bp+var_20]
	add	ax, 10h
	mov	word ptr [bp+var_1CA], ax
	mov	word ptr [bp+var_1CA+2], dx
	lfs	bx, [bp+var_1CA]
	cmp	byte ptr fs:[bx], 0
	jz	l_askWhoTransfers
	push	[bp+var_1C4]
	push	[bp+var_1C6]
	push	dx
	push	ax
	push	cs
	call	near ptr transfer_findName
	add	sp, 8
	mov	[bp+var_1B6], ax
	cmp	[bp+var_1B6], 0
	jl	short loc_267AE

	mov	ax, charSize
	imul	[bp+var_1B6]
	add	ax, [bp+var_1C6]
	mov	dx, [bp+var_1C4]
	push	dx
	push	ax
	push	cs
	call	near ptr transfer_bt3Character
	add	sp, 4

loc_267AE:
	inc	[bp+var_17C]
	cmp	[bp+var_17C], 7
	jl	short loc_26748
	jmp	l_askWhoTransfers

l_transferCharacter:
	mov	si, [bp+var_1C0]
	shl	si, 1
	shl	si, 1
	push	word ptr [bp+si+var_17A+2]
	push	word ptr [bp+si+var_17A]
	push	cs
	call	near ptr transfer_bt3Character
	add	sp, 4
	jmp	l_askWhoTransfers

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getTransferCharacters endp

; DWORD - arg_0 & arg_2, arg_4 & arg_6
;
; Only used when attempting to transfer a party. Since a party
; definition can have names that don't exist in the thieves.inf
; file, this function searches the thieves.inf for the given
; name.
;
; Attributes: bp-based frame

transfer_findName proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0

l_loop:
	mov	ax, charSize
	imul	[bp+var_2]
	add	ax, [bp+arg_4]
	mov	dx, [bp+arg_6]
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	strcmp
	add	sp, 8
	or	ax, ax
	jz	short l_returnValue
	inc	[bp+var_2]
	cmp	[bp+var_2], 75
	jge	short l_returnFailed
	jmp	short l_loop

l_returnValue:
	mov	ax, [bp+var_2]
	jmp	short l_return

l_returnFailed:
	mov	ax, 0FFFFh

l_return:
	mov	sp, bp
	pop	bp
	retf
transfer_findName endp

; Attributes: bp-based frame

transfer_bt3Character proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	push	[bp+arg_2]
	push	[bp+arg_0]
	call	roster_nameExists
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_26868
	call	roster_countCharacters
	mov	[bp+var_2], ax
	mov	ax, charSize
	imul	[bp+var_2]
	mov	bx, ax
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	copyCharacterBuf
	add	sp, 8
	jmp	short loc_26881
loc_26868:
	mov	ax, offset s_characterAlreadyExists
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	mov	ax, 4000h
	push	ax
	call	getKey
	add	sp, 2
loc_26881:
	mov	sp, bp
	pop	bp
	retf
transfer_bt3Character endp

; Attributes: bp-based frame

importCharacter	proc far

	var_1F0= dword ptr -1F0h
	var_1EC= word ptr -1ECh
	var_1EA= word ptr -1EAh
	var_1E8= word ptr -1E8h
	var_1E6= word ptr -1E6h
	var_1E0= word ptr -1E0h
	var_1C2= word ptr -1C2h
	var_1AE= word ptr -1AEh
	var_17C= word ptr -17Ch
	var_178= word ptr -178h
	var_176= word ptr -176h
	var_24=	word ptr -24h
	var_22=	word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 1F0h
	call	someStackOperation
	push	si

	mov	ax, 2BF2h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	[bp+var_1EC], ax
	mov	[bp+var_1EA], dx
	mov	word ptr [bp+var_1F0], ax
	mov	word ptr [bp+var_1F0+2], dx
loc_268AD:
	mov	ax, offset s_diskToTransferFrom
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1AE]
	mov	[bp+var_24], ax
	mov	[bp+var_22], ss
	mov	ax, 18h
	push	ax
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	or	ax, ax
	jz	short loc_268F2
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	push	[bp+var_22]
	push	[bp+var_24]
	call	strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
loc_268F2:
	mov	bx, [bp+arg_0]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (oldCharFilters+2)[bx]
	push	word ptr oldCharFilters[bx]
	push	[bp+var_22]
	push	[bp+var_24]
	call	strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	lea	ax, [bp+var_1E0]
	push	ss
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	findFirstFile
	add	sp, 8
	or	ax, ax
	jnz	short loc_26965

	mov	ax, offset s_noCharactersFoundOn
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	sub	ax, ax
	push	ax
	call	getKey
	add	sp, 2
	mov	[bp+var_20], ax
	cmp	ax, dosKeys_ESC
	jz	l_return
	jmp	loc_268AD

loc_26965:
	mov	[bp+var_1E8], 0
loc_2696B:
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	lea	ax, [bp+var_1C2]
	push	ss
	push	ax
	push	dx
	push	[bp+var_24]
	call	strcat
	add	sp, 8
	mov	[bp+var_24], ax
	mov	[bp+var_22], dx
	sub	ax, ax
	push	ax
	lea	ax, [bp+var_1AE]
	push	ss
	push	ax
	call	open
	add	sp, 6
	mov	[bp+var_17C], ax
	inc	ax
	jz	short loc_26A01
	mov	ax, 81h	
	push	ax
	push	word ptr [bp+var_1F0+2]
	push	word ptr [bp+var_1F0]
	push	[bp+var_17C]
	call	read
	add	sp, 8
	lfs	bx, [bp+var_1F0]
	cmp	byte ptr fs:[bx+10h], 1
	jnz	short loc_269F5
	mov	si, [bp+var_1E8]
	inc	[bp+var_1E8]
	shl	si, 1
	shl	si, 1
	mov	ax, bx
	mov	dx, fs
	mov	[bp+si+var_178], ax
	mov	[bp+si+var_176], dx
	add	word ptr [bp+var_1F0], 96h 
loc_269F5:
	push	[bp+var_17C]
	call	close
	add	sp, 2
loc_26A01:
	call	sub_27C4A
	or	ax, ax
	jnz	loc_2696B

loc_26A0D:
	push	[bp+var_1E8]
	lea	ax, [bp+var_178]
	push	ss
	push	ax
	mov	ax, offset s_whoShallTransfer
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_1E6], ax
	or	ax, ax
	jge	short loc_26A3E
	push	[bp+var_1EA]
	push	[bp+var_1EC]
	call	_freeMaybe
	add	sp, 4
	jmp	short l_return
loc_26A3E:
	cmp	[bp+arg_0], 0
	jz	short loc_26A5D
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	push	cs
	push	cs
	call	near ptr transfer_bt2Character
	add	sp, 4
	add	sp, 4
	jmp	short loc_26A74
loc_26A5D:
	mov	si, [bp+var_1E6]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_176]
	push	[bp+si+var_178]
	push	cs
	call	near ptr transfer_bt1Character
	add	sp, 4
loc_26A74:
	mov	ax, offset newCharBuffer
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	cs
	call	near ptr transfer_bt3Character
	add	sp, 4
	jmp	short loc_26A0D
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
importCharacter	endp

; Attributes: bp-based frame

convertSpellLevel proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	spLevel= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation

	cmp	[bp+spLevel], 0
	jz	short l_return
	mov	bx, [bp+arg_0]
	mov	al, mageSpellIndex[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 0FFh
	jz	short l_return
	mov	[bp+var_4], 0
loc_26AB8:
	mov	ax, [bp+spLevel]
	cmp	[bp+var_4], ax
	jge	short l_return
	push	[bp+var_2]
	push	[bp+var_4]
	mov	ax, 7
	push	ax
	call	mage_learnSpellLevel
	add	sp, 6
	inc	[bp+var_4]
	jmp	short loc_26AB8
l_return:
	mov	sp, bp
	pop	bp
	retf
convertSpellLevel endp

; Attributes: bp-based frame

transfer_bt2Character proc far

	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	ax, 78h	
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8

	mov	[bp+var_4], 0
l_copyName:
	mov	bx, [bp+var_4]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	mov	[bp+var_8], al
	or	al, al
	jz	short l_copyStats
	mov	byte ptr gs:newCharBuffer._name[bx], al
	inc	[bp+var_4]
	jmp	short l_copyName

l_copyStats:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.strength]
	mov	gs:newCharBuffer.strength, al
	mov	al, fs:[bx+bii_char_t.intelligence]
	mov	gs:newCharBuffer.intelligence, al
	mov	al, fs:[bx+bii_char_t.dexterity]
	mov	gs:newCharBuffer.dexterity, al
	mov	al, fs:[bx+bii_char_t.constitution]
	mov	gs:newCharBuffer.constitution, al
	mov	al, fs:[bx+bii_char_t.luck]
	mov	gs:newCharBuffer.luck, al
	mov	ax, word ptr fs:[bx+bii_char_t.experience]
	mov	dx, fs:[bx+45h]
	mov	word ptr gs:newCharBuffer.experience, ax
	mov	word ptr gs:newCharBuffer.experience+2,	dx
	mov	ax, word ptr fs:[bx+bii_char_t.gold]
	mov	dx, fs:[bx+49h]
	mov	word ptr gs:newCharBuffer.gold,	ax
	mov	word ptr gs:newCharBuffer.gold+2, dx
	mov	al, fs:[bx+bii_char_t.level]
	sub	al, 35
	sbb	cl, cl
	and	al, cl
	add	al, 35
	sub	ah, ah
	mov	gs:newCharBuffer.level,	ax
	mov	gs:newCharBuffer.maxLevel, ax
	mov	ax, fs:[bx+bii_char_t.maxHp]
	mov	gs:newCharBuffer.currentHP, ax
	mov	ax, fs:[bx+bii_char_t.maxHp]
	mov	gs:newCharBuffer.maxHP,	ax
	mov	ax, fs:[bx+bii_char_t.maxSppt]
	mov	gs:newCharBuffer.currentSppt, ax
	mov	ax, fs:[bx+bii_char_t.currentSppt]
	mov	gs:newCharBuffer.maxSppt, ax
	mov	bl, fs:[bx+bii_char_t.class]
	sub	bh, bh
	mov	al, bii_classMap[bx]
	mov	gs:newCharBuffer.class,	al
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.race]
	mov	gs:newCharBuffer.race, al
	call	getCharacterGender
	and	al, 1
	mov	gs:newCharBuffer.gender, al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	shl	bx, 1
	sub	ah, ah
	add	bx, ax
	mov	al, g_classPictureNumber[bx]
	mov	gs:newCharBuffer.picIndex, al
	mov	gs:newCharBuffer.status, ah

	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
l_copyInventory:
	mov	si, [bp+var_4]
	shl	si, 1
	lfs	bx, [bp+arg_0]
	mov	bl, byte ptr fs:[bx+si+bii_char_t.inventory]
	sub	bh, bh
	mov	al, bii_inventoryMap[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_26CE6
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemNo[bx], al
	mov	bx, [bp+var_2]
	mov	al, g_itemBaseCount[bx]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemCount[bx], al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_26CE2
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemFlags[bx], 2
loc_26CE2:
	add	[bp+var_6], 3
loc_26CE6:
	inc	[bp+var_4]
	cmp	[bp+var_4], 8
	jl	l_copyInventory

loc_26CE9:
	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	or	ax, ax
	jz	short loc_26D25
	cmp	ax, class_rogue
	jz	short loc_26CF5
	cmp	ax, class_bard
	jz	short loc_26D0E
	cmp	ax, class_paladin
	jz	short loc_26D25
	cmp	ax, class_hunter
	jz	short loc_26D36
	cmp	ax, class_monk
	jz	short loc_26D25
	jmp	short loc_26D68

loc_26CF5:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.field_52]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, al
	mov	gs:newCharBuffer.specAbil+2, al
	jmp	short loc_26D68

loc_26D0E:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.songsLeft]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, 0FCh 
	jmp	short loc_26D68

loc_26D25:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.numAttacks]
	mov	gs:newCharBuffer.numAttacks, al
	jmp	short loc_26D68

loc_26D36:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.field_55]
	mov	gs:newCharBuffer.specAbil, al

loc_26D68:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.wizdLevel]
	sub	ah, ah
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.sorcLevel]
	sub	ah, ah
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.conjLevel]
	sub	ah, ah
	push	ax
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.magiLevel]
	sub	ah, ah
	push	ax
	mov	ax, 4
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bii_char_t.archLevel]
	sub	ah, ah
	push	ax
	mov	ax, 0Ah
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4

	pop	si
	mov	sp, bp
	pop	bp
	retf
transfer_bt2Character endp


; Attributes: bp-based frame

transfer_bt1Character proc far

	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si

	mov	ax, 78h	
	push	ax
	sub	ax, ax
	push	ax
	mov	ax, offset newCharBuffer
	mov	dx, seg seg027
	push	dx
	push	ax
	call	memset
	add	sp, 8
	mov	[bp+var_4], 0

l_copyName:
	mov	bx, [bp+var_4]
	lfs	si, [bp+arg_0]
	mov	al, fs:[bx+si]
	mov	[bp+var_8], al
	or	al, al
	jz	short l_copyStats
	mov	byte ptr gs:newCharBuffer._name[bx], al
	inc	[bp+var_4]
	jmp	short l_copyName

l_copyStats:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.strength]
	mov	gs:newCharBuffer.strength, al
	mov	al, byte ptr fs:[bx+bi_char_t.intelligence]
	mov	gs:newCharBuffer.intelligence, al
	mov	al, byte ptr fs:[bx+bi_char_t.dexterity]
	mov	gs:newCharBuffer.dexterity, al
	mov	al, byte ptr fs:[bx+bi_char_t.constitution]
	mov	gs:newCharBuffer.constitution, al
	mov	al, byte ptr fs:[bx+bi_char_t.luck]
	mov	gs:newCharBuffer.luck, al
	mov	ax, word ptr fs:[bx+bi_char_t.experience]
	mov	dx, fs:[bx+47h]
	mov	word ptr gs:newCharBuffer.experience, ax
	mov	word ptr gs:newCharBuffer.experience+2,	dx
	mov	ax, word ptr fs:[bx+bi_char_t.gold]
	mov	dx, fs:[bx+4Bh]
	mov	word ptr gs:newCharBuffer.gold,	ax
	mov	word ptr gs:newCharBuffer.gold+2, dx
	mov	ax, fs:[bx+bi_char_t.level]
	sub	al, 35
	sbb	cl, cl
	and	al, cl
	add	al, 35
	mov	gs:newCharBuffer.level,	ax
	mov	gs:newCharBuffer.maxLevel, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.currentHP, ax
	mov	ax, fs:[bx+bi_char_t.maxHP]
	mov	gs:newCharBuffer.maxHP,	ax
	mov	ax, fs:[bx+bi_char_t.currentSppt]
	mov	gs:newCharBuffer.currentSppt, ax
	mov	ax, fs:[bx+bi_char_t.maxSppt]
	mov	gs:newCharBuffer.maxSppt, ax
	mov	bx, fs:[bx+bi_char_t.class]
	mov	al, bii_classMap[bx]
	mov	gs:newCharBuffer.class,	al
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.race]
	mov	gs:newCharBuffer.race, al
	call	getCharacterGender
	and	al, 1
	mov	gs:newCharBuffer.gender, al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	shl	bx, 1
	sub	ah, ah
	add	bx, ax
	mov	al, g_classPictureNumber[bx]
	mov	gs:newCharBuffer.picIndex, al
	mov	gs:newCharBuffer.status, ah
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_26F55
loc_26F52:
loc_26F55:
	mov	si, [bp+var_4]
	shl	si, 1
	lfs	bx, [bp+arg_0]
	mov	bl, byte ptr fs:[bx+si+bi_char_t.inventory]
	sub	bh, bh
	mov	al, bi_inventoryMap[bx]
	cbw
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_26FD1
	mov	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemNo[bx], al
	mov	bx, [bp+var_2]
	mov	al, g_itemBaseCount[bx]
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemCount[bx], al
	mov	bl, gs:newCharBuffer.class
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_26FCD
	mov	bx, [bp+var_6]
	mov	gs:newCharBuffer.inventory.itemFlags[bx], 2
loc_26FCD:
	add	[bp+var_6], 3
loc_26FD1:
	inc	[bp+var_4]
	cmp	[bp+var_4], 8
	jl	loc_26F52

	mov	al, gs:newCharBuffer.class
	sub	ah, ah
	or	ax, ax
	jz	short loc_27010
	cmp	ax, class_rogue
	jz	short loc_26FE0
	cmp	ax, class_bard
	jz	short loc_26FF9
	cmp	ax, class_paladin
	jz	short loc_27010
	cmp	ax, class_hunter
	jz	short loc_27021
	cmp	ax, class_monk
	jz	short loc_27010
	jmp	short loc_27053

loc_26FE0:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_55]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, al
	mov	gs:newCharBuffer.specAbil+2, al
	jmp	short loc_27053

loc_26FF9:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.songsLeft]
	mov	gs:newCharBuffer.specAbil, al
	mov	gs:newCharBuffer.specAbil+1, 0FCh
	jmp	short loc_27053

loc_27010:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.numAttacks]
	mov	gs:newCharBuffer.numAttacks, al
	jmp	short loc_27053

loc_27021:
	lfs	bx, [bp+arg_0]
	mov	al, byte ptr fs:[bx+bi_char_t.field_5B]
	mov	gs:newCharBuffer.specAbil, al

loc_27053:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.wizdLevel]
	sub	ah, ah
	push	ax
	mov	ax, 1
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.sorcLevel]
	sub	ah, ah
	push	ax
	mov	ax, 2
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.conjLevel]
	sub	ah, ah
	push	ax
	mov	ax, 3
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx+bi_char_t.magiLevel]
	sub	ah, ah
	push	ax
	mov	ax, 4
	push	ax
	push	cs
	call	near ptr convertSpellLevel
	add	sp, 4

	pop	si
	mov	sp, bp
	pop	bp
	retf
transfer_bt1Character endp


seg017 ends

; Segment type: Pure code
seg018 segment byte public 'CODE' use16
        assume cs:seg018
;org 0Ch
        assume es:nothing, ss:nothing, ds:dseg, fs:nothing, gs:seg027

; DWORD - var_130 & var_132
;
; Attributes: bp-based frame

copyProtection proc	far

	var_14C= word ptr -14Ch
	var_14A= word ptr -14Ah
	var_136= word ptr -136h
	random16_3= word ptr -134h
	var_132= word ptr -132h
	var_130= word ptr -130h
	var_12E= word ptr -12Eh
	var_12C= word ptr -12Ch
	var_12A= word ptr -12Ah
	random16_1= word ptr -2Ah
	var_28=	word ptr -28h
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	random16_2= word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_A= word ptr	-0Ah
	random16_4= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 14Ch
	call	someStackOperation
	push	si

	call	random
	and	ax, 0Fh
	mov	[bp+random16_1], ax
	call	random
	and	ax, 0Fh
	mov	[bp+random16_2], ax
	call	random
	and	ax, 0Fh
	mov	[bp+random16_3], ax

	call	random
	and	ax, 0Fh
	mov	[bp+random16_4], ax
	mov	bx, ax
	mov	al, byte_4CA18[bx]
	sub	ah, ah
	mov	[bp+var_A], ax			; var_A = byte_4CA18[random16_4]
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_136], ax		; var_136 = var_A >> 4

	mov	al, byte ptr [bp+random16_4]
	xor	al, byte ptr [bp+random16_1]
	test	al, 1				; if ((random16_1 ^ random16_4) & 1)
	jz	short loc_2712B
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	cx, [bp+random16_2]
	and	cx, 1
	or	ax, cx				
	mov	[bp+var_12E], ax		;   var_12E = ((var_A & 7) << 1) | (random16_2 & 1))

	mov	bx, ax
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	add	ax, [bp+random16_1]
	sub	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+random16_2], ax		;   random16_2 = (byte_4CA28[var_12E] + random16_1 - var_136) & 0Fh
						; endif
loc_2712B:
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	[bp+var_12E], ax		; var_12E = ((var_A & 7) << 1)

	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	add	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+var_12C], ax		; var_12C = (random16_2 - random16_1 + var_136) & 0Fh

	mov	bx, [bp+var_12E]
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	cmp	ax, [bp+var_12C]
	jz	short loc_27162			; if (byte_4CA28[var_12E] == var_12C) var_26 = 1
	mov	al, byte_4CA28[bx + 1]
	cmp	ax, [bp+var_12C]		; if (byte_4CA28[var_12E+1] == var_12C) var_26 = 1
	jnz	short loc_27167			; else var_26 = 0
loc_27162:
	mov	ax, 1
	jmp	short loc_27169
loc_27167:
	sub	ax, ax
loc_27169:
	mov	[bp+var_26], ax
	or	ax, ax
	jz	short loc_2717F			; if var_26 != 0
	mov	ax, [bp+random16_3]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl
	or	al, 8
	jmp	short loc_27189			;   var_4 = ((random16_3 - random16_1) << 4) | 8

loc_2717F:					; else
	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl				;   var_4 = (random16_2 - random16_1) << 4

loc_27189:
	mov	[bp+var_4], ax
	mov	al, byte ptr [bp+var_4]
	add	al, byte ptr [bp+var_A]
	sub	ah, ah
	mov	[bp+var_2], ax			; var_2 = var_4 + var_A

	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	add	ax, [bp+var_2]
	mov	[bp+var_24], ax			; var_24 = (var_2 & 0F0h) + var_2

	mov	[bp+var_28], 0Fh		; var_28 = 0Fh
loc_271A9:					; do {
	mov	ax, [bp+var_24]
	and	ax, 1
	mov	[bp+var_4], ax			;   var_4 = var_24 & 1
	shr	[bp+var_24], 1			;   var_24 >> 1
	or	ax, ax				;   if var_4 != 0
	jz	short loc_271C6			;     var_24 += 0B400
	add	byte ptr [bp+var_24+1],	0B4h
loc_271C6:
	dec	[bp+var_28]			; } while (--var_28 > 0)
	cmp	[bp+var_28], 0
	jg	short loc_271A9

loc_271C8:
	mov	al, byte ptr [bp+var_24+1]
	sub	ah, ah
	mov	[bp+var_14C], ax
	mov	ax, [bp+var_2]
	and	ax, 7
	mov	si, ax
	shr	si, 1
	mov	al, byte_4CA38[si]
	sub	ah, ah
	and	[bp+var_14C], ax
	mov	ax, si
	xor	al, 3
	mov	[bp+var_20], ax


	; Zero 20 bytes of var_1E
	mov	[bp+var_28], 0
loc_271F3:
	mov	si, [bp+var_28]
	mov	byte ptr [bp+si+var_1E], 0
	inc	[bp+var_28]
	cmp	[bp+var_28], 20
	jl	short loc_271F3

	mov	[bp+var_28], 0

	mov	ax, [bp+var_14C]
	mov	cl, 7
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[0] = ((var_14C >> 7) & 7) | 0x30

	mov	ax, [bp+var_14C]
	mov	cl, 4
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[1] = ((var_14C >> 4) & 7) | 0x30

	mov	ax, [bp+var_14C]
	shr	ax, 1
	push	ax
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[2] = ((var_14C >> 1) & 7) | 0x30

	mov	ax, [bp+var_24]
	mov	cl, 6
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[3] = ((var_24 >> 6) & 7) | 0x30

	mov	ax, [bp+var_24]
	mov	cl, 3
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[4] = ((var_24 >> 3) & 7 | 0x30

	push	[bp+var_24]
	push	cs
	call	near ptr cp_toDigit
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al			; var_1E[5] = (var_24 & 7) | 0x30

	mov	ax, offset s_copyProtectIntro
	push	ds
	push	ax
	lea	ax, [bp+var_12A]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_1]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationOne+2)[bx]
	push	word ptr g_cpLocationOne[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	ax, offset s_commaSpace
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_2]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationTwo+2)[bx]
	push	word ptr g_cpLocationTwo[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	ax, offset s_commaSpace
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_3]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationThree+2)[bx]
	push	word ptr g_cpLocationThree[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	ax, offset s_commaAnd
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	mov	bx, [bp+random16_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_cpLocationFour+2)[bx]
	push	word ptr g_cpLocationFour[bx]
	push	dx
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	ax, offset s_period
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx

	lea	ax, [bp+var_12A]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 10h
	push	ax
	lea	ax, [bp+var_14A]
	push	ss
	push	ax
	call	readString
	add	sp, 6

	push	[bp+var_20]
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_14A]
	push	ss
	push	ax
	push	cs
	call	near ptr cp_compareStrings
	add	sp, 0Ah

	pop	si
	mov	sp, bp
	pop	bp
	retf
copyProtection endp

; Attributes: bp-based frame

cp_toDigit proc far

	inValue= word ptr	 6

	push	bp
	mov	bp, sp

	mov	ax, [bp+inValue]
	and	ax, 7
	or	al, 30h
	mov	sp, bp
	pop	bp
	retf
cp_toDigit endp

; Attributes: bp-based frame

cp_compareStrings proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si

	mov	ax, [bp+arg_8]
	mov	[bp+var_2], ax
l_loop:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_4]
	cmp	fs:[bx+si], al
;	jnz	short l_returnFail		; Uncomment to enable copy protection
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_loop
	jmp	short l_returnSuccess

l_returnFail:
	sub	ax, ax
	jmp	short l_return

l_returnSuccess:
	mov	ax, 1

l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
cp_compareStrings endp



seg018 ends

include seg019.asm
include seg020.asm
include seg021.asm
include seg022.asm
; Segment type:	Regular
seg023 segment para public 'DATA' use16
	assume cs:seg023
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
graphicsBuf db 4A38h dup(0)	    ; 0
monsterBuf db 480h dup(0)	   ; 0
byte_3BA68 db 11C4h dup(0)	   ; 0
iconLight db 474h dup(0)	  ; 0
iconCompass db 820h dup(0)	    ; 0
iconAreaEnchant	db 550h	dup(0)		; 0
iconShield db 1E0h dup(0)	   ; 0
iconLevitation db 640h dup(0)	       ; 0

characterBitmasks db	0,	0,	0,	0,	0,	0,	0,	0	; 0  
		db	60h,	0F0h,	0F0h,	60h,	60h,	0,	60h,	0	; 1	!
		;	01100000
		;	11110000
		;	11110000
		;	01100000
		;	00000000
		;	01100000
		;	00000000
		db	0D8h,	0D8h,	0D8h,	0,	0,	0,	0,	0	; 2  
		db	6Ch,	6Ch,	0FEh,	6Ch,	0FEh,	6Ch,	6Ch,	0	; 3  
		db	30h,	7Ch,	0C0h,	78h,	0Ch,	0F8h,	30h,	0	; 4  
		db	0,	0C6h,	0CCh,	18h,	30h,	66h,	0C6h,	0	; 5  
		db	38h,	6Ch,	38h,	76h,	0DCh,	0CCh,	76h,	0	; 6  
		db	60h,	60h,	0C0h,	0,	0,	0,	0,	0	; 7  
		db	30h,	60h,	0C0h,	0C0h,	0C0h,	60h,	30h,	0	; 8  
		db	0C0h,	60h,	30h,	30h,	30h,	60h,	0C0h,	0	; 9  
		db	0,	0CCh,	78h,	0FCh,	78h,	0CCh,	0,	0	; 10 
		db	0,	30h,	30h,	0FCh,	30h,	30h,	0,	0	; 11 
		db	0,	0,	0,	0,	0,	60h,	60h,	0C0h	; 12 
		db	0,	0,	0,	0F8h,	0,	0,	0,	0	; 13 
		db	0,	0,	0,	0,	0,	60h,	60h,	0	; 14 
		db	0,	0Ch,	18h,	30h,	60h,	0C0h,	80h,	0	; 15 
		db	7Ch,	0C6h,	0CEh,	0DEh,	0F6h,	0E6h,	7Ch,	0	; 16 
		db	30h,	70h,	30h,	30h,	30h,	30h,	0FCh,	0	; 17 
		db	78h,	0CCh,	0Ch,	38h,	60h,	0CCh,	0FCh,	0	; 18 
		db	78h,	0CCh,	0Ch,	38h,	0Ch,	0CCh,	78h,	0	; 19 
		db	1Ch,	3Ch,	6Ch,	0CCh,	0FEh,	0Ch,	1Eh,	0	; 20 
		db	0FCh,	0C0h,	0F8h,	0Ch,	0Ch,	0CCh,	78h,	0	; 21 
		db	38h,	60h,	0C0h,	0F8h,	0CCh,	0CCh,	78h,	0	; 22 
		db	0FCh,	0CCh,	0Ch,	18h,	30h,	30h,	30h,	0	; 23 
		db	78h,	0CCh,	0CCh,	78h,	0CCh,	0CCh,	78h,	0	; 24 
		db	78h,	0CCh,	0CCh,	7Ch,	0Ch,	18h,	70h,	0	; 25 
		db	0,	0C0h,	0C0h,	0,	0,	0C0h,	0C0h,	0	; 26 
		db	0,	60h,	60h,	0,	0,	60h,	60h,	0C0h	; 27 
		db	18h,	30h,	60h,	0C0h,	60h,	30h,	18h,	0	; 28 
		db	0,	0,	0F8h,	0,	0,	0F8h,	0,	0	; 29 
		db	0C0h,	60h,	30h,	18h,	30h,	60h,	0C0h,	0	; 30 
		db	78h,	0CCh,	0Ch,	18h,	30h,	0,	30h,	0	; 31 
		db	7Ch,	0C6h,	0DEh,	0DEh,	0DEh,	0C0h,	78h,	0	; 32 
		db	30h,	78h,	0CCh,	0CCh,	0FCh,	0CCh,	0CCh,	0	; 33 
		db	0FCh,	66h,	66h,	7Ch,	66h,	66h,	0FCh,	0	; 34 
		db	3Ch,	66h,	0C0h,	0C0h,	0C0h,	66h,	3Ch,	0	; 35 
		db	0F8h,	6Ch,	66h,	66h,	66h,	6Ch,	0F8h,	0	; 36 
		db	0FEh,	62h,	68h,	78h,	68h,	62h,	0FEh,	0	; 37 
		db	0FEh,	62h,	68h,	78h,	68h,	60h,	0F0h,	0	; 38 
		db	3Ch,	66h,	0C0h,	0C0h,	0CEh,	66h,	3Eh,	0	; 39 
		db	0CCh,	0CCh,	0CCh,	0FCh,	0CCh,	0CCh,	0CCh,	0	; 40 
		db	78h,	30h,	30h,	30h,	30h,	30h,	78h,	0	; 41 
		db	1Eh,	0Ch,	0Ch,	0Ch,	0CCh,	0CCh,	78h,	0	; 42 
		db	0E6h,	66h,	6Ch,	78h,	6Ch,	66h,	0E6h,	0	; 43 
		db	0F0h,	60h,	60h,	60h,	62h,	66h,	0FEh,	0	; 44 
		db	0C6h,	0EEh,	0FEh,	0FEh,	0D6h,	0C6h,	0C6h,	0	; 45 
		db	0C6h,	0E6h,	0F6h,	0DEh,	0CEh,	0C6h,	0C6h,	0	; 46 
		db	38h,	6Ch,	0C6h,	0C6h,	0C6h,	6Ch,	38h,	0	; 47 
		db	0FCh,	66h,	66h,	7Ch,	60h,	60h,	0F0h,	0	; 48 
		db	78h,	0CCh,	0CCh,	0CCh,	0DCh,	78h,	1Ch,	0	; 49 
		db	0FCh,	66h,	66h,	7Ch,	6Ch,	66h,	0E6h,	0	; 50 
		db	78h,	0CCh,	0E0h,	70h,	1Ch,	0CCh,	78h,	0	; 51 
		db	0FCh,	0B4h,	30h,	30h,	30h,	30h,	78h,	0	; 52 
		db	0CCh,	0CCh,	0CCh,	0CCh,	0CCh,	0CCh,	0FCh,	0	; 53 
		db	0CCh,	0CCh,	0CCh,	0CCh,	0CCh,	78h,	30h,	0	; 54 
		db	0C6h,	0C6h,	0C6h,	0D6h,	0FEh,	0EEh,	0C6h,	0	; 55 
		db	0C6h,	0C6h,	6Ch,	38h,	38h,	6Ch,	0C6h,	0	; 56 
		db	0CCh,	0CCh,	0CCh,	78h,	30h,	30h,	78h,	0	; 57 
		db	0FEh,	0C6h,	8Ch,	18h,	32h,	66h,	0FEh,	0	; 58 
		db	0F0h,	0C0h,	0C0h,	0C0h,	0C0h,	0C0h,	0F0h,	0	; 59 
		db	0,	0C0h,	60h,	30h,	18h,	0Ch,	4,	0	; 60 
		db	0F0h,	30h,	30h,	30h,	30h,	30h,	0F0h,	0	; 61 
		db	10h,	38h,	6Ch,	0C6h,	0,	0,	0,	0	; 62 
		db	0,	0,	0,	0,	0,	0,	0,	0FFh	; 63 
		db	0C0h,	0C0h,	60h,	0,	0,	0,	0,	0	; 64 
		db	0,	0,	0F0h,	18h,	0F8h,	98h,	0E8h,	0	; 65 
		db	0C0h,	0C0h,	0C0h,	0F0h,	0D8h,	0D8h,	0F0h,	0	; 66 
		db	0,	0,	0F0h,	0D0h,	0C0h,	0D0h,	0F0h,	0	; 67 
		db	38h,	18h,	18h,	78h,	0D8h,	0D8h,	78h,	0	; 68 
		db	0,	0,	70h,	0D8h,	0F8h,	0C0h,	70h,	0	; 69 
		db	38h,	68h,	60h,	0F0h,	60h,	60h,	0F0h,	0	; 70 
		db	0,	0,	68h,	0D8h,	0D8h,	0F8h,	18h,	0F0h	; 71 
		db	0C0h,	0C0h,	0C0h,	0F0h,	0D8h,	0D8h,	0D8h,	0	; 72 
		db	0C0h,	0,	0C0h,	0C0h,	0C0h,	0C0h,	0C0h,	0	; 73 
		db	18h,	0,	18h,	18h,	18h,	0D8h,	0D8h,	0F0h	; 74 
		db	0C0h,	0C0h,	0C8h,	0D8h,	0F0h,	0D8h,	0C8h,	0	; 75 
		db	0E0h,	60h,	60h,	60h,	60h,	60h,	0F0h,	0	; 76 
		db	0,	0,	0CCh,	0FEh,	0FEh,	0D6h,	0C6h,	0	; 77 
		db	0,	0,	0F0h,	0D8h,	0D8h,	0D8h,	0D8h,	0	; 78 
		db	0,	0,	70h,	0D8h,	0D8h,	0D8h,	70h,	0	; 79 - o
		; 00000000
		; 00000000
		; 01110000
		; 11011000
		; 11011000
		; 11011000
		; 01110000
		db	0,	0,	70h,	0D8h,	0D8h,	0F0h,	0C0h,	0C0h	; 80 - p
		; 00000000
		; 00000000
		; 01110000
		; 11011000
		; 11011000
		; 11110000
		; 11000000
		; 11000000
		db	0,	0,	78h,	0D8h,	0D8h,	78h,	18h,	38h	; 81 
		db	0,	0,	70h,	0D8h,	0C0h,	0C0h,	0E0h,	0	; 82 
		db	0,	0,	78h,	0C0h,	70h,	18h,	0F0h,	0	; 83 
		db	20h,	60h,	0F8h,	60h,	60h,	68h,	30h,	0	; 84 
		db	0,	0,	0D8h,	0D8h,	0D8h,	0D8h,	0F8h,	0	; 85 
		db	0,	0,	0D8h,	0D8h,	0D8h,	70h,	20h,	0	; 86 
		db	0,	0,	88h,	0A8h,	0A8h,	0A8h,	0F8h,	0	; 87 
		db	0,	0,	88h,	0D8h,	70h,	0D8h,	88h,	0	; 88 
		db	0,	0,	0D8h,	0D8h,	0D8h,	0F8h,	18h,	0F0h	; 89 
		db	0,	0,	0F8h,	30h,	60h,	0C8h,	0F8h,	0	; 90 
		db	38h,	60h,	60h,	0C0h,	60h,	60h,	38h,	0	; 91 
		db	0C0h,	0C0h,	0C0h,	0,	0C0h,	0C0h,	0C0h,	0	; 92 
		db	0E0h,	30h,	30h,	18h,	30h,	30h,	0E0h,	0	; 93 
		db	76h,	0DCh,	0,	0,	0,	0,	0,	0	; 94 
		db	0FFh,	0FFh,	0FFh,	0FFh,	0FFh,	0FFh,	0FFh,	0FFh	; 95 
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		; 11111111
		db	7Eh,	42h,	42h,	42h,	42h,	42h,	42h,	7Eh	; 96 
		; 01111110
		; 01000010
		; 01000010
		; 01000010
		; 01000010
		; 01000010
		; 01000010
		; 01111110
		db	18h,	3Ch,	7Eh,	0FFh,	18h,	18h,	18h,	18h	; 97 
		db	18h,	18h,	18h,	18h,	0FFh,	7Eh,	3Ch,	18h	; 98 


minimap_squareToDraw db 8, 8, 8, 89h, 8, 8, 8, 8;	0
seg023 ends

include seg024.asm
include seg025.asm
include seg026.asm
include seg027.asm
include dseg.asm
include seg029.asm
