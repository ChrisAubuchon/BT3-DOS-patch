; Attributes: bp-based frame

sub_1766A proc far
	push	bp
	mov	bp, sp
	cmp	gs:byte_422A0, 0
	jz	short loc_17688
	CALL(sub_17691, near)
	or	ax, ax
	jz	short l_return
loc_17688:
	call	far ptr	sub_3E971
l_return:
	mov	sp, bp
	pop	bp
	retf
sub_1766A endp

; Attributes: bp-based frame

sub_17691 proc far
	push	bp
	mov	bp, sp
	mov	ax, mouseBoxes._left
	cmp	mouse_x, ax
	jl	short loc_176CB
	mov	ax, mouseBoxes._right
	cmp	mouse_x, ax
	jge	short loc_176CB
	mov	ax, mouseBoxes._top
	cmp	mouse_y, ax
	jl	short loc_176CB
	mov	ax, mouseBoxes._bottom
	cmp	mouse_y, ax
	jl	short loc_176D0
loc_176CB:
	mov	ax, 1
	jmp	short loc_176D2
loc_176D0:
	sub	ax, ax
loc_176D2:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_17691 endp
