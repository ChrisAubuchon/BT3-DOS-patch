; Segment type:	Pure code
seg007 segment word public 'CODE' use16
	assume cs:seg007
;org 0Dh
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_191CD:
align 2
; This function	sets the direction facing in the
; opposite direction. Used when	exiting	buildings.
; If the party was facing north, after this function
; they would be	facing south.
; Attributes: bp-based frame

map_turnPartyAround proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, dirFacing
	add	ax, 2
	and	ax, 3
	mov	dirFacing, ax
	mov	sp, bp
	pop	bp
locret_191ED:
	retf
map_turnPartyAround endp

; Attributes: bp-based frame
map_movePartyOneSq proc	far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	mov	si, dirFacing
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	sq_north, ax
	mov	ax, dirDeltaE[si]
	add	sq_east, ax
	pop	si
	mov	sp, bp
	pop	bp
	retf
map_movePartyOneSq endp

; This function	is the mechanism behind	an if-then
; clause in the	code.
; Attributes: bp-based frame

_mfunc_ifBranch	proc far

	memOff=	word ptr  6
	memSeg=	word ptr  8
	rval= word ptr	0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
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
	jmp	short loc_1926A
loc_1925F:
	mov	gs:breakAfterFunc, 1
loc_1926A:
	jmp	short loc_1927C
loc_1926C:
	cmp	gs:breakAfterFunc, 0
	jz	short loc_1927C
	add	[bp+memOff], 2
loc_1927C:
	mov	ax, [bp+memOff]
	mov	dx, [bp+memSeg]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_mfunc_ifBranch	endp

; Attributes: bp-based frame

dun_changeLevels proc far

	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	word ptr [bp+var_4], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_4+2], seg seg022
	mov	si, dunLevelNum
	lfs	bx, [bp+var_4]
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

	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	word ptr [bp+var_4], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_4+2], seg seg022
	lfs	bx, [bp+var_4]
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

	dataOffset= word ptr  6
	dataSegment= word ptr  8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	word_4EE66, 0
	jnz	short loc_193B0
	mov	word_4EE66, 1
	call	text_clear
	mov	al, levFlags
	sub	ah, ah
	and	ax, 10h
	push	ax
	mov	ax, offset aThereAreStairs
	push	ds
	push	ax
	call	stairsPluralHelper
	add	sp, 6
	call	getYesNo
	or	ax, ax
	jz	short loc_193B0
	push	[bp+dataSegment]
	push	[bp+dataOffset]
	push	cs
	call	near ptr mfunc_zero4ee66
	add	sp, 4
	dec	dunLevelNum
	jns	short loc_193AC
	push	cs
	call	near ptr dun_setExitLocation
	jmp	short loc_193B0
loc_193AC:
	push	cs
	call	near ptr dun_changeLevels
loc_193B0:
	mov	ax, [bp+dataOffset]
	mov	dx, [bp+dataSegment]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_downStairs endp

; Attributes: bp-based frame

mfunc_upStairs proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	word_4EE66, 0
	jnz	short loc_1941F
	mov	word_4EE66, 1
	call	text_clear
	mov	al, levFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	mov	ax, offset aThereAreStairs
	push	ds
	push	ax
	call	stairsPluralHelper
	add	sp, 6
	call	getYesNo
	or	ax, ax
	jz	short loc_1941F
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr mfunc_zero4ee66
	add	sp, 4
	inc	dunLevelNum
	push	cs
	call	near ptr dun_changeLevels
loc_1941F:
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_upStairs endp

; Attributes: bp-based frame

sub_1942B proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	jmp	short loc_1949E
l_convertToGeomancer:
	mov	al, gs:byte_42288
	sub	ah, ah
	push	ax
	call	far ptr convertToGeomancer
	add	sp, 2
	jmp	short loc_194B4
loc_1945B:
	cmp	inDungeonMaybe, 0
	jz	short loc_1946E
	call	sub_253D0
	jmp	short loc_19473
loc_1946E:
	call	printLocation
loc_19473:
	jmp	short loc_194B4
doVictory:
	call	doVictoryMaybe
	jmp	short loc_194B4
loc_1947C:
	call	geomancerSomething
	mov	gs:breakAfterFunc, ax
	jmp	short loc_194B4
loc_1948B:
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr sub_1B0BA
	add	sp, 4
	jmp	short loc_194BC
	jmp	short loc_194B4
	jmp	short loc_194B4
loc_1949E:
	cmp	ax, 3
	jz	short l_convertToGeomancer
	cmp	ax, 4
	jz	short loc_1945B
	cmp	ax, 5
	jz	short doVictory
	cmp	ax, 9
	jz	short loc_1947C
	jmp	short loc_1948B
loc_194B4:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
loc_194BC:
	mov	sp, bp
	pop	bp
	retf
sub_1942B endp

; Attributes: bp-based frame

mfunc_teleport proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr mfunc_zero4ee66
	add	sp, 4
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	sq_north, ax
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	sq_east, ax
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	cmp	inDungeonMaybe, 0
	jz	short loc_19557
	cmp	ax, 80h
	jb	short loc_19531
	mov	buildingRvalMaybe, 2
	and	ax, 7Fh
	mov	currentLocationMaybe, ax
	jmp	short loc_19555
loc_19531:
	mov	ax, [bp+var_2]
	cmp	dunLevelIndex, ax
	jz	short loc_1954A
	mov	buildingRvalMaybe, 4
loc_1954A:
	mov	ax, [bp+var_2]
	mov	dunLevelIndex, ax
loc_19555:
	jmp	short loc_1959D
loc_19557:
	cmp	[bp+var_2], 80h
	jb	short loc_19579
	mov	buildingRvalMaybe, 4
	mov	ax, [bp+var_2]
	and	ax, 7Fh
	mov	dunLevelIndex, ax
	jmp	short loc_1959D
loc_19579:
	mov	ax, [bp+var_2]
	cmp	currentLocationMaybe, ax
	jz	short loc_19592
	mov	buildingRvalMaybe, 2
loc_19592:
	mov	ax, [bp+var_2]
	mov	currentLocationMaybe, ax
loc_1959D:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_teleport endp

; Attributes: bp-based frame

mfunc_battle proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	byte_4EEC9, al
	cmp	al, 4
	jb	short loc_195E3
	mov	ax, offset aZounds
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_195E3:
	mov	[bp+var_2], 0
	jmp	short loc_195ED
loc_195EA:
	inc	[bp+var_2]
loc_195ED:
	mov	al, byte_4EEC9
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jbe	short loc_1962A
	getMonP	[bp+var_2], si
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	byte ptr gs:monGroups._name[si], al
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	gs:monGroups.groupSize[si], al
	jmp	short loc_195EA
loc_1962A:
	mov	gs:byte_42458, 1
	mov	partyAttackFlag, 0
	call	bat_init
	or	ax, ax
	jz	short loc_19665
	mov	buildingRvalMaybe, 5
	mov	gs:breakAfterFunc, 0
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short loc_19683
loc_19665:
	cmp	gs:runAwayFlag,	1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
loc_19683:
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_battle endp

; Attributes: bp-based frame

mfunc_clearPrintString proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	text_clear
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr mfunc_printString
	add	sp, 4
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_clearPrintString endp

; Replace the opcode at	*membuf	with 0xff effectively
; removing the code from the level. Used so the	party
; only runs the	code at	the current square once	per
; level.
; Attributes: bp-based frame

mfunc_ffcode proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0FFh
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	add	ax, 2
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ffcode endp

; This function	draws the bigpic image located at
; *memBuf;
; Attributes: bp-based frame

mfunc_drawBigpic proc far

	picNo= word ptr	-2
	memBuf=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+memBuf]
	inc	word ptr [bp+memBuf]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+picNo], ax
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	mov	ax, word ptr [bp+memBuf]
	mov	dx, word ptr [bp+memBuf+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_drawBigpic endp

; This function	reads an 0x80AND'd string from *membuf
; and sets the title. The string is 0xff terminated.
; Attributes: bp-based frame

mfunc_setTitle proc far

	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 102h
	call	someStackOperation
	push	si
	mov	[bp+var_102], 0
loc_1971F:
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0FFh
	jz	short loc_1973E
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	and	al, 7Fh
	mov	si, [bp+var_102]
	inc	[bp+var_102]
	mov	byte ptr [bp+si+var_100], al
	jmp	short loc_1971F
loc_1973E:
	mov	si, [bp+var_102]
	mov	byte ptr [bp+si+var_100], 0
	inc	word ptr [bp+arg_0]
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	setTitle
	add	sp, 4
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_setTitle endp

; Attributes: bp-based frame

mfunc_getChMaybe proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	wait4IO
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_getChMaybe endp

; Attributes: bp-based frame

mfunc_text_clear proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	text_clear
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_text_clear endp

; Attributes: bp-based frame

mfunc_ifFlag proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr checkProgressFlags
	add	sp, 2
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifFlag endp

; Attributes: bp-based frame

mfunc_ifNotFlag	proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr checkProgressFlags
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifNotFlag	endp

; Attributes: bp-based frame

checkProgressFlags proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_4], ax
	mov	ax, [bp+arg_0]
	and	ax, 7
	mov	[bp+var_2], ax
	mov	bx, [bp+var_4]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+var_2]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
checkProgressFlags endp

; Attributes: bp-based frame

sub_19855 proc far

	var_1C=	dword ptr -1Ch
	var_18=	word ptr -18h
	var_14=	word ptr -14h
	var_12=	dword ptr -12h
	var_E= word ptr	-0Eh
	charBufOff= word ptr -0Ch
	charBufSeg= word ptr -0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 1Ch
	call	someStackOperation
	mov	[bp+charBufOff], offset	g_rosterCharacterBuffer
	mov	[bp+charBufSeg], seg seg022
	mov	ax, [bp+charBufOff]
	mov	dx, [bp+charBufSeg]
	add	ax, 24h	
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_E], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_14], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_18], ax
	mov	ax, [bp+var_E]
	shl	ax, 1
	add	ax, [bp+var_6]
	mov	word ptr [bp+var_1C], ax
	mov	word ptr [bp+var_1C+2],	dx
	lfs	bx, [bp+var_1C]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	cx, [bp+var_14]
	mov	dx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, dx
	add	ax, cx
	add	ax, offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_12], ax
	mov	word ptr [bp+var_12+2],	seg seg022
	mov	ax, [bp+var_18]
	and	ax, 0Fh
	mov	[bp+var_2], ax
	mov	cl, 4
	shr	[bp+var_18], cl
	test	byte ptr [bp+var_18], 2
	jz	short loc_198EC
	inc	word ptr [bp+var_12]
loc_198EC:
	test	byte ptr [bp+var_18], 1
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
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_19855 endp

; Attributes: bp-based frame

mfunc_setFlag proc far

	flagNo=	word ptr -2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+flagNo], ax
	mov	ax, 0FFh
	push	ax
	push	[bp+flagNo]
	push	cs
	call	near ptr _updateFlags
	add	sp, 4
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setFlag endp

; Attributes: bp-based frame

mfunc_clearFlag	proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	sub	ax, ax
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr _updateFlags
	add	sp, 4
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_clearFlag	endp

; Attributes: bp-based frame

_updateFlags proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	flagNo=	word ptr  6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+flagNo]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_6], ax
	mov	ax, [bp+flagNo]
	and	ax, 7
	mov	[bp+var_4], ax
	mov	bx, [bp+var_6]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+var_4]
	mov	cl, flagMaskList[bx]
	sub	ch, ch
	and	ax, cx
	mov	[bp+var_2], ax
	mov	al, byteMaskList[bx]
	and	al, [bp+arg_2]
	or	al, byte ptr [bp+var_2]
	mov	bx, [bp+var_6]
	mov	g_gameProgressFlags[bx], al
	mov	sp, bp
	pop	bp
	retf
_updateFlags endp

; Attributes: bp-based frame
mfunc_ifCurSpellEQ proc	far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	cmp	ax, g_curSpellNumber
	jnz	short loc_19A21
	mov	ax, 1
	jmp	short loc_19A23
loc_19A21:
	sub	ax, ax
loc_19A23:
	mov	[bp+var_2], ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifCurSpellEQ endp

; Attributes: bp-based frame

mfunc_setMapRval proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	gs:mapRval, 1
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setMapRval endp

; Attributes: bp-based frame

mfunc_printString proc far

	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 100h
	call	someStackOperation
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_mfunc_getString
	add	sp, 8
	mov	[bp+arg_0], ax
	mov	[bp+arg_2], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_printString endp

; Attributes: bp-based frame

mfunc_doNothing	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_doNothing	endp

; Attributes: bp-based frame
mfunc_ifChHasItemF proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	al, charSize
	mul	gs:byte_42288
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemFlags[bx]
	mov	[bp+var_6], ax
	sar	ax, 1
	sar	ax, 1
	and	ax, 0Fh
	mov	[bp+var_2], ax
	cmp	[bp+var_4], ax
	jnz	short loc_19B02
	mov	ax, 1
	jmp	short loc_19B04
loc_19B02:
	sub	ax, ax
loc_19B04:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifChHasItemF endp

; Attributes: bp-based frame

mfunc_getItem proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 10Ch
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_108], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_6], ax
loc_19B4A:
	call	text_clear
	mov	ax, offset aWhoWantsToGetT
	push	ds
	push	ax
	lea	ax, [bp+var_106]
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
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	call	readSlotNumber
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_19BB0
	sub	ax, ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	loc_19CB5
loc_19BB0:
	push	[bp+var_6]
	push	[bp+var_108]
	push	[bp+var_2]
	push	[bp+var_4]
	call	inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short loc_19C46
	getCharP	[bp+var_4], bx
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	mov	ax, offset aGotThe
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
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 1
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short loc_19CB5
	jmp	short loc_19CB2
loc_19C46:
	mov	ax, offset s_sorryBut
	push	ds
	push	ax
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	getCharP	[bp+var_4], bx
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
	mov	ax, offset aCanTCarryAny_0
	push	ds
	push	ax
	push	dx
	push	[bp+var_10C]
	call	strcat
	add	sp, 8
	mov	[bp+var_10C], ax
	mov	[bp+var_10A], dx
	lea	ax, [bp+var_106]
	push	ss
	push	ax
	call	printString
	add	sp, 4
loc_19CB2:
	jmp	loc_19B4A
loc_19CB5:
	mov	sp, bp
	pop	bp
	retf
mfunc_getItem endp

; Attributes: bp-based frame

mfunc_ifHasItem	proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr sub_19D2A
	add	sp, 2
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifHasItem	endp

; Attributes: bp-based frame
mfunc_ifNotHasItem proc	far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr sub_19D2A
	add	sp, 2
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifNotHasItem endp

; Attributes: bp-based frame

sub_19D2A proc far

	charNo=	word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+charNo], 0
	jmp	short loc_19D3F
loc_19D3C:
	inc	[bp+charNo]
loc_19D3F:
	cmp	[bp+charNo], 7
	jge	short loc_19D92
	mov	[bp+var_2], 1
	jmp	short loc_19D50
loc_19D4C:
	add	[bp+var_2], 3
loc_19D50:
	cmp	[bp+var_2], inventorySize
	jge	short loc_19D90
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_2]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short loc_19D8E
	mov	al, byte ptr [bp+var_2]
	dec	al
	mov	gs:g_usedItemSlotNumber, al
	mov	al, byte ptr [bp+charNo]
	mov	gs:byte_42288, al
	mov	ax, 1
	jmp	short loc_19D96
loc_19D8E:
	jmp	short loc_19D4C
loc_19D90:
	jmp	short loc_19D3C
loc_19D92:
	sub	ax, ax
	jmp	short $+2
loc_19D96:
	mov	sp, bp
	pop	bp
	retf
sub_19D2A endp

; Attributes: bp-based frame

mfunc_ifW4ee66 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, word_4EE66
	mov	[bp+var_2], ax
	mov	word_4EE66, 1
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifW4ee66 endp

; Attributes: bp-based frame

mfunc_ifYesNo proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	getYesNo
	mov	[bp+var_2], ax
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifYesNo endp

; Attributes: bp-based frame
mfunc_goto proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	map_getDataOffsetP
	add	sp, 4
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_goto endp

; Attributes: bp-based frame

mfunc_battleNoCry proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	gs:byte_4228B, 1
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr mfunc_battle
	add	sp, 4
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_battleNoCry endp

; Attributes: bp-based frame

mfunc_zero4ee66	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	word_4EE66, 0
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_zero4ee66	endp

; Attributes: bp-based frame

mfunc_turnAround proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	cs
	call	near ptr map_turnPartyAround
	push	cs
	call	near ptr map_movePartyOneSq
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_turnAround endp

; Attributes: bp-based frame

mfunc_removeItem proc far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr _removeItem
	add	sp, 2
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_removeItem endp

; Attributes: bp-based frame

_removeItem proc far

	charNo=	word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+charNo], 0
	jmp	short loc_19EB4
loc_19EB1:
	inc	[bp+charNo]
loc_19EB4:
	cmp	[bp+charNo], 7
	jge	short loc_19F08
	mov	[bp+var_2], 1
	jmp	short loc_19EC5
loc_19EC1:
	add	[bp+var_2], 3
loc_19EC5:
	cmp	[bp+var_2], 24h	
	jge	short loc_19F06
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_2]
	mov	al, gs:party.inventory.itemFlags[bx]
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short loc_19F04
	mov	ax, [bp+var_2]
	dec	ax
	mov	gs:word_42416, ax
	mov	ax, [bp+charNo]
	mov	gs:word_4244C, ax
	call	inven_pack
	jmp	short loc_19F06
loc_19F04:
	jmp	short loc_19EC1
loc_19F06:
	jmp	short loc_19EB1
loc_19F08:
	mov	sp, bp
	pop	bp
	retf
_removeItem endp

; Attributes: bp-based frame

mfunc_incRegister proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	inc	_mfunc_regs[bx]
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_incRegister endp

; Attributes: bp-based frame

mfunc_decRegister proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	dec	_mfunc_regs[bx]
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_decRegister endp

; Attributes: bp-based frame
mfunc_ifRegNotZero proc	far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	cmp	_mfunc_regs[bx], 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegNotZero endp

; Attributes: bp-based frame

mfunc_ifRegister proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	push	_mfunc_regs[bx]
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegister endp

; Attributes: bp-based frame

mfunc_drainHP proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+var_2], ax
	mov	[bp+var_4], 0
	jmp	short loc_1A01A
loc_1A017:
	inc	[bp+var_4]
loc_1A01A:
	cmp	[bp+var_4], 7
	jge	short loc_1A05E
	mov	ax, [bp+var_2]
	mov	cx, ax
	getCharP	[bp+var_4], bx
	cmp	gs:party.currentHP[bx], cx
	jbe	short loc_1A047
	getCharP	[bp+var_4], bx
	sub	gs:party.currentHP[bx], cx
	jmp	short loc_1A05C
loc_1A047:
	getCharP	[bp+var_4], si
	mov	gs:party.currentHP[si], 0
	or	gs:party.status[si], 4
loc_1A05C:
	jmp	short loc_1A017
loc_1A05E:
	call	party_getLastSlot
	cmp	ax, 7
	jle	short loc_1A073
	mov	buildingRvalMaybe, 5
loc_1A073:
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_drainHP endp

; Attributes: bp-based frame

mfunc_ifInBox proc far

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
	mov	ax, 0Eh
	call	someStackOperation
	push	si
	mov	ax, sq_north
	mov	[bp+var_C], ax
	mov	ax, sq_east
	mov	[bp+var_E], ax
	cmp	inDungeonMaybe, 0
	jnz	short loc_1A0DB
	mov	si, dirFacing
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	[bp+var_C], ax
	mov	ax, dirDeltaE[si]
	add	[bp+var_E], ax
loc_1A0DB:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_8], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_6], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_4], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	ax, [bp+var_8]
	cmp	[bp+var_C], ax
	jl	short loc_1A132
	mov	ax, [bp+var_4]
	cmp	[bp+var_C], ax
	jg	short loc_1A132
	mov	ax, [bp+var_6]
	cmp	[bp+var_E], ax
	jl	short loc_1A132
	mov	ax, [bp+var_2]
	cmp	[bp+var_E], ax
	jg	short loc_1A132
	mov	ax, 1
	jmp	short loc_1A134
loc_1A132:
	sub	ax, ax
loc_1A134:
	mov	[bp+var_A], ax
	push	ax
	push	fs
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_ifInBox endp

; Attributes: bp-based frame

mfunc_invANDc3 proc far

	var_6= dword ptr -6
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	shl	ax, 1
	shl	ax, 1
	mov	[bp+var_2], ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], seg seg027
	lfs	bx, [bp+var_6]
	mov	al, fs:[bx]
	and	al, 0C3h
	or	al, byte ptr [bp+var_2]
	mov	fs:[bx], al
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_invANDc3 endp

; Attributes: bp-based frame

mfunc_addToInv proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	al, 78h	
	mul	gs:byte_42288
	mov	si, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	si, ax
	mov	al, gs:party.inventory.itemCount[si]
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	mov	al, gs:party.inventory.itemNo[si]
	sub	ah, ah
	mov	[bp+var_4], ax
	cmp	[bp+var_2], 0FEh 
	jle	short loc_1A1FC
	mov	[bp+var_2], 0FEh 
loc_1A1FC:
	mov	bx, [bp+var_4]
	mov	al, byte_464B8[bx]
	sub	ah, ah
	sub	ax, [bp+var_2]
	sbb	cx, cx
	and	ax, cx
	add	ax, [bp+var_2]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	gs:party.inventory.itemCount[bx], cl
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_addToInv endp

; Attributes: bp-based frame

mfunc_subFromInv proc far

	var_A= dword ptr -0Ah
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	mov	al, 78h	
	mul	gs:byte_42288
	mov	cl, gs:g_usedItemSlotNumber
	sub	ch, ch
	add	ax, cx
	add	ax, offset party.inventory.itemCount
	mov	word ptr [bp+var_A], ax
	mov	word ptr [bp+var_A+2], seg seg027
	lfs	bx, [bp+var_A]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_4], ax
	cmp	[bp+var_2], 0FEh 
	jz	short loc_1A2A6
	cmp	[bp+var_2], ax
	jl	short loc_1A29E
	mov	al, byte ptr [bp+var_2]
	sub	al, byte ptr [bp+var_4]
	jmp	short loc_1A2A0
loc_1A29E:
	sub	al, al
loc_1A2A0:
	lfs	bx, [bp+var_A]
	mov	fs:[bx], al
loc_1A2A6:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_subFromInv endp

; Attributes: bp-based frame

mfunc_addToRegister proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+var_2], ax
	mov	ax, [bp+var_2]
	mov	bx, [bp+var_4]
	shl	bx, 1
	add	_mfunc_regs[bx], ax
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_addToRegister endp

; Attributes: bp-based frame

mfunc_subFromRegister proc far

	register= word ptr -4
	value= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+register], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+value], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+value], ax
	mov	ax, [bp+value]
	mov	bx, [bp+register]
	shl	bx, 1
	sub	_mfunc_regs[bx], ax
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_subFromRegister endp

; Attributes: bp-based frame
mfunc_setDirFacing proc	far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	dirFacing, ax
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setDirFacing endp

; Attributes: bp-based frame

mfunc_getStrFromUser proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

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
	mov	[bp+var_2], 0
	jmp	short loc_1A3A4
loc_1A3A1:
	inc	[bp+var_2]
loc_1A3A4:
	cmp	[bp+var_2], 10h
	jge	short loc_1A3CF
	mov	bx, [bp+var_2]
	mov	al, gs:mfunc_ioBuf[bx]
	sub	ah, ah
	push	ax
	call	_str_capitalize
	add	sp, 2
	mov	bx, [bp+var_2]
	mov	gs:mfunc_ioBuf[bx], al
	jmp	short loc_1A3A1
loc_1A3CF:
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_getStrFromUser endp

; Attributes: bp-based frame
mapstrcmp proc	far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
loc_1A3E5:
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	and	al, 7Fh
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	cmp	al, fs:[bx]
	jnz	short loc_1A3FD
	inc	word ptr [bp+arg_0]
	jmp	short loc_1A3E5
loc_1A3FD:
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short loc_1A40B
	mov	ax, 1
	jmp	short loc_1A40D
loc_1A40B:
	sub	ax, ax
loc_1A40D:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mapstrcmp endp

; Attributes: bp-based frame

mfunc_ifStrEq proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr mapstrcmp
	add	sp, 8
	mov	[bp+var_2], ax
loc_1A436:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	cmp	byte ptr fs:[bx], 0FFh
	jz	short loc_1A444
	jmp	short loc_1A436
loc_1A444:
	push	[bp+var_2]
	push	fs
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifStrEq endp

; Attributes: bp-based frame

mfunc_setRegFromBuf proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	lea	ax, [bp+var_2]
	push	ss
	push	ax
	mov	ax, offset aD
	push	ds
	push	ax
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	sscanf
	add	sp, 0Ch
	mov	ax, [bp+var_2]
	mov	bx, [bp+var_4]
	shl	bx, 1
	mov	_mfunc_regs[bx], ax
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setRegFromBuf endp

; Attributes: bp-based frame
mfunc_getCharacter proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	readSlotNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_1A4CA
	mov	al, byte ptr [bp+var_2]
	mov	gs:byte_42288, al
loc_1A4CA:
	cmp	[bp+var_2], 0
	jl	short loc_1A4D5
	mov	ax, 1
	jmp	short loc_1A4D7
loc_1A4D5:
	sub	ax, ax
loc_1A4D7:
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_getCharacter endp

; Attributes: bp-based frame

mfunc_ifGiveGold proc far

	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	mov	ax, word ptr gs:party.gold[bx]
	mov	dx, word ptr gs:(party.gold+2)[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	bx, [bp+var_6]
	shl	bx, 1
	mov	ax, _mfunc_regs[bx]
	cwd
	mov	[bp+var_A], ax
	mov	[bp+var_8], dx
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	cmp	[bp+var_8], dx
	ja	short loc_1A571
	jb	short loc_1A54C
	cmp	[bp+var_A], ax
	ja	short loc_1A571
loc_1A54C:
	mov	ax, [bp+var_A]
	mov	dx, [bp+var_8]
	mov	cx, ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	sub	word ptr gs:party.gold[bx], cx
	sbb	word ptr gs:(party.gold+2)[bx], dx
	jmp	short loc_1A58A
loc_1A571:
	mov	ax, offset aYouDonTHaveEno
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	3
loc_1A58A:
	mov	bx, [bp+var_6]
	shl	bx, 1
	mov	ax, _mfunc_regs[bx]
	cwd
	cmp	dx, [bp+var_2]
	ja	short loc_1A5AA
	jb	short loc_1A5A5
	cmp	ax, [bp+var_4]
	ja	short loc_1A5AA
loc_1A5A5:
	mov	ax, 1
	jmp	short loc_1A5AC
loc_1A5AA:
	sub	ax, ax
loc_1A5AC:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifGiveGold endp

; Attributes: bp-based frame

sub_1A5C0 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	mov	ax, _mfunc_regs[bx]
	cwd
	mov	cx, ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	add	word ptr gs:party.gold[bx], cx
	adc	word ptr gs:(party.gold+2)[bx], dx
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_1A5C0 endp

; Attributes: bp-based frame

mfunc_ifRegLT proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+var_2], ax
	mov	ax, [bp+var_2]
	mov	bx, [bp+var_4]
	shl	bx, 1
	cmp	_mfunc_regs[bx], ax
	jge	short loc_1A65B
	mov	ax, 1
	jmp	short loc_1A65D
loc_1A65B:
	sub	ax, ax
loc_1A65D:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegLT endp

; Attributes: bp-based frame

mfunc_ifRegEQ proc far
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+var_2], ax
	mov	ax, [bp+var_2]
	mov	bx, [bp+var_4]
	shl	bx, 1
	cmp	_mfunc_regs[bx], ax
	jnz	short loc_1A6BC
	mov	ax, 1
	jmp	short loc_1A6BE
loc_1A6BC:
	sub	ax, ax
loc_1A6BE:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegEQ endp

; Attributes: bp-based frame

mfunc_ifRegGE proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+var_2], ax
	mov	ax, [bp+var_2]
	mov	bx, [bp+var_4]
	shl	bx, 1
	cmp	_mfunc_regs[bx], ax
	jl	short loc_1A71D
	mov	ax, 1
	jmp	short loc_1A71F
loc_1A71D:
	sub	ax, ax
loc_1A71F:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifRegGE endp

; Attributes: bp-based frame

mfunc_learnSpell proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	mov	al, gs:byte_42288
	push	ax
	call	mage_learnSpell
	add	sp, 4
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_learnSpell endp

; Attributes: bp-based frame

mfunc_setRegister proc far

	regNum=	word ptr -4
	val= word ptr -2
	memBuf=	dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+memBuf]
	inc	word ptr [bp+memBuf]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+regNum], ax
	mov	bx, word ptr [bp+memBuf]
	inc	word ptr [bp+memBuf]
	mov	al, fs:[bx]
	mov	[bp+val], ax
	mov	bx, word ptr [bp+memBuf]
	inc	word ptr [bp+memBuf]
	mov	ah, fs:[bx]
	sub	al, al
	add	[bp+val], ax
	mov	ax, [bp+val]
	mov	bx, [bp+regNum]
	shl	bx, 1
	mov	_mfunc_regs[bx], ax
	mov	ax, word ptr [bp+memBuf]
	mov	dx, word ptr [bp+memBuf+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setRegister endp

; Attributes: bp-based frame

mfunc_chHasItemNo proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	cmp	ax, [bp+var_2]
	jnz	short loc_1A7FF
	mov	ax, 1
	jmp	short loc_1A801
loc_1A7FF:
	sub	ax, ax
loc_1A801:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_chHasItemNo endp

; Attributes: bp-based frame
mfunc_packInvMaybe proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:byte_42288
	sub	ah, ah
	mov	gs:word_4244C, ax
	mov	al, gs:g_usedItemSlotNumber
	mov	gs:word_42416, ax
	call	inven_pack
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_packInvMaybe endp

; Attributes: bp-based frame

mfunc_addMonToParty proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	call	party_findEmptySlot
	mov	[bp+var_2], ax
	cmp	ax, 7
	jge	short loc_1A89E
	getMonP	[bp+var_4], bx
	lea	ax, monsterBuf[bx]
	mov	dx, seg	seg023
	push	dx
	push	ax
	push	[bp+var_2]
	call	_sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr g_printPartyFlag,	0
loc_1A89E:
	cmp	[bp+var_2], 7
	jge	short loc_1A8A9
	mov	ax, 1
	jmp	short loc_1A8AB
loc_1A8A9:
	sub	ax, ax
loc_1A8AB:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_addMonToParty endp

; Attributes: bp-based frame
mfunc_ifMonInParty proc	far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	[bp+var_4], 0
	mov	[bp+var_2], 0
	jmp	short loc_1A8DA
loc_1A8D7:
	inc	[bp+var_2]
loc_1A8DA:
	cmp	[bp+var_2], 7
	jge	short loc_1A917
	getCharP	[bp+var_2], si
	cmp	gs:party.class[si], class_monster
	jnz	short loc_1A915
	lea	ax, party._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr mapstrcmp
	add	sp, 8
	or	ax, ax
	jz	short loc_1A915
	mov	[bp+var_4], 1
	jmp	short loc_1A917
loc_1A915:
	jmp	short loc_1A8D7
loc_1A917:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	cmp	byte ptr fs:[bx], 0FFh
	jz	short loc_1A925
	jmp	short loc_1A917
loc_1A925:
	mov	al, byte ptr [bp+var_2]
	mov	gs:byte_42288, al
	push	[bp+var_4]
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_ifMonInParty endp

; Attributes: bp-based frame

mfunc_clrPrtStrOffset proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	call	text_clear
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr mfunc_printStrAtOffset
	add	sp, 4
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_clrPrtStrOffset endp

; Attributes: bp-based frame

mfunc_ifIsNight	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	gs:isNight, 1
	sbb	ax, ax
	neg	ax
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifIsNight	endp

; Attributes: bp-based frame

mfunc_rmMonFromParty proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:byte_42288
	sub	ah, ah
	push	ax
	call	party_pack
	add	sp, 2
	mov	byte ptr g_printPartyFlag,	0
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_rmMonFromParty endp

; Attributes: bp-based frame

sub_1A9C8 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_8], ax
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_2], ax
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_1A9FF
loc_1A9FC:
	inc	[bp+var_4]
loc_1A9FF:
	cmp	[bp+var_4], 7
	jge	short loc_1AA36
	getCharP	[bp+var_4], bx
	add	bx, [bp+var_2]
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+var_8]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_1AA34
	mov	[bp+var_6], 1
	jmp	short loc_1AA36
loc_1AA34:
	jmp	short loc_1A9FC
loc_1AA36:
	push	[bp+var_6]
	push	cs
	call	near ptr chron_questFlagSet
	add	sp, 2
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_1A9C8 endp

; This function	returns	1 if there is a	character
; in the party that has	the bit	set in chronoQuest
; that matches the passed in quest mask.
; Attributes: bp-based frame
chron_questFlagSet proc	far

	qIndex=	word ptr -8
	rval= word ptr -6
	charNo=	word ptr -4
	qByte= word ptr	-2
	questMask= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	ax, [bp+questMask]
	and	ax, 7
	mov	[bp+qIndex], ax
	mov	ax, [bp+questMask]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+qByte], ax
	mov	[bp+rval], 0
	mov	[bp+charNo], 0
	jmp	short loc_1AA82
loc_1AA7F:
	inc	[bp+charNo]
loc_1AA82:
	cmp	[bp+charNo], 7
	jge	short loc_1AACB
	getCharP	[bp+charNo], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1AAC9
	cmp	gs:party.class[si], class_monster
	jnb	short loc_1AAC9
	mov	bx, [bp+qByte]
	add	bx, si
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+qIndex]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_1AAC9
	mov	[bp+rval], 1
	jmp	short loc_1AACB
loc_1AAC9:
	jmp	short loc_1AA7F
loc_1AACB:
	mov	ax, [bp+rval]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
chron_questFlagSet endp

; Attributes: bp-based frame

sub_1AAD5 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr chron_questFlagNotSet
	add	sp, 2
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_1AAD5 endp

; This function	returns	one if there is	a character
; in the party that does NOT have the quest mask
; set.
; Attributes: bp-based frame

chron_questFlagNotSet proc far

	var_8= word ptr	-8
	rval= word ptr -6
	charNo=	word ptr -4
	var_2= word ptr	-2
	questMask= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	mov	ax, [bp+questMask]
	and	ax, 7
	mov	[bp+var_8], ax
	mov	ax, [bp+questMask]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_2], ax
	mov	[bp+rval], 0
	mov	[bp+charNo], 0
	jmp	short loc_1AB38
loc_1AB35:
	inc	[bp+charNo]
loc_1AB38:
	cmp	[bp+charNo], 7
	jge	short loc_1AB81
	getCharP	[bp+charNo], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1AB7F
	cmp	gs:party.class[si], class_monster
	jnb	short loc_1AB7F
	mov	bx, [bp+var_2]
	add	bx, si
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+var_8]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short loc_1AB7F
	mov	[bp+rval], 1
	jmp	short loc_1AB81
loc_1AB7F:
	jmp	short loc_1AB35
loc_1AB81:
	mov	ax, [bp+rval]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
chron_questFlagNotSet endp

; Attributes: bp-based frame

mfunc_setChronQuestFlag	proc far
arg_0= dword ptr  6
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr chron_setQuestFlag
	add	sp, 2
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_setChronQuestFlag	endp

; Attributes: bp-based frame
chron_setQuestFlag proc	far

	var_6= word ptr	-6
	charNo=	word ptr -4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	ax, [bp+arg_0]
	and	ax, 7
	mov	[bp+var_6], ax
	mov	ax, [bp+arg_0]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+var_2], ax
	mov	[bp+charNo], 0
	jmp	short loc_1ABDD
loc_1ABDA:
	inc	[bp+charNo]
loc_1ABDD:
	cmp	[bp+charNo], 7
	jge	short loc_1AC1B
	getCharP	[bp+charNo], si
	cmp	gs:party.class[si], class_monster
	jnb	short loc_1AC19
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1AC19
	mov	bx, [bp+var_6]
	mov	al, byteMaskList[bx]
	mov	bx, [bp+var_2]
	add	bx, si
	or	gs:party.chronoQuest[bx], al
loc_1AC19:
	jmp	short loc_1ABDA
loc_1AC1B:
	pop	si
	mov	sp, bp
	pop	bp
	retf
chron_setQuestFlag endp

; Attributes: bp-based frame

sub_1AC20 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	lfs	bx, [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+var_8], ax
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+var_2], ax
	mov	[bp+var_6], 0
	jmp	short loc_1AC53
loc_1AC50:
	inc	[bp+var_6]
loc_1AC53:
	cmp	[bp+var_6], 7
	jge	short loc_1AC91
	getCharP	[bp+var_6], si
	cmp	gs:party.class[si], class_monster
	jnb	short loc_1AC8F
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1AC8F
	mov	bx, [bp+var_8]
	mov	al, flagMaskList[bx]
	mov	bx, [bp+var_2]
	add	bx, si
	and	gs:party.chronoQuest[bx], al
loc_1AC8F:
	jmp	short loc_1AC50
loc_1AC91:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_1AC20 endp

; Attributes: bp-based frame

sub_1AC9E proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr _partyCharUnderLevel
	add	sp, 2
	mov	[bp+var_4], ax
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_1AC9E endp

; This function	returns	0 if there is a	character
; in the party whose level is less than	the passed
; in level. If there is	not it returns 1.
; Attributes: bp-based frame

_partyCharUnderLevel proc far

	rval= word ptr -4
	counter= word ptr -2
	level= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	[bp+rval], 1
	mov	[bp+counter], 0
	jmp	short loc_1ACF1
loc_1ACEE:
	inc	[bp+counter]
loc_1ACF1:
	cmp	[bp+counter], 7
	jge	short loc_1AD1E
	getCharP	[bp+counter], si
	cmp	byte ptr gs:party._name[si], 0
	jz	short loc_1AD1C
	mov	ax, [bp+level]
	cmp	gs:party.level[si], ax
	jnb	short loc_1AD1C
	mov	[bp+rval], 0
	jmp	short loc_1AD1E
loc_1AD1C:
	jmp	short loc_1ACEE
loc_1AD1E:
	mov	ax, [bp+rval]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
_partyCharUnderLevel endp

; Attributes: bp-based frame

mfunc_isWildSqFlagSet proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	push	si
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+var_6], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+var_8], ax
	push	[bp+var_6]
	push	ax
	call	wild_getSquare
	add	sp, 4
	and	ax, 0Fh
	mov	[bp+var_4], ax
	mov	ax, [bp+var_2]
	cmp	[bp+var_4], ax
	jnz	short loc_1AD95
	mov	ax, 1
	jmp	short loc_1AD97
loc_1AD95:
	sub	ax, ax
loc_1AD97:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_isWildSqFlagSet endp

; Attributes: bp-based frame

mfunc_wildSetSqFlag proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	si, dirFacing
	shl	si, 1
	mov	ax, sq_north
	sub	ax, dirDeltaN[si]
	mov	[bp+var_2], ax
	mov	ax, dirDeltaE[si]
	add	ax, sq_east
	mov	[bp+var_4], ax
	cmp	gs:wildWrapFlag, 0
	jz	short loc_1AE38
	mov	al, gs:mapHeight
	sub	ah, ah
	push	ax
	push	[bp+var_2]
	call	wrapNumber
	add	sp, 4
	mov	[bp+var_2], ax
	mov	al, gs:mapWidth
	sub	ah, ah
	push	ax
	push	[bp+var_4]
	call	wrapNumber
	add	sp, 4
	mov	[bp+var_4], ax
loc_1AE38:
	cmp	[bp+var_2], 0
	jl	short loc_1AE79
	mov	al, gs:mapHeight
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jb	short loc_1AE79
	cmp	[bp+var_4], 0
	jl	short loc_1AE79
	mov	al, gs:mapWidth
	cmp	ax, [bp+var_4]
	jb	short loc_1AE79
	mov	bx, [bp+var_2]
	shl	bx, 1
	shl	bx, 1
	lfs	bx, gs:rowOffset[bx]
	mov	si, [bp+var_4]
	mov	al, byte ptr [bp+var_6]
	mov	fs:[bx+si], al
loc_1AE79:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
mfunc_wildSetSqFlag endp

; Attributes: bp-based frame

mfunc_ifIsClass	proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, 78h	
	mul	gs:byte_42288
	mov	bx, ax
	mov	al, gs:party.class[bx]
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jnz	short loc_1AEC1
	mov	ax, 1
	jmp	short loc_1AEC3
loc_1AEC1:
	sub	ax, ax
loc_1AEC3:
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr _mfunc_ifBranch
	add	sp, 6
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_ifIsClass	endp

; Attributes: bp-based frame

mfunc_printStrAtOffset proc far

	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 104h
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	map_getDataOffsetP
	add	sp, 4
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	add	[bp+arg_0], 2
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	push	dx
	push	[bp+var_104]
	call	_mfunc_getString
	add	sp, 8
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_printStrAtOffset endp

; Attributes: bp-based frame

mfunc_clrAndTeleport proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, 0FEh
	push	ax
	call	bigpic_drawPictureNumber
	add	sp, 2
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr mfunc_teleport
	add	sp, 4
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mfunc_clrAndTeleport endp

; Attributes: bp-based frame

map_execute proc far

	dataOffsetP= dword ptr -0Ch
	opcode=	word ptr -8
	dataCount= word	ptr -6
	sqNorth= word ptr -4
	sqEast=	word ptr -2
	memBuf=	dword ptr  6
	spellFlag= word	ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 0Ch
	call	someStackOperation
	push	word ptr [bp+memBuf+2]
	push	word ptr [bp+memBuf]
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+memBuf], ax
	mov	word ptr [bp+memBuf+2],	dx
	lfs	bx, [bp+memBuf]
	inc	word ptr [bp+memBuf]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+dataCount],	ax
	mov	gs:mapRval, 0
loc_1AF8A:
	mov	ax, [bp+dataCount]
	dec	[bp+dataCount]
	or	ax, ax
	jnz	short loc_1AF97
	jmp	loc_1B0AC
loc_1AF97:
	lfs	bx, [bp+memBuf]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+sqNorth], ax
	cmp	[bp+spellFlag],	0
	jz	short loc_1AFAC
	xor	byte ptr [bp+sqNorth], 80h
loc_1AFAC:
	mov	al, fs:[bx+1]
	sub	ah, ah
	mov	[bp+sqEast], ax
	cmp	[bp+sqNorth], 7Fh 
	jz	short loc_1AFCC
	mov	ax, [bp+sqNorth]
	cmp	sq_north, ax
	jz	short loc_1AFCC
	jmp	loc_1B0A5
loc_1AFCC:
	cmp	[bp+sqEast], 0FFh
	jz	short loc_1AFE4
	mov	ax, [bp+sqEast]
	cmp	sq_east, ax
	jz	short loc_1AFE4
	jmp	loc_1B0A5
loc_1AFE4:
	mov	ax, word ptr [bp+memBuf]
	mov	dx, word ptr [bp+memBuf+2]
	add	ax, 2
	push	dx
	push	ax
	call	map_getDataOffsetP
	add	sp, 4
	mov	word ptr [bp+dataOffsetP], ax
	mov	word ptr [bp+dataOffsetP+2], dx
loc_1AFFD:
	lfs	bx, [bp+dataOffsetP]
	inc	word ptr [bp+dataOffsetP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+opcode], ax
	cmp	ax, 0FFh
	jnz	short loc_1B01D
	mov	gs:breakAfterFunc, 0
	jmp	short loc_1B080
loc_1B01D:
	mov	ax, [bp+opcode]
	and	ax, 80h
	mov	gs:breakAfterFunc, ax
	and	[bp+opcode], 7Fh
	cmp	[bp+opcode], 46h
	jbe	short loc_1B050
	mov	ax, offset aBadOpcode
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	short loc_1B0B6
loc_1B050:
	mov	bx, [bp+opcode]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr off_46CFC[bx]
	mov	dx, word ptr (off_46CFC+2)[bx]
	mov	word ptr gs:dword_42436, ax
	mov	word ptr gs:dword_42436+2, dx
	push	word ptr [bp+dataOffsetP+2]
	push	word ptr [bp+dataOffsetP]
	call	gs:dword_42436
	add	sp, 4
	mov	word ptr [bp+dataOffsetP], ax
	mov	word ptr [bp+dataOffsetP+2], dx
loc_1B080:
	cmp	gs:breakAfterFunc, 0
	jz	short loc_1B08F
	jmp	loc_1AFFD
loc_1B08F:
	cmp	buildingRvalMaybe, 0
	jz	short loc_1B0A5
	mov	ax, gs:mapRval
	jmp	short loc_1B0B6
loc_1B0A5:
	add	word ptr [bp+memBuf], 4
	jmp	loc_1AF8A
loc_1B0AC:
	mov	ax, gs:mapRval
	jmp	short $+2
loc_1B0B6:
	mov	sp, bp
	pop	bp
	retf
map_execute endp

; Attributes: bp-based frame

sub_1B0BA proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, offset aThisFunctionIs
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	jmp	short loc_1B0E6
	wait4IO
loc_1B0E6:
	mov	sp, bp
	pop	bp
locret_1B0E9:
	retf
sub_1B0BA endp

seg007 ends
