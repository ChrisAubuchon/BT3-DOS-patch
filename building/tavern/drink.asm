; Attributes: bp-based frame

tavern_drink proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	drinkIndexNumber= word ptr	 8

	FUNC_ENTER(2)

	CALL(text_clear)

	cmp	[bp+drinkIndexNumber], 4
	jnz	short loc_13D39
	PUSH_OFFSET(s_thirstQuencher)
	PRINTSTRING
	jmp	l_return

loc_13D39:
	cmp	[bp+drinkIndexNumber], 3
	jnz	short loc_13D4E
	PUSH_OFFSET(s_goodStuff)
	PRINTSTRING
	jmp	short loc_13D5B

loc_13D4E:
	PUSH_OFFSET(s_burpNotBad)
	PRINTSTRING

loc_13D5B:
	mov	bx, [bp+arg_0]
	mov	si, [bp+drinkIndexNumber]
	mov	al, tavern_drinkStrength[si]
	add	tav_drunkLevel[bx], al
	cmp	tav_drunkLevel[bx], 0Ch
	jle	short loc_13D78
	mov	bx, [bp+arg_0]
	mov	tav_drunkLevel[bx], 0Ch
loc_13D78:
	mov	bx, [bp+arg_0]
	mov	al, tav_drunkLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drunkString+2)[bx]
	push	word ptr drunkString[bx]
	PRINTSTRING

	; Restore bard songs
	CHARINDEX(ax, STACKVAR(arg_0), si)
	cmp	gs:party.class[si], class_bard
	jnz	short l_return
	mov	ax, gs:party.level[si]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	mov	[bp+var_2], ax
	mov	al, gs:party.specAbil[si]
	sub	ah, ah
	cmp	ax, [bp+var_2]
	jnb	short l_return
	inc	gs:party.specAbil[si]
l_return:
	IOWAIT
	pop	si
	mov	sp, bp
	pop	bp
	retf
tavern_drink endp
