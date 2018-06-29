; Attributes: bp-based frame
bat_partyPackBonuses proc	far

	loopCounter= word ptr	-2
	slotNumber= word ptr	 6

	FUNC_ENTER(2)
	mov	ax, [bp+slotNumber]
	mov	[bp+loopCounter], ax
l_loop:
	mov	bx, [bp+loopCounter]
	mov	al, gs:(byte_42444+1)[bx]
	mov	gs:byte_42444[bx], al
	mov	bx, [bp+loopCounter]
	mov	al, gs:(g_strengthSpellBonus+1)[bx]
	mov	gs:g_strengthSpellBonus[bx], al
	mov	bx, [bp+loopCounter]
	mov	al, gs:(vorpalPlateBonus+1)[bx]
	mov	gs:vorpalPlateBonus[bx], al
	mov	bx, [bp+loopCounter]
	mov	al, gs:(g_characterMeleeDistance+1)[bx]
	mov	gs:g_characterMeleeDistance[bx], al
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short l_loop

	mov	gs:byte_42444+6, 0
	mov	gs:g_strengthSpellBonus+6, 0
	mov	gs:vorpalPlateBonus+6, 0
	mov	gs:g_characterMeleeDistance+6, 0
	FUNC_EXIT
	retf
bat_partyPackBonuses endp
