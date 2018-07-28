; This function	returns	one if there is	a character
; in the party that does NOT have the quest mask
; set.
; Attributes: bp-based frame

quest_partyNotHasFlagSet proc far

	questMaskIndex= word ptr	-8
	rval= word ptr -6
	slotNumber=	word ptr -4
	questByteNumber= word ptr	-2
	questData= word	ptr  6

	FUNC_ENTER(8)
	push	si

	mov	ax, [bp+questData]
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	mov	ax, [bp+questData]
	mov	cl, 3
	sar	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	mov	bx, [bp+questByteNumber]
	add	bx, si
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questMaskIndex]
	mov	cl, g_byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jnz	short l_next
	mov	[bp+rval], 1
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	ax, [bp+rval]
	pop	si
	FUNC_EXIT
	retf
quest_partyNotHasFlagSet endp
