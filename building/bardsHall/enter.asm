; Attributes: bp-based frame

bards_enter proc far
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(4)
	push	si

	PUSH_OFFSET(s_bardsHall)
	CALL(setTitle)
	mov	ax, 83
	push	ax
	CALL(bigpic_drawPictureNumber)
l_loop:
	PRINTOFFSET(s_bardHallGreeting, clear)
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	mov	ax, g_printPartyFlag[si]
	or	ax, bitMask16bit[si]
	mov	[bp+var_2], ax
	CALL(getKey)
	mov	[bp+var_4], ax
	cmp	ax, 10Eh
	jl	short loc_25B7D
	cmp	ax, 119h
	jg	short loc_25B7D
	mov	al, gs:txt_numLines
	sub	ah, ah
	dec	ax
	sub	[bp+var_4], ax
loc_25B7D:
	cmp	[bp+var_4], 'L'
	jz	short l_listen
	cmp	[bp+var_4], 10Eh
	jnz	short loc_25B8E
l_listen:
	CALL(bards_listen, near)
loc_25B8E:
	cmp	[bp+var_4], dosKeys_ESC
	jz	short l_return
	cmp	[bp+var_4], 'E'
	jz	short l_return
	cmp	[bp+var_4], 10Fh
	jnz	short l_loop

l_return:
	sub	ax, ax
	pop	si
	FUNC_EXIT
	retf
bards_enter endp
