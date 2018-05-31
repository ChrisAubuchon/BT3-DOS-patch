; Attributes: bp-based frame

gameLoop proc far
	currentState= word ptr	 6

	FUNC_ENTER
	call	far ptr j_nullsub_3

l_loop:
	cmp	[bp+currentState], 0FFh		; 0FFh - Exit game
	jz	short l_return

	mov	g_mapRval, 0
	mov	ax, [bp+currentState]

	cmp	ax, gameState_inCamp
	jz	short l_enterCamp

	cmp	ax, gameState_inWilderness
	jz	short l_enterWild

	cmp	ax, gameState_inDungeon
	jz	short l_enterDungeon

	cmp	ax, gameState_partyDied
	jz	short l_party_died

	jmp	short l_return

l_enterCamp:
	CALL(camp_enter)
	mov	[bp+currentState], ax
	jmp	short l_loop

l_enterWild:
	CALL(wild_main, near)
	mov	[bp+currentState], ax
	jmp	short l_loop

l_enterDungeon:
	mov	inDungeonMaybe, 1
	CALL(dun_main, near)
	mov	[bp+currentState], ax
	mov	inDungeonMaybe, 0
	jmp	short l_loop

l_party_died:
	CALL(party_died)
	mov	[bp+currentState], ax
	jmp	short l_loop

l_return:
	FUNC_EXIT
	retf
gameLoop endp
