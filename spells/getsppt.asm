; This function	gets the spell points required for
; a particular spell. It takes into account equipment
; that the player has equipped.

; Attributes: bp-based frame

getSpptRequired	proc far

	sppt= word ptr	-2
	partySlotNumber= word ptr  6
	spellIndexNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	bx, [bp+spellIndexNumber]
	mov	al, spptRequired[bx]
	sub	ah, ah
	mov	[bp+sppt], ax
	mov	ax, itemEff_quaterSpptUse
	push	ax
	push	[bp+partySlotNumber]
	std_call	hasEffectEquipped,4
	or	ax, ax
	jnz	short l_checkHalf
	mov	ax, [bp+sppt]
	sar	ax, 1
	sar	ax, 1
	jmp	short l_return
l_checkHalf:
	mov	ax, itemEff_halfSpptUsage
	push	ax
	push	[bp+partySlotNumber]
	std_call	hasEffectEquipped,4
	or	ax, ax
	jnz	short l_returnSppt
	mov	ax, [bp+sppt]
	sar	ax, 1
	jmp	short l_return
l_returnSppt:
	mov	ax, [bp+sppt]
	jmp	short $+2
l_return:
	mov	sp, bp
	pop	bp
	retf
getSpptRequired	endp