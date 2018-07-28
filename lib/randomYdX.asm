; This function	unpacks	a single byte into the number
; of dice to roll and the sides	of the dice. A random
; number between 1DX and YDX is	returned
; Attributes: bp-based frame
randomYdX proc	far

	rval= word ptr -8
	loopCounter= word ptr -6
	ndice= word ptr	-4
	dieval=	word ptr -2
	die= word ptr  6

	FUNC_ENTER(8)

	mov	[bp+rval], 0
	mov	ax, [bp+die]
	mov	cl, 5
	sar	ax, cl
	and	ax, 7
	mov	[bp+dieval], ax
	mov	ax, [bp+die]
	and	ax, 1Fh
	mov	[bp+ndice], ax
	mov	[bp+loopCounter], 0

l_loop:
	mov	ax, [bp+ndice]
	cmp	[bp+loopCounter], ax
	jg	short l_return
	CALL(random)
	mov	bx, [bp+dieval]
	mov	cl, g_diceMasks[bx]
	sub	ch, ch
	and	cx, ax
	inc	cx
	add	[bp+rval], cx
	inc	[bp+loopCounter]
	jmp	short l_loop

l_return:
	mov	ax, [bp+rval]
	FUNC_EXIT
	retf
randomYdX endp
