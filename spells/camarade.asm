; Attributes: bp-based frame

sp_camaraderie proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+loopCounter], 0
l_loopEnter:
	getCharP	[bp+spellCaster], bx
	cmp	gs:roster.hostileFlag[bx], 0
	jz	short l_loopNext
	call	_random
	and	al, 1
	mov	cx, ax
	getCharP	[bp+spellCaster], bx
	mov	gs:roster.hostileFlag[bx], cl
l_loopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEnter
	mov	sp, bp
	pop	bp
	retf
sp_camaraderie endp
