; Attributes: bp-based frame

isAlphaNum proc	far
	arg_0= byte ptr	 6

	FUNC_ENTER
	CHKSTK

	mov	al, [bp+arg_0]
	cbw
	push	ax
	CALL(_str_capitalize)
	mov	[bp+arg_0], al
	cmp	al, 'A'
	jl	short loc_15414
	cmp	al, 'Z'
	jle	short l_returnTrue
loc_15414:
	cmp	[bp+arg_0], '0'
	jl	short l_returnFalse
	cmp	[bp+arg_0], '9'
	jg	short l_returnFalse
l_returnTrue:
	mov	ax, 1
	jmp	short l_return
l_returnFalse:
	sub	ax, ax
l_return:
	mov	sp, bp
	pop	bp
	retf
isAlphaNum endp
