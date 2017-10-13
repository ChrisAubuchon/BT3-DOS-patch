; Attributes: bp-based frame

roster_partyExists proc far

	loopCounter= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+loopCounter], 0
loc_132BC:
	jge	short l_returnMinusOne
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lea	ax, partyIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jz	l_returnPartyIndex
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ah
	jl	loc_132BF
l_returnMinusOne:
	mov	ax, 0FFFFh
	jmp	short l_return
l_returnPartyIndex:
	mov	ax, [bp+loopCounter]
l_return:
	mov	sp, bp
	pop	bp
	retf
roster_partyExists endp

