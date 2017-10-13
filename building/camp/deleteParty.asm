; Attributes: bp-based frame

camp_deleteParty proc far

	outputStringBufP= dword ptr -10Ah
	partyBuf= dword ptr -106h
	var_102= word ptr -102h
	outputStringBuf= word ptr -100h
	partyIndexNumber= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 10Ah
	call	someStackOperation
	push	si
	mov	ax, [bp+partyIndexNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+partyBuf], ax
	mov	word ptr [bp+partyBuf+2], seg seg022
	mov	ax, offset aAreYouSureYouW
	push	ds
	push	ax
	lea	ax, [bp+outputStringBuf]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx
	push	word ptr [bp+partyBuf+2]
	push	word ptr [bp+partyBuf]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx
	dword_appendChar	outputStringBufP, '?'
	null_terminate	[bp+outputStringBufP]
	lea	ax, [bp+outputStringBuf]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jz	short l_return
	mov	ax, [bp+partyIndexNumber]
	mov	[bp+var_102], ax
l_packPartyBuf:
	cmp	[bp+var_102], 9
	jge	short l_zeroPartyBuf
	mov	ax, word ptr [bp+partyBuf]
	mov	dx, word ptr [bp+partyBuf+2]
	add	ax, 80h
	mov	word ptr [bp+outputStringBufP], ax
	mov	word ptr [bp+outputStringBufP+2], dx
	mov	ax, 80h
	push	ax
	push	dx
	push	word ptr [bp+outputStringBufP]
	push	dx
	push	word ptr [bp+partyBuf]
	call	_memcpy
	add	sp, 0Ah
	mov	ax, word ptr [bp+outputStringBufP]
	mov	dx, word ptr [bp+outputStringBufP+2]
	mov	word ptr [bp+partyBuf], ax
	mov	word ptr [bp+partyBuf+2], dx
	inc	[bp+var_102]
	jmp	short l_packPartyBuf
l_zeroPartyBuf:
	mov	word ptr [bp+partyBuf], offset g_partyBufTail
	mov	word ptr [bp+partyBuf+2], seg seg022
	mov	[bp+var_102], 0
l_zeroPartyBufLoopEntry:
	cmp	[bp+var_102], 80h
	jge	short l_return
	mov	bx, [bp+var_102]
	lfs	si, [bp+partyBuf]
	mov	byte ptr fs:[bx+si], 0
	inc	[bp+var_102]
	jmp	short l_zeroPartyBufLoopEntry
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
camp_deleteParty endp
