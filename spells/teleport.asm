; Attributes: bp-based frame

sp_teleport proc far

	stringBuffer= word ptr -114h
	levelP=	dword ptr -14h
	loopCounter= word ptr -10h
	stringBufferP=	dword ptr -0Eh
	lineCount= word ptr	-0Ah
	activeLineNumber= word ptr	-8
	teleDeltaList= word ptr	-6
	spellCaster= word ptr	 6
	spellIndexNumber= word ptr	 8

	FUNC_ENTER(114h)
	push	di
	push	si

	mov	word ptr [bp+levelP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+levelP+2],	seg seg022
	cmp	inDungeonMaybe, 0
	jnz	short l_entry

	push	[bp+spellIndexNumber]
	push	[bp+spellCaster]
	CALL(printSpellFizzled, near)
	jmp	l_return

l_entry:
	mov	g_sameSquareFlag, 0
	mov	[bp+activeLineNumber], 0

	mov	[bp+loopCounter], 0
l_initializeDeltaLoop:
	mov	si, [bp+loopCounter]
	shl	si, 1
	mov	[bp+si+teleDeltaList], 0
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_initializeDeltaLoop

	CALL(text_clear)
	PUSH_OFFSET(s_teleportMenu)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+lineCount], ax
	mov	al, g_levelFlags
	and	ax, 10h
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_downUp)
	PLURALIZE(stringBufferP)

	lfs	bx, [bp+stringBufferP]
	mov	byte ptr fs:[bx], 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING

l_drawScreen:
	mov	al, byte ptr [bp+lineCount]
	add	al, 3
	mov	gs:txt_numLines, al
	mov	[bp+loopCounter], 0
l_printNumberLoop:
	mov	ax, [bp+loopCounter]
	cmp	[bp+activeLineNumber], ax
	jnz	short l_notActiveLine
	mov	ax, 1
	jmp	short l_printNumber
l_notActiveLine:
	sub	ax, ax
l_printNumber:
	push	ax
	mov	si, [bp+loopCounter]
	shl	si, 1
	push	[bp+si+teleDeltaList]
	CALL(teleport_printNumber, near)
	inc	gs:txt_numLines
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 3
	jl	short l_printNumberLoop

	sub	ax, ax
	push	ax
	CALL(getKey)
	cmp	ax, dosKeys_ESC
	jz	l_return
	cmp	ax, ' '
	jz	short l_nextLine
	cmp	ax, dosKeys_upArrow
	jz	short l_incrementCount
	cmp	ax, dosKeys_downArrow
	jz	short l_decrementCount
	jmp	short l_loopNext

l_nextLine:
	inc	[bp+activeLineNumber]
	jmp	short l_loopNext

l_incrementCount:
	mov	si, [bp+activeLineNumber]
	shl	si, 1
	mov	ax, g_teleportMaximumValues[si]
	cmp	[bp+si+teleDeltaList], ax
	jge	short l_dontIncrement
	inc	[bp+si+teleDeltaList]
l_dontIncrement:
	jmp	short l_loopNext

l_decrementCount:
	mov	si, [bp+activeLineNumber]
	shl	si, 1
	mov	ax, g_teleportMaximumValues[si]
	neg	ax
	cmp	[bp+si+teleDeltaList], ax
	jle	short l_loopNext
	dec	[bp+si+teleDeltaList]

l_loopNext:
	cmp	[bp+activeLineNumber], 3
	jl	l_drawScreen

	PRINTOFFSET(s_confirmTeleport)
	CALL(getYesNo)
	or	ax, ax
	jnz	short l_executeTeleport

	PRINTOFFSET(s_cancelTeleport)
	IOWAIT
	jmp	l_return

l_executeTeleport:
	mov	ax, g_dunLevelNum
	add	ax, [bp+teleDeltaList+4]
	push	ax
	mov	ax, g_sqEast
	add	ax, [bp+teleDeltaList+2]
	push	ax
	mov	ax, g_sqNorth
	add	ax, [bp+teleDeltaList]
	push	ax
	CALL(teleport_execute, near)
	or	ax, ax
	jz	l_teleportFailed

l_teleportSuccess:
	PRINTOFFSET(s_successfulTeleport)
	mov	ax, [bp+teleDeltaList]
	add	g_sqNorth, ax
	mov	ax, [bp+teleDeltaList+2]
	add	g_sqEast, ax
	mov	ax, [bp+teleDeltaList+4]
	add	g_dunLevelNum,	ax
	mov	di, g_dunLevelNum
	lfs	bx, [bp+levelP]
	mov	al, fs:[bx+di+dun_t.dunLevel]
	sub	ah, ah
	mov	si, ax
	cmp	dunLevelIndex, si
	jz	short l_return
	mov	dunLevelIndex, si
	mov	g_mapRval, 4
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	g_sqNorth, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	g_sqEast, ax
	mov	gs:levelChangedFlag, 1
	jmp	short l_return

l_teleportFailed:
	PRINTOFFSET(s_failedTeleport)

l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
sp_teleport endp
