; Attributes: bp-based frame

mfunc_battle proc far

	loopCounter= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(2)
	push	si

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	g_monsterGroupCount, al
	cmp	al, 4
	jb	short l_skipZounds
	PUSH_OFFSET(s_zounds)
	PRINTSTRING
	IOWAIT

l_skipZounds:
	mov	[bp+loopCounter], 0
l_setEncounterLoop:
	mov	al, g_monsterGroupCount
	sub	ah, ah
	cmp	ax, [bp+loopCounter]
	jbe	short l_doBattle
	MONINDEX(ax, STACKVAR(loopCounter), si)
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
	CALL(bat_init)
	or	ax, ax
	jz	short l_battleOver
	mov	g_mapRval, gameState_partyDied
	mov	gs:breakAfterFunc, 0
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	jmp	short l_return

l_battleOver:
	cmp	gs:g_runAwayFlag,	1
	sbb	ax, ax
	neg	ax
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if)
	jmp	short $+2
l_return:
	pop	si
	FUNC_EXIT
	retf
mfunc_battle endp
