; Attributes: bp-based frame

tav_isPartyDrunk proc far

	lastCharNo= word ptr  6

	FUNC_ENTER
	CHKSTK

l_loopEntry:
	cmp	[bp+lastCharNo], 0
	jl	short l_returnOne
	mov	bx, [bp+lastCharNo]
	cmp	tav_drunkLevel[bx], maxDrunkLevel
	jl	short l_returnZero
	dec	[bp+lastCharNo]
	jmp	short l_loopEntry

l_returnOne:
	mov	ax, 1
	jmp	short l_return

l_returnZero:
	sub	ax, ax

l_return:
	FUNC_EXIT
	retf
tav_isPartyDrunk endp
