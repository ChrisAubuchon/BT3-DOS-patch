; Attributes: bp-based frame
quest_setFlag proc	far

	questMaskIndex= word ptr	-6
	slotNumber=	word ptr -4
	questByteNumber= word ptr	-2
	questData= word ptr	 6

	FUNC_ENTER(6)
	push	si

	mov	ax, [bp+questData]
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	mov	ax, [bp+questData]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+slotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	bx, [bp+questMaskIndex]
	mov	al, g_byteMaskList[bx]
	mov	bx, [bp+questByteNumber]
	add	bx, si
	or	gs:party.chronoQuest[bx], al

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop
	pop	si
	FUNC_EXIT
	retf
quest_setFlag endp
