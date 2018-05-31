; Attributes: bp-based frame

bat_convertSongToCombat	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_2]
	jmp	short loc_1CEC0
loc_1CE55:
	mov	gs:songCanRun, 1
	or	gs:disbelieveFlags, disb_nohelp
	jmp	short loc_1CEDA
loc_1CE6B:
	cmp	[bp+arg_0], 60
	jle	short loc_1CE75
	mov	al, 0Fh
	jmp	short loc_1CE7C
loc_1CE75:
	mov	ax, [bp+arg_0]
	sar	ax, 1
	sar	ax, 1
loc_1CE7C:
	mov	gs:g_songAcBonus,	al
	or	al, al
	jnz	short loc_1CE8D
	inc	gs:g_songAcBonus
loc_1CE8D:
	jmp	short loc_1CEDA
loc_1CE8F:
	mov	ax, [bp+arg_0]
	cmp	ax, 0Fh
	jle	short loc_1CE9E
	mov	ax, 0Fh
loc_1CE9E:
	mov	gs:songRegenHP,	al
	jmp	short loc_1CEDA
loc_1CEA4:
	mov	gs:songExtraAttack, 1
	jmp	short loc_1CEDA
loc_1CEB0:
	mov	gs:songHalfDamage, 1
	jmp	short loc_1CEDA
loc_1CEBC:
	jmp	short loc_1CEDA
	jmp	short loc_1CEDA
loc_1CEC0:
	or	ax, ax
	jz	short loc_1CE55
	cmp	ax, song_sanctuary
	jz	short loc_1CE6B
	cmp	ax, song_bringaround
	jz	short loc_1CE8F
	cmp	ax, song_duotime
	jz	short loc_1CEA4
	cmp	ax, song_shield
	jz	short loc_1CEB0
	jmp	short loc_1CEBC
loc_1CEDA:
	mov	sp, bp
	pop	bp
	retf
bat_convertSongToCombat	endp
