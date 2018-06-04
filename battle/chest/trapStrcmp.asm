; Attributes: bp-based frame

chest_trapStrcmp proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	FUNC_ENTER(2)
	push	si

define(`loopCounter', `dx')
	sub	loopCounter, loopCounter
loc_1FB2A:
	cmp	loopCounter, 28h
	jge	short l_returnOne

	mov	bx, loopCounter
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	or	ax, cx
	jz	short l_returnOne

	push	loopCounter
	lfs	si, [bp+arg_4]
	mov	al, fs:[bx+si]
	cbw
	push	ax
	CALL(toUpper)
	mov	bx, loopCounter
	lfs	si, [bp+arg_0]
	mov	cx, ax
	mov	al, fs:[bx+si]
	cbw
	push	ax
	mov	si, cx
	CALL(toUpper)
	pop	loopCounter
	cmp	ax, si
	jnz	short l_returnZero

l_loopNext:
	inc	loopCounter
	jmp	short loc_1FB2A

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	pop	si
	FUNC_EXIT
	retf
chest_trapStrcmp endp

undefine(`loopCounter')

