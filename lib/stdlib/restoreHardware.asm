restoreHardware proc far
	push	es
	sub	ax, ax
	mov	es, ax
	assume es:nothing
	cli
	mov	ax, word ptr cs:g_savedDosTimerInterrupt
	mov	es:20h,	ax
	mov	ax, word ptr cs:g_savedDosTimerInterrupt+2
	mov	es:22h,	ax
	mov	al, 36h	
	out	43h, al		; Timer	8253-5 (AT: 8254.2).
	mov	ax, 0
	out	40h, al		; Timer	8253-5 (AT: 8254.2).
	xchg	al, ah
	out	40h, al		; Timer	8253-5 (AT: 8254.2).
	mov	di, 90h	
	mov	ax, cs:g_savedDosErrorInterrupt
	mov	es:[di], ax
	mov	ax, cs:g_savedDosErrorInterrupt+2
	mov	es:[di+2], ax
	sti
	pop	es
	assume es:nothing
	retf
restoreHardware endp
