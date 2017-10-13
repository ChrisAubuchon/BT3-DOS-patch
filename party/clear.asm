; Attributes: bp-based frame

party_clear proc far

	slotNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	call	roster_writeParty
	mov	[bp+slotNo], 0
l_loopEnter:
	getCharP	[bp+slotNo], bx
	mov	byte ptr gs:roster._name[bx], 0
	inc	[bp+slotNo]
	cmp	[bp+slotNo], 7
	jl	short l_loopEnter
	mov	sp, bp
	pop	bp
	retf
party_clear endp
