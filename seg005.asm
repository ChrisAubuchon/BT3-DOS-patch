; Segment type:	Pure code
seg005 segment byte public 'CODE' use16
	assume cs:seg005
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame

sub_17920 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_0]
	mov	al, byte_4472A[bx]
	sub	ah, ah
	push	ax
	push	bx
	push	cs
	call	near ptr icon_draw
	add	sp, 4
	mov	bx, [bp+arg_0]
	mov	lightDuration[bx], 0
	mov	ax, [bp+arg_0]
	jmp	short loc_1797C
loc_1794E:
	sub	al, al
	mov	lightDistance, al
	mov	gs:gl_detectSecretDoorFlag, al
	jmp	short loc_1798C
loc_17962:
	mov	detectType, 0
	jmp	short loc_1798C
loc_1796E:
	mov	byte_4EECB, 0
loc_17978:
	jmp	short loc_1798C
	jmp	short loc_1798C
loc_1797C:
	or	ax, ax
	jz	short loc_1794E
	cmp	ax, 2
	jz	short loc_17962
	cmp	ax, 3
	jz	short loc_1796E
	jmp	short loc_17978
loc_1798C:
	mov	sp, bp
	pop	bp
locret_1798F:
	retf
sub_17920 endp

; Attributes: bp-based frame

icon_activate proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	mov	bx, [bp+arg_0]
	mov	iconActiveFlagMaybe[bx], 1
	mov	bx, [bp+arg_0]
	mov	si, bx
	sub	al, al
	mov	byte_44718[si],	al
	mov	byte_44730[bx],	al
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr icon_draw
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
icon_activate endp

; Attributes: bp-based frame

sub_179C4 proc far

	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	al, byte ptr dirFacing
	mov	byte_44731, al
	cmp	gs:byte_422A0, 0
	jz	short loc_17A34
	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 3
	jnz	short loc_17A34
	inc	gs:bigpicImageNo
	and	gs:bigpicImageNo, 3
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicImageNo
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:word_4240A
	mov	dx, gs:word_4240C
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
	jmp	short loc_17A9C
loc_17A34:
	cmp	gs:word_42560, 0
	jz	short loc_17A9C
	mov	ax, gs:word_4245A
	inc	gs:word_4245A
	test	al, 7
	jnz	short loc_17A9C
	inc	gs:bigpicImageNo
	cmp	gs:bigpicImageNo, 3
	jnz	short loc_17A6D
	mov	gs:word_42560, 0
loc_17A6D:
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	mov	al, gs:bigpicImageNo
	sub	ah, ah
	mov	cx, 1340h
	mul	cx
	add	ax, gs:word_4240A
	mov	dx, gs:word_4240C
	push	dx
	push	ax
	call	far ptr	vid_drawBigpic
	add	sp, 8
loc_17A9C:
	mov	[bp+var_2], 0
	jmp	short loc_17AA6
loc_17AA3:
	inc	[bp+var_2]
loc_17AA6:
	cmp	[bp+var_2], 5
	jge	short loc_17B1E
	mov	bx, [bp+var_2]
	cmp	lightDuration[bx], 0
	jz	short loc_17B1C
	mov	si, bx
	mov	al, byte_44718[si]
	cmp	byte_44730[bx],	al
	jz	short loc_17AE0
	mov	al, byte_44730[si]
	mov	byte_44718[bx],	al
	mov	bx, [bp+var_2]
	mov	al, byte_44730[bx]
	cbw
	push	ax
	push	bx
	push	cs
	call	near ptr icon_draw
	add	sp, 4
loc_17AE0:
	mov	bx, [bp+var_2]
	cmp	byte_4471E[bx],	0
	jz	short loc_17B1C
	mov	al, iconActiveFlagMaybe[bx]
	dec	iconActiveFlagMaybe[bx]
	cmp	al, 1
	jnz	short loc_17B1C
	mov	bx, [bp+var_2]
	mov	si, bx
	mov	al, byte_4471E[si]
	mov	iconActiveFlagMaybe[bx], al
	mov	bx, [bp+var_2]
	inc	byte_44730[bx]
	mov	al, byte_44730[bx]
	mov	bx, [bp+var_2]
	cmp	al, byte_4472A[bx]
	jnz	short loc_17B1C
	mov	byte_44730[bx],	0
loc_17B1C:
	jmp	short loc_17AA3
loc_17B1E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_179C4 endp

; Attributes: bp-based frame

icon_draw proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= byte ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr iconDataList[bx]
	mov	dx, word ptr (iconDataList+2)[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_17B46:
	mov	al, [bp+arg_2]
	dec	[bp+arg_2]
	or	al, al
	jz	short loc_17B60
	mov	bl, [bp+arg_0]
	sub	bh, bh
	shl	bx, 1
	mov	ax, word_4470E[bx]
	add	[bp+var_4], ax
	jmp	short loc_17B46
loc_17B60:
	mov	al, [bp+arg_0]
	sub	ah, ah
	mov	si, ax
	mov	al, iconWidth[si]
	push	ax
	mov	al, iconHeight[si]
	push	ax
	mov	al, iconXOffset[si]
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	far ptr	sub_3E986
	add	sp, 0Ah
	pop	si
	mov	sp, bp
	pop	bp
locret_17B88:
	retf
icon_draw endp

seg005 ends
