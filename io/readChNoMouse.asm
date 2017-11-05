; Attributes: bp-based frame

readChNoMouse proc far

	inputKey= word ptr	-2

	FUNC_ENTER(2)

	sub	ax, ax
	push	ax
	CALL(mouse_getClick, near)
loc_151FF:
	CALL(checkKeyboard)
	or	ax, ax
	jz	short loc_151FF
loc_1520A:
	CALL(_readChFromKeyboard)
	mov	[bp+inputKey], ax
	or	al, al
	jz	short loc_1521D
	mov	al, byte ptr [bp+inputKey]
	sub	ah, ah
	jmp	short loc_15222
loc_1521D:
	mov	ax, [bp+inputKey]
	jmp	short $+2
loc_15222:
	mov	sp, bp
	pop	bp
	retf
readChNoMouse endp
