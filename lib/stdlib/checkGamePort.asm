checkGamePort proc far
	xor	ax, ax
	cmp	g_mouseButtonClicked, al
	jz	short loc_281B1
	mov	g_mouseButtonClicked, al
	inc	ax
	jmp	short locret_281DE
db 90h
loc_281B1:
	cmp	g_mousePresentFlag2, al
	jz	short loc_281CF
	mov	dx, 201h
	in	al, dx		; Game I/O port
			; bits 0-3: Coordinates	(resistive, time-dependent inputs)
			; bits 4-7: Buttons/Triggers (digital inputs)
	cmp	g_mouseButtonDown, 0
	jz	short loc_281D2
	test	al, 10h
	mov	ax, 0
	jz	short locret_281DE
	mov	g_mouseButtonDown, al
	jmp	short locret_281DE
db 90h
loc_281CF:
	jmp	short locret_281DE
align 2
loc_281D2:
	test	al, 10h
	mov	ax, 0
	jnz	short locret_281DE
	inc	al
	mov	g_mouseButtonDown, al
locret_281DE:
	retf
checkGamePort endp
