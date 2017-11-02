; Attributes: bp-based frame

sp_lightSpell proc far

	spellEffect= word ptr	-2
	spellNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK(2)

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
	CALL(icon_activate)
	mov	bx, [bp+spellEffect]
	mov	al, lightDetectList[bx]
	mov	gs:gl_detectSecretDoorFlag, al
	PUSH_OFFSET(s_elipsisNl)
	PRINTSTRING
	DELAY(2)

	FUNC_EXIT
	retf
sp_lightSpell endp
