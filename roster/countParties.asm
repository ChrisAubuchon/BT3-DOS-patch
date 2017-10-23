; Attributes: bp-based frame

roster_countParties proc far

	loopCounter= word ptr	-6
	partyBufferP= dword ptr -4

	FUNC_ENTER
	CHKSTK(6)
	push	si
	mov	word ptr [bp+partyBufferP], offset g_rosterPartyBuffer
	mov	word ptr [bp+partyBufferP+2], seg seg022
	mov	[bp+loopCounter], 0
l_loopEntry:
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+partyBufferP]
	cmp	byte ptr fs:[bx+si], 0
	jz	l_returnCounter
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 0Ah
	jl	short l_loopEntry
	mov	ax, 0Ah			; Return maximum number of parties
	jmp	short l_return
l_returnCounter:
	mov	ax, [bp+loopCounter]
l_return:
	pop	si
	FUNC_EXIT
	retf
roster_countParties endp

