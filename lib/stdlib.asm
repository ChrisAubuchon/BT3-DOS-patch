undefine(`CALL')

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
	call	sub_284C2
	xor	ax, ax
	push	ax
	call	sub_28785
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
	call	sub_284C2
	call	sub_28785
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

; Attributes: bp-based frame
sub_28424 proc near
	push	bp
	mov	bp, sp
	mov	si, offset byte_5006A
	mov	di, offset byte_5006A
	call	sub_284AF
	mov	si, offset off_4F910
	mov	di, offset seg027_41
	call	sub_284AF
	jmp	short loc_2843E
sub_28424 endp

; Attributes: bp-based frame
sub_2843B proc near
arg_2= word ptr	 6
	push	bp
	mov	bp, sp
loc_2843E::
	mov	si, offset seg027_41
	mov	di, offset seg027_41
	call	sub_284AF
	mov	si, offset seg027_41
	mov	di, offset seg027_41
	call	sub_284AF
	call	sub_28510
	or	ax, ax
	jz	short loc_28464
	cmp	[bp+arg_2], 0
	jnz	short loc_28464
	mov	[bp+arg_2], 0FFh
loc_28464:
	mov	cx, 0Fh
	mov	bx, 5
loc_2846A:
	test	byte_4EFFC[bx],	1
	jz	short loc_28475
	mov	ah, 3Eh
	int	21h		; DOS -	2+ - CALL(close) A FILE WITH HANDLE
			; BX = file handle
loc_28475:
	inc	bx
	loop	loc_2846A
	call	sub_28482
	mov	ax, [bp+arg_2]
	mov	ah, 4Ch
	int	21h		; DOS -	2+ - QUIT WITH EXIT CODE (EXIT)
sub_2843B endp		; AL = exit code
sub_28482 proc near
	mov	cx, word_4F906
	jcxz	short loc_2848F
	mov	bx, 2
	call	dword ptr unk_4F904
loc_2848F:
	push	ds
	lds	dx, dword_4EFE1
	mov	ax, 2500h
	int	21h		; DOS -	SET INTERRUPT VECTOR
			; AL = interrupt number
			; DS:DX	= new vector to	be used	for specified interrupt
	pop	ds
	cmp	byte_4F022, 0
	jz	short locret_284AE
	push	ds
	mov	al, byte_4F023
	lds	dx, dword_4F024
	mov	ah, 25h
	int	21h		; DOS -	SET INTERRUPT VECTOR
			; AL = interrupt number
			; DS:DX	= new vector to	be used	for specified interrupt
	pop	ds
locret_284AE:
	retn
sub_28482 endp

sub_284AF proc near
	cmp	si, di
	jnb	short locret_284C1
	sub	di, 4
	mov	ax, [di]
	or	ax, [di+2]
	jz	short sub_284AF
	call	dword ptr [di]
	jmp	short sub_284AF
locret_284C1:
	retn
sub_284AF endp

; Attributes: bp-based frame

sub_284C2 proc far
	push	bp
	mov	bp, sp
	mov	ax, 0FCh 
	push	ax
	call	sub_28785
	cmp	word_4F02A, 0
	jz	short loc_284D9
	call	dword ptr unk_4F028
loc_284D9:
	mov	ax, 0FFh
	push	ax
	call	sub_28785
	mov	sp, bp
	pop	bp
	retf
sub_284C2 endp

sub_284E6 proc near
	mov	ax, 2
	jmp	loc_2834B
sub_284E6 endp

someStackOperation proc	far
	pop	cx
	pop	dx
	mov	bx, sp
	sub	bx, ax
	jb	short loc_284FF
	cmp	bx, word_4F030
	jb	short loc_284FF
	mov	sp, bx
	push	dx
	push	cx
	retf
loc_284FF:
	mov	ax, word ptr dword_4F02C
	inc	ax
	jnz	short loc_2850A
	xor	ax, ax
	jmp	loc_2834B
loc_2850A:
	push	dx
	push	cx
	jmp	dword_4F02C
someStackOperation endp


sub_28510 proc far
	push	si
	mov	si, offset word_42670
	mov	cx, 42h	
	xor	ah, ah
	cld
loc_28519:
	lodsb
	xor	ah, al
	loop	loc_28519
	xor	ah, 55h
	jz	short loc_28534
	call	sub_284C2
	mov	ax, 1
	push	ax
	call	sub_28785
	mov	ax, 1
loc_28534:
	pop	si
	retf
sub_28510 endp

sub_28536 proc near
	pop	word ptr dword_4F032
	pop	word ptr dword_4F032+2
	mov	dx, 2
	cmp	byte ptr word_4EFF5, dl
	jz	short loc_28570
	mov	es, word_4EFF3
	assume es:nothing
	mov	es, word ptr es:2Ch
	mov	word ptr off_4F01A+2, es
	xor	ax, ax
	cwd
	mov	cx, 8000h
	xor	di, di
loc_2855C:
	repne scasb
	scasb
	jnz	short loc_2855C
	inc	di
	inc	di
	mov	word ptr off_4F01A, di
	mov	cx, 0FFFFh
	repne scasb
	not	cx
	mov	dx, cx
loc_28570:
	mov	di, 1
	mov	si, 81h	
	mov	ds, word_4EFF3
loc_2857A:
	lodsb
	cmp	al, 20h	
	jz	short loc_2857A
	cmp	al, 9
	jz	short loc_2857A
	cmp	al, 0Dh
	jz	short loc_285F6
	or	al, al
	jz	short loc_285F6
	inc	di
loc_2858C:
	dec	si
loc_2858D:
	lodsb
	cmp	al, 20h	
	jz	short loc_2857A
	cmp	al, 9
	jz	short loc_2857A
	cmp	al, 0Dh
	jz	short loc_285F6
	or	al, al
	jz	short loc_285F6
	cmp	al, 22h	
	jz	short loc_285C6
	cmp	al, 5Ch	
	jz	short loc_285A9
	inc	dx
	jmp	short loc_2858D
loc_285A9:
	xor	cx, cx
loc_285AB:
	inc	cx
	lodsb
	cmp	al, 5Ch	
	jz	short loc_285AB
	cmp	al, 22h	
	jz	short loc_285B9
	add	dx, cx
	jmp	short loc_2858C
loc_285B9:
	mov	ax, cx
	shr	cx, 1
	adc	dx, cx
	test	al, 1
	jnz	short loc_2858D
	jmp	short loc_285C6
loc_285C5:
	dec	si
loc_285C6:
	lodsb
	cmp	al, 0Dh
	jz	short loc_285F6
	or	al, al
	jz	short loc_285F6
	cmp	al, 22h	
	jz	short loc_2858D
	cmp	al, 5Ch	
	jz	short loc_285DA
	inc	dx
	jmp	short loc_285C6
loc_285DA:
	xor	cx, cx
loc_285DC:
	inc	cx
	lodsb
	cmp	al, 5Ch	
	jz	short loc_285DC
	cmp	al, 22h	
	jz	short loc_285EA
	add	dx, cx
	jmp	short loc_285C5
loc_285EA:
	mov	ax, cx
	shr	cx, 1
	adc	dx, cx
	test	al, 1
	jnz	short loc_285C6
	jmp	short loc_2858D
loc_285F6:
	push	ss
	pop	ds
	mov	word_4F010, di
	add	dx, di
	inc	di
	shl	di, 1
	shl	di, 1
	add	dx, di
	and	dl, 0FEh
	sub	sp, dx
	mov	ax, sp
	mov	word_4F012, ax
	mov	word_4F014, ds
	mov	bx, ax
	add	di, bx
	push	ss
	pop	es
	assume es:dseg
	mov	ss:[bx], di
	mov	word ptr ss:[bx+2], ss
	add	bx, 4
	lds	si, off_4F01A
loc_28627:
	lodsb
	stosb
	or	al, al
	jnz	short loc_28627
	mov	si, 81h	
	mov	ds, ss:word_4EFF3
	jmp	short loc_2863A
loc_28637:
	xor	ax, ax
	stosb
loc_2863A:
	lodsb
	cmp	al, 20h	
	jz	short loc_2863A
	cmp	al, 9
	jz	short loc_2863A
	cmp	al, 0Dh
	jnz	short loc_2864A
	jmp	loc_286CE
loc_2864A:
	or	al, al
	jnz	short loc_28651
	jmp	short loc_286CE
db 90h
loc_28651:
	mov	ss:[bx], di
	mov	word ptr ss:[bx+2], ss
	add	bx, 4
loc_2865B:
	dec	si
loc_2865C:
	lodsb
	cmp	al, 20h	
	jz	short loc_28637
	cmp	al, 9
	jz	short loc_28637
	cmp	al, 0Dh
	jz	short loc_286CB
	or	al, al
	jz	short loc_286CB
	cmp	al, 22h	
	jz	short loc_28698
	cmp	al, 5Ch	
	jz	short loc_28678
	stosb
	jmp	short loc_2865C
loc_28678:
	xor	cx, cx
loc_2867A:
	inc	cx
	lodsb
	cmp	al, 5Ch	
	jz	short loc_2867A
	cmp	al, 22h	
	jz	short loc_2868A
	mov	al, 5Ch	
	rep stosb
	jmp	short loc_2865B
loc_2868A:
	mov	al, 5Ch	
	shr	cx, 1
	rep stosb
	jnb	short loc_28698
	mov	al, 22h	
	stosb
	jmp	short loc_2865C
loc_28697:
	dec	si
loc_28698:
	lodsb
	cmp	al, 0Dh
	jz	short loc_286CB
	or	al, al
	jz	short loc_286CB
	cmp	al, 22h	
	jz	short loc_2865C
	cmp	al, 5Ch	
	jz	short loc_286AC
	stosb
	jmp	short loc_28698
loc_286AC:
	xor	cx, cx
loc_286AE:
	inc	cx
	lodsb
	cmp	al, 5Ch	
	jz	short loc_286AE
	cmp	al, 22h	
	jz	short loc_286BE
	mov	al, 5Ch	
	rep stosb
	jmp	short loc_28697
loc_286BE:
	mov	al, 5Ch	
	shr	cx, 1
	rep stosb
	jnb	short loc_2865C
	mov	al, 22h	
	stosb
	jmp	short loc_28698
loc_286CB:
	xor	ax, ax
	stosb
loc_286CE:
	push	ss
	pop	ds
	mov	word ptr [bx], 0
	mov	word ptr [bx+2], 0
	jmp	dword_4F032
sub_28536 endp

align 2
; Attributes: bp-based frame

sub_286DE proc far
	push	bp
	mov	bp, sp
	push	bp
	mov	ds, word_4EFF3
	assume ds:nothing
	xor	cx, cx
	mov	ax, cx
	mov	bp, cx
	mov	di, cx
	dec	cx
	mov	si, ds:2Ch
	or	si, si
	jz	short loc_28707
	mov	es, si
	assume es:nothing
	cmp	byte ptr es:0, 0
	jz	short loc_28707
loc_28701:
	repne scasb
	inc	bp
	scasb
	jnz	short loc_28701
loc_28707:
	inc	bp
	xchg	ax, di
	inc	ax
	and	al, 0FEh
	mov	di, bp
	shl	bp, 1
	shl	bp, 1
	add	ax, bp
	push	ss
	pop	ds
	push	di
	mov	di, 9
	call	sub_287B0
	pop	di
	mov	cx, di
	mov	di, bp
	add	di, ax
	mov	ds:word_4F016, bp
	mov	ds:word_4F018, ds
	push	ds
	pop	es
	assume es:dseg
	mov	ds, si
	xor	si, si
	dec	cx
	jcxz	short loc_2874C
loc_28735:
	cmp	word ptr [si], 433Bh
	jz	short loc_28744
	mov	[bp+0],	di
	mov	word ptr [bp+2], es
	add	bp, 4
loc_28744:
	lodsb
	stosb
	or	al, al
	jnz	short loc_28744
	loop	loc_28735
loc_2874C:
	mov	[bp+0],	cx
	mov	[bp+2],	cx
	push	ss
	pop	ds
	pop	bp
	mov	sp, bp
	pop	bp
	retf
sub_286DE endp

align 2
; Attributes: bp-based frame

sub_2875A proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	push	si
	push	di
	push	ds
	pop	es
	mov	dx, [bp+arg_0]
	mov	si, (offset aNmsg+8)
loc_28767:
	lodsw
	cmp	ax, dx
	jz	short loc_2877C
	inc	ax
	xchg	ax, si
	jz	short loc_2877C
	xchg	ax, di
	xor	ax, ax
	mov	cx, 0FFFFh
	repne scasb
	mov	si, di
	jmp	short loc_28767
loc_2877C:
	xchg	ax, si
	pop	di
	pop	si
	mov	sp, bp
	pop	bp
	retf	2
sub_2875A endp

; Attributes: bp-based frame

sub_28785 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	push	di
	push	[bp+arg_0]
	call	sub_2875A
	or	ax, ax
	jz	short loc_287A9
	xchg	ax, dx
	mov	di, dx
	xor	ax, ax
	mov	cx, 0FFFFh
	repne scasb
	not	cx
	dec	cx
	mov	bx, 2
	mov	ah, 40h
	int	21h		; DOS -	2+ - CALL(write) TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
loc_287A9:
	pop	di
	mov	sp, bp
	pop	bp
	retf	2
sub_28785 endp

sub_287B0 proc near
	mov	dx, ax
	add	ax, ds:word_4EF82
	jb	short loc_287ED
	cmp	ds:word_4EF7C, ax
	jnb	short loc_287E3
	add	ax, 0Fh
	push	ax
	rcr	ax, 1
	mov	cl, 3
	shr	ax, cl
	mov	cx, ds
	mov	bx, ds:word_4EFF3
	sub	cx, bx
	add	ax, cx
	mov	es, bx
	assume es:nothing
	mov	bx, ax
	mov	ah, 4Ah
	int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
			; ES = segment address of block	to change
			; BX = new size	in paragraphs
	pop	ax
	jb	short loc_287ED
	and	al, 0F0h
	dec	ax
	mov	ds:word_4EF7C, ax
loc_287E3:
	xchg	ax, bp
	mov	bp, ds:word_4EF82
	add	ds:word_4EF82, dx
	retn
loc_287ED:
	mov	ax, di
	jmp	loc_2834B
sub_287B0 endp

	jb	short loc_28807
loc_287F4:
	xor	ax, ax
	mov	sp, bp
	pop	bp
	retf
	jnb	short loc_287F4
	push	ax
	call	sub_28818
	pop	ax
	mov	sp, bp
	pop	bp
	retf
; START	OF FUNCTION CHUNK FOR sub_2A2F6
loc_28805:
	jnb	short loc_2880E
loc_28807:
	call	sub_28818
	mov	ax, 0FFFFh
	cwd
loc_2880E:
	mov	sp, bp
	pop	bp
	retf
; END OF FUNCTION CHUNK	FOR sub_2A2F6
	xor	ah, ah
	call	sub_28818
	retf

sub_28818 proc near
	mov	ds:byte_4EFF8, al
	or	ah, ah
	jnz	short loc_28842
	cmp	ds:word_4EFF5, 3
	jb	short loc_28833
	cmp	al, 22h	
	jnb	short loc_28837
	cmp	al, 20h	
	jb	short loc_28833
	mov	al, 5
	jmp	short loc_28839
db 90h
loc_28833:
	cmp	al, 13h
	jbe	short loc_28839
loc_28837:
	mov	al, 13h
loc_28839:
	mov	bx, offset byte_4F036
	xlat
loc_2883D:
	cbw
	mov	ds:word_4EFED, ax
	retn
loc_28842:
	mov	al, ah
	jmp	short loc_2883D
sub_28818 endp

sub_28846	proc far

	var_6 = dword ptr -6

	push	bp
	mov	bp, sp
	sub	sp, 6
	push	si
	mov	ax, offset off_4F64C
	mov	[bp-6],	ax
	mov	word ptr [bp-4], ds
	sub	si, si
	jmp	short loc_28876
loc_2885A:
	les	bx, [bp-6]
	test	byte ptr es:[bx+0Ah], 83h
	jz	short loc_28872
	push	es
	push	bx
	call	sub_28DC2
	add	sp, 4
	inc	ax
	jz	short loc_28872
	inc	si
loc_28872:
	add	word ptr [bp-6], 0Ch
loc_28876:
	mov	ax, ds:word_4F7B4
	mov	dx, ds:seg_4F7B6
	cmp	[bp-6],	ax
	jbe	short loc_2885A
	mov	ax, si
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_28846	endp

align 2
; Attributes: bp-based frame

printf proc far

	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	sub	sp, 0Ch
	push	si
	mov	ax, offset byte_4F658
	mov	[bp+var_A], ax
	mov	[bp+var_8], ds
	lea	ax, [bp+arg_4]
	mov	[bp+var_6], ax
	mov	[bp+var_4], ss
	push	ds
	push	[bp+var_A]
	call	sub_28C28
	add	sp, 4
	mov	si, ax
	push	[bp+var_4]
	push	[bp+var_6]
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+var_8]
	push	[bp+var_A]
	call	printf_doPrint
	add	sp, 0Ch
	mov	[bp+var_C], ax
	push	[bp+var_8]
	push	[bp+var_A]
	push	si
	call	sub_28CE2
	add	sp, 6
	mov	ax, [bp+var_C]
	pop	si
	mov	sp, bp
	pop	bp
	retf
printf endp

align 2
; Attributes: bp-based frame

sub_288E6 proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 2
	push	si
	mov	ax, [bp+arg_0]
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, offset off_4F64C
	mov	[bp+var_2], ax
	les	bx, dword ptr [bp+arg_0]
	test	byte ptr es:[bx+0Ah], 83h
	jz	short loc_28918
	test	byte ptr es:[bx+0Ah], 40h
	jz	short loc_2891E
loc_28918:
	mov	ax, 0FFFFh
	jmp	loc_289DB
loc_2891E:
	les	bx, dword ptr [bp+arg_0]
	test	byte ptr es:[bx+0Ah], 2
	jz	short loc_28930
	or	byte ptr es:[bx+0Ah], 20h
	jmp	short loc_28918
align 2
loc_28930:
	or	byte ptr es:[bx+0Ah], 1
	mov	bx, [bp+var_2]
	and	byte ptr [bx], 0FBh
	mov	bx, [bp+arg_0]
	test	byte ptr es:[bx+0Ah], 0Ch
	jnz	short loc_2896C
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	test	ds:byte_4F73C[bx], 1
	jnz	short loc_2896C
	push	es
	push	[bp+arg_0]
	call	sub_28B9E
	add	sp, 4
	jmp	short loc_2897E
align 2
loc_2896C:
	les	bx, dword ptr [bp+arg_0]
	mov	ax, es:[bx+6]
	mov	dx, es:[bx+8]
	mov	es:[bx], ax
	mov	es:[bx+2], dx
loc_2897E:
	mov	bx, [bp+var_2]
	push	word ptr [bx+2]
	les	bx, dword ptr [bp+arg_0]
	push	word ptr es:[bx+8]
	push	word ptr es:[bx+6]
	mov	al, es:[bx+0Bh]
	cbw
	push	ax
	call	sub_2A370
	add	sp, 8
	les	bx, dword ptr [bp+arg_0]
	mov	es:[bx+4], ax
	or	ax, ax
	jz	short loc_289AD
	cmp	ax, 0FFFFh
	jnz	short loc_289C8
loc_289AD:
	cmp	word ptr es:[bx+4], 0
	jz	short loc_289B8
	mov	al, 20h	
	jmp	short loc_289BA
loc_289B8:
	mov	al, 10h
loc_289BA:
	or	es:[bx+0Ah], al
	mov	word ptr es:[bx+4], 0
	jmp	loc_28918
align 2
loc_289C8:
	dec	word ptr es:[bx+4]
	mov	si, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	al, es:[si]
	sub	ah, ah
loc_289DB:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_288E6 endp

; Attributes: bp-based frame

sub_289E0 proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	sub	sp, 8
	push	di
	push	si
	les	bx, [bp+arg_2]
	mov	al, es:[bx+0Bh]
	cbw
	mov	[bp+var_6], ax
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, offset off_4F64C
	mov	[bp+var_8], ax
	test	byte ptr es:[bx+0Ah], 83h
	jz	short loc_28A1A
	test	byte ptr es:[bx+0Ah], 40h
	jz	short loc_28A28
loc_28A1A:
	les	bx, [bp+arg_2]
	or	byte ptr es:[bx+0Ah], 20h
	mov	ax, 0FFFFh
	jmp	loc_28B98
loc_28A28:
	test	byte ptr es:[bx+0Ah], 1
	jnz	short loc_28A1A
	or	byte ptr es:[bx+0Ah], 2
	and	byte ptr es:[bx+0Ah], 0EFh
	sub	ax, ax
	mov	es:[bx+4], ax
	mov	si, ax
	mov	[bp+var_4], si
	test	byte ptr es:[bx+0Ah], 0Ch
	jz	short loc_28A4E
	jmp	loc_28AE4
loc_28A4E:
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	test	ds:byte_4F73C[bx], 1
	jnz	short loc_28AE4
	cmp	word ptr [bp+arg_2], offset byte_4F658
	jnz	short loc_28A76
	cmp	word ptr [bp+arg_2+2], seg dseg
	jz	short loc_28A84
loc_28A76:
	cmp	word ptr [bp+arg_2], offset byte_4F664
	jnz	short loc_28AD8
	cmp	word ptr [bp+arg_2+2], seg dseg
	jnz	short loc_28AD8
loc_28A84:
	push	[bp+var_6]
	call	sub_2A9AC
	add	sp, 2
	or	ax, ax
	jnz	short loc_28AE4
	inc	word_4F04A
	cmp	word ptr [bp+arg_2], offset byte_4F658
	jnz	short loc_28AB2
	cmp	word ptr [bp+arg_2+2], seg dseg
	jnz	short loc_28AB2
	les	bx, [bp+arg_2]
	mov	ax, offset byte_4F24C
	mov	dx, seg	dseg
	jmp	short loc_28ABB
db 2 dup(90h)
loc_28AB2:
	les	bx, [bp+arg_2]
	mov	ax, offset byte_4F44C
	mov	dx, seg	dseg
loc_28ABB:
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	bx, [bp+var_8]
	mov	word ptr [bx+2], 200h
	mov	byte ptr [bx], 1
	jmp	short loc_28AE4
align 2
loc_28AD8:
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	call	sub_28B9E
	add	sp, 4
loc_28AE4:
	les	bx, [bp+arg_2]
	test	byte ptr es:[bx+0Ah], 8
	jnz	short loc_28B08
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	test	ds:byte_4F73C[bx], 1
	jz	short loc_28B72
loc_28B08:
	mov	bx, word ptr [bp+arg_2]
	mov	si, es:[bx]
	sub	si, es:[bx+6]
	mov	ax, es:[bx+6]
	mov	dx, es:[bx+8]
	inc	ax
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	di, [bp+var_8]
	mov	ax, [di+2]
	dec	ax
	mov	es:[bx+4], ax
	or	si, si
	jle	short loc_28B48
	push	si
	push	dx
	push	word ptr es:[bx+6]
	push	[bp+var_6]
	call	sub_2A45A
	add	sp, 8
	mov	[bp+var_4], ax
	jmp	short loc_28B63
align 2
loc_28B48:
	mov	bx, [bp+var_6]
	test	ds:byte_4EFFC[bx], 20h
	jz	short loc_28B63
	mov	ax, 2
	push	ax
	sub	ax, ax
	push	ax
	push	ax
	push	bx
	call	sub_2A2F6
	add	sp, 8
loc_28B63:
	les	bx, [bp+arg_2]
	les	bx, es:[bx+6]
	mov	al, byte ptr [bp+arg_0]
	mov	es:[bx], al
	jmp	short loc_28B8B
loc_28B72:
	mov	si, 1
	mov	ax, si
	push	ax
	lea	ax, [bp+arg_0]
	push	ss
	push	ax
	push	[bp+var_6]
	call	sub_2A45A
	add	sp, 8
	mov	[bp+var_4], ax
loc_28B8B:
	cmp	[bp+var_4], si
	jz	short loc_28B93
	jmp	loc_28A1A
loc_28B93:
	mov	al, byte ptr [bp+arg_0]
	sub	ah, ah
loc_28B98:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_289E0 endp

; Attributes: bp-based frame
sub_28B9E proc near

	var_4= dword ptr -4
	arg_0= word ptr	 4

	push	bp
	mov	bp, sp
	sub	sp, 4
	mov	ax, [bp+arg_0]
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, offset byte_4F73C
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ds
	mov	ax, 200h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	les	bx, dword ptr [bp+arg_0]
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	or	dx, ax
	jz	short loc_28BEC
	or	byte ptr es:[bx+0Ah], 8
	les	bx, [bp+var_4]
	mov	word ptr es:[bx+2], 200h
	jmp	short loc_28C0C
loc_28BEC:
	les	bx, dword ptr [bp+arg_0]
	or	byte ptr es:[bx+0Ah], 4
	mov	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	inc	ax
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	les	bx, [bp+var_4]
	mov	word ptr es:[bx+2], 1
loc_28C0C:
	les	bx, dword ptr [bp+arg_0]
	mov	ax, es:[bx+6]
	mov	dx, es:[bx+8]
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	word ptr es:[bx+4], 0
	mov	sp, bp
	pop	bp
	retn
sub_28B9E endp

; Attributes: bp-based frame

sub_28C28 proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	sub	sp, 6
	push	si
	inc	word_4F04A
	cmp	word ptr [bp+arg_0], offset byte_4F658
	jnz	short loc_28C4E
	cmp	word ptr [bp+arg_0+2], seg dseg
	jnz	short loc_28C4E
	mov	[bp+var_4], offset byte_4F24C
	mov	[bp+var_2], seg	dseg
	jmp	short loc_28C66
align 2
loc_28C4E:
	cmp	word ptr [bp+arg_0], offset byte_4F664
	jnz	short loc_28C8A
	cmp	word ptr [bp+arg_0+2], seg dseg
	jnz	short loc_28C8A
	mov	[bp+var_4], offset byte_4F44C
	mov	[bp+var_2], seg	dseg
loc_28C66:
	les	bx, [bp+arg_0]
	test	byte ptr es:[bx+0Ah], 0Ch
	jnz	short loc_28C8A
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	test	ds:byte_4F73C[bx],	1
	jz	short loc_28C8E
loc_28C8A:
	sub	ax, ax
	jmp	short loc_28CDD
loc_28C8E:
	mov	ax, word ptr [bp+arg_0]
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, offset byte_4F73C
	mov	[bp+var_6], ax
	les	bx, [bp+arg_0]
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	si, [bp+var_6]
	mov	ax, 200h
	mov	[si+2],	ax
	mov	es:[bx+4], ax
	mov	bx, si
	mov	byte ptr [bx], 1
	mov	bx, word ptr [bp+arg_0]
	or	byte ptr es:[bx+0Ah], 2
	mov	ax, 1
loc_28CDD:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_28C28 endp

; Attributes: bp-based frame

sub_28CE2 proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	sub	sp, 4
	cmp	[bp+arg_0], 0
	jnz	short loc_28CF1
	jmp	loc_28D7A
loc_28CF1:
	cmp	word ptr [bp+arg_2], offset byte_4F658
	jnz	short loc_28CFF
	cmp	word ptr [bp+arg_2+2], seg dseg
	jz	short loc_28D13
loc_28CFF:
	cmp	word ptr [bp+arg_2], offset byte_4F664
	jz	short loc_28D09
	jmp	loc_28DBD
loc_28D09:
	cmp	word ptr [bp+arg_2+2], seg dseg
	jz	short loc_28D13
	jmp	loc_28DBD
loc_28D13:
	les	bx, [bp+arg_2]
	mov	al, es:[bx+0Bh]
	cbw
	push	ax
	call	sub_2A9AC
	add	sp, 2
	or	ax, ax
	jnz	short loc_28D2B
	jmp	loc_28DBD
loc_28D2B:
	mov	ax, word ptr [bp+arg_2]
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, offset byte_4F73C
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ds
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	call	sub_28DC2
	add	sp, 4
	les	bx, [bp+var_4]
	mov	byte ptr es:[bx], 0
	mov	word ptr es:[bx+2], 0
	les	bx, [bp+arg_2]
	sub	ax, ax
	cwd
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	jmp	short loc_28DBD
loc_28D7A:
	les	bx, [bp+arg_2]
	cmp	word ptr es:[bx+6], offset byte_4F24C
	jnz	short loc_28D8D
	cmp	word ptr es:[bx+8], seg	dseg
	jz	short loc_28D9D
loc_28D8D:
	cmp	word ptr es:[bx+6], offset byte_4F44C
	jnz	short loc_28DBD
	cmp	word ptr es:[bx+8], seg	dseg
	jnz	short loc_28DBD
loc_28D9D:
	mov	al, es:[bx+0Bh]
	cbw
	push	ax
	call	sub_2A9AC
	add	sp, 2
	or	ax, ax
	jz	short loc_28DBD
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	call	sub_28DC2
	add	sp, 4
loc_28DBD:
	mov	sp, bp
	pop	bp
	retf
sub_28CE2 endp

align 2
; Attributes: bp-based frame

sub_28DC2 proc far
	var_4= word ptr	-4
	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	sub	sp, 4
	push	si
	sub	si, si
	les	bx, [bp+arg_0]
	mov	al, es:[bx+0Ah]
	and	al, 3
	cmp	al, 2
	jnz	short loc_28E31
	test	byte ptr es:[bx+0Ah], 8
	jnz	short loc_28DF9
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	test	ds:byte_4F73C[bx], 1
	jz	short loc_28E31
loc_28DF9:
	mov	bx, word ptr [bp+arg_0]
	mov	ax, es:[bx]
	sub	ax, es:[bx+6]
	mov	[bp+var_4], ax
	or	ax, ax
	jle	short loc_28E31
	push	ax
	push	word ptr es:[bx+8]
	push	word ptr es:[bx+6]
	mov	al, es:[bx+0Bh]
	cbw
	push	ax
	call	sub_2A45A
	add	sp, 8
	cmp	ax, [bp+var_4]
	jz	short loc_28E31
	les	bx, [bp+arg_0]
	or	byte ptr es:[bx+0Ah], 20h
	mov	si, 0FFFFh
loc_28E31:
	les	bx, [bp+arg_0]
	mov	ax, es:[bx+6]
	mov	dx, es:[bx+8]
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	mov	word ptr es:[bx+4], 0
	mov	ax, si
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_28DC2 endp

; Attributes: bp-based frame

_sscanf proc far

	var_6= byte ptr	-6
	var_4= byte ptr	-4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	di
	push	si
	mov	word_4FD7A, 0
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	mov	word ptr sscanf_structP, ax
	mov	word ptr sscanf_structP+2,	dx
	mov	ax, offset sscanf_buf
	mov	word ptr sscanf_bufp, ax
	mov	word ptr sscanf_bufp+2,	ds
	mov	word_4FE8A, 0
	mov	word_4FE8C, 0
	mov	ax, [bp+arg_8]
	mov	dx, [bp+arg_A]
	mov	word ptr dword_4FD7C, ax
	mov	word ptr dword_4FD7C+2,	dx
loc_28E93:
	les	bx, [bp+arg_4]
	mov	al, es:[bx]
	mov	[bp+var_6], al
	or	al, al
	jnz	short loc_28EA3
	jmp	loc_2927E
loc_28EA3:
	cbw
	mov	bx, ax
	test	sscanf_charFlags[bx],	8
	jz	short loc_28EC4
	push	cs
	call	near ptr _sscanf_skipWhitespace
loc_28EB1:
	inc	word ptr [bp+arg_4]
	les	bx, [bp+arg_4]
	mov	al, es:[bx]
	cbw
	mov	bx, ax
	test	sscanf_charFlags[bx],	8
	jnz	short loc_28EB1
loc_28EC4:
	mov	bx, word ptr [bp+arg_4]
	cmp	byte ptr es:[bx], 25h ;	'%'
	jz	short loc_28ED0
	jmp	loc_29254
loc_28ED0:
	sub	ax, ax
	mov	sscanf_noAssign, ax
	mov	word_4FD84, ax
	mov	sscanf_charListFlag, ax
	mov	word_4FD72, ax
	mov	word_4FD74, ax
	mov	word_4FD6C, ax
	mov	sscanf_argSizeFlag, ax
	mov	sscanf_minWidth, ax
	mov	[bp+var_4], al
	inc	word ptr [bp+arg_4]
	mov	bx, word ptr [bp+arg_4]
	cmp	byte ptr es:[bx], 2Ah ;	'*'
	jnz	short loc_28F00
	inc	sscanf_noAssign
	inc	word ptr [bp+arg_4]
loc_28F00:
	mov	bx, word ptr [bp+arg_4]
	mov	al, es:[bx]
	cbw
	mov	bx, ax
	test	sscanf_charFlags[bx], 4
	jz	short loc_28F50
	mov	di, word ptr [bp+arg_4]
loc_28F13:
	mov	al, es:[di]
	cbw
	mov	cx, sscanf_minWidth
	shl	cx, 1
	shl	cx, 1
	add	cx, sscanf_minWidth
	shl	cx, 1
	add	cx, ax
	sub	cx, 30h	
	mov	sscanf_minWidth, cx
	inc	di
	mov	al, es:[di]
	cbw
	mov	bx, ax
	test	sscanf_charFlags[bx], 4
	jnz	short loc_28F13
	mov	word ptr [bp+arg_4], di
	mov	word ptr [bp+arg_4+2], es
	or	cx, cx
	jz	short loc_28F4C
	inc	word_4FD84
	jmp	short loc_28F50
loc_28F4C:
	inc	word_4FD74
loc_28F50:
	mov	bx, word ptr [bp+arg_4]
	mov	al, es:[bx]
	cbw
	cmp	ax, 46h	
	jz	short loc_28FD0
	cmp	ax, 4Eh	
	jz	short loc_28FC8
	cmp	ax, 68h	
	jz	short loc_28F72
	cmp	ax, 6Ch	
	jz	short loc_28FC0
	cmp	ax, 70h	
	jz	short loc_28FD0
	jmp	short loc_28F78
loc_28F72:
	mov	sscanf_argSizeFlag, 1
loc_28F78:
	cmp	sscanf_argSizeFlag, 0
	jz	short loc_28F88
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 70h ;	'p'
	jnz	short loc_28F91
loc_28F88:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 4Ch ;	'L'
	jnz	short loc_28F94
loc_28F91:
	inc	word ptr [bp+arg_4]
loc_28F94:
	mov	bx, word ptr [bp+arg_4]
	mov	al, es:[bx]
	cbw
	mov	si, ax
	test	sscanf_charFlags[si], 1
	jz	short loc_28FD8
	cmp	si, 45h	
	jz	short loc_28FB9
	cmp	si, 47h	
	jz	short loc_28FB9
	cmp	si, 58h	
	jz	short loc_28FB9
	mov	sscanf_argSizeFlag, 2
loc_28FB9:
	add	si, 20h	
	jmp	loc_29040
align 2
loc_28FC0:
	mov	sscanf_argSizeFlag, 2
	jmp	short loc_28F78
loc_28FC8:
	mov	sscanf_argSizeFlag, 8
	jmp	short loc_28F78
loc_28FD0:
	mov	sscanf_argSizeFlag, 10h
	jmp	short loc_28F78
loc_28FD8:
	cmp	si, 5Bh	
	jnz	short loc_29040
	inc	sscanf_charListFlag
	inc	word ptr [bp+arg_4]
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 5Eh ;	'^'
	jnz	short loc_28FF3
	inc	[bp+var_4]
	inc	word ptr [bp+arg_4]
loc_28FF3:
	mov	ax, 100h
	push	ax
	mov	al, [bp+var_4]
	cbw
	push	ax
	push	word ptr sscanf_bufp+2
	push	word ptr sscanf_bufp
	call	memset
	add	sp, 8
	jmp	short loc_29028
loc_2900E:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 5Dh ;	']'
	jz	short loc_29031
	mov	al, es:[bx]
	cbw
	mov	bx, ax
	les	di, sscanf_bufp
	xor	byte ptr es:[bx+di], 1
	inc	word ptr [bp+arg_4]
loc_29028:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 0
	jnz	short loc_2900E
loc_29031:
	cmp	byte ptr es:[bx], 0
	jz	short loc_2903C
	mov	ax, 73h	
	jmp	short loc_2903E
loc_2903C:
	sub	ax, ax
loc_2903E:
	mov	si, ax
loc_29040:
	cmp	si, 69h	
	jz	short loc_29048
	jmp	loc_290FA
loc_29048:
	mov	word_4F7B8, 1
	push	cs
	call	near ptr _sscanf_skipWhitespace
	inc	word_4FE8C
	les	bx, sscanf_structP
	dec	word ptr es:[bx+4]
	js	short loc_29072
	mov	di, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	al, es:[di]
	sub	ah, ah
	jmp	short loc_2907F
align 2
loc_29072:
	push	word ptr sscanf_structP+2
	push	bx
	call	sub_288E6
	add	sp, 4
loc_2907F:
	mov	si, ax
	cmp	si, 30h	
	jnz	short loc_290E2
	inc	word_4FD72
	inc	word_4FE8C
	les	bx, sscanf_structP
	dec	word ptr es:[bx+4]
	js	short loc_290AA
	mov	di, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	al, es:[di]
	sub	ah, ah
	jmp	short loc_290B7
align 2
loc_290AA:
	push	word ptr sscanf_structP+2
	push	bx
	call	sub_288E6
	add	sp, 4
loc_290B7:
	mov	si, ax
	cmp	si, 78h	
	jz	short loc_290C3
	cmp	si, 58h	
	jnz	short loc_290C8
loc_290C3:
	mov	si, 78h	
	jmp	short loc_290FA
loc_290C8:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
	mov	si, 6Fh	
	jmp	short loc_290FA
loc_290E2:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
	mov	si, 64h	
loc_290FA:
	or	si, si
	jnz	short loc_29101
	jmp	loc_2927E
loc_29101:
	mov	ax, si
	sub	ax, 63h	
	cmp	ax, 15h
	jbe	short loc_2910E
	jmp	_sscanf_parseLiteral
loc_2910E:
	add	ax, ax
	xchg	ax, bx
	jmp	cs:_sscanf_parsers[bx]
_sscanf_parseChar:
	cmp	word_4FD84, 0
	jnz	short loc_29126
	mov	ax, 1
	mov	sscanf_minWidth, ax
	mov	word_4FD84, ax
loc_29126:
	sub	ax, ax
loc_29128:
	push	ax
	push	cs
	call	near ptr sscanf_readString
loc_2912D:
	add	sp, 2
	jmp	loc_29240
align 2
_sscanf_parseString:
	mov	ax, 1
	jmp	short loc_29128
align 2
_sscanf_parseNchars:
	inc	word_4FD6C
_sscanf_parseSignedInt:
	mov	ax, 0Ah
loc_29141:
	push	ax
	push	cs
	call	near ptr sscanf_readNumber
	jmp	short loc_2912D
_sscanf_parseOctal:
	mov	ax, 8
	jmp	short loc_29141
align 2
_sscanf_parsePointer:
	cmp	sscanf_argSizeFlag, 1
	jnz	short loc_29158
	jmp	_sscanf_parseHex
loc_29158:
	cmp	sscanf_argSizeFlag, 8
	jnz	short loc_29162
	jmp	_sscanf_parseHex
loc_29162:
	cmp	sscanf_argSizeFlag, 0
	jnz	short loc_2916C
	jmp	_sscanf_parseHex
loc_2916C:
	mov	ax, 10h
	push	ax
	push	cs
	call	near ptr sscanf_readNumber
	add	sp, 2
	sub	word ptr dword_4FD7C, 4
	les	bx, dword_4FD7C
	les	bx, es:[bx]
	mov	ax, es:[bx]
	mov	dx, es:[bx+2]
	mov	word_4FED0, ax
	mov	word_4FED2, dx
	inc	word_4FE8C
	les	bx, sscanf_structP
	dec	word ptr es:[bx+4]
	js	short loc_291B0
	mov	di, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	al, es:[di]
	sub	ah, ah
	jmp	short loc_291BD
loc_291B0:
	push	word ptr sscanf_structP+2
	push	bx
	call	sub_288E6
	add	sp, 4
loc_291BD:
	mov	si, ax
	cmp	si, 3Ah	
	jnz	short loc_291EC
	inc	word_4FE8A
	mov	ax, 10h
	push	ax
	push	cs
	call	near ptr sscanf_readNumber
	add	sp, 2
	sub	word ptr dword_4FD7C, 4
	les	bx, dword_4FD7C
	les	bx, es:[bx]
	mov	dx, word_4FED0
	sub	ax, ax
	or	es:[bx+2], dx
	jmp	short loc_29201
align 2
loc_291EC:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
loc_29201:
	add	word ptr dword_4FD7C, 4
	jmp	short loc_29240
_sscanf_parseHex:
	mov	ax, 10h
	jmp	loc_29141
_sscanf_parseFloat:
	push	cs
	call	near ptr sscanf_readFloat
	jmp	short loc_29240
_sscanf_parsers dw offset _sscanf_parseChar
dw offset _sscanf_parseSignedInt
dw offset _sscanf_parseFloat
dw offset _sscanf_parseFloat
dw offset _sscanf_parseFloat
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseNchars
dw offset _sscanf_parseOctal
dw offset _sscanf_parsePointer
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseString
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseSignedInt
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseLiteral
dw offset _sscanf_parseHex
loc_29240:
	cmp	word_4FD7A, 0
	jz	short loc_29284
	cmp	word_4FE8A, 0
	jnz	short loc_2927E
loc_2924E:
	mov	ax, 0FFFFh
	jmp	short loc_2928A
align 2
loc_29254:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 0
	jz	short loc_2927E
_sscanf_parseLiteral:
	les	bx, [bp+arg_4]
	mov	al, es:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr sscanf_readLiteral
	add	sp, 2
	mov	si, ax
	or	si, si
	jz	short loc_29284
	cmp	si, 1
	jz	short loc_2927E
	cmp	word_4FE8A, 0
	jz	short loc_2924E
loc_2927E:
	mov	ax, word_4FE8A
	jmp	short loc_2928A
align 2
loc_29284:
	inc	word ptr [bp+arg_4]
	jmp	loc_28E93
loc_2928A:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
_sscanf endp

; Attributes: bp-based frame

sscanf_readString proc far

	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_4= dword ptr -4
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 0Ah
	push	di
	push	si
	les	bx, dword_4FD7C
	mov	ax, es:[bx]
	mov	dx, es:[bx+2]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	[bp+var_A], ax
	mov	[bp+var_8], dx
	cmp	sscanf_noAssign, 0
	jnz	short loc_292BB
	add	word ptr dword_4FD7C, 4
loc_292BB:
	cmp	word_4FD74, 0
	jz	short loc_292C5
	jmp	loc_293A8
loc_292C5:
	cmp	[bp+arg_0], 0
	jz	short loc_292D6
	cmp	sscanf_charListFlag, 0
	jnz	short loc_292D6
	push	cs
	call	near ptr _sscanf_skipWhitespace
loc_292D6:
	mov	di, [bp+arg_0]
	jmp	short loc_29301
align 2
loc_292DC:
	mov	al, sscanf_charFlags[si]
	and	al, 8
	mov	cx, ax
	cmp	cl, 1
	sbb	ax, ax
	neg	ax
loc_292EB:
	or	ax, ax
	jz	short loc_29328
loc_292EF:
	cmp	sscanf_noAssign, 0
	jnz	short loc_29301
	les	bx, [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	inc	word ptr [bp+var_4]
loc_29301:
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_29328
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	inc	ax
	jz	short loc_29328
	or	di, di
	jz	short loc_292EF
	cmp	sscanf_charListFlag, 0
	jz	short loc_292DC
	les	bx, sscanf_bufp
	mov	al, es:[bx+si]
	cbw
	jmp	short loc_292EB
align 2
loc_29328:
	cmp	si, 0FFFFh
	jnz	short loc_29334
	inc	word_4FD7A
	jmp	short loc_29380
align 2
loc_29334:
	cmp	[bp+arg_0], 0
	jz	short loc_29380
	cmp	word_4FD84, 0
	jz	short loc_2936B
	cmp	sscanf_minWidth, 0
	jnz	short loc_2936B
	cmp	sscanf_charListFlag, 0
	jz	short loc_2935E
	les	bx, sscanf_bufp
	cmp	byte ptr es:[bx+si], 1
	sbb	ax, ax
	neg	ax
	jmp	short loc_29367
align 2
loc_2935E:
	mov	al, sscanf_charFlags[si]
	sub	ah, ah
	and	ax, 8
loc_29367:
	or	ax, ax
	jz	short loc_29380
loc_2936B:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
loc_29380:
	cmp	sscanf_noAssign, 0
	jnz	short loc_293A8
	cmp	[bp+arg_0], 0
	jz	short loc_29394
	les	bx, [bp+var_4]
	mov	byte ptr es:[bx], 0
loc_29394:
	mov	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	cmp	[bp+var_A], ax
	jnz	short loc_293A4
	cmp	[bp+var_8], dx
	jz	short loc_293A8
loc_293A4:
	inc	word_4FE8A
loc_293A8:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sscanf_readString endp

; Attributes: bp-based frame

sscanf_readNumber proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 8
	push	di
	push	si
	mov	si, [bp+arg_0]
	sub	ax, ax
	mov	[bp+var_2], ax
	cwd
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
	cmp	word_4FD6C, ax
	jz	short loc_293CE
	jmp	loc_294EE
loc_293CE:
	cmp	word_4FD74, ax
	jz	short loc_293E0
	cmp	sscanf_noAssign, ax
	jz	short loc_293DD
	jmp	loc_2954F
loc_293DD:
	jmp	loc_2954A
loc_293E0:
	cmp	word_4F7B8, 0
	jnz	short loc_293EB
	push	cs
	call	near ptr _sscanf_skipWhitespace
loc_293EB:
	push	cs
	call	near ptr sscanf_getc
	mov	di, ax
	cmp	di, 2Dh	
	jz	short loc_293FE
	cmp	di, 2Bh	
	jz	short loc_293FE
	jmp	loc_294A5
loc_293FE:
	cmp	di, 2Dh	
	jnz	short loc_29406
	inc	[bp+var_2]
loc_29406:
	dec	sscanf_minWidth
	jmp	loc_2949F
align 2
loc_2940E:
	mov	ax, 30h	
loc_29411:
	sub	di, ax
	jmp	short loc_29492
align 2
loc_29416:
	cmp	si, 8
	jnz	short loc_29468
	cmp	di, 38h	
	jge	short loc_2942E
	mov	al, 3
	push	ax
	lea	ax, [bp+var_6]
	push	ax
	call	sub_2ACF6
	jmp	short loc_2948F
loc_2942E:
	cmp	di, 0FFFFh
	jz	short loc_29448
	dec	word_4FE8C
	push	word ptr ds:sscanf_structP+2
	push	word ptr ds:sscanf_structP
	push	di
	call	sscanf_segAdjust
	add	sp, 6
loc_29448:
	cmp	[bp+var_2], 0
	jnz	short loc_29451
	jmp	loc_294F9
loc_29451:
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	neg	ax
	adc	dx, 0
	neg	dx
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
	jmp	loc_294F9
align 2
loc_29468:
	test	ds:sscanf_charFlags[di], 4
	jz	short loc_2942E
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	cl, 2
loc_29477:
	shl	ax, 1
	rcl	dx, 1
	dec	cl
	jnz	short loc_29477
	add	ax, [bp+var_6]
	adc	dx, [bp+var_4]
	shl	ax, 1
	rcl	dx, 1
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
loc_2948F:
	sub	di, 30h	
loc_29492:
	mov	ax, di
	cwd
	add	[bp+var_6], ax
	adc	[bp+var_4], dx
	inc	word_4FD72
loc_2949F:
	push	cs
	call	near ptr sscanf_getc
	mov	di, ax
loc_294A5:
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_2942E
	cmp	di, 0FFFFh
	jnz	short loc_294B5
	jmp	loc_2942E
loc_294B5:
	test	ds:sscanf_charFlags[di], 80h
	jnz	short loc_294BF
	jmp	loc_2942E
loc_294BF:
	cmp	si, 10h
	jz	short loc_294C7
	jmp	loc_29416
loc_294C7:
	mov	al, 4
	push	ax
	lea	ax, [bp+var_6]
	push	ax
	call	sub_2ACF6
	test	sscanf_charFlags[di], 1
	jz	short loc_294DD
	add	di, 20h	
loc_294DD:
	test	sscanf_charFlags[di], 2
	jnz	short loc_294E7
	jmp	loc_2940E
loc_294E7:
	mov	ax, 57h	
	jmp	loc_29411
align 2
loc_294EE:
	mov	ax, word_4FE8C
	mov	[bp+var_6], ax
	mov	[bp+var_4], 0
loc_294F9:
	cmp	sscanf_noAssign, 0
	jnz	short loc_2954F
	cmp	word_4FD72, 0
	jnz	short loc_2950E
	cmp	word_4FD6C, 0
	jz	short loc_2954A
loc_2950E:
	cmp	sscanf_argSizeFlag, 2
	jz	short loc_2951C
	cmp	sscanf_argSizeFlag, 10h
	jnz	short loc_29532
loc_2951C:
	les	bx, dword_4FD7C
	les	bx, es:[bx]
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	jmp	short loc_2953F
loc_29532:
	les	bx, dword_4FD7C
	les	bx, es:[bx]
	mov	ax, [bp+var_6]
	mov	es:[bx], ax
loc_2953F:
	cmp	word_4FD6C, 0
	jnz	short loc_2954A
	inc	word_4FE8A
loc_2954A:
	add	word ptr dword_4FD7C, 4
loc_2954F:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sscanf_readNumber endp

align 2
; Attributes: bp-based frame

sscanf_readFloat proc far

	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_6= word ptr	-6
	var_4= dword ptr -4

	push	bp
	mov	bp, sp
	sub	sp, 0Ch
	push	di
	push	si
	mov	[bp+var_6], 0
	cmp	word_4FD74, 0
	jz	short loc_29578
	cmp	sscanf_noAssign, 0
	jz	short loc_29574
	jmp	loc_2971E
loc_29574:
	jmp	loc_29719
align 2
loc_29578:
	push	cs
	call	near ptr _sscanf_skipWhitespace
	mov	ax, offset _sscanf_floatBuf
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ds
	mov	dx, ds
	add	ax, 40h	
	mov	[bp+var_C], ax
	mov	[bp+var_A], dx
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	cmp	si, 2Bh	
	jz	short loc_295A0
	cmp	si, 2Dh	
	jnz	short loc_295BA
loc_295A0:
	cmp	si, 2Dh	
	jnz	short loc_295B0
	les	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
loc_295B0:
	dec	sscanf_minWidth
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
loc_295BA:
	mov	di, [bp+var_6]
	jmp	short loc_295DD
align 2
loc_295C0:
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_295E9
	inc	di
	les	bx, [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	inc	word ptr [bp+var_4]
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
loc_295DD:
	push	si
	push	cs
	call	near ptr sub_29724
	add	sp, 2
	or	ax, ax
	jnz	short loc_295C0
loc_295E9:
	mov	[bp+var_6], di
	cmp	si, 2Eh	
	jnz	short loc_2963E
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_2963E
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_2963E
	les	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	jmp	short loc_29629
align 2
loc_29612:
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_2963B
	inc	di
	les	bx, [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	inc	word ptr [bp+var_4]
loc_29629:
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	push	si
	push	cs
	call	near ptr sub_29724
	add	sp, 2
	or	ax, ax
	jnz	short loc_29612
loc_2963B:
	mov	[bp+var_6], di
loc_2963E:
	cmp	[bp+var_6], 0
	jnz	short loc_29647
	jmp	loc_296CC
loc_29647:
	cmp	si, 65h	
	jz	short loc_29651
	cmp	si, 45h	
	jnz	short loc_296CC
loc_29651:
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_296CC
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_296CC
	les	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	cmp	si, 2Dh	
	jz	short loc_2967F
	cmp	si, 2Bh	
	jnz	short loc_296C0
loc_2967F:
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_296C0
	cmp	si, 2Dh	
	jnz	short loc_296BA
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_296BA
	les	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	jmp	short loc_296BA
loc_296A4:
	mov	ax, [bp+var_C]
	mov	dx, [bp+var_A]
	cmp	word ptr [bp+var_4], ax
	jnb	short loc_296CC
	les	bx, [bp+var_4]
	mov	ax, si
	mov	es:[bx], al
	inc	word ptr [bp+var_4]
loc_296BA:
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
loc_296C0:
	push	si
	push	cs
	call	near ptr sub_29724
	add	sp, 2
	or	ax, ax
	jnz	short loc_296A4
loc_296CC:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
	cmp	sscanf_noAssign, 0
	jnz	short loc_2971E
	cmp	[bp+var_6], 0
	jz	short loc_29719
	les	bx, [bp+var_4]
	mov	byte ptr es:[bx], 0
	mov	ax, offset _sscanf_floatBuf
	push	ds
	push	ax
	push	word ptr dword_4FD7C+2
	push	word ptr dword_4FD7C
	mov	ax, sscanf_argSizeFlag
	and	ax, 2
	push	ax
	call	off_4F7EC
	add	sp, 0Ah
	inc	word_4FE8A
loc_29719:
	add	word ptr dword_4FD7C, 4
loc_2971E:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sscanf_readFloat endp

; Attributes: bp-based frame

sub_29724 proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	cmp	[bp+arg_0], 0FFFFh
	jz	short loc_29744
	mov	bx, [bp+arg_0]
	test	sscanf_charFlags[bx], 4
	jz	short loc_29744
	push	cs
	call	near ptr sub_297F0
	or	ax, ax
	jz	short loc_29744
	mov	ax, 1
	jmp	short loc_29746
loc_29744:
	sub	ax, ax
loc_29746:
	pop	bp
	retf
sub_29724 endp

; Attributes: bp-based frame

sscanf_readLiteral proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 2
	push	si
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	cmp	si, [bp+arg_0]
	jnz	short loc_2975E
	sub	ax, ax
	jmp	short loc_29780
loc_2975E:
	cmp	si, 0FFFFh
	jnz	short loc_29768
	mov	ax, 0FFFFh
	jmp	short loc_29780
loc_29768:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
	mov	ax, 1
loc_29780:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sscanf_readLiteral endp

align 2

sscanf_getc proc far
	push	si
	inc	word_4FE8C
	les	bx, sscanf_structP
	assume es:nothing
	dec	word ptr es:[bx+4]
	js	short loc_297A6
	mov	si, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	al, es:[si]
	sub	ah, ah
	jmp	short loc_297B3
loc_297A6:
	push	word ptr sscanf_structP+2
	push	bx
	call	sub_288E6
	add	sp, 4
loc_297B3:
	pop	si
	retf
sscanf_getc endp

align 2
; Attributes: bp-based frame

_sscanf_skipWhitespace proc far
	push	bp
	mov	bp, sp
	sub	sp, 2
	push	si
loc_297BD:
	push	cs
	call	near ptr sscanf_getc
	mov	si, ax
	test	sscanf_charFlags[si], 8
	jnz	short loc_297BD
	cmp	si, 0FFFFh
	jnz	short loc_297D6
	inc	word_4FD7A
	jmp	short loc_297EB
align 2
loc_297D6:
	dec	word_4FE8C
	push	word ptr sscanf_structP+2
	push	word ptr sscanf_structP
	push	si
	call	sscanf_segAdjust
	add	sp, 6
loc_297EB:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sscanf_skipWhitespace endp


sub_297F0 proc far
	cmp	word_4FD84, 0
	jnz	short loc_297FC
loc_297F7:
	mov	ax, 1
	jmp	short locret_2980C
loc_297FC:
	cmp	sscanf_minWidth, 0
	jle	short loc_2980A
	dec	sscanf_minWidth
	jmp	short loc_297F7
align 2
loc_2980A:
	sub	ax, ax
locret_2980C:
	retf
sub_297F0 endp

align 2
; Attributes: bp-based frame

printf_doPrint proc far

	var_A= byte ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	mov	ax, offset byte_4FF08
	mov	word_4FF02, ax
	mov	word_4FF04, ds
	mov	ax, [bp+arg_8]
	mov	dx, [bp+arg_A]
	mov	word ptr dword_4FEF0, ax
	mov	word ptr dword_4FEF0+2,	dx
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	mov	word ptr dword_4FED6, ax
	mov	word ptr dword_4FED6+2,	dx
	mov	word_4FEFC, 0
	mov	word_4FEFA, 0
	jmp	loc_29B8D
loc_2984C:
	cmp	[bp+var_A], 25h	
	jz	short loc_29855
	jmp	loc_29AFC
loc_29855:
	mov	word_4FEFE, 1
	sub	ax, ax
	mov	word_4FEE0, ax
	mov	word_4FEDC, ax
	mov	word_4FEF8, ax
	mov	word_4FEDE, ax
	mov	word_4FEF6, ax
	mov	word_4FEF4, ax
	mov	word_4FEDA, ax
	mov	word_4FED4, ax
	mov	word_4FEEE, ax
	mov	word_50068, 20h	
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx+1], 30h	
	jnz	short loc_298D1
	inc	word ptr [bp+arg_4]
	mov	word_50068, 30h	
	jmp	short loc_298D1
align 2
loc_29894:
	mov	bx, word ptr [bp+arg_4]
	cmp	byte ptr es:[bx], 2Bh ;	'+'
	jnz	short loc_298AA
	inc	word_4FEE0
	mov	word_4FEF4, 0
	jmp	short loc_298D1
align 2
loc_298AA:
	cmp	byte ptr es:[bx], 20h ;	' '
	jnz	short loc_298BE
	cmp	word_4FEE0, 0
	jnz	short loc_298D1
	inc	word_4FEF4
	jmp	short loc_298D1
align 2
loc_298BE:
	inc	word_4FED4
	jmp	short loc_298D1
loc_298C4:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 2Dh ;	'-'
	jnz	short loc_29894
	inc	word_4FEEE
loc_298D1:
	inc	word ptr [bp+arg_4]
	mov	bx, word ptr [bp+arg_4]
	mov	al, es:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr sub_2A22A
	add	sp, 2
	or	ax, ax
	jnz	short loc_298C4
	push	word ptr [bp+arg_4+2]
	push	word ptr [bp+arg_4]
	mov	ax, offset word_4FF06
	push	ds
	push	ax
	push	cs
	call	near ptr sub_2A188
	add	sp, 8
	mov	word ptr [bp+arg_4], ax
	mov	word ptr [bp+arg_4+2], dx
	cmp	word_4FF06, 0
	jge	short loc_29912
	inc	word_4FEEE
	mov	ax, word_4FF06
	neg	ax
	mov	word_4FF06, ax
loc_29912:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 2Eh ;	'.'
	jnz	short loc_29949
	inc	word_4FEF6
	inc	word ptr [bp+arg_4]
	push	es
	push	word ptr [bp+arg_4]
	mov	ax, word_4FEFE
	push	ds
	push	ax
	push	cs
	call	near ptr sub_2A188
	add	sp, 8
	mov	word ptr [bp+arg_4], ax
	mov	word ptr [bp+arg_4+2], dx
	cmp	word_4FEFE, 0
	jge	short loc_29949
	mov	word_4FEFE, 1
	dec	word_4FEF6
loc_29949:
	les	bx, [bp+arg_4]
	mov	al, es:[bx]
	cbw
	cmp	ax, 46h	
	jz	short loc_29992
	cmp	ax, 4Eh	
	jz	short loc_2999A
	cmp	ax, 68h	
	jz	short loc_2998A
	cmp	ax, 6Ch	
	jnz	short loc_2996A
	mov	word_4FEDE, 2
loc_2996A:
	cmp	word_4FEDE, 0
	jnz	short loc_2997A
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 4Ch ;	'L'
	jnz	short loc_2997D
loc_2997A:
	inc	word ptr [bp+arg_4]
loc_2997D:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 0
	jnz	short loc_299A2
	jmp	loc_29B9D
align 2
loc_2998A:
	mov	word_4FEDE, 1
	jmp	short loc_2996A
loc_29992:
	mov	word_4FEDE, 10h
	jmp	short loc_2996A
loc_2999A:
	mov	word_4FEDE, 8
	jmp	short loc_2996A
loc_299A2:
	mov	al, es:[bx]
	cbw
	mov	[bp+var_8], ax
	cmp	ax, 45h	
	jz	short loc_299B8
	cmp	ax, 47h	
	jz	short loc_299B8
	cmp	ax, 58h	
	jnz	short loc_299C0
loc_299B8:
	inc	word_4FEDC
	add	[bp+var_8], 20h	
loc_299C0:
	mov	ax, [bp+var_8]
	sub	ax, 63h	
	cmp	ax, 15h
	jbe	short loc_299CE
	jmp	loc_29AEC
loc_299CE:
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_29B0C[bx]
loc_299D6:
	les	bx, dword_4FEF0
	les	bx, es:[bx]
	mov	ax, word_4FEFA
	mov	es:[bx], ax
	add	word ptr dword_4FEF0, 4
	jmp	loc_29B38
align 2
loc_299EC:
	inc	word_4FEF8
loc_299F0:
	mov	word_4FED4, 0
	mov	ax, 0Ah
loc_299F9:
	push	ax
	push	cs
	call	near ptr sub_29BBC
loc_299FE:
	add	sp, 2
	jmp	loc_29B38
loc_29A04:
	mov	ax, 8
	jmp	short loc_299F9
align 2
loc_29A0A:
	inc	word_4FEDA
	inc	word_4FEDC
	cmp	word_4FEF6, 0
	jnz	short loc_29A22
	mov	word_4FF00, 1
	jmp	short loc_29A28
align 2
loc_29A22:
	mov	word_4FF00, 0
loc_29A28:
	inc	word_4FEF6
	mov	word_4FEFE, 4
	cmp	word_4FEDE, 8
	jnz	short loc_29A3C
	jmp	loc_29ACC
loc_29A3C:
	sub	ax, ax
	mov	word_4FEDE, ax
	mov	[bp+var_6], ax
	cmp	word_4FF06, ax
	jz	short loc_29A71
	mov	ax, word_4FF06
	mov	[bp+var_6], ax
	cmp	word_4FEEE, 0
	jz	short loc_29A60
	mov	word_4FF06, 0
	jmp	short loc_29A71
align 2
loc_29A60:
	sub	word_4FF06, 5
	mov	ax, word_4FF06
	or	ax, ax
	jge	short loc_29A6E
	sub	ax, ax
loc_29A6E:
	mov	word_4FF06, ax
loc_29A71:
	add	word ptr dword_4FEF0, 2
	mov	ax, 10h
	push	ax
	push	cs
	call	near ptr sub_29BBC
	add	sp, 2
	mov	ax, 3Ah	
	push	ax
	push	cs
	call	near ptr sub_29F12
	add	sp, 2
	cmp	[bp+var_6], 0
	jz	short loc_29AB4
	cmp	word_4FEEE, 0
	jz	short loc_29AAE
	mov	ax, [bp+var_6]
	sub	ax, 5
	mov	word_4FF06, ax
	or	ax, ax
	jge	short loc_29AA8
	sub	ax, ax
loc_29AA8:
	mov	word_4FF06, ax
	jmp	short loc_29AB4
align 2
loc_29AAE:
	mov	word_4FF06, 0
loc_29AB4:
	sub	word ptr dword_4FEF0, 4
	mov	ax, 10h
	push	ax
	push	cs
	call	near ptr sub_29BBC
	add	sp, 2
	add	word ptr dword_4FEF0, 2
	jmp	short loc_29B38
align 2
loc_29ACC:
	mov	ax, 10h
	jmp	loc_299F9
loc_29AD2:
	sub	ax, ax
loc_29AD4:
	push	ax
	push	cs
	call	near ptr sub_29D32
	jmp	loc_299FE
loc_29ADC:
	mov	ax, 1
	jmp	short loc_29AD4
align 2
loc_29AE2:
	push	[bp+var_8]
	push	cs
	call	near ptr sub_29E26
	jmp	loc_299FE
loc_29AEC:
	cmp	word_4FEDE, 0
	jz	short loc_29AFC
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	dec	word ptr [bp+arg_4]
loc_29AFC:
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	inc	ax
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	jmp	short loc_29B5D
align 2
off_29B0C dw offset loc_29ADC
dw offset loc_299F0
dw offset loc_29AE2
dw offset loc_29AE2
dw offset loc_29AE2
dw offset loc_29AEC
dw offset loc_299F0
dw offset loc_29AEC
dw offset loc_29AEC
dw offset loc_29AEC
dw offset loc_29AEC
dw offset loc_299D6
dw offset loc_29A04
dw offset loc_29A0A
dw offset loc_29AEC
dw offset loc_29AEC
dw offset loc_29AD2
dw offset loc_29AEC
dw offset loc_299EC
dw offset loc_29AEC
dw offset loc_29AEC
dw offset loc_29ACC
loc_29B38:
	cmp	word_4FEFC, 0
	jz	short loc_29B54
	cmp	word_4FEFA, 0
	jnz	short loc_29BB4
	les	bx, dword_4FED6
	test	byte ptr es:[bx+0Ah], 20h
	jnz	short loc_29BAF
	jmp	short loc_29BB4
align 2
loc_29B54:
	inc	word ptr [bp+arg_4]
	jmp	short loc_29B8D
align 2
loc_29B5A:
	inc	word ptr [bp+var_4]
loc_29B5D:
	les	bx, [bp+var_4]
	mov	al, es:[bx]
	mov	[bp+var_A], al
	or	al, al
	jz	short loc_29B6E
	cmp	al, 25h	
	jnz	short loc_29B5A
loc_29B6E:
	mov	ax, bx
	sub	ax, word ptr [bp+arg_4]
	push	ax
	push	word ptr [bp+arg_4+2]
	push	word ptr [bp+arg_4]
	push	cs
	call	near ptr sub_29FCA
	add	sp, 6
	mov	ax, word ptr [bp+var_4]
	mov	dx, word ptr [bp+var_4+2]
	mov	word ptr [bp+arg_4], ax
	mov	word ptr [bp+arg_4+2], dx
loc_29B8D:
	les	bx, [bp+arg_4]
	mov	al, es:[bx]
	mov	[bp+var_A], al
	or	al, al
	jz	short loc_29B9D
	jmp	loc_2984C
loc_29B9D:
	cmp	word_4FEFA, 0
	jnz	short loc_29BB4
	les	bx, dword_4FED6
	test	byte ptr es:[bx+0Ah], 20h
	jz	short loc_29BB4
loc_29BAF:
	mov	ax, 0FFFFh
	jmp	short loc_29BB7
loc_29BB4:
	mov	ax, word_4FEFA
loc_29BB7:
	mov	sp, bp
	pop	bp
	retf
printf_doPrint endp

align 2
; Attributes: bp-based frame

sub_29BBC proc far

	var_12=	word ptr -12h
	var_10=	word ptr -10h
	var_E= dword ptr -0Eh
	var_A= word ptr	-0Ah
	var_8= dword ptr -8
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 12h
	push	di
	push	si
	cmp	[bp+arg_0], 0Ah
	jz	short loc_29BCE
	inc	word_4FEF8
loc_29BCE:
	cmp	word_4FEDE, 2
	jz	short loc_29BDC
	cmp	word_4FEDE, 10h
	jnz	short loc_29BF4
loc_29BDC:
	les	bx, dword_4FEF0
	mov	ax, es:[bx]
	mov	dx, es:[bx+2]
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	add	word ptr dword_4FEF0, 4
	jmp	short loc_29C1F
loc_29BF4:
	cmp	word_4FEF8, 0
	jz	short loc_29C0C
	les	bx, dword_4FEF0
	mov	ax, es:[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_2], 0
	jmp	short loc_29C1A
loc_29C0C:
	les	bx, dword_4FEF0
	mov	ax, es:[bx]
	cwd
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_29C1A:
	add	word ptr dword_4FEF0, 2
loc_29C1F:
	cmp	word_4FED4, 0
	jz	short loc_29C34
	mov	ax, [bp+var_4]
	or	ax, [bp+var_2]
	jz	short loc_29C34
	mov	ax, [bp+arg_0]
	jmp	short loc_29C36
align 2
loc_29C34:
	sub	ax, ax
loc_29C36:
	mov	word_50066, ax
	mov	ax, word_4FF02
	mov	dx, word_4FF04
	mov	word ptr [bp+var_E], ax
	mov	word ptr [bp+var_E+2], dx
	cmp	word_4FEF8, 0
	jnz	short loc_29C7E
	cmp	[bp+var_2], 0
	jge	short loc_29C7E
	cmp	[bp+arg_0], 0Ah
	jnz	short loc_29C76
	les	bx, [bp+var_E]
	inc	word ptr [bp+var_E]
	mov	byte ptr es:[bx], 2Dh ;	'-'
	mov	ax, [bp+var_4]
	mov	dx, [bp+var_2]
	neg	ax
	adc	dx, 0
	neg	dx
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
loc_29C76:
	mov	[bp+var_A], 1
	jmp	short loc_29C83
align 2
loc_29C7E:
	mov	[bp+var_A], 0
loc_29C83:
	mov	ax, offset byte_4FEE2
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], ds
	push	[bp+arg_0]
	push	ds
	push	ax
	push	[bp+var_2]
	push	[bp+var_4]
	call	sub_2A98A
	add	sp, 0Ah
	cmp	word_4FEF6, 0
	jz	short loc_29CD7
	push	word ptr [bp+var_8+2]
	push	word ptr [bp+var_8]
	call	_strlen
	add	sp, 4
	mov	cx, word_4FEFE
	sub	cx, ax
	mov	[bp+var_10], cx
	les	di, [bp+var_E]
	jmp	short loc_29CC7
loc_29CC2:
	mov	byte ptr es:[di], 30h ;	'0'
	inc	di
loc_29CC7:
	mov	ax, cx
	dec	cx
	or	ax, ax
	jg	short loc_29CC2
	mov	word ptr [bp+var_E], di
	mov	word ptr [bp+var_E+2], es
	mov	[bp+var_10], cx
loc_29CD7:
	mov	cx, word_4FEDC
	mov	[bp+var_12], ds
	lds	si, [bp+var_E]
loc_29CE1:
	les	bx, [bp+var_8]
	mov	al, es:[bx]
	mov	[si], al
	or	cx, cx
	jz	short loc_29CF4
	cmp	al, 61h	
	jl	short loc_29CF4
	sub	byte ptr [si], 20h 
loc_29CF4:
	inc	si
	inc	word ptr [bp+var_8]
	cmp	byte ptr es:[bx], 0
	jnz	short loc_29CE1
	mov	word ptr [bp+var_E], si
	mov	word ptr [bp+var_E+2], ds
	mov	ds, [bp+var_12]
	cmp	word_4FEF8, 0
	jnz	short loc_29D22
	mov	ax, word_4FEE0
	or	ax, word_4FEF4
	jz	short loc_29D22
	cmp	[bp+var_A], 0
	jnz	short loc_29D22
	mov	ax, 1
	jmp	short loc_29D24
loc_29D22:
	sub	ax, ax
loc_29D24:
	push	ax
	push	cs
	call	near ptr sub_2A040
	add	sp, 2
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_29BBC endp

; Attributes: bp-based frame

sub_29D32 proc far

	var_E= dword ptr -0Eh
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 10h
	push	di
	push	si
	cmp	[bp+arg_0], 0
	jz	short loc_29D58
	mov	si, 1
	mov	ax, word ptr dword_4FEF0
	mov	dx, word ptr dword_4FEF0+2
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	add	word ptr dword_4FEF0, 2
	jmp	loc_29DED
loc_29D58:
	cmp	word_4FEDE, 8
	jz	short loc_29D78
	les	bx, dword_4FEF0
	mov	ax, es:[bx]
	mov	dx, es:[bx+2]
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	add	word ptr dword_4FEF0, 4
	jmp	short loc_29D8D
align 2
loc_29D78:
	les	bx, dword_4FEF0
	mov	ax, es:[bx]
	mov	[bp+var_4], ax
	mov	[bp+var_8], ax
	mov	[bp+var_6], ds
	add	word ptr dword_4FEF0, 2
loc_29D8D:
	cmp	word_4FEDE, 8
	jz	short loc_29DA2
	mov	ax, [bp+var_8]
	or	ax, [bp+var_6]
	jnz	short loc_29DB1
	mov	ax, offset aNull
	jmp	short loc_29DAB
align 2
loc_29DA2:
	cmp	[bp+var_4], 0
	jnz	short loc_29DB1
	mov	ax, offset aNull_0
loc_29DAB:
	mov	[bp+var_8], ax
	mov	[bp+var_6], ds
loc_29DB1:
	mov	ax, [bp+var_8]
	mov	dx, [bp+var_6]
	mov	word ptr [bp+var_E], ax
	mov	word ptr [bp+var_E+2], dx
	sub	si, si
	cmp	word_4FEF6, si
	jz	short loc_29DE1
	mov	cx, word_4FEFE
	jmp	short loc_29DD9
align 2
loc_29DCC:
	les	bx, [bp+var_E]
	inc	word ptr [bp+var_E]
	cmp	byte ptr es:[bx], 0
	jz	short loc_29DED
	inc	si
loc_29DD9:
	cmp	cx, si
	jle	short loc_29DED
	jmp	short loc_29DCC
align 2
loc_29DE0:
	inc	si
loc_29DE1:
	les	bx, [bp+var_E]
	inc	word ptr [bp+var_E]
	cmp	byte ptr es:[bx], 0
	jnz	short loc_29DE0
loc_29DED:
	mov	di, word_4FF06
	sub	di, si
	cmp	word_4FEEE, 0
	jnz	short loc_29E02
	push	di
	push	cs
	call	near ptr sub_29F5E
	add	sp, 2
loc_29E02:
	push	si
	push	[bp+var_6]
	push	[bp+var_8]
	push	cs
	call	near ptr sub_29FCA
	add	sp, 6
	cmp	word_4FEEE, 0
	jz	short loc_29E1F
	push	di
	push	cs
	call	near ptr sub_29F5E
	add	sp, 2
loc_29E1F:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_29D32 endp

align 2
; Attributes: bp-based frame

sub_29E26 proc far

	var_6= byte ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 6
	mov	ax, word ptr dword_4FEF0
	mov	dx, word ptr dword_4FEF0+2
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	cmp	[bp+arg_0], 67h	
	jz	short loc_29E45
	cmp	[bp+arg_0], 47h	
	jnz	short loc_29E4A
loc_29E45:
	mov	al, 1
	jmp	short loc_29E4C
align 2
loc_29E4A:
	sub	al, al
loc_29E4C:
	mov	[bp+var_6], al
	cmp	word_4FEF6, 0
	jnz	short loc_29E5C
	mov	word_4FEFE, 6
loc_29E5C:
	cmp	[bp+var_6], 0
	jz	short loc_29E6F
	cmp	word_4FEFE, 0
	jnz	short loc_29E6F
	mov	word_4FEFE, 1
loc_29E6F:
	push	word_4FEDC
	push	word_4FEFE
	push	[bp+arg_0]
	push	word_4FF04
	push	word_4FF02
	push	[bp+var_2]
	push	[bp+var_4]
	call	off_4F7E4
	add	sp, 0Eh
	cmp	[bp+var_6], 0
	jz	short loc_29EB5
	cmp	word_4FED4, 0
	jnz	short loc_29EB5
	push	word_4FF04
	push	word_4FF02
	call	off_4F7E8
	add	sp, 4
loc_29EB5:
	cmp	word_4FED4, 0
	jz	short loc_29ED7
	cmp	word_4FEFE, 0
	jnz	short loc_29ED7
	push	word_4FF04
	push	word_4FF02
	call	off_4F7F0
	add	sp, 4
loc_29ED7:
	add	word ptr dword_4FEF0, 8
	mov	word_50066, 0
	mov	ax, word_4FEE0
	or	ax, word_4FEF4
	jz	short loc_29F06
	push	[bp+var_2]
	push	[bp+var_4]
	call	off_4F7F4
	add	sp, 4
	or	ax, ax
	jz	short loc_29F06
	mov	ax, 1
	jmp	short loc_29F08
loc_29F06:
	sub	ax, ax
loc_29F08:
	push	ax
	push	cs
	call	near ptr sub_2A040
	mov	sp, bp
	pop	bp
	retf
sub_29E26 endp

align 2
; Attributes: bp-based frame

sub_29F12 proc far

	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	push	si
	cmp	word_4FEFC, 0
	jnz	short loc_29F5A
	les	bx, dword_4FED6
	assume es:nothing
	dec	word ptr es:[bx+4]
	js	short loc_29F3C
	mov	al, [bp+arg_0]
	mov	si, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	es:[si], al
	sub	ah, ah
	jmp	short loc_29F4C
align 2
loc_29F3C:
	push	word ptr dword_4FED6+2
	push	bx
	push	word ptr [bp+arg_0]
	call	sub_289E0
	add	sp, 6
loc_29F4C:
	inc	ax
	jnz	short loc_29F56
	inc	word_4FEFC
	jmp	short loc_29F5A
align 2
loc_29F56:
	inc	word_4FEFA
loc_29F5A:
	pop	si
	pop	bp
	retf
sub_29F12 endp

align 2
; Attributes: bp-based frame

sub_29F5E proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 2
	push	di
	push	si
	cmp	word_4FEFC, 0
	jnz	short loc_29FC4
	mov	si, [bp+arg_0]
	or	si, si
	jle	short loc_29FC4
	jmp	short loc_29F91
loc_29F76:
	push	word ptr dword_4FED6+2
	push	word ptr dword_4FED6
	push	word_50068
	call	sub_289E0
	add	sp, 6
loc_29F8A:
	inc	ax
	jnz	short loc_29F91
	inc	word_4FEFC
loc_29F91:
	mov	ax, si
	dec	si
	or	ax, ax
	jle	short loc_29FB6
	les	bx, dword_4FED6
	dec	word ptr es:[bx+4]
	js	short loc_29F76
	mov	al, byte ptr word_50068
	mov	di, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	es:[di], al
	sub	ah, ah
	jmp	short loc_29F8A
loc_29FB6:
	cmp	word_4FEFC, 0
	jnz	short loc_29FC4
	mov	ax, [bp+arg_0]
	add	word_4FEFA, ax
loc_29FC4:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_29F5E endp

; Attributes: bp-based frame

sub_29FCA proc far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	sub	sp, 2
	push	di
	push	si
	mov	si, [bp+arg_4]
	cmp	word_4FEFC, 0
	jnz	short loc_2A03A
	jmp	short loc_2A000
loc_29FDE:
	push	word ptr dword_4FED6+2
	push	word ptr dword_4FED6
	les	bx, [bp+arg_0]
	mov	al, es:[bx]
	cbw
	push	ax
	call	sub_289E0
	add	sp, 6
loc_29FF6:
	inc	ax
	jnz	short loc_29FFD
	inc	word_4FEFC
loc_29FFD:
	inc	word ptr [bp+arg_0]
loc_2A000:
	mov	ax, si
	dec	si
	or	ax, ax
	jz	short loc_2A02C
	les	bx, dword_4FED6
	dec	word ptr es:[bx+4]
	js	short loc_29FDE
	les	bx, [bp+arg_0]
	mov	al, es:[bx]
	les	bx, dword_4FED6
	mov	di, es:[bx]
	inc	word ptr es:[bx]
	mov	es, word ptr es:[bx+2]
	mov	es:[di], al
	sub	ah, ah
	jmp	short loc_29FF6
loc_2A02C:
	cmp	word_4FEFC, 0
	jnz	short loc_2A03A
	mov	ax, [bp+arg_4]
	add	word_4FEFA, ax
loc_2A03A:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_29FCA endp

; Attributes: bp-based frame

sub_2A040 proc far

	var_C= dword ptr -0Ch
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 0Ch
	push	si
	mov	ax, word_4FF02
	mov	dx, word_4FF04
	mov	word ptr [bp+var_C], ax
	mov	word ptr [bp+var_C+2], dx
	sub	ax, ax
	mov	[bp+var_4], ax
	mov	[bp+var_6], ax
	cmp	word_50068, 30h	
	jnz	short loc_2A07B
	cmp	word_4FEF6, ax
	jz	short loc_2A07B
	cmp	word_4FEDA, ax
	jz	short loc_2A075
	cmp	word_4FF00, ax
	jnz	short loc_2A07B
loc_2A075:
	mov	word_50068, 20h	
loc_2A07B:
	mov	si, word_4FF06
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	call	_strlen
	add	sp, 4
	mov	[bp+var_8], ax
	sub	si, ax
	sub	si, [bp+arg_0]
	cmp	word_4FEEE, 0
	jnz	short loc_2A0BE
	les	bx, [bp+var_C]
	cmp	byte ptr es:[bx], 2Dh ;	'-'
	jnz	short loc_2A0BE
	cmp	word_50068, 30h	
	jnz	short loc_2A0BE
	inc	word ptr [bp+var_C]
	mov	al, es:[bx]
	cbw
	push	ax
	push	cs
	call	near ptr sub_29F12
	add	sp, 2
	dec	[bp+var_8]
loc_2A0BE:
	cmp	word_50068, 30h	
	jz	short loc_2A0D0
	or	si, si
	jle	short loc_2A0D0
	cmp	word_4FEEE, 0
	jz	short loc_2A0EB
loc_2A0D0:
	cmp	[bp+arg_0], 0
	jz	short loc_2A0DD
	inc	[bp+var_6]
	push	cs
	call	near ptr sub_2A146
loc_2A0DD:
	cmp	word_50066, 0
	jz	short loc_2A0EB
	inc	[bp+var_4]
	push	cs
	call	near ptr sub_2A15E
loc_2A0EB:
	cmp	word_4FEEE, 0
	jnz	short loc_2A11B
	push	si
	push	cs
	call	near ptr sub_29F5E
	add	sp, 2
	cmp	[bp+arg_0], 0
	jz	short loc_2A10A
	cmp	[bp+var_6], 0
	jnz	short loc_2A10A
	push	cs
	call	near ptr sub_2A146
loc_2A10A:
	cmp	word_50066, 0
	jz	short loc_2A11B
	cmp	[bp+var_4], 0
	jnz	short loc_2A11B
	push	cs
	call	near ptr sub_2A15E
loc_2A11B:
	push	[bp+var_8]
	push	word ptr [bp+var_C+2]
	push	word ptr [bp+var_C]
	push	cs
	call	near ptr sub_29FCA
	add	sp, 6
	cmp	word_4FEEE, 0
	jz	short loc_2A140
	mov	word_50068, 20h	
	push	si
	push	cs
	call	near ptr sub_29F5E
	add	sp, 2
loc_2A140:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2A040 endp

align 2

sub_2A146 proc far
	cmp	word_4FEE0, 0
	jz	short loc_2A152
	mov	ax, 2Bh	
	jmp	short loc_2A155
loc_2A152:
	mov	ax, 20h	
loc_2A155:
	push	ax
	push	cs
	call	near ptr sub_29F12
	add	sp, 2
	retf
sub_2A146 endp


sub_2A15E proc far
	mov	ax, 30h	
	push	ax
	push	cs
	call	near ptr sub_29F12
	add	sp, 2
	cmp	word_50066, 10h
	jnz	short locret_2A187
	cmp	word_4FEDC, 0
	jz	short loc_2A17C
	mov	ax, 58h	
	jmp	short loc_2A17F
loc_2A17C:
	mov	ax, 78h	
loc_2A17F:
	push	ax
	push	cs
	call	near ptr sub_29F12
	add	sp, 2
locret_2A187:
	retf
sub_2A15E endp

; Attributes: bp-based frame

sub_2A188 proc far

	var_6= byte ptr	-6
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	sub	sp, 6
	push	di
	push	si
	mov	[bp+var_2], 1
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 2Ah ;	'*'
	jnz	short loc_2A1B0
	les	bx, dword_4FEF0
	mov	si, es:[bx]
	add	word ptr dword_4FEF0, 2
	inc	word ptr [bp+arg_4]
	jmp	short loc_2A210
align 2
loc_2A1B0:
	les	bx, [bp+arg_4]
	cmp	byte ptr es:[bx], 2Dh ;	'-'
	jnz	short loc_2A1C1
	mov	[bp+var_2], 0FFFFh
	inc	word ptr [bp+arg_4]
loc_2A1C1:
	sub	si, si
	mov	bx, word ptr [bp+arg_4]
	mov	al, es:[bx]
	mov	[bp+var_6], al
	cmp	al, 30h	
	jl	short loc_2A210
	cmp	al, 39h	
	jg	short loc_2A210
	cmp	word_4FEF6, si
	jnz	short loc_2A1E4
	cmp	al, 30h	
	jnz	short loc_2A1E4
	mov	word_50068, 30h	
loc_2A1E4:
	mov	di, bx
	jmp	short loc_2A1EE
loc_2A1E8:
	cmp	byte ptr es:[di], 39h ;	'9'
	jg	short loc_2A20A
loc_2A1EE:
	mov	al, es:[di]
	cbw
	mov	cx, si
	shl	cx, 1
	shl	cx, 1
	add	cx, si
	shl	cx, 1
	add	cx, ax
	sub	cx, 30h	
	mov	si, cx
	inc	di
	cmp	byte ptr es:[di], 30h ;	'0'
	jge	short loc_2A1E8
loc_2A20A:
	mov	word ptr [bp+arg_4], di
	mov	word ptr [bp+arg_4+2], es
loc_2A210:
	mov	ax, [bp+var_2]
	imul	si
	mov	si, ax
	les	bx, [bp+arg_0]
	mov	es:[bx], si
	mov	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_2A188 endp

align 2
; Attributes: bp-based frame

sub_2A22A proc far

	var_4= dword ptr -4
	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 4
	push	di
	mov	ax, offset asc_4F7C8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ds
	mov	cl, [bp+arg_0]
	les	di, [bp+var_4]
	jmp	short loc_2A243
loc_2A242:
	inc	di
loc_2A243:
	cmp	byte ptr es:[di], 0
	jz	short loc_2A25A
	cmp	es:[di], cl
	jnz	short loc_2A242
	mov	ax, 1
	mov	word ptr [bp+var_4], di
	mov	word ptr [bp+var_4+2], es
	jmp	short loc_2A262
align 2
loc_2A25A:
	mov	word ptr [bp+var_4], di
	mov	word ptr [bp+var_4+2], es
	sub	ax, ax
loc_2A262:
	pop	di
	mov	sp, bp
	pop	bp
	retf
sub_2A22A endp

align 2
; Attributes: bp-based frame

sscanf_segAdjust proc far

	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	push	si
	mov	si, [bp+arg_0]
	les	bx, [bp+arg_2]
	test	byte ptr es:[bx+0Ah], 1
	jz	short loc_2A27E
	cmp	si, 0FFFFh
	jnz	short loc_2A284
loc_2A27E:
	mov	ax, 0FFFFh
	jmp	short loc_2A2F3
align 2
loc_2A284:
	les	bx, [bp+arg_2]
	mov	ax, es:[bx+6]
	or	ax, es:[bx+8]
	jnz	short loc_2A299
	push	es
	push	bx
	call	sub_28B9E
	add	sp, 4
loc_2A299:
	les	bx, [bp+arg_2]
	mov	ax, es:[bx]
	mov	dx, es:[bx+2]
	cmp	es:[bx+6], ax
	jnz	short loc_2A2B9
	cmp	es:[bx+8], dx
	jnz	short loc_2A2B9
	cmp	word ptr es:[bx+4], 0
	jnz	short loc_2A27E
	inc	word ptr es:[bx]
loc_2A2B9:
	inc	word ptr es:[bx+4]
	dec	word ptr es:[bx]
	les	bx, es:[bx]
	mov	ax, si
	mov	es:[bx], al
	les	bx, [bp+arg_2]
	and	byte ptr es:[bx+0Ah], 0EFh
	test	byte ptr es:[bx+0Ah], 40h
	jnz	short loc_2A2EF
	mov	ax, bx
	sub	ax, offset off_4F64C
	cwd
	mov	cx, 0Ch
	idiv	cx
	mov	bx, ax
	shl	bx, 1
	add	bx, ax
	shl	bx, 1
	or	byte_4F73C[bx], 4
loc_2A2EF:
	mov	ax, si
	sub	ah, ah
loc_2A2F3:
	pop	si
	pop	bp
	retf
sscanf_segAdjust endp

; Attributes: bp-based frame

sub_2A2F6 proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_2= word ptr	 6
	arg_4= word ptr	 8
	arg_6= word ptr	 0Ah
	arg_8= word ptr	 0Ch

; FUNCTION CHUNK AT 13D5 SIZE 0000000D BYTES
	push	bp
	mov	bp, sp
	sub	sp, 4
	mov	bx, [bp+arg_2]
	cmp	bx, word_4EFFA
	jb	short loc_2A30A
	mov	ax, 900h
	jmp	short loc_2A334
loc_2A30A:
	test	[bp+arg_6], 8000h
	jz	short loc_2A359
	cmp	[bp+arg_8], 0
	jz	short loc_2A331
	xor	cx, cx
	mov	dx, cx
	mov	ax, 4201h
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method: offset from present location
	jb	short loc_2A36D
	test	[bp+arg_8], 2
	jnz	short loc_2A337
	add	ax, [bp+arg_4]
	adc	dx, [bp+arg_6]
	jns	short loc_2A359
loc_2A331:
	mov	ax, 1600h
loc_2A334:
	stc
	jmp	short loc_2A36D
loc_2A337:
	mov	[bp+var_2], dx
	mov	[bp+var_4], ax
	mov	dx, cx
	mov	ax, 4202h
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method: offset from end of file
	add	ax, [bp+arg_4]
	adc	dx, [bp+arg_6]
	jns	short loc_2A359
	mov	cx, [bp+var_2]
	mov	dx, [bp+var_4]
	mov	ax, 4200h
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method: offset from beginning of	file
	jmp	short loc_2A331
loc_2A359:
	mov	dx, [bp+arg_4]
	mov	cx, [bp+arg_6]
	mov	al, byte ptr [bp+arg_8]
	mov	ah, 42h
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method:
			; 0-from beginnig,1-from current,2-from	end
	jb	short loc_2A36D
	and	byte_4EFFC[bx], 0FDh
loc_2A36D:
	jmp	loc_28805
sub_2A2F6 endp

; Attributes: bp-based frame

sub_2A370 proc far

	var_1= word ptr	-1
	arg_2= word ptr	 6
	arg_4= dword ptr  8
	arg_8= word ptr	 0Ch

	push	bp
	mov	bp, sp
	sub	sp, 2
	mov	bx, [bp+arg_2]
	cmp	bx, word_4EFFA
	jb	short loc_2A385
	stc
	mov	ax, 900h
	jmp	short loc_2A3EC
loc_2A385:
	xor	ax, ax
	mov	cx, [bp+arg_8]
	jcxz	short loc_2A3EC
	test	byte_4EFFC[bx],	2
	jnz	short loc_2A3EC
	mov	cx, [bp+arg_8]
	push	ds
	lds	dx, [bp+arg_4]
	mov	ah, 3Fh
	int	21h		; DOS -	2+ - CALL(read) FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
	pop	ds
	jnb	short loc_2A3A5
	mov	ah, 9
	jmp	short loc_2A3EC
loc_2A3A5:
	test	byte_4EFFC[bx],	80h
	jz	short loc_2A3EC
	and	byte_4EFFC[bx],	0FBh
	push	si
	push	di
	push	ds
	pop	es
	assume es:dseg
	mov	ds, word ptr [bp+arg_4+2]
	cld
	mov	si, dx
	mov	di, dx
	mov	cx, ax
	jcxz	short loc_2A3E8
	mov	ah, 0Dh
	cmp	byte ptr [si], 0Ah
	jnz	short loc_2A3CE
	or	es:byte_4EFFC[bx], 4
loc_2A3CE:
	lodsb
	cmp	al, ah
	jz	short loc_2A3EF
	cmp	al, 1Ah
	jnz	short loc_2A3DF
	or	es:byte_4EFFC[bx],	2
	jmp	short loc_2A3E4
loc_2A3DF:
	mov	[di], al
	inc	di
loc_2A3E2:
	loop	loc_2A3CE
loc_2A3E4:
	mov	ax, di
	sub	ax, dx
loc_2A3E8:
	push	es
	pop	ds
loc_2A3EA:
	pop	di
	pop	si
loc_2A3EC:
	jmp	loc_28805
loc_2A3EF:
	cmp	cx, 1
	jz	short loc_2A3FB
	cmp	byte ptr [si], 0Ah
	jz	short loc_2A3E2
	jmp	short loc_2A3DF
loc_2A3FB:
	push	es
	pop	ds
	test	byte_4EFFC[bx],	40h
	jz	short loc_2A41C
	mov	ax, 4400h
	int	21h		; DOS -	2+ - IOCTL - GET DEVICE	INFORMATION
			; BX = file or device handle
	test	dx, 20h
	jnz	short loc_2A418
	lea	dx, [bp-1]
	mov	ah, 3Fh
	int	21h		; DOS -	2+ - CALL(read) FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
	jb	short loc_2A3EA
loc_2A418:
	mov	al, 0Ah
	jmp	short loc_2A448
loc_2A41C:
	mov	byte ptr [bp+var_1], 0
	lea	dx, [bp+var_1]
	mov	ah, 3Fh
	int	21h		; DOS -	2+ - CALL(read) FROM FILE WITH HANDLE
			; BX = file handle, CX = number	of bytes to read
			; DS:DX	-> buffer
	jb	short loc_2A3EA
	or	ax, ax
	jz	short loc_2A446
	cmp	[bp+arg_8], 1
	jz	short loc_2A452
loc_2A433:
	mov	cx, 0FFFFh
	mov	dx, cx
	mov	ax, 4201h
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method: offset from present location
	mov	cx, 1
	cmp	byte ptr [bp+var_1], 0Ah
	jz	short loc_2A44D
loc_2A446:
	mov	al, 0Dh
loc_2A448:
	lds	dx, [bp+arg_4]
	jmp	short loc_2A3DF
loc_2A44D:
	lds	dx, [bp+arg_4]
	jmp	short loc_2A3E2
loc_2A452:
	cmp	byte ptr [bp+var_1], 0Ah
	jnz	short loc_2A433
	jmp	short loc_2A418
sub_2A370 endp

; Attributes: bp-based frame

sub_2A45A proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_2= word ptr	 6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

; FUNCTION CHUNK AT 313A SIZE 00000039 BYTES
	push	bp
	mov	bp, sp
	sub	sp, 8
	mov	bx, [bp+arg_2]
	cmp	bx, word_4EFFA
	jb	short loc_2A470
	mov	ax, 900h
	stc
loc_2A46D:
	jmp	loc_28805
loc_2A470:
	test	byte_4EFFC[bx], 20h
	jz	short loc_2A482
	mov	ax, 4202h
	xor	cx, cx
	mov	dx, cx
	int	21h		; DOS -	2+ - MOVE FILE CALL(read)/CALL(write) POINTER (LSEEK)
			; AL = method: offset from end of file
	jb	short loc_2A46D
loc_2A482:
	test	byte_4EFFC[bx], 80h
	jz	short loc_2A505
	mov	[bp+var_6], ds
	mov	es, [bp+arg_4]
	assume es:nothing
	lds	dx, [bp+8]
	xor	ax, ax
	mov	[bp+var_2], ax
	mov	[bp+var_4], ax
	cld
	push	di
	push	si
	mov	di, dx
	mov	si, dx
	mov	[bp+var_8], sp
	mov	cx, [bp+arg_6]
	jcxz	short loc_2A507
	mov	al, 0Ah
	repne scasb
	jnz	short loc_2A500
	push	ds
	mov	ds, [bp+var_6]
	call	sub_2A5A4
	pop	ds
	cmp	ax, 0A8h 
	jbe	short loc_2A509
	sub	sp, 2
	mov	bx, sp
	mov	dx, 200h
	cmp	ax, 228h
	jnb	short loc_2A4CE
	mov	dx, 80h
loc_2A4CE:
	sub	sp, dx
	mov	dx, sp
	mov	di, dx
	push	ss
	pop	es
	assume es:dseg
	mov	cx, [bp+arg_6]
loc_2A4D9:
	lodsb
	cmp	al, 0Ah
	jz	short loc_2A4EA
loc_2A4DE:
	cmp	di, bx
	jz	short loc_2A4FB
loc_2A4E2:
	stosb
	loop	loc_2A4D9
	call	near ptr sub_2A50E
	jmp	short loc_2A559
loc_2A4EA:
	mov	al, 0Dh
	cmp	di, bx
	jnz	short loc_2A4F3
	call	near ptr sub_2A50E
loc_2A4F3:
	stosb
	mov	al, 0Ah
	inc	[bp+var_4]
	jmp	short loc_2A4DE
loc_2A4FB:
	call	near ptr sub_2A50E
	jmp	short loc_2A4E2
loc_2A500:
	pop	si
	pop	di
	mov	ds, [bp+var_6]
loc_2A505:
	jmp	short loc_2A56A
loc_2A507:
	jmp	short loc_2A559
loc_2A509:
	xor	ax, ax
	jmp	loc_2834B
sub_2A45A endp


sub_2A50E proc far
	push	ax
	push	bx
	push	cx
	push	ds
	push	es
	pop	ds
	mov	cx, di
	sub	cx, dx
	jcxz	short loc_2A52A
	mov	bx, [bp+6]
	mov	ah, 40h
	int	21h		; DOS -	2+ - CALL(write) TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
	jb	short loc_2A531
	add	[bp-2],	ax
	or	ax, ax
	jz	short loc_2A531
loc_2A52A:
	pop	ds
	pop	cx
	pop	bx
	pop	ax
	mov	di, dx
	retn
loc_2A531:
	pop	ds
	add	sp, 8
	jnb	short loc_2A53B
	mov	ah, 9
	jmp	short loc_2A55F
loc_2A53B:
	mov	ds, word ptr [bp-2]
	test	byte_4EFFC[bx], 40h
	jz	short loc_2A553
	mov	ds, word ptr [bp+0Ah]
	mov	bx, [bp+8]
	cmp	byte ptr [bx], 1Ah
	jnz	short loc_2A553
	clc
	jmp	short loc_2A55F
loc_2A553:
	stc
	mov	ax, 1C00h
	jmp	short loc_2A55F
loc_2A559::
	mov	ax, [bp-2]
	sub	ax, [bp-4]
loc_2A55F:
	mov	sp, [bp-8]
	pop	si
	pop	di
	mov	ds, word ptr [bp-6]
loc_2A567::
	jmp	loc_28805
sub_2A50E endp

; START	OF FUNCTION CHUNK FOR sub_2A45A
loc_2A56A:
	mov	cx, [bp+arg_6]
	or	cx, cx
	jnz	short loc_2A576
	mov	ax, cx
	jmp	loc_28805
loc_2A576:
	push	ds
	lds	dx, [bp+8]
	mov	ah, 40h
	int	21h		; DOS -	2+ - CALL(write) TO FILE WITH	HANDLE
			; BX = file handle, CX = number	of bytes to write, DS:DX -> buffer
	push	ds
	pop	es
	pop	ds
	jnb	short loc_2A587
	mov	ah, 9
	jmp	short loc_2A567
loc_2A587:
	or	ax, ax
	jnz	short loc_2A567
	test	byte_4EFFC[bx], 40h
	jz	short loc_2A59D
	mov	bx, dx
	cmp	byte ptr es:[bx], 1Ah
	jnz	short loc_2A59D
	clc
	jmp	short loc_2A567
loc_2A59D:
	stc
	mov	ax, 1C00h
	jmp	short loc_2A567
; END OF FUNCTION CHUNK	FOR sub_2A45A
align 2

sub_2A5A4 proc far
	pop	cx
	pop	dx
	mov	ax, word_4F030
	cmp	ax, sp
	jnb	short loc_2A5B4
	sub	ax, sp
	neg	ax
loc_2A5B1:
	push	dx
	push	cx
	retf
loc_2A5B4:
	xor	ax, ax
	jmp	short loc_2A5B1
sub_2A5A4 endp

	push	bp
	mov	bp, sp
	mov	bx, [bp+6]
	or	bx, bx
	jz	short loc_2A5C6
	or	byte ptr [bx-2], 1
loc_2A5C6:
	mov	sp, bp
	pop	bp
	retf
; Attributes: bp-based frame

sub_2A5CA proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	push	si
	push	di
	mov	bx, offset word_4F7CE
	cmp	word ptr [bx], 0
	jnz	short loc_2A600
	push	ds
	pop	es
	mov	ax, 5
	call	sub_2A82C
	jnz	short loc_2A5E6
	xor	ax, ax
	cwd
	jmp	short loc_2A60A
loc_2A5E6:
	inc	ax
	and	al, 0FEh
	mov	word_4F7CE, ax
	mov	word_4F7D0, ax
	xchg	ax, si
	mov	word ptr [si], 1
	add	si, 4
	mov	word ptr [si-2], 0FFFEh
	mov	word_4F7D4, si
loc_2A600:
	mov	cx, [bp+arg_0]
	mov	ax, ds
	mov	es, ax
	call	sub_2A6ED
loc_2A60A:
	pop	di
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2A5CA endp

; Attributes: bp-based frame
_freeMaybe proc	far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	les	bx, [bp+arg_0]
	assume es:nothing
	mov	ax, es
	or	ax, bx
	jz	short loc_2A621
	or	byte ptr es:[bx-2], 1
loc_2A621:
	mov	sp, bp
	pop	bp
	retf
_freeMaybe endp

; Attributes: bp-based frame

_mallocMaybe proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	sub	sp, 2
	push	si
	push	di
	mov	ax, [bp+arg_0]
	cmp	ax, 0FFF1h
	jnb	short loc_2A653
	cmp	word_4F7D8, 0
	jnz	short loc_2A644
	call	sub_2A664
	jz	short loc_2A653
	mov	word_4F7D8, ax
loc_2A644:
	call	sub_2A6D2
	jnz	short loc_2A65E
	call	sub_2A664
	jz	short loc_2A653
	call	sub_2A6D2
	jnz	short loc_2A65E
loc_2A653:
	push	[bp+arg_0]
	call	sub_2A5CA
	add	sp, 2
loc_2A65E:
	pop	di
	pop	si
	mov	sp, bp
	pop	bp
	retf
_mallocMaybe endp

sub_2A664 proc near
	mov	bx, 0F0h 
	cmp	[bp+6],	bx
	jbe	short loc_2A673
	mov	bx, [bp+6]
	inc	bx
	and	bx, 0FFFEh
loc_2A673:
	mov	[bp-2],	bx
	xor	ax, ax
	push	ds
	push	ax
	push	ax
	lea	cx, [bx+0Eh]
	push	cx
	mov	al, 2
	push	ax
	call	sub_2A84E
	add	sp, 8
	cmp	dx, 0FFFFh
	jz	short loc_2A6D0
	mov	ax, dx
	xchg	dx, word_4F7DA
	mov	word_4F7DC, ax
	cmp	ax, word_4F7E0
	jbe	short loc_2A6A1
	mov	word_4F7E0, ax
loc_2A6A1:
	or	dx, dx
	jz	short loc_2A6AA
	mov	ds, dx
	assume ds:nothing
	mov	ds:8,	ax
loc_2A6AA:
	mov	bx, [bp-2]
	mov	ds, ax
	assume ds:nothing
	xor	ax, ax
	mov	ds:8,	ax
	dec	ax
	dec	ax
	mov	[bx+0Ch], ax
	mov	ax, 0Ah
	mov	ds:0, ax
	mov	ds:2, ax
	lea	ax, [bx+1]
	mov	ds:0Ah, ax
	add	ax, 0Dh
	mov	ds:6, ax
	mov	ax, ds
loc_2A6D0:
	pop	ds
	retn
sub_2A664 endp

sub_2A6D2 proc near
	mov	ax, ds
	mov	es, ax
	assume es:dseg
	mov	cx, [bp+6]
	xor	bx, bx
	mov	ds, word_4F7DC
	call	sub_2A6ED
	or	dx, dx
	mov	cx, es
	mov	ds, cx
	retn
sub_2A6D2 endp

align 2
; START	OF FUNCTION CHUNK FOR sub_2A6ED
loc_2A6EA:
	jmp	loc_2A7BB
; END OF FUNCTION CHUNK	FOR sub_2A6ED
sub_2A6ED proc near
; FUNCTION CHUNK AT 32BA SIZE 00000003 BYTES
	inc	cx
	jz	short loc_2A6EA
	and	cl, 0FEh
	cmp	cx, 0FFEEh
	jnb	short loc_2A6EA
	mov	si, [bx+2]
	cld
	lodsw
	mov	di, si
	test	al, 1
	jz	short loc_2A745
loc_2A703:
	dec	ax
	cmp	ax, cx
	jnb	short loc_2A71D
	mov	dx, ax
	add	si, ax
	lodsw
	test	al, 1
	jz	short loc_2A745
	add	ax, dx
	add	ax, 2
	mov	si, di
	mov	[si-2],	ax
	jmp	short loc_2A703
loc_2A71D:
	mov	di, si
	jz	short loc_2A72D
	add	di, cx
	mov	[si-2],	cx
	sub	ax, cx
	dec	ax
	mov	[di], ax
	jmp	short loc_2A732
loc_2A72D:
	add	di, cx
	dec	byte ptr [si-2]
loc_2A732:
	mov	ax, si
	mov	dx, ds
	mov	cx, ss
	cmp	dx, cx
	jz	short loc_2A741
	mov	es:word_4F7DC, ds
loc_2A741:
	mov	[bx+2],	di
	retn
loc_2A745:
	mov	es:byte_4F7E2, 2
loc_2A74B:
	cmp	ax, 0FFFEh
	jz	short loc_2A775
	mov	di, si
	add	si, ax
loc_2A754:
	lodsw
	test	al, 1
	jz	short loc_2A74B
	mov	di, si
loc_2A75B:
	dec	ax
	cmp	ax, cx
	jnb	short loc_2A71D
	mov	dx, ax
	add	si, ax
	lodsw
	test	al, 1
	jz	short loc_2A74B
	add	ax, dx
	add	ax, 2
	mov	si, di
	mov	[si-2],	ax
	jmp	short loc_2A75B
loc_2A775:
	mov	ax, [bx+8]
	or	ax, ax
	jz	short loc_2A780
	mov	ds, ax
	jmp	short loc_2A794
loc_2A780:
	dec	es:byte_4F7E2
	jz	short loc_2A798
	mov	ax, ds
	mov	di, ss
	cmp	ax, di
	jz	short loc_2A794
	mov	ds, es:word_4F7D8
loc_2A794:
	mov	si, [bx]
	jmp	short loc_2A754
loc_2A798:
	mov	si, [bx+6]
	xor	ax, ax
	call	sub_2A80A
	cmp	ax, si
	jz	short loc_2A7B1
	and	al, 1
	inc	ax
	inc	ax
	cbw
	call	sub_2A80A
	jz	short loc_2A7BB
	dec	byte ptr [di-2]
loc_2A7B1:
	call	sub_2A7D0
	jz	short loc_2A7BB
	xchg	ax, si
	dec	si
	dec	si
	jmp	short loc_2A754
loc_2A7BB::
	mov	ax, ds
	mov	cx, ss
	cmp	ax, cx
	jz	short loc_2A7C7
	mov	es:word_4F7DC, ax
loc_2A7C7:
	mov	ax, [bx]
	mov	[bx+2],	ax
	xor	ax, ax
	cwd
	retn
sub_2A6ED endp

sub_2A7D0 proc near
	push	cx
	mov	ax, [di-2]
	test	al, 1
	jz	short loc_2A7DB
	sub	cx, ax
	dec	cx
loc_2A7DB:
	inc	cx
	inc	cx
	mov	dx, 7FFFh
loc_2A7E0:
	cmp	dx, es:word_4F7DE
	jbe	short loc_2A7EB
	shr	dx, 1
	jnz	short loc_2A7E0
loc_2A7EB:
	mov	ax, cx
	add	ax, si
	jb	short loc_2A806
	add	ax, dx
	jb	short loc_2A802
	not	dx
	and	ax, dx
	sub	ax, si
	call	sub_2A80A
	jnz	short loc_2A808
	not	dx
loc_2A802:
	shr	dx, 1
	jnz	short loc_2A7EB
loc_2A806:
	xor	ax, ax
loc_2A808:
	pop	cx
	retn
sub_2A7D0 endp

sub_2A80A proc near
	push	dx
	push	cx
	call	sub_2A82C
	jz	short loc_2A829
	push	di
	mov	di, si
	mov	si, ax
	add	si, dx
	mov	word ptr [si-2], 0FFFEh
	mov	[bx+6],	si
	mov	dx, si
	sub	dx, di
	dec	dx
	mov	[di-2],	dx
	pop	ax
loc_2A829:
	pop	cx
	pop	dx
	retn
sub_2A80A endp

sub_2A82C proc near
	push	bx
	push	ax
	xor	dx, dx
	push	ds
	push	dx
	push	dx
	push	ax
	mov	ax, 1
	push	ax
	push	es
	pop	ds
	call	sub_2A84E
	add	sp, 8
	cmp	dx, 0FFFFh
	pop	ds
	pop	dx
	pop	bx
	jz	short locret_2A84C
	or	dx, dx
locret_2A84C:
	retn
sub_2A82C endp

align 2
; Attributes: bp-based frame

sub_2A84E proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	push	si
	push	di
	push	es
	cmp	[bp+arg_4], 0
	jnz	short loc_2A892
	mov	di, offset word_4EF82
	mov	dx, [bp+arg_2]
	mov	ax, [bp+arg_0]
	dec	ax
	jnz	short loc_2A86D
	call	sub_2A8BC
	jb	short loc_2A892
	jmp	short loc_2A8B5
loc_2A86D:
	mov	si, off_4EFD2
	dec	ax
	jz	short loc_2A885
	cmp	si, di
	jz	short loc_2A885
	mov	ax, [si+2]
	mov	[bp+arg_8], ax
	push	si
	call	sub_2A8BC
	pop	si
	jnb	short loc_2A8B5
loc_2A885:
	add	si, 4
	cmp	si, offset off_4EFD2
	jnb	short loc_2A892
	or	dx, dx
	jnz	short loc_2A898
loc_2A892:
	mov	ax, 0FFFFh
	cwd
	jmp	short loc_2A8B5
loc_2A898:
	mov	bx, dx
	add	bx, 0Fh
	rcr	bx, 1
	mov	cl, 3
	shr	bx, cl
	mov	ah, 48h
	int	21h		; DOS -	2+ - ALLOCATE MEMORY
			; BX = number of 16-byte paragraphs desired
	jb	short loc_2A892
	xchg	ax, dx
	mov	[si], ax
	mov	[si+2],	dx
	mov	off_4EFD2, si
	xor	ax, ax
loc_2A8B5:
	pop	es
	assume es:nothing
	pop	di
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2A84E endp

sub_2A8BC proc near
	mov	cx, [bp+0Eh]
	mov	si, di
loc_2A8C1:
	cmp	[si+2],	cx
	jz	short loc_2A8D2
	add	si, 4
	cmp	si, off_4EFD2
	jnz	short loc_2A8C1
	stc
	jmp	short locret_2A911
loc_2A8D2:
	mov	bx, dx
	add	bx, [si]
	jb	short locret_2A911
	mov	dx, bx
	mov	es, cx
	cmp	si, di
	jnz	short loc_2A8E6
	cmp	word_4EF7C, bx
	jnb	short loc_2A90C
loc_2A8E6:
	add	bx, 0Fh
	rcr	bx, 1
	shr	bx, 1
	shr	bx, 1
	shr	bx, 1
	cmp	si, di
	jnz	short loc_2A8FE
	add	bx, cx
	mov	ax, word_4EFF3
	sub	bx, ax
	mov	es, ax
loc_2A8FE:
	mov	ah, 4Ah
	int	21h		; DOS -	2+ - ADJUST MEMORY BLOCK SIZE (SETBLOCK)
			; ES = segment address of block	to change
			; BX = new size	in paragraphs
	jb	short locret_2A911
	cmp	si, di
	jnz	short loc_2A90C
	mov	word_4EF7C, dx
loc_2A90C:
	xchg	ax, dx
	xchg	ax, [si]
	mov	dx, cx
locret_2A911:
	retn
sub_2A8BC endp

; Attributes: bp-based frame

_strcpy proc far

	destString= dword ptr  6
	srcString= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	dx, di
	mov	bx, si
	push	ds
	lds	si, [bp+srcString]
	mov	di, si
	mov	ax, ds
	mov	es, ax
	assume es:dseg

	xor	ax, ax
	mov	cx, 0FFFFh
	repne scasb			; scan srcString for '\0' 
	not	cx			; cx has the index of '\0'
	les	di, [bp+destString]
	assume es:nothing
	mov	ax, di
	test	al, 1
	jz	short loc_2A937
	movsb
	dec	cx
loc_2A937:
	shr	cx, 1
	rep movsw
	adc	cx, cx
	rep movsb
	mov	si, bx
	mov	di, dx
	pop	ds
	mov	dx, es
	pop	bp
	retf
_strcpy endp

; Attributes: bp-based frame

strcmp	proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	mov	dx, di
	mov	bx, si
	push	ds
	lds	si, [bp+arg_0]
	les	di, [bp+arg_4]
	xor	ax, ax
	mov	cx, 0FFFFh
	repne scasb
	not	cx
	sub	di, cx
	repe cmpsb
	jz	short loc_2A96A
	sbb	ax, ax
	sbb	ax, 0FFFFh
loc_2A96A:
	pop	ds
	mov	si, bx
	mov	di, dx
	pop	bp
	retf
strcmp	endp

align 2
; Attributes: bp-based frame

_strlen	proc far

	arg_0= dword ptr  6

	push	bp
	mov	bp, sp
	mov	dx, di
	les	di, [bp+arg_0]
	xor	ax, ax
	mov	cx, 0FFFFh
	repne scasb
	not	cx
	dec	cx
	xchg	ax, cx
	mov	di, dx
	pop	bp
	retf
_strlen	endp

align 2
; Attributes: bp-based frame
; Attributes: bp-based frame

toUpper	proc far
arg_0= word ptr	 6
	push	bp
	mov	bp, sp
	mov	bx, [bp+arg_0]
	test	sscanf_charFlags[bx],	2
	jz	short loc_2A9A8
	mov	ax, bx
	sub	ax, 20h	
	jmp	short loc_2A9AA
loc_2A9A8:
	mov	ax, bx
loc_2A9AA:
	pop	bp
	retf
toUpper	endp

; Attributes: bp-based frame

sub_2A9AC proc far
arg_0= word ptr	 6
	push	bp
	mov	bp, sp
	mov	bx, [bp+arg_0]
	cmp	bx, word_4EFFA
	jge	short loc_2A9C9
	cmp	bx, 0
	jl	short loc_2A9C9
	test	byte_4EFFC[bx],	40h
	jz	short loc_2A9C9
	mov	ax, 1
	jmp	short loc_2A9CB
loc_2A9C9:
	xor	ax, ax
loc_2A9CB:
	mov	sp, bp
	pop	bp
	retf
sub_2A9AC endp

align 2
	mov	dh, 1
	jmp	short loc_2A9D6

sub_2A9D4 proc far
	mov	dh, 8
loc_2A9D6::
	mov	ax, word_4F900
	or	ah, ah
	jnz	short loc_2A9E5
	mov	word_4F900, 0FFFFh
	jmp	short locret_2A9EA
loc_2A9E5:
	xchg	ax, dx
	int	21h		; DOS -
	mov	ah, 0
locret_2A9EA:
	retf
sub_2A9D4 endp

align 2
; Attributes: bp-based frame

sscanf proc far
var_14=	word ptr -14h
var_8= dword ptr -8
var_4= word ptr	-4
var_2= word ptr	-2
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
arg_6= word ptr	 0Ch
arg_8= word ptr	 0Eh
	push	bp
	mov	bp, sp
	sub	sp, 14h
	lea	ax, [bp+var_14]
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], ss
	lea	ax, [bp+arg_8]
	mov	[bp+var_4], ax
	mov	[bp+var_2], ss
	les	bx, [bp+var_8]
	mov	byte ptr es:[bx+0Ah], 49h 
	mov	ax, [bp+arg_0]
	mov	dx, [bp+arg_2]
	mov	es:[bx+6], ax
	mov	es:[bx+8], dx
	mov	es:[bx], ax
	mov	es:[bx+2], dx
	push	dx
	push	ax
	call	_strlen
	add	sp, 4
	les	bx, [bp+var_8]
	mov	es:[bx+4], ax
	push	[bp+var_2]
	push	[bp+var_4]
	push	[bp+arg_6]
	push	[bp+arg_4]
	push	es
	push	bx
	call	_sscanf
	mov	sp, bp
	pop	bp
	retf
sscanf endp

align 2
; Attributes: bp-based frame

memcpy	proc far
arg_0= dword ptr  6
arg_4= dword ptr  0Ah
arg_8= word ptr	 0Eh
	push	bp
	mov	bp, sp
	mov	cx, [bp+arg_8]
	jcxz	short loc_2AAA0
	push	ds
	push	di
	push	si
	lds	si, [bp+arg_4]
	les	di, [bp+arg_0]
loc_2AA5B:
	mov	ax, cx
	dec	ax
	mov	dx, di
	not	dx
	sub	ax, dx
	sbb	bx, bx
	and	ax, bx
	add	ax, dx
	mov	dx, si
	not	dx
	sub	ax, dx
	sbb	bx, bx
	and	ax, bx
	add	ax, dx
	inc	ax
	xchg	ax, cx
	sub	ax, cx
	shr	cx, 1
	rep movsw
	adc	cx, cx
	rep movsb
	xchg	ax, cx
	jcxz	short loc_2AA9D
	or	si, si
	jnz	short loc_2AA90
	mov	ax, ds
	add	ax, 1000h
	mov	ds, ax
	assume ds:nothing
loc_2AA90:
	or	di, di
	jnz	short loc_2AA5B
	mov	ax, es
	add	ax, 1000h
	mov	es, ax
	assume es:nothing
	jmp	short loc_2AA5B
loc_2AA9D:
	pop	si
	pop	di
	pop	ds
	assume ds:dseg
loc_2AAA0:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	pop	bp
	retf
memcpy	endp

; Attributes: bp-based frame

memset	proc far
_ptr= dword ptr	 6
_c= word ptr  0Ah
_size= word ptr	 0Ch
	push	bp
	mov	bp, sp
	mov	cx, [bp+_size]
	jcxz	short loc_2AAE8
	push	di
	les	di, [bp+_ptr]
	assume es:nothing
	mov	dx, di
	neg	dx
	jz	short loc_2AAC6
	sub	dx, cx
	sbb	bx, bx
	and	dx, bx
	add	dx, cx
	xchg	dx, cx
	sub	dx, cx
loc_2AAC6:
	mov	ax, [bp+_c]
	mov	ah, al
	shr	cx, 1
	rep stosw
	adc	cx, cx
	rep stosb
	xchg	dx, cx
	jcxz	short loc_2AAE7
	mov	bx, es
	add	bx, 1000h
	mov	es, bx
	assume es:nothing
	shr	cx, 1
	rep stosw
	adc	cx, cx
	rep stosb
loc_2AAE7:
	pop	di
loc_2AAE8:
	mov	ax, word ptr [bp+_ptr]
	mov	dx, word ptr [bp+_ptr+2]
	pop	bp
	retf
memset	endp

; START	OF FUNCTION CHUNK FOR sub_2A98A

sub_2A98A proc far
arg_2= word ptr	 6
arg_4= word ptr	 8
arg_6= dword ptr  0Ah
arg_A= word ptr	 0Eh
; FUNCTION CHUNK AT 36C0 SIZE 00000063 BYTES
	push	bp
	mov	bp, sp
	push	si
	push	di
	mov	bl, 0
	jmp	loc_2AAF0
loc_2AAF0:
	mov	cx, [bp+arg_A]
	mov	ax, [bp+arg_2]
	mov	dx, [bp+arg_4]
	push	ds
	lds	di, [bp+arg_6]
	push	di
	push	ds
	pop	es
	assume es:dseg
	cld
	xchg	ax, bx
	or	al, al
	jz	short loc_2AB19
	cmp	cx, 0Ah
	jnz	short loc_2AB19
	or	dx, dx
	jns	short loc_2AB19
	mov	al, 2Dh	
	stosb
	neg	bx
	adc	dx, 0
	neg	dx
loc_2AB19:
	mov	si, di
loc_2AB1B:
	xchg	ax, dx
	xor	dx, dx
	or	ax, ax
	jz	short loc_2AB24
	div	cx
loc_2AB24:
	xchg	ax, bx
	div	cx
	xchg	ax, dx
	xchg	dx, bx
	add	al, 30h	
	cmp	al, 39h	
	jbe	short loc_2AB32
	add	al, 27h	
loc_2AB32:
	stosb
	mov	ax, dx
	or	ax, bx
	jnz	short loc_2AB1B
	mov	[di], al
loc_2AB3B:
	dec	di
	lodsb
	xchg	al, [di]
	mov	[si-1],	al
	lea	ax, [si+1]
	cmp	ax, di
	jb	short loc_2AB3B
	mov	dx, ds
	pop	ax
	pop	ds
	pop	di
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_2A98A endp

; END OF FUNCTION CHUNK	FOR sub_2A98A
align 2
; Attributes: bp-based frame

__32bitDivide proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
arg_6= word ptr	 0Ch
	push	bp
	mov	bp, sp
	push	di
	push	si
	push	bx
	xor	di, di
	mov	ax, [bp+arg_2]
	or	ax, ax
	jge	short loc_2AB74
	inc	di
	mov	dx, [bp+arg_0]
	neg	ax
	neg	dx
	sbb	ax, 0
	mov	[bp+arg_2], ax
	mov	[bp+arg_0], dx
loc_2AB74:
	mov	ax, [bp+arg_6]
	or	ax, ax
	jge	short loc_2AB8C
	inc	di
	mov	dx, [bp+arg_4]
	neg	ax
	neg	dx
	sbb	ax, 0
	mov	[bp+arg_6], ax
	mov	[bp+arg_4], dx
loc_2AB8C:
	or	ax, ax
	jnz	short loc_2ABA5
	mov	cx, [bp+arg_4]
	mov	ax, [bp+arg_2]
	xor	dx, dx
	div	cx
	mov	bx, ax
	mov	ax, [bp+arg_0]
	div	cx
	mov	dx, bx
	jmp	short loc_2ABDD
loc_2ABA5:
	mov	bx, ax
	mov	cx, [bp+arg_4]
	mov	dx, [bp+arg_2]
	mov	ax, [bp+arg_0]
loc_2ABB0:
	shr	bx, 1
	rcr	cx, 1
	shr	dx, 1
	rcr	ax, 1
	or	bx, bx
	jnz	short loc_2ABB0
	div	cx
	mov	si, ax
	mul	[bp+arg_6]
	xchg	ax, cx
	mov	ax, [bp+arg_4]
	mul	si
	add	dx, cx
	jb	short loc_2ABD9
	cmp	dx, [bp+arg_2]
	ja	short loc_2ABD9
	jb	short loc_2ABDA
	cmp	ax, [bp+arg_0]
	jbe	short loc_2ABDA
loc_2ABD9:
	dec	si
loc_2ABDA:
	xor	dx, dx
	xchg	ax, si
loc_2ABDD:
	dec	di
	jnz	short loc_2ABE7
	neg	dx
	neg	ax
	sbb	dx, 0
loc_2ABE7:
	pop	bx
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf	8
__32bitDivide endp

; This function	multiplies the characters level
; times	a 32 bit number. The first argument is the
; character level. The second is the high word of the
; level	converted to a 32 bit double. This is always
; going	to be zero. The	third and fourth are the lo
; and hi words of the multiplicant
; Attributes: bp-based frame

_level32bitMult	proc far
level= word ptr	 6
zero= word ptr	8
numLo= word ptr	 0Ah
numHi= word ptr	 0Ch
	push	bp
	mov	bp, sp
	mov	ax, [bp+zero]
	mov	bx, [bp+numHi]
	or	bx, ax
	mov	bx, [bp+numLo]
	jnz	short loc_2AC0B
	mov	ax, [bp+level]
	mul	bx
	mov	sp, bp
	pop	bp
locret_2AC08:
	retf	8
loc_2AC0B:
	mul	bx
	mov	cx, ax
	mov	ax, [bp+level]
	mul	[bp+numHi]
	add	cx, ax
	mov	ax, [bp+level]
	mul	bx
	add	dx, cx
	mov	sp, bp
	pop	bp
	retf	8
_level32bitMult	endp

; Attributes: bp-based frame

_32bitMod proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
arg_6= word ptr	 0Ch
	push	bp
	mov	bp, sp
	push	bx
	push	di
	xor	di, di
	mov	ax, [bp+arg_2]
	or	ax, ax
	jge	short loc_2AC43
	inc	di
	mov	dx, [bp+arg_0]
	neg	ax
	neg	dx
	sbb	ax, 0
	mov	[bp+arg_2], ax
	mov	[bp+arg_0], dx
loc_2AC43:
	mov	ax, [bp+arg_6]
	or	ax, ax
	jge	short loc_2AC5A
	mov	dx, [bp+arg_4]
	neg	ax
	neg	dx
	sbb	ax, 0
	mov	[bp+arg_6], ax
	mov	[bp+arg_4], dx
loc_2AC5A:
	or	ax, ax
	jnz	short loc_2AC76
	mov	cx, [bp+arg_4]
	mov	ax, [bp+arg_2]
	xor	dx, dx
	div	cx
	mov	ax, [bp+arg_0]
	div	cx
	mov	ax, dx
	xor	dx, dx
	dec	di
	jns	short loc_2ACB7
	jmp	short loc_2ACBE
loc_2AC76:
	mov	bx, ax
	mov	cx, [bp+arg_4]
	mov	dx, [bp+arg_2]
	mov	ax, [bp+arg_0]
loc_2AC81:
	shr	bx, 1
	rcr	cx, 1
	shr	dx, 1
	rcr	ax, 1
	or	bx, bx
	jnz	short loc_2AC81
	div	cx
	mov	cx, ax
	mul	[bp+arg_6]
	xchg	ax, cx
	mul	[bp+arg_4]
	add	dx, cx
	jb	short loc_2ACA8
	cmp	dx, [bp+arg_2]
	ja	short loc_2ACA8
	jb	short loc_2ACAE
	cmp	ax, [bp+arg_0]
	jbe	short loc_2ACAE
loc_2ACA8:
	sub	ax, [bp+arg_4]
	sbb	dx, [bp+arg_6]
loc_2ACAE:
	sub	ax, [bp+arg_0]
	sbb	dx, [bp+arg_2]
	dec	di
	jns	short loc_2ACBE
loc_2ACB7:
	neg	dx
	neg	ax
	sbb	dx, 0
loc_2ACBE:
	pop	di
	pop	bx
	mov	sp, bp
	pop	bp
	retf	8
_32bitMod endp


sub_2ACC6 proc far
	xor	ch, ch
	jcxz	short locret_2ACD0
loc_2ACCA:
	shl	ax, 1
	rcl	dx, 1
	loop	loc_2ACCA
locret_2ACD0:
	retf
sub_2ACC6 endp

align 2
; Attributes: bp-based frame

_32bitDivide proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
	push	bp
	mov	bp, sp
	mov	bx, [bp+arg_0]
	push	[bp+arg_4]
	push	[bp+arg_2]
	push	word ptr [bx+2]
	push	word ptr [bx]
	call	__32bitDivide
	mov	bx, [bp+arg_0]
	mov	[bx+2],	dx
	mov	[bx], ax
	mov	sp, bp
	pop	bp
	retf	6
_32bitDivide endp

; Attributes: bp-based frame

sub_2ACF6 proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
	push	bp
	mov	bp, sp
	mov	bx, [bp+arg_0]
	mov	ax, [bx]
	mov	dx, [bx+2]
	mov	cx, [bp+arg_2]
	call	sub_2ACC6
	mov	bx, [bp+arg_0]
	mov	[bx], ax
	mov	[bx+2],	dx
	mov	sp, bp
	pop	bp
locret_2AD14:
	retf	4
sub_2ACF6 endp

