executeKeyboardCommand proc far

	arg_0= word ptr	 6

	FUNC_ENTER

	cmp	[bp+arg_0], dosKeys_F1
	jl	short l_notFunctionKeySpell
	cmp	[bp+arg_0], dosKeys_F7
	jg	short l_notFunctionKeySpell
	push	[bp+arg_0]
	CALL(noncombatCast)
	jmp	l_success

l_notFunctionKeySpell:
	cmp	[bp+arg_0], '1'
	jl	short l_notPrintCharacter
	cmp	[bp+arg_0], '7'
	jg	short l_notPrintCharacter
	mov	ax, [bp+arg_0]
	sub	ax, '1'
	push	ax
	CALL(character_print)
	jmp	l_success
	
l_notPrintCharacter:
	mov	ax, [bp+arg_0]
	jmp	l_keySwitch

l_printHelp:
	CALL(printCommandHelp, near)
	jmp	l_success

l_castSpell:
	sub	ax, ax
	push	ax
	CALL(noncombatCast)
	jmp	l_success
	
l_reorderParty:
	CALL(party_reorder)
	jmp	l_success
	
l_saveGame:
	CALL(saveGame)
	jmp	l_success
	
l_singBardSong:
	CALL(song_singNonCombat)
	jmp	l_success

l_dropMember:
	CALL(dropPartyMember)
	jmp	l_success

l_pauseGame:
	cmp	gs:byte_42296, 0FFh
	jz	l_fail
	mov	gs:advanceTimeFlag, 1
	PUSH_OFFSET(s_pausing)
	CALL(printStringWithWait)
	mov	gs:advanceTimeFlag, 0
	jmp	l_success

l_partyAttack:
	mov	g_partyAttackFlag, 1
	jmp	l_fail

l_battle:
	push di
	push si
	mov	ax, 1
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	mov	di, ax

	mov	g_direction, 2
	mov	si, g_direction
	shl	si, 1

	mov	al, g_tavernData.sqN[di]
	cbw
	add	ax, dirDeltaN[si]
	mov	sq_north, ax

	mov	al, g_tavernData.sqE[di]
	cbw
	sub	ax, dirDeltaE[si]
	mov	sq_east,  ax

	mov	al, g_tavernData.location[di]
	cbw
	mov	g_locationNumber, ax
	pop	si
	pop	di
	CALL(tavern_enter)
	jmp	l_fail

l_useItem:
	CALL(useItem)
	jmp	l_success

l_toggleSound:
	CALL(snd_toggle)
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
;		dw offset l_fail	
		dw offset l_battle
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

