checkMouse proc	far
	push	bp
	push	si
	push	di
	push	ds
	push	es
	cmp	g_mousePresentFlag1, 0
	jz	short l_noMousePresent

	mov	g_mouseButtonDown, 0
	mov	ax, 5			; 5: Get Mouse Button Press Information
	sub	bx, bx			; 0: left mouse button

	int	33h			; - MS MOUSE - RETURN BUTTON PRESS DATA
					;		BX = button
					; Return:	AX = button states
					; 		BX = number of times specified button has been pressed
					;		CX = column at time specified button was last pressed
					;		DX = row at time specified button was last pressed
	test	al, 3
	jz	short l_noButtonPressed

	mov	g_mouseButtonDown, 1
	cmp	g_mouseButtonDownFlag, 0	; if g_mouseButtonDownFlag is not zero then a button
						; is still being held down. Don't set the 
						; g_mouseButtonClickedFlag in this case
	jnz	short loc_2807C

	mov	g_mouseButtonClicked, 1
	mov	g_mouseButtonDownFlag, 1
	jmp	short loc_2807C

l_noButtonPressed:
	mov	g_mouseButtonDownFlag, 0

loc_2807C:
	mov	ax, 0Bh
	int	33h		; - MS MOUSE - read MOTION COUNTERS
				; Return: CX = number of mickeys mouse moved horizontally since	last call
				; DX = number of mickeys mouse moved vertically
	or	cx, cx
	jnz	short loc_2808C

	or	dx, dx
	jz	l_return

loc_2808C:
	add	cx, g_mouseX
	test	ch, 80h
	jz	short loc_28098
	mov	cx, 1
loc_28098:
	cmp	cx, 304
	jbe	short loc_280A1
	mov	cx, 304
loc_280A1:
	mov	g_mouseX, cx

	add	dx, g_mouseY
	test	dh, 80h
	jz	short loc_280B1
	mov	dx, 1
loc_280B1:
	cmp	dx, 194 
	jbe	short loc_280BA
	mov	dx, 194 
loc_280BA:
	mov	g_mouseY, dx
	jmp	short l_setMouseMoved

l_noMousePresent:
	cmp	g_joystickPresentFlag, 0
	jz	short l_return

	cmp	g_mousePresentFlag2, 0
	jz	short l_return

	sti
	call	sub_28115
	or	ax, ax
	jz	short l_return

	mov	ax, g_mouseX
	cmp	ax, 130h
	jbe	short loc_280E6

	mov	ax, 130h
	jmp	short loc_280EE
align 2
loc_280E6:
	cmp	ax, 1
	jnb	short loc_280EE
	mov	ax, 1
loc_280EE:
	mov	g_mouseX, ax
	mov	ax, g_mouseY
	cmp	ax, 0C2h 
	jbe	short loc_280FF
	mov	ax, 0C2h 
	jmp	short loc_28107
db 90h
loc_280FF:
	cmp	ax, 1
	jnb	short loc_28107
	mov	ax, 1
loc_28107:
	mov	g_mouseY, ax

l_setMouseMoved:
	mov	g_mouseMoved, 1

l_return:
	pop	es
	pop	ds
	pop	di
	pop	si
	pop	bp
	retf
checkMouse endp
