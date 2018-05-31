; Attributes: bp-based frame
bat_charGetAction proc	far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	g_partyAttackFlag, 0
	jnz	short loc_1DA49
	test	gs:monGroups.groupSize,	1Fh
	jz	short loc_1DA49
	cmp	[bp+arg_4], 4
	jl	short loc_1DA45
	mov	bx, [bp+arg_4]
	cmp	gs:g_characterMeleeDistance[bx], 0
	jz	short loc_1DA49
loc_1DA45:
	mov	al, 1
	jmp	short loc_1DA4B
loc_1DA49:
	sub	al, al
loc_1DA4B:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+1], 1
	mov	byte ptr fs:[bx+2], 1
	getCharP	[bp+arg_4], bx
	mov	ax, gs:party.currentSppt[bx]
	lfs	bx, [bp+arg_0]
	or	ax, ax
	jz	l_bat_charGetAction_sppts
	mov	al, 1

l_bat_charGetAction_sppts:
	mov	fs:[bx+3], al
	mov	byte ptr fs:[bx+4], 1
	mov	bx, [bp+arg_4]
	cmp	gs:g_characterMeleeDistance[bx], 9
	jnb	short loc_1DAA7
	getCharP	bx, bx
	cmp	gs:party.class[bx], class_rogue
	jnz	short loc_1DAA7
	mov	al, 1
	jmp	short loc_1DAA9
loc_1DAA7:
	sub	al, al
loc_1DAA9:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+5], al
	getCharP	[bp+arg_4], bx
	cmp	gs:party.class[bx], class_bard
	jnz	short loc_1DADB
	mov	ax, itType_instrument
	push	ax
	push	[bp+arg_4]
	call	character_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_1DADB
	mov	al, 1
	jmp	short loc_1DADD
loc_1DADB:
	sub	al, al
loc_1DADD:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+6], al
	mov	sp, bp
	pop	bp
	retf
bat_charGetAction endp
