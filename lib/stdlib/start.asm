assume ss:seg029, ds:nothing
public start

start proc far
	mov	ah, 30h
	int	21h		; DOS -	GET DOS	VERSION
			; Return: AL = major version number (00h for DOS 1.x)
	cmp	al, 2
	jnb	short loc_2829C
	int	20h		; DOS -	PROGRAM	TERMINATION
			; returns to DOS--identical to INT 21/AH=00h
loc_2829C:
	mov	di, seg	dseg
	mov	si, ds:2
	sub	si, di
	cmp	si, 1000h
	jb	short loc_282AE
	mov	si, 1000h
loc_282AE:
	cli
	mov	ss, di
	assume ss:dseg
	add	sp, offset dseg_end
	sti
	jnb	short loc_282CC
	push	ss
	pop	ds
	assume ds:dseg
	call	lib_printRuntimeError
	xor	ax, ax
	push	ax
	call	lib_printError
	mov	ax, 4CFFh
	int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
			; AL = exit code
loc_282CC:
	assume ds:nothing
	and	sp, 0FFFEh
	mov	ss:word_4EF82, sp
	mov	ss:word_4EF7E, sp
	mov	ax, si
	mov	cl, 4
	shl	ax, cl
	dec	ax
	mov	ss:word_4EF7C, ax
	add	si, di
	mov	ds:2, si
	mov	bx, es
	sub	bx, si
	neg	bx
	mov	ah, 4Ah
	int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
			; ES = segment address of block	to change
			; BX = new size	in paragraphs
	mov	ss:word_4EFF3, ds
	push	ss
	pop	es
	assume es:dseg
	cld
	mov	di, offset g_tavernSayingBase
	mov	cx, offset dseg_end+2
	sub	cx, di
	xor	ax, ax
	rep stosb
	push	ss
	pop	ds
	call 	far ptr loc_28360
	push	ss
	pop	ds
	call	far ptr sub_286DE
	call	far ptr	sub_28536
	xor	bp, bp
	push	ds:word_4F018
	push	ds:word_4F016
	push	ds:word_4F014
	push	ds:word_4F012
	push	ds:word_4F010
	call	_main
	push	ax
	call	far ptr	sub_28424

loc_2833C:
	mov	ax, seg	dseg
	mov	ds, ax
	mov	ax, 3
	mov	ss:off_4EF80, offset sub_28424
loc_2834B::
	push	ax
	call	lib_printRuntimeError
	call	lib_printError
	mov	ax, 0FFh
	push	ax
	push	cs
	call	off_4EF80

	db 0

loc_28360:
	mov	ah, 30h
	int	21h
	mov	ds:word_4EFF5, ax
	mov	ax, 3500h
	int	21h		; DOS -	2+ - GET INTERRUPT VECTOR
			; AL = interrupt number
			; Return: ES:BX	= value	of interrupt vector
	mov	word ptr ds:dword_4EFE1, bx
	mov	word ptr ds:dword_4EFE1+2,	es
	push	cs
	pop	ds
	assume ds:seg019
	mov	ax, 2500h
	mov	dx, offset loc_2833C
	int	21h		; DOS -	SET INTERRUPT VECTOR
			; AL = interrupt number
			; DS:DX	= new vector to	be used	for specified interrupt
	push	ss
	pop	ds
	assume ds:dseg
	mov	cx, word_4F906
	jcxz	short loc_283B4
	mov	es, word_4EFF3
	assume es:nothing
	mov	si, es:2Ch
	lds	ax, dword_4F908
	mov	dx, ds
	xor	bx, bx
	call	dword ptr ss:unk_4F904
	jnb	short loc_283A3
	push	ss
	pop	ds
	jmp	sub_284E6
loc_283A3:
	lds	ax, ss:dword_4F90C
	mov	dx, ds
	mov	bx, 3
	call	dword ptr ss:unk_4F904
	push	ss
	pop	ds
loc_283B4:
	mov	es, word_4EFF3
	mov	cx, es:2Ch
	jcxz	short loc_283F5
	mov	es, cx
	xor	di, di
loc_283C3:
	cmp	byte ptr es:[di], 0
	jz	short loc_283F5
	mov	cx, 0Ch
	mov	si, offset aC_file_info
	repe cmpsb
	jz	short loc_283DE
	mov	cx, 7FFFh
	xor	ax, ax
	repne scasb
	jnz	short loc_283F5
	jmp	short loc_283C3
loc_283DE:
	push	es
	push	ds
	pop	es
	assume es:dseg
	pop	ds
	mov	si, di
	mov	di, offset byte_4EFFC
	lodsb
	cbw
	xchg	ax, cx
loc_283EA:
	lodsb
	inc	al
	jz	short loc_283F0
	dec	ax
loc_283F0:
	stosb
	loop	loc_283EA
	push	ss
	pop	ds
loc_283F5:
	mov	bx, 4
loc_283F8:
	and	byte_4EFFC[bx],	0BFh
	mov	ax, 4400h
	int	21h		; DOS -	2+ - IOCTL - GET DEVICE	INFORMATION
			; BX = file or device handle
	jb	short loc_2840E
	test	dl, 80h
	jz	short loc_2840E
	or	byte_4EFFC[bx],	40h
loc_2840E:
	dec	bx
	jns	short loc_283F8
	mov	si, offset off_4F910
	mov	di, offset off_4F910
	call	sub_284AF
	mov	si, offset off_4F910
	mov	di, offset off_4F910
	call	sub_284AF
	retf
start endp

