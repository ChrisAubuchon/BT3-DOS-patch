; This function	returns	the index of the character
; in the saved character list matching "name". If the
; name is not found it returns 0xffff
; Attributes: bp-based frame

roster_nameExists proc far

	counter= word ptr -2
	nameOffset= word ptr  6
	nameString= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+counter], 0
l_loopEntry:
	getCharP	[bp+counter], bx
	lea	ax, characterIOBuf[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+nameString]
	push	[bp+nameOffset]
	call	_strcmp
	add	sp, 8
	or	ax, ax
	jz	short l_returnValue
	inc	[bp+counter]
	cmp	[bp+counter], 75
	jl	short l_loopEntry
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnValue:
	mov	ax, [bp+counter]
l_return:
	mov	sp, bp
	pop	bp
	retf
roster_nameExists endp

