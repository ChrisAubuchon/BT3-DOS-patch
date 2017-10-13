; Attributes: bp-based frame

sub_132F7 proc far

	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	ax, [bp+arg_0]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset partyIOBuf
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], seg seg022
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], '>'
	push	[bp+arg_4]
	push	[bp+arg_2]
	mov	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	inc	ax
	push	dx
	push	ax
	call	sub_2A912
	add	sp, 8
	mov	[bp+var_6], 0
	jmp	short loc_1333C
loc_13339:
	inc	[bp+var_6]
loc_1333C:
	cmp	[bp+var_6], 7
	jge	short loc_1336F
	getCharP	[bp+var_6], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_6]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	add	ax, 10h
	push	dx
	push	ax
	call	sub_2A912
	add	sp, 8
	jmp	short loc_13339
loc_1336F:
	mov	sp, bp
	pop	bp
	retf
sub_132F7 endp
