; Attributes: bp-based frame

dunsq_doTrap proc far

	damageAmount= word ptr -10Ch
	trapNumber= word ptr -10Ah
	loopCounter= word ptr -108h
	stringBufferP= dword ptr -106h
	trapHitFlag= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(10Ch)
	push	si

	CALL(trap_levitationCheck, near)
	mov	[bp+trapHitFlag], ax
	or	ax, ax
	jz	l_return

loc_24DCB:
	CALL(random)
	and	ax, 3
	mov	[bp+trapNumber], ax
	cmp	ax, 3
	jz	short loc_24DCB

	mov	al, g_levelNumber
	sub	ah, ah
	and	ax, 7
	shl	ax, 1
	shl	ax, 1
	or	ax, [bp+trapNumber]
	mov	gs:g_trapIndex, ax
	PUSH_OFFSET(s_hitTrap)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	bx, gs:g_trapIndex
	mov	al, g_trapIndexByLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_trapNameList+2)[bx]
	push	word ptr g_trapNameList[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(clear)
	mov	bx, gs:g_trapIndex
	mov	al, g_trapDiceList[bx]
	cbw
	push	ax
	CALL(randomYdX)
	mov	[bp+damageAmount], ax

	mov	si, gs:g_trapIndex
	shl	si, 1
	mov	al, g_trapSaveList._low[si]
	mov	gs:g_monGroups.breathSaveLo, al
	mov	al, g_trapSaveList._high[si]
	mov	gs:g_monGroups.breathSaveHi, al

	mov	[bp+loopCounter], 0
loc_24E97:
	push	[bp+damageAmount]
	push	[bp+loopCounter]
	CALL(trap_doDamage)
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short loc_24E97

l_return:
	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax
	push	ax
	push	g_sqEast
	push	g_sqNorth
	CALL(spGeo_removeTrap)
	mov	ax, [bp+trapHitFlag]

	pop	si
	FUNC_EXIT
	retf
dunsq_doTrap endp
