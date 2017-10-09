; Segment type:	Pure code
seg004 segment word public 'CODE' use16
	assume cs:seg004
;org 7
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_17737:
align 2
; Attributes: bp-based frame

bigpic_drawTopology proc far

	headerSize= word ptr -1Eh
	height=	word ptr -1Ch
	_offset= dword ptr -1Ah
	gbufOff= word ptr -12h
	gbufSeg= word ptr -10h
	row= word ptr -0Eh
	column=	word ptr -0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_2= word ptr	-2
	quadrant= word ptr  6
	sq= word ptr  8
	gbuf= dword ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 1Eh
	call	someStackOperation
	push	di
	push	si
	cmp	inDungeonMaybe, 0
	jz	short loc_17756
	mov	ax, 10h
	jmp	short loc_17759
loc_17756:
	mov	ax, 14h
loc_17759:
	mov	[bp+headerSize], ax
	mov	si, [bp+quadrant]
	shl	si, 1
	mov	al, byte ptr stru_44592.field_0[si]
	cbw
	mov	[bp+column], ax
	mov	al, stru_44592.field_1[si]
	cbw
	mov	[bp+row], ax
	mov	bx, [bp+quadrant]
	mov	al, byte_44278[bx]
	cbw
	mov	[bp+var_6], ax
	mov	al, byte_442F4[bx]
	cbw
	mov	cx, [bp+sq]
	shl	cx, 1
	shl	cx, 1
	add	ax, cx
	mov	[bp+var_8], ax
	mov	ax, [bp+headerSize]
	cmp	[bp+var_8], ax
	jl	short loc_177A8
	jmp	loc_1786B
loc_177A8:
	mov	di, [bp+var_8]
	lfs	bx, [bp+gbuf]
	mov	ah, fs:[bx+di+1]
	sub	al, al
	mov	bx, di
	mov	di, word ptr [bp+gbuf]
	mov	cl, fs:[bx+di]
	sub	ch, ch
	add	ax, cx
	add	ax, di
	mov	dx, fs
	add	ax, 9
	mov	word ptr [bp+_offset], ax
	mov	word ptr [bp+_offset+2], dx
	lfs	bx, [bp+_offset]
	inc	word ptr [bp+_offset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+var_2], ax
	mov	bx, word ptr [bp+_offset]
	inc	word ptr [bp+_offset]
	mov	al, fs:[bx]
	cbw
	mov	[bp+height], ax
	mov	ax, word ptr [bp+_offset]
	add	ax, 2
	mov	[bp+gbufOff], ax
	mov	[bp+gbufSeg], dx
	cmp	[bp+column], 0
	jge	short loc_17813
	mov	ax, [bp+column]
	sub	[bp+gbufOff], ax
	mov	ax, [bp+var_6]
	add	ax, [bp+column]
	jns	short loc_17809
	sub	ax, ax
loc_17809:
	mov	[bp+var_A], ax
	mov	[bp+column], 0
	jmp	short loc_1782F
loc_17813:
	mov	ax, [bp+column]
	add	ax, [bp+var_6]
	cmp	ax, 56
	jle	short loc_17829
	mov	ax, 55
	sub	ax, [bp+column]
	mov	[bp+var_A], ax
	jmp	short loc_1782F
loc_17829:
	mov	ax, [bp+var_6]
	mov	[bp+var_A], ax
loc_1782F:
	cmp	[bp+var_2], 0
	jz	short loc_1786B
	mov	bx, [bp+quadrant]
	mov	al, byte_444D8[bx]
	cbw
	push	ax
	mov	al, byte_442B6[bx]
	cbw
	push	ax
	push	[bp+height]
	push	[bp+var_2]
	push	[bp+var_A]
	push	[bp+row]
	push	[bp+column]
	push	[bp+gbufSeg]
	push	[bp+gbufOff]
	call	_bigpic_copyTopoElem
	add	sp, 12h
loc_1786B:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
bigpic_drawTopology endp

; Attributes: bp-based frame

dun_setBigpicBG	proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	func_enter
	_chkstk		4

	test	levFlags, 20h
	jz	loc_dun_setBigpicBG_inDungeon

	push_imm	44h
	push_imm	0BBBBh
	mov		ax, offset bigpicBuf
	mov		dx, seg seg021
	push		dx
	push		ax
	std_call	bigpic_setBG, 8
	jmp	loc_dun_setBigpicBG_exit
	

loc_dun_setBigpicBG_inDungeon:
	push	si
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+11h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+10h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, offset bigpicBuf
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	lfs	bx, [bp+arg_0]
	mov	ah, fs:(graphicsBuf+13h)[bx]
	sub	al, al
	mov	cl, fs:(graphicsBuf+12h)[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, bx
	mov	dx, fs
	add	ax, 0Dh
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, 9A0h
	push	ax
	push	dx
	push	[bp+var_4]
	mov	ax, (offset bigpicBuf+9A0h)
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
	cmp	lightDistance, 4
	jnb	short loc_dun_setBigpicBG_exit
	mov	al, lightDistance
	sub	ah, ah
	mov	si, ax
	shl	si, 1
	push	bigpicLightSize[si]
	sub	ax, ax
	push	ax
	mov	bx, bigpicLightOffset[si]
	lea	ax, bigpicBuf[bx]
	mov	dx, seg	seg021
	push	dx
	push	ax
	call	_memset
	add	sp, 8
	pop	si
loc_dun_setBigpicBG_exit:
	func_exit
	retf
dun_setBigpicBG	endp

seg004 ends
