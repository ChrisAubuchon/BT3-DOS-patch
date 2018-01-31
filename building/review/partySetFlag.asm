; Attributes: bp-based frame

review_questPartySetFlag proc far

	questDataP= dword ptr -6
	slotNumber= word ptr	-2
	questIndex= word ptr	 6

	FUNC_ENTER(6)
	push	di
	push	si

	mov	[bp+slotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jz	short l_next

	mov	bx, [bp+questIndex]
	mov	al, g_questByteList[bx]
	sub	ah, ah
	add	ax, si
	add	ax, offset party.chronoQuest
	mov	word ptr [bp+questDataP], ax
	mov	word ptr [bp+questDataP+2], seg seg027
	mov	al, g_questMaskList[bx]
	sub	ah, ah
	lfs	bx, [bp+questDataP]
	mov	cl, fs:[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short l_next
	mov	di, [bp+questIndex]
	mov	al, g_questMaskList[di]
	or	fs:[bx], al
l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
review_questPartySetFlag endp
