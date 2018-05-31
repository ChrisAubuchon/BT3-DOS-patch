; Attributes: bp-based frame
bat_charPrintMeleeDamage proc	far

	dmgLo= word ptr	 6
	dmgHi= word ptr	 8
	multiAttackFlag= word ptr  0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+multiAttackFlag], 1
	jg	short loc_1E2A7
	mov	ax, offset aAndHitsFor
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short loc_1E2F4
loc_1E2A7:
	mov	ax, offset aAndHits
	push	ds
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+multiAttackFlag]
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, offset aTimesFor
	push	ds
	push	ax
	push	dx
	push	[bp+dmgLo]
	call	strcat
	add	sp, 8
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
loc_1E2F4:
	sub	ax, ax
	push	ax
	mov	ax, gs:damageAmount
	cwd
	push	dx
	push	ax
	push	[bp+dmgHi]
	push	[bp+dmgLo]
	call	itoa
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	mov	ax, gs:damageAmount
	dec	ax
	push	ax
	push	dx
	push	[bp+dmgLo]
	mov	ax, offset aPointSOfDamage
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+dmgLo], ax
	mov	[bp+dmgHi], dx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
bat_charPrintMeleeDamage endp
