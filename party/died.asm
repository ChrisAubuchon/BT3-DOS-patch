; Attributes: bp-based frame

party_died proc far
	FUNC_ENTER
	mov	byte ptr g_printPartyFlag,	0
	mov	gs:byte_42296, 0FFh
	mov	ax, bigpic_partyDied
	push	ax
	CALL(bigpic_drawPictureNumber)
	PUSH_OFFSET(s_sorryBud)
	CALL(setTitle)
	PRINTOFFSET(s_partyHasExpired, clear)
	IOWAIT
	sub	al, al
	mov	gs:g_nonRandomBattleFlag, al
	mov	g_partyAttackFlag, al
	sub	ah, ah
	mov	g_locationNumber, ax
	mov	sq_north, 0Bh
	mov	sq_east, 0Fh
	mov	g_direction, 0
	mov	ax, 1
	FUNC_EXIT
	retf
party_died endp
