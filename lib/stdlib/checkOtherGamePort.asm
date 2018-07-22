checkOtherGamePort proc	far
	xor	ax, ax
	cmp	byte_4EF53, 0
	jz	short loc_281EF
	mov	byte_4EF53, al
	inc	ax
	jmp	short locret_2821D
db 90h
loc_281EF:
	cmp	g_mousePresentFlag2, 0
	jz	short loc_2820E
	mov	dx, 201h
	in	al, dx		; Game I/O port
			; bits 0-3: Coordinates	(resistive, time-dependent inputs)
			; bits 4-7: Buttons/Triggers (digital inputs)
	cmp	byte_4EF51, 0
	jz	short loc_28211
	test	al, 20h
	mov	ax, 0
	jz	short locret_2821D
	mov	byte_4EF51, al
	jmp	short locret_2821D
align 2
loc_2820E:
	jmp	short locret_2821D
db 90h
loc_28211:
	test	al, 20h
	mov	ax, 0
	jnz	short locret_2821D
	inc	al
	mov	byte_4EF51, al
locret_2821D:
	retf
checkOtherGamePort endp
