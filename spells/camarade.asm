; Attributes: bp-based frame

sp_camaraderie proc far

	loopCounter= word ptr	-2
	spellCaster= word ptr	 6

	FUNC_ENTER(2)

	mov	[bp+loopCounter], 0
l_loopEnter:
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	cmp	gs:party.hostileFlag[bx], 0
	jz	short l_loopNext
	CALL(random)
	and	al, 1
	mov	cx, ax
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	gs:party.hostileFlag[bx], cl
l_loopNext:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEnter
	FUNC_EXIT
	retf
sp_camaraderie endp
