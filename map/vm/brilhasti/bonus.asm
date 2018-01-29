; Attributes: bp-based frame

brilhasti_doBonus proc far

	slotNumber= word ptr	-2

	FUNC_ENTER(2)
	push	si

	mov	[bp+slotNumber], 0
l_loop:
	push	[bp+slotNumber]
	CALL(brilhasti_checkQuest, near)
	or	ax, ax
	jz	short l_next

	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	mov	al, gs:party.class[bx]

	or	al, al
	jz	short l_nonMagicUser

	cmp	al, 5
	jnb	short l_nonMagicUser

	push	[bp+slotNumber]
	CALL(brilhasti_levelMagicUser)
	jmp	short l_next

l_nonMagicUser:
	mov	ax, 34
	push	ax
	push	[bp+slotNumber]
	CALL(getLevelXp)
	mov	cx, ax
	mov	bx, dx
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	mov	word ptr gs:party.experience[si], cx
	mov	word ptr gs:(party.experience+2)[si], bx
l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

	pop	si
	FUNC_EXIT
	retf
brilhasti_doBonus endp
