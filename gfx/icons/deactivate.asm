icon_deactivate proc far

	iconIndex= word ptr	 6

	FUNC_ENTER

	mov	bx, [bp+iconIndex]
	mov	al, g_iconClearIndex[bx]
	sub	ah, ah
	push	ax
	push	bx
	CALL(icon_draw, near)
	mov	bx, [bp+iconIndex]
	mov	lightDuration[bx], 0
	mov	ax, [bp+iconIndex]
	or	ax, ax
	jz	short l_light
	cmp	ax, 2
	jz	short l_detect
	cmp	ax, 3
	jz	short l_shield
	jmp	short l_return

l_light:
	sub	al, al
	mov	lightDistance, al
	mov	gs:g_detectSecretDoorFlag, al
	jmp	short l_return

l_detect:
	mov	g_detectType, 0
	jmp	short l_return

l_shield:
	mov	shieldAcBonus, 0

l_return:
	FUNC_EXIT
	retf
icon_deactivate endp
