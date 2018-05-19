; Attributes: bp-based frame

dun_canAdvance proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER

	cmp	gs:stuckFlag, 0
	jz	short l_notStuck
	CALL(text_clear)
	PRINTOFFSET(s_stuckEllipsis)
	jmp	l_returnZero

l_notStuck:
	mov	ax, [bp+arg_0]
	mov	cl, 4
	shr	ax, cl
	and	ax, 0Fh
	mov	bx, ax
	mov	al, byte_44344[bx]
	sub	ah, ah

	or	ax, ax
	jz	l_success

	cmp	ax, 1
	jb	l_returnZero

	cmp	ax, 2
	jg	l_returnZero

	cmp	[bp+arg_2], 0
	jz	l_returnZero

l_success:
	mov	g_sameSquareFlag, 0
	CALL(text_clear)
	mov	ax, 1
	jmp	l_return
	
l_returnZero:
	xor	ax, ax

l_return:
	FUNC_EXIT
	retf
dun_canAdvance endp
