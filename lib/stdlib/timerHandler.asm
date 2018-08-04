timerIntHandler proc far
	push	es
	push	ds
	push	ax

	mov	ds, cs:g_savedDsRegister
	xor	ax, ax
	CALL(music_driver)
	mov	al, 20h	
	out	20h, al		; Interrupt controller,	8259A.
	mov	ds, cs:g_savedDsRegister
	inc	g_totalClockTicks
	mov	ax, g_totalClockTicks
	and	ax, 3
	jnz	short l_return
	inc	g_clockTicks
	pop	ax
	pop	ds
	pop	es
	jmp	cs:g_savedDosTimerInterrupt

l_return:
	pop	ax
	pop	ds
	pop	es
	iret
timerIntHandler endp
