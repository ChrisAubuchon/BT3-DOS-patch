; If the first argument is >=0 then this function checks for input from 
; the keyboard with the first argument as a time limit. If the time limit 
; is reached before a character is entered, the function returns a space (' ').
;
; If the first argument is <0 then this function just calls readChNoMouse
; and returns that functions return value.
;
; Attributes: bp-based frame

timedGetKey proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	timeDelay= word ptr	 6

	FUNC_ENTER(4)

	cmp	[bp+timeDelay], 0
	jge	short l_getkeyWithDelay
	CALL(readChNoMouse, near)
	jmp	short l_return
l_getkeyWithDelay:
	mov	ax, [bp+timeDelay]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, _clockTicks
	mov	[bp+var_4], ax
l_timerLoop:
	mov	ax, [bp+var_4]
	cmp	_clockTicks, ax
	jz	short l_returnSpace
	CALL(checkKeyboard)
	or	ax, ax
	jz	short l_timerLoop
	CALL(_readChFromKeyboard)
	mov	[bp+var_2], ax
	or	al, al
	jz	short l_returnKey
	mov	al, byte ptr [bp+var_2]
	sub	ah, ah
	jmp	short l_return
l_returnKey:
	mov	ax, [bp+var_2]
	jmp	short l_return
l_returnSpace:
	mov	ax, 20h	
l_return:
	mov	sp, bp
	pop	bp
	ret
timedGetKey endp
