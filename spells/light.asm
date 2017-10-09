; Attributes: bp-based frame

sp_lightSpell proc far

	spellEffect= word ptr	-2
	spellNumber= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	bx, [bp+spellNumber]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+spellEffect], ax
	mov	bx, ax
	mov	al, lightDistList[bx]
	mov	lightDistance, al
	mov	al, lightDurList[bx]
	mov	lightDuration, al
	sub	ax, ax
	push	ax
	call	icon_activate
	add	sp, 2
	mov	bx, [bp+spellEffect]
	mov	al, lightDetectList[bx]
	mov	gs:gl_detectSecretDoorFlag, al
	mov	ax, offset aElipsisNLNL
	push	ds
	push	ax
	call	printString
	add	sp, 4
	delayNoTable	2
	mov	sp, bp
	pop	bp
	retf
sp_lightSpell endp
