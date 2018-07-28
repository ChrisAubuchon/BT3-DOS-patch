; Attributes: bp-based frame

initializeHardware proc far
	push	bp
	mov	bp, sp
	push	es
	sub	ax, ax
	mov	es, ax
	assume es:nothing
	cli
	mov	ax, es:20h
	mov	word ptr cs:g_savedDosTimerInterrupt, ax
	mov	ax, es:22h
	mov	word ptr cs:g_savedDosTimerInterrupt+2, ax
	mov	word ptr es:20h, offset	timerIntHandler
	mov	word ptr es:22h, cs
	mov	cs:g_savedDsRegister, ds

	; Set the timer to generate an interrupt 60 times per second
	mov	al, 36h	
	out	43h, al		; Timer	8253-5 (AT: 8254.2).
	mov	ax, 4DA7h
	out	40h, al		; Timer	8253-5 (AT: 8254.2).
	xchg	al, ah
	out	40h, al		; Timer	8253-5 (AT: 8254.2).
	sti
	mov	di, 90h	
	cli
	mov	ax, es:[di]
	mov	word ptr cs:g_savedDosErrorInterrupt, ax
	mov	ax, es:[di+2]
	mov	word ptr cs:g_savedDosErrorInterrupt+2, ax
	mov	word ptr es:[di], offset errorHandler
	mov	word ptr es:[di+2], cs
	sti
	sub	ax, ax
	mov	es, ax

	; es:0CCh is the address of int 33h
	cmp	word ptr es:0CCh, 0
	jz	short l_return
	int	33h			; - MS MOUSE - RESET DRIVER AND	read STATUS
					; Return: AX = status
					; BX = number of buttons
	or	ax, ax			; AX is 0000 when no mouse is detected. 0FFFFh otherwise.
	jz	short l_return

	mov	g_mousePresentFlag1, 1
	mov	g_joystickPresentFlag, 1
	jmp	short l_return

l_return:
	pop	es
	assume es:nothing
	pop	bp
	retf
initializeHardware endp
