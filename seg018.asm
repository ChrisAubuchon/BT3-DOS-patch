; Segment type:	Pure code
seg018 segment byte public 'CODE' use16
	assume cs:seg018
;org 0Ch
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
; Attributes: bp-based frame
geomancerSomething proc	far

	var_14C= word ptr -14Ch
	var_14A= word ptr -14Ah
	var_136= word ptr -136h
	random16_3= word ptr -134h
	var_132= word ptr -132h
	var_130= word ptr -130h
	var_12E= word ptr -12Eh
	var_12C= word ptr -12Ch
	var_12A= word ptr -12Ah
	random16_1= word ptr -2Ah
	var_28=	word ptr -28h
	var_26=	word ptr -26h
	var_24=	word ptr -24h
	random16_2= word ptr -22h
	var_20=	word ptr -20h
	var_1E=	word ptr -1Eh
	var_A= word ptr	-0Ah
	random16_4= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2

;	mov	ax, 1
;	retf
;geomancerSomething endp

	push	bp
	mov	bp, sp
	mov	ax, 14Ch
	call	someStackOperation
	push	si
	call	_random
	and	ax, 0Fh
	mov	[bp+random16_1], ax
	call	_random
	and	ax, 0Fh
	mov	[bp+random16_2], ax
	call	_random
	and	ax, 0Fh
	mov	[bp+random16_3], ax
	call	_random
	and	ax, 0Fh
	mov	[bp+random16_4], ax
	mov	bx, ax
	mov	al, byte_4CA18[bx]
	sub	ah, ah
	mov	[bp+var_A], ax
	mov	cl, 4
	shr	ax, cl
	mov	[bp+var_136], ax
	mov	al, byte ptr [bp+random16_4]
	xor	al, byte ptr [bp+random16_1]
	test	al, 1
	jz	short loc_2712B
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	cx, [bp+random16_2]
	and	cx, 1
	or	ax, cx
	mov	[bp+var_12E], ax
	mov	bx, ax
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	add	ax, [bp+random16_1]
	sub	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+random16_2], ax
loc_2712B:
	mov	ax, [bp+var_A]
	and	ax, 7
	shl	ax, 1
	mov	[bp+var_12E], ax
	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	add	ax, [bp+var_136]
	and	ax, 0Fh
	mov	[bp+var_12C], ax
	mov	bx, [bp+var_12E]
	mov	al, byte_4CA28[bx]
	sub	ah, ah
	cmp	ax, [bp+var_12C]
	jz	short loc_27162
	mov	al, byte_4CA29[bx]
	cmp	ax, [bp+var_12C]
	jnz	short loc_27167
loc_27162:
	mov	ax, 1
	jmp	short loc_27169
loc_27167:
	sub	ax, ax
loc_27169:
	mov	[bp+var_26], ax
	or	ax, ax
	jz	short loc_2717F
	mov	ax, [bp+random16_3]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl
	or	al, 8
	jmp	short loc_27189
loc_2717F:
	mov	ax, [bp+random16_2]
	sub	ax, [bp+random16_1]
	mov	cl, 4
	shl	ax, cl
loc_27189:
	mov	[bp+var_4], ax
	mov	al, byte ptr [bp+var_4]
	add	al, byte ptr [bp+var_A]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	ah, byte ptr [bp+var_2]
	sub	al, al
	add	ax, [bp+var_2]
	mov	[bp+var_24], ax
	mov	[bp+var_28], 0Fh
	jmp	short loc_271AC
loc_271A9:
	dec	[bp+var_28]
loc_271AC:
	cmp	[bp+var_28], 0
	jle	short loc_271C8
	mov	ax, [bp+var_24]
	and	ax, 1
	mov	[bp+var_4], ax
	shr	[bp+var_24], 1
	or	ax, ax
	jz	short loc_271C6
	add	byte ptr [bp+var_24+1],	0B4h
loc_271C6:
	jmp	short loc_271A9
loc_271C8:
	mov	al, byte ptr [bp+var_24+1]
	sub	ah, ah
	mov	[bp+var_14C], ax
	mov	ax, [bp+var_2]
	and	ax, 7
	mov	si, ax
	shr	si, 1
	mov	al, byte_4CA38[si]
	sub	ah, ah
	and	[bp+var_14C], ax
	mov	ax, si
	xor	al, 3
	mov	[bp+var_20], ax
	mov	[bp+var_28], 0
	jmp	short loc_271F6
loc_271F3:
	inc	[bp+var_28]
loc_271F6:
	cmp	[bp+var_28], 14h
	jge	short loc_27205
	mov	si, [bp+var_28]
	mov	byte ptr [bp+si+var_1E], 0
	jmp	short loc_271F3
loc_27205:
	mov	[bp+var_28], 0
	mov	ax, [bp+var_14C]
	mov	cl, 7
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	mov	ax, [bp+var_14C]
	mov	cl, 4
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	mov	ax, [bp+var_14C]
	shr	ax, 1
	push	ax
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	mov	ax, [bp+var_24]
	mov	cl, 6
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	mov	ax, [bp+var_24]
	mov	cl, 3
	shr	ax, cl
	push	ax
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	push	[bp+var_24]
	push	cs
	call	near ptr sub_273DA
	add	sp, 2
	mov	si, [bp+var_28]
	inc	[bp+var_28]
	mov	byte ptr [bp+si+var_1E], al
	mov	ax, offset aToTraverseTime
	push	ds
	push	ax
	lea	ax, [bp+var_12A]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	bx, [bp+random16_1]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_4C958+2)[bx]
	push	word ptr off_4C958[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	ax, offset asc_4C8DA
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	bx, [bp+random16_2]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_4C998+2)[bx]
	push	word ptr off_4C998[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	ax, offset asc_4C8DA
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	bx, [bp+random16_3]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_4C9D8+2)[bx]
	push	word ptr off_4C9D8[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	ax, offset aAnd_0
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	bx, [bp+random16_4]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_4C918+2)[bx]
	push	word ptr off_4C918[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	mov	ax, offset a__0
	push	ds
	push	ax
	push	dx
	push	[bp+var_132]
	call	_strcat
	add	sp, 8
	mov	[bp+var_132], ax
	mov	[bp+var_130], dx
	lea	ax, [bp+var_12A]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	ax, 10h
	push	ax
	lea	ax, [bp+var_14A]
	push	ss
	push	ax
	call	readString
	add	sp, 6
	push	[bp+var_20]
	lea	ax, [bp+var_1E]
	push	ss
	push	ax
	lea	ax, [bp+var_14A]
	push	ss
	push	ax
	push	cs
	call	near ptr sub_273F2
	add	sp, 0Ah
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
geomancerSomething endp

; Attributes: bp-based frame

sub_273DA proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_0]
	and	ax, 7
	or	al, 30h
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_273DA endp

; Attributes: bp-based frame

sub_273F2 proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, [bp+arg_8]
	mov	[bp+var_2], ax
	jmp	short loc_27409
loc_27406:
	inc	[bp+var_2]
loc_27409:
	cmp	[bp+var_2], 7
	jge	short loc_27429
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_4]
	cmp	fs:[bx+si], al
	jmp	short loc_27427
	sub	ax, ax
	jmp	short loc_2742E
loc_27427:
	jmp	short loc_27406
loc_27429:
	mov	ax, 1
	jmp	short $+2
loc_2742E:
	pop	si
	mov	sp, bp
	pop	bp
locret_27432:
	retf
sub_273F2 endp

seg018 ends
