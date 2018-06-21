; Attributes: bp-based frame

tavern_drink proc far

	slotLevel= word ptr	-2
	slotNumber= word ptr	 6
	drinkIndexNumber= word ptr	 8

	FUNC_ENTER(2)
	push	si

	CALL(text_clear)

	cmp	[bp+drinkIndexNumber], tavern_gingerAle
	jnz	short l_notGingerAle

	PRINTOFFSET(s_thirstQuencher)
	jmp	l_return

l_notGingerAle:
	cmp	[bp+drinkIndexNumber], tavern_foulSpirits
	jnz	short l_notFoulSpirits

	PRINTOFFSET(s_goodStuff)
	jmp	short l_calculateDrunkLevel

l_notFoulSpirits:
	PRINTOFFSET(s_burpNotBad)

l_calculateDrunkLevel:
	mov	bx, [bp+slotNumber]
	mov	si, [bp+drinkIndexNumber]
	mov	al, tavern_drinkStrength[si]
	add	tav_drunkLevel[bx], al
	cmp	tav_drunkLevel[bx], 0Ch
	jle	short l_printDrunkString

	mov	bx, [bp+slotNumber]
	mov	tav_drunkLevel[bx], 0Ch

l_printDrunkString:
	mov	bx, [bp+slotNumber]
	mov	al, tav_drunkLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (drunkString+2)[bx]
	push	word ptr drunkString[bx]
	PRINTSTRING

	; Restore bard songs
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_bard
	jnz	short l_return

	mov	ax, gs:party.level[si]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	mov	[bp+slotLevel], ax
	mov	al, gs:party.specAbil[si]
	sub	ah, ah
	cmp	ax, [bp+slotLevel]
	jnb	short l_return
	inc	gs:party.specAbil[si]

l_return:
	IOWAIT
	pop	si
	FUNC_EXIT
	retf
tavern_drink endp
