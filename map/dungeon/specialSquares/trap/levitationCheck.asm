; Attributes: bp-based frame

trap_levitationCheck proc far
	FUNC_ENTER

	cmp	levitationDuration, 0
	jz	short l_returnOne

	CALL(random)
	and	al, 3
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	short l_return
l_returnOne:
	mov	ax, 1
l_return:
	FUNC_EXIT
	retf
trap_levitationCheck endp
