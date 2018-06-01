; Attributes: bp-based frame
bat_partyPackBonuses proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	[bp+var_2], ax
	jmp	short loc_1F0AD
loc_1F0AA:
	inc	[bp+var_2]
loc_1F0AD:
	cmp	[bp+var_2], 6
	jge	short loc_1F0F9
	mov	bx, [bp+var_2]
	mov	al, gs:(byte_42444+1)[bx]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+var_2]
	mov	al, gs:(g_strengthSpellBonus+1)[bx]
	mov	gs:g_strengthSpellBonus[bx], al
	mov	bx, [bp+var_2]
	mov	al, gs:(vorpalPlateBonus+1)[bx]
	mov	gs:vorpalPlateBonus[bx], al
	mov	bx, [bp+var_2]
	mov	al, gs:(g_characterMeleeDistance+1)[bx]
	mov	gs:g_characterMeleeDistance[bx], al
	jmp	short loc_1F0AA
loc_1F0F9:
	mov	gs:byte_42444+6, 0
	mov	gs:g_strengthSpellBonus+6, 0
	mov	gs:vorpalPlateBonus+6, 0
	mov	gs:g_characterMeleeDistance+6, 0
	mov	sp, bp
	pop	bp
	retf
bat_partyPackBonuses endp
