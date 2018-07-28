; Attributes: bp-based frame

mfunc_clearQuestFlag proc far

	questMaskIndex= word ptr	-8
	rval= word ptr	-6
	questByteNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(8)
	push	si

	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
l_loop:
	CHARINDEX(ax, STACKVAR(rval), si)
	cmp	gs:party.class[si], class_monster
	jnb	short l_next
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	bx, [bp+questMaskIndex]
	mov	al, g_questFlagMasks[bx]
	mov	bx, [bp+questByteNumber]
	add	bx, si
	and	gs:party.chronoQuest[bx], al

l_next:
	inc	[bp+rval]
	cmp	[bp+rval], 7
	jl	short l_loop

	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]
	pop	si
	FUNC_EXIT
	retf
mfunc_clearQuestFlag endp
