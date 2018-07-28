; Attributes: bp-based frame

sp_scrySight proc far

	sqNorth= word ptr -112h
	levelNumber= word ptr -110h
	stringBufferP= dword ptr -10Eh
	squareOffset= word ptr -10Ah
	levelP= dword ptr -108h
	stringBuffer= word ptr -104h
	pluralFlag= word ptr	-4
	sqEast= word ptr	-2

	FUNC_ENTER(112h)
	push	si

	mov	[bp+pluralFlag], 0
	mov	word ptr [bp+levelP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+levelP+2], seg seg022
	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+dun_t.levelNum]
	sub	ah, ah
	mov	[bp+levelNumber], ax

	PUSH_OFFSET(s_youFace)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_directionStringList+2)[bx]
	push	word ptr g_directionStringList[bx]
	push	dx
	push	ax
	STRCAT(stringBufferP)

	cmp	[bp+levelNumber], 0
	jz	l_skipAboveBelow

	mov	ax, [bp+pluralFlag]
	inc	[bp+pluralFlag]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_andAre)
	PLURALIZE(stringBufferP)

	sub	ax, ax
	push	ax
	mov	ax, [bp+levelNumber]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	mov	ax, [bp+levelNumber]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_levels)
	PLURALIZE(stringBufferP)

	mov	al, g_levelFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_aboveBelow)
	PLURALIZE(stringBufferP)

l_skipAboveBelow:
	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, g_sqNorth
	mov	cx, ax
	mov	si, [bp+levelNumber]
	mov	bl, fs:[bx+si+dun_t.dunLevel]
	sub	bh, bh
	mov	al, g_scryDeltaNS[bx]
	cbw
	sub	cx, ax
	mov	[bp+sqNorth], cx
	or	cx, cx
	jz	l_skipNS

	mov	ax, [bp+pluralFlag]
	inc	[bp+pluralFlag]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	mov	cx, 1
	push	cx
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_andAre)
	PLURALIZE(stringBufferP)
	cmp	[bp+sqNorth], 0
	jl	short l_negateNS
	mov	ax, [bp+sqNorth]
	jmp	short l_appendNSOffset

l_negateNS:
	mov	ax, [bp+sqNorth]
	neg	ax

l_appendNSOffset:
	mov	[bp+squareOffset], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+squareOffset]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)
	mov	ax, [bp+squareOffset]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_paces)
	PLURALIZE(stringBufferP)

	cmp	[bp+sqNorth], 0
	jge	short l_useNorth
	mov	ax, 1
	jmp	short l_appendNS

l_useNorth:
	sub	ax, ax

l_appendNS:
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_northSouth)
	PLURALIZE(stringBufferP)

l_skipNS:
	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, g_sqEast
	mov	cx, ax
	mov	si, [bp+levelNumber]
	mov	bl, fs:[bx+si+dun_t.dunLevel]
	sub	bh, bh
	mov	al, g_scryDeltaEW[bx]
	cbw
	sub	cx, ax
	mov	[bp+sqEast], cx
	or	cx, cx
	jz	l_skipEW

	mov	ax, [bp+pluralFlag]
	inc	[bp+pluralFlag]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_andAre)
	PLURALIZE(stringBufferP)
	cmp	[bp+sqEast], 0
	jl	short l_negateEW

	mov	ax, [bp+sqEast]
	jmp	short l_appendEWOffset

l_negateEW:
	mov	ax, [bp+sqEast]
	neg	ax

l_appendEWOffset:
	mov	[bp+squareOffset], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+squareOffset]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)
	mov	ax, [bp+squareOffset]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_paces)
	PLURALIZE(stringBufferP)
	cmp	[bp+sqEast], 0
	jge	short l_useEast
	mov	ax, 1
	jmp	short l_appendEW

l_useEast:
	sub	ax, ax

l_appendEW:
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_eastWest)
	PLURALIZE(stringBufferP)

l_skipEW:
	cmp	[bp+pluralFlag], 0
	jz	short l_atEntranceSq

	mov	ax, offset s_of
	jmp	short l_appendBase

l_atEntranceSq:
	mov	ax, offset s_andAreAt

l_appendBase:
	push	ds
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	mov	si, [bp+levelNumber]
	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	mov	[bp+squareOffset], ax
	mov	bx, ax
	mov	al, g_scryBaseMap[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_scryBaseList+2)[bx]
	push	word ptr g_scryBaseList[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	IOWAIT

	pop	si
	FUNC_EXIT
	retf
sp_scrySight endp
