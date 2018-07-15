; Attributes: bp-based frame

sp_lightSpell proc far

	spellEffect= word ptr	-2
	spellNumber= word ptr	 8

	FUNC_ENTER(2)

	mov	bx, [bp+spellNumber]
	mov	al, g_spellEffectData[bx]
	sub	ah, ah
	mov	[bp+spellEffect], ax
	mov	bx, ax
	mov	al, g_lightDistanceList[bx]
	mov	lightDistance, al
	mov	al, g_lightDurationList[bx]
	mov	lightDuration, al
	sub	ax, ax
	push	ax
	CALL(icon_activate)
	mov	bx, [bp+spellEffect]
	mov	al, g_lightDetectionList[bx]
	mov	gs:gl_detectSecretDoorFlag, al
	PUSH_OFFSET(s_elipsisNl)
	PRINTSTRING
	DELAY(2)

	FUNC_EXIT
	retf
sp_lightSpell endp
