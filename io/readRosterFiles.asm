
; Attributes: bp-based frame

readRosterFiles proc far

	bufferP= dword ptr -0Ah
	loopCounter= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	mov	word ptr [bp+bufferP], offset g_rosterCharacterBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
	jmp	short loc_135CF
loc_135CC:
	inc	[bp+loopCounter]
loc_135CF:
	cmp	[bp+loopCounter], 4Bh	
	jge	short loc_135E6
	getCharP	[bp+loopCounter], bx
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_135CC
loc_135E6:
	mov	ax, offset aThieves_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_4], ax
	mov	ax, 9000
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	_read
	add	sp, 8
	push	[bp+var_4]
	call	_close
	add	sp, 2
	push	cs
	call	near ptr countSavedChars
	mov	[bp+var_2], ax
	mov	[bp+loopCounter], ax
	jmp	short loc_13626
loc_13623:
	inc	[bp+loopCounter]
loc_13626:
	cmp	[bp+loopCounter], 75
	jge	short loc_1363D
	getCharP	[bp+loopCounter], bx
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13623
loc_1363D:
	mov	word ptr [bp+bufferP], offset g_rosterPartyBuffer
	mov	word ptr [bp+bufferP+2], seg seg022
	mov	[bp+loopCounter], 0
	jmp	short loc_13651
loc_1364E:
	inc	[bp+loopCounter]
loc_13651:
	cmp	[bp+loopCounter], 0Ah
	jge	short loc_13667
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_1364E
loc_13667:
	mov	ax, offset aParties_inf
	push	ds
	push	ax
	push	cs
	call	near ptr getDisk2
	add	sp, 4
	mov	[bp+var_4], ax
	mov	ax, 500h
	push	ax
	mov	ax, offset g_rosterPartyBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+var_4]
	call	_read
	add	sp, 8
	push	cs
	call	near ptr roster_countParties
	mov	[bp+loopCounter], ax
	jmp	short loc_13699
loc_13696:
	inc	[bp+loopCounter]
loc_13699:
	cmp	[bp+loopCounter], 0Ah
	jge	short loc_136AF
	mov	bx, [bp+loopCounter]
	mov	cl, 7
	shl	bx, cl
	lfs	si, [bp+bufferP]
	mov	byte ptr fs:[bx+si], 0
	jmp	short loc_13696
loc_136AF:
	push	[bp+var_4]
	call	_close
	add	sp, 2
	mov	ax, [bp+var_2]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
readRosterFiles endp
