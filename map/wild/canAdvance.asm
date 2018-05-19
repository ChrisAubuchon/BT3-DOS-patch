; Attributes: bp-based frame

wild_canAdvance proc far

	arg_0= byte ptr	 6

	FUNC_ENTER

	test	[bp+arg_0], 0F0h
	jz	l_returnOne

	mov	al, [bp+arg_0]
	and	al, 0F0h
	cmp	al, 0E0h
	jz	l_returnZero

	mov	al, [bp+arg_0]
	and	al, 0F0h
	cmp	al, 0F0h
	jz	l_returnOne

	mov	al, [bp+arg_0]
	and	al, 0Fh
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
	jmp	l_return

l_returnZero:
	xor	ax, ax
	jmp	l_return

l_returnOne:
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf

wild_canAdvance endp
