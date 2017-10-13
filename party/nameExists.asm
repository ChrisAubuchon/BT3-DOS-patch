; Returns the character	number of the character	name.
; Returns -1 if	there is no character by the provided
; name in the party
; Attributes: bp-based frame

party_nameExists	proc far

	var_2= word ptr	-2
	_offset= word ptr  6
	_segment= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
l_loopEntry:
	getCharP	[bp+var_2], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+_segment]
	push	[bp+_offset]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jz	l_returnValue
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	l_loopEntry
	mov	ax, 0FFFFh
	jmp	l_return
l_returnValue:
	mov	ax, [bp+var_2]
l_return:
	mov	sp, bp
	pop	bp
	retf
party_nameExists	endp
