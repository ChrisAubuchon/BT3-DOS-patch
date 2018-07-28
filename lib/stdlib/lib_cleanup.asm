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
	int	21h		; DOS -	2+ - close A FILE WITH HANDLE
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
