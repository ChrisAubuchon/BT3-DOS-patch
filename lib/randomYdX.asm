; This function	unpacks	a single byte into the number
; of dice to roll and the sides	of the dice. A random
; number between 1DX and YDX is	returned
; Attributes: bp-based frame
randomYdX proc	far

	rval= word ptr -8
	counter= word ptr -6
	ndice= word ptr	-4
	dieval=	word ptr -2
	die= word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	[bp+rval], 0
	mov	ax, [bp+die]
	mov	cl, 5
	sar	ax, cl
	and	ax, 7
	mov	[bp+dieval], ax
	mov	ax, [bp+die]
	and	ax, 1Fh
	mov	[bp+ndice], ax
	mov	[bp+counter], 0
	jmp	short loc_1D333
loc_1D330:
	inc	[bp+counter]
loc_1D333:
	mov	ax, [bp+ndice]
	cmp	[bp+counter], ax
	jg	short loc_1D356
	call	random
	mov	bx, [bp+dieval]
	mov	cl, diceMaskList[bx]
	sub	ch, ch
	and	cx, ax
	inc	cx
	add	[bp+rval], cx
	jmp	short loc_1D330
loc_1D356:
	mov	ax, [bp+rval]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
randomYdX endp
