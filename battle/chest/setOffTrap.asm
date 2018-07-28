; Attributes: bp-based frame

chest_setOffTrap proc far

	var_108= word ptr -108h
	stringBufferP= dword ptr -106h
	var_102= word ptr -102h
	stringBuffer= word ptr -100h
	arg_0= word ptr	 6

	FUNC_ENTER(108h)
	push	si

	PUSH_OFFSET(s_youSetOff)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	mov	bx, gs:g_trapIndex
	mov	al, g_chestTrapIndexToName[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_chestTrapName+2)[bx]
	push	word ptr g_chestTrapName[bx]
	push	dx
	push	word ptr [bp+stringBufferP]
	STRCAT(stringBufferP)

	mov	bx, gs:g_trapIndex
	mov	al, g_chestTrapDice[bx]
	sub	ah, ah
	push	ax
	CALL(randomYdX)
	mov	[bp+var_108], ax
	mov	si, gs:g_trapIndex
	shl	si, 1
	mov	al, byte ptr g_chestTrapSaveData.lo[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, g_chestTrapSaveData.hi[si]
	mov	gs:monGroups.breathSaveHi, al
	mov	bx, gs:g_trapIndex
	test	g_chestTrapFlags[bx], 80h
	jz	short l_affectWholeParty

	push	[bp+var_108]
	push	[bp+arg_0]
	CALL(chest_doTrap, near)
	jmp	short l_return

l_affectWholeParty:
	mov	[bp+var_102], 0
l_damageLoop:
	push	[bp+var_108]
	push	[bp+var_102]
	CALL(chest_doTrap)
	inc	[bp+var_102]
	cmp	[bp+var_102], 7
	jl	short l_damageLoop

l_return:
	mov	gs:g_trapIndex, 0
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	mov	byte ptr g_printPartyFlag,	0
	IOWAIT
	mov	ax, 1

	pop	si
	FUNC_EXIT
	retf
chest_setOffTrap endp
