; Attributes: bp-based frame

; DWORD: arg_2 & goldAmount

character_removeGold	proc far

	partySlotNumber= word ptr	 6
	arg_2= word ptr	 8
	goldAmount= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK
	push	si
	mov	ax, [bp+arg_2]
	mov	dx, [bp+goldAmount]
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	cmp	word ptr gs:(party.gold+2)[si], bx
	ja	short loc_13CEF
	jb	short loc_13CEB
	cmp	word ptr gs:party.gold[si], cx
	jnb	short loc_13CEF
loc_13CEB:
	sub	ax, ax
	jmp	short loc_13D0D
loc_13CEF:
	mov	ax, [bp+arg_2]
	mov	dx, bx
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(partySlotNumber), si)
	sub	word ptr gs:party.gold[si], cx
	sbb	word ptr gs:(party.gold+2)[si], bx
	mov	ax, 1
	jmp	short $+2
loc_13D0D:
	pop	si
	mov	sp, bp
	pop	bp
	retf
character_removeGold	endp
