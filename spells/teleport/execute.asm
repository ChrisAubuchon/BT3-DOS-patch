; Attributes: bp-based frame

teleport_execute proc far

	var_1A=	dword ptr -1Ah
	newSqN=	word ptr -16h
	newLevelP=	dword ptr -14h
	var_10=	word ptr -10h
	currentLevelP= dword ptr -0Eh
	newSqE= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	sqN= word ptr  6
	sqE= word ptr  8
	level= word ptr	 0Ah

	FUNC_EXIT(1Ah)
	push	si

	cmp	[bp+level], 0
	jl	l_returnZero
	cmp	[bp+level], 7
	jg	l_returnZero

	mov	word ptr [bp+currentLevelP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+currentLevelP+2], seg seg022
	lfs	bx, [bp+currentLevelP]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+newSqN], ax

	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+newSqE], ax

	mov	si, [bp+level]
	test	fs:[bx+si+dun_t.dunLevel], dunLevel_noTeleport
	jnz	l_returnZero

	mov	si, [bp+level]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	cmp	ax, dunLevelIndex
	jnz	short l_readNewLevel

	mov	ax, bx
	mov	dx, word ptr [bp+currentLevelP+2]
	mov	word ptr [bp+newLevelP], ax
	mov	word ptr [bp+newLevelP+2], dx
	jmp	short l_adjustCoordinates

l_readNewLevel:
	mov	ax, 4000
	push	ax
	CALL(_mallocMaybe)
	SAVE_STACK_DWORD(dx, ax, newLevelP)
	push	dx
	push	ax
	mov	si, [bp+level]
	lfs	bx, [bp+currentLevelP]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	add	ax, 0Ah
	push	ax
	CALL(map_read)

l_adjustCoordinates:
	lfs	bx, [bp+newLevelP]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	sub	[bp+newSqN], ax

	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	sub	[bp+newSqE], ax

	cmp	[bp+newSqN], 0
	jl	short loc_212D5

	mov	al, fs:[bx+dun_t._height]
	sub	ah, ah
	cmp	ax, [bp+newSqN]
	jbe	short loc_212D5
	cmp	[bp+newSqE], 0
	jl	short loc_212D5

	mov	al, fs:[bx+dun_t._width]
	cmp	ax, [bp+newSqE]
	ja	short loc_212F6

loc_212D5:
	mov	ax, word ptr [bp+currentLevelP]
	mov	dx, word ptr [bp+currentLevelP+2]
	cmp	bx, ax
	jnz	short loc_212E4

	cmp	word ptr [bp+newLevelP+2], dx
	jz	l_returnZero

loc_212E4:
	PUSH_STACK_DWORD(newLevelP)
	CALL(_freeMaybe)
	jmp	l_returnZero

loc_212F6:
	mov	ax, word ptr [bp+newLevelP]
	mov	dx, word ptr [bp+newLevelP+2]
	add	ax, 24h	
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	mov	ax, [bp+newSqN]
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
	add	ax, word ptr [bp+newLevelP]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	si, [bp+newSqE]
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
	mov	ax, word ptr [bp+currentLevelP]
	mov	dx, word ptr [bp+currentLevelP+2]
	cmp	word ptr [bp+newLevelP], ax
	jnz	short loc_21359
	cmp	word ptr [bp+newLevelP+2],	dx
	jz	short loc_21367

loc_21359:
	PUSH_STACK_DWORD(newLevelP)
	CALL(_freeMaybe)

loc_21367:
	mov	ax, [bp+var_10]
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
teleport_execute endp
