; Attributes: bp-based frame

rnd_Xd4	proc far

	rval= word ptr -2
	numOfDice= word	ptr  6

	FUNC_ENTER
	CHKSTK(2)

	mov	[bp+rval], 0
l_loopEnter:
	CALL(random)
	and	ax, 3
	inc	ax
	add	[bp+rval], ax
	dec	[bp+numOfDice]
	cmp	[bp+numOfDice],	0
	jg	short l_loopEnter
	mov	ax, [bp+rval]

	FUNC_EXIT
	retf
rnd_Xd4	endp
