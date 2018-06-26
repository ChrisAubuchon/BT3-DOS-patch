; Attributes: bp-based frame

bat_monDisbelieve proc far

	loopCounter=	word ptr -2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_illusion
	jnz	short l_next
	mov	gs:bat_curTarget, 80h
	sub	ax, ax
	push	ax
	push	ax
	CALL(savingThrowCheck)
	or	ax, ax
	jz	short l_next

	inc	gs:monDisbelieveFlag
	PRINTOFFSET(s_theyDisbelieve)
	DELAY
	jmp	short l_return

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_monDisbelieve endp
