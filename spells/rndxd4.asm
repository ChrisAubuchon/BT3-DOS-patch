; Attributes: bp-based frame

rnd_Xd4	proc far

	rval= word ptr -2
	numOfDice= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+rval], 0
l_loopEnter:
	call	_random
	and	ax, 3
	inc	ax
	add	[bp+rval], ax
	dec	[bp+numOfDice]
	cmp	[bp+numOfDice],	0
	jg	short l_loopEnter
	mov	ax, [bp+rval]
	mov	sp, bp
	pop	bp
	retf
rnd_Xd4	endp
