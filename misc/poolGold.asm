; Attributes: bp-based frame

doPoolGold proc	far

	var_6= dword ptr	-6
	loopCounter= word ptr	-2
	poolTarget= word ptr	 6
	lastSlot= word ptr	 8

	FUNC_ENTER(6)
	push	si

	sub	ax, ax
	mov	word ptr [bp+var_6+2], ax
	mov	word ptr [bp+var_6], ax
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
	add	word ptr [bp+var_6], ax
	adc	word ptr [bp+var_6+2], dx
	sub	ax, ax
	mov	word ptr gs:(party.gold+2)[si], ax
	mov	word ptr gs:party.gold[si], ax
l_loopIncrement:
	inc	[bp+loopCounter]
	jmp	short l_loopEntry

l_giveGold:
	mov	ax, word ptr [bp+var_6]
	mov	dx, word ptr [bp+var_6+2]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(poolTarget), si)
	mov	word ptr gs:party.gold[si], cx
	mov	word ptr gs:(party.gold+2)[si], bx
	pop	si
	FUNC_EXIT
	retf
doPoolGold endp

