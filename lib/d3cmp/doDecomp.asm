
d3cmp_doDecomp proc near
	push	bp
	mov	ax, word ptr dataHeader		; Return if dataHeader == 0
	or	ax, word ptr dataHeader+2
	jz	l_return

	CALL(d3cmp_init)
	xor	bp, bp
	sub	ax, ax
	mov	word ptr countMaybe+2, ax
	mov	word ptr countMaybe, ax
	sub	dx, dx

loc_278E6:
	mov	ax, word ptr dataHeader
	mov	cx, word ptr dataHeader+2
	cmp	word ptr countMaybe+2, cx
	ja	l_output

loc_278F6:
	jb	short loc_27901
	cmp	word ptr countMaybe, ax
	jnb	short l_output

loc_27901:
	CALL(d3cmp_getNextWord)
	cmp	ax, 256				; Just output the value if less than 256
	jge	short l_repeatSequence
	mov	ds:d3comp_outputBuffer[bp], al
	inc	bp
	test	bp, 4096
	jz	short loc_2791B
	CALL(d3cmp_outputToBuffer)
	mov	bp, 0

loc_2791B:
	add	word ptr countMaybe, 1
	adc	word ptr countMaybe+2, 0
	jmp	short loc_27978

l_repeatSequence:				; A value greater than 256 indicates a repeat copy
	sub	ax, 253				; number of repeats is value - 3
	mov	d3cmp_repeatCount, ax
	CALL(d3cmp_readCopyOffset)
	mov	cx, bp				; bp is the work buffer index
	sub	cx, ax
	dec	cx
	mov	_d3cmp_baseAddr, cx		; Copy address is buffer - 1 - value from d3cmp_readCopyOffset
	mov	_d3cmp_offset, 0
	jmp	short loc_2796F

loc_27941:
	mov	bx, _d3cmp_baseAddr
	add	bx, _d3cmp_offset
	and	bh, 0Fh
	mov	al, d3comp_outputBuffer[bx]
	mov	ds:d3comp_outputBuffer[bp], al
	inc	bp
	test	bp, 1000h
	jz	short loc_27961
	CALL(d3cmp_outputToBuffer)
	xor	bp, bp

loc_27961:
	add	word ptr countMaybe, 1
	adc	word ptr countMaybe+2, 0
	inc	_d3cmp_offset

loc_2796F:
	mov	ax, d3cmp_repeatCount
	cmp	_d3cmp_offset, ax
	jl	short loc_27941

loc_27978:
	jmp	loc_278E6

l_output:
	CALL(d3cmp_outputToBuffer)

l_return:
	pop	bp
	retn
d3cmp_doDecomp endp
