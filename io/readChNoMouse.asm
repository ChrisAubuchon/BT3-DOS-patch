; Attributes: bp-based frame

readChNoMouse proc far

	inputKey= word ptr	-2

	FUNC_ENTER(2)

	sub	ax, ax
	push	ax
	CALL(mouse_getClick, near)

l_checkKeyboardLoop:
	CALL(checkKeyboard)
	or	ax, ax
	jz	short l_checkKeyboardLoop

	CALL(_readChFromKeyboard)
	mov	[bp+inputKey], ax
	or	al, al
	jz	short loc_1521D

	mov	al, byte ptr [bp+inputKey]
	sub	ah, ah
	jmp	short l_return

loc_1521D:
	mov	ax, [bp+inputKey]

l_return:
	FUNC_EXIT
	retf
readChNoMouse endp
