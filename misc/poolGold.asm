; DWORD - var_4 & var_6

; Attributes: bp-based frame

doPoolGold proc	far

	var_6= word ptr	-6
	var_4= word ptr	-4
	loopCounter= word ptr	-2
	poolTarget= word ptr	 6
	lastSlot= word ptr	 8

	FUNC_ENTER(6)
	push	si

	sub	ax, ax
	mov	[bp+var_4], ax
	mov	[bp+var_6], ax
	mov	[bp+loopCounter], ax

l_loopEntry:
	mov	ax, [bp+lastSlot]
	cmp	[bp+loopCounter], ax
	jge	short l_giveGold

	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_loopIncrement

	mov	ax, word ptr gs:party.gold[si]
	mov	dx, word ptr gs:(party.gold+2)[si]
	add	[bp+var_6], ax
	adc	[bp+var_4], dx
	sub	ax, ax
	mov	word ptr gs:(party.gold+2)[si], ax
	mov	word ptr gs:party.gold[si], ax
l_loopIncrement:
	inc	[bp+loopCounter]
	jmp	short l_loopEntry

l_giveGold:
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(poolTarget), si)
	mov	word ptr gs:party.gold[si], cx
	mov	word ptr gs:(party.gold+2)[si], bx
	pop	si
	mov	sp, bp
	pop	bp
	retf
doPoolGold endp

