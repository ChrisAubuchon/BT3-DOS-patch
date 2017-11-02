; Attributes: bp-based frame
; Read a key from the user. The mouse can also be used to select an option

getKey proc far

	inputKey= word ptr	-2
	arg_0= word ptr	 6

	FUNC_ENTER
	CHKSTK(2)

	mov	spell_mouseClicked, 0
	CALL(sub_1766A, near)
l_loopEntry:
	CALL(checkMouse)
	cmp	mouse_moved, 0
	jz	short l_skipMouseUpdate
	call	far ptr	sub_3E974

	push	[bp+arg_0]
	CALL(mouse_updateIcon, near)
	CALL(sub_1766A, near)

l_skipMouseUpdate:
	push	[bp+arg_0]
	CALL(mouse_getClick, near)
	mov	[bp+inputKey], ax
	or	ax, ax
	jz	short l_skipMouseClick
	call	far ptr	sub_3E974
	mov	spell_mouseClicked, 1
	mov	ax, [bp+inputKey]
	jmp	short l_return

l_skipMouseClick:
	CALL(checkKeyboard)
	or	ax, ax
	jz	short loc_14EBE
	call	far ptr	sub_3E974

	CALL(_readChFromKeyboard)
	mov	[bp+inputKey], ax
	or	al, al
	jz	short loc_14EB9
	mov	al, byte ptr [bp+inputKey]
	sub	ah, ah
	push	ax
	CALL(_str_capitalize)
	jmp	short l_return
loc_14EB9:
	mov	ax, [bp+inputKey]
	jmp	short l_return
loc_14EBE:
	CALL(doRealtimeEvents, near)
	CALL(party_print, near)
	jmp	short l_loopEntry

l_return:
	FUNC_EXIT
	retf
getKey endp
