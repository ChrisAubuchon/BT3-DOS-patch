; Copy a number of bytes from d3comp_outputBuffer to the 
; destination buffer at d3cmp_destP
;
; bp has the number of bytes to copy
;
d3cmp_outputToBuffer proc near
	push	es
	push	di
	push	si
	cld
	mov	ax, word ptr d3cmp_destP
	mov	es, ax
	mov	di, word ptr d3cmp_destP+2
	mov	si, offset d3comp_outputBuffer
	mov	cx, bp
	rep movsb
	add	word ptr d3cmp_destP+2, bp
	jb	short loc_2766C

loc_27668:
	pop	si
	pop	di
	pop	es
	retn

loc_2766C:
	add	word ptr d3cmp_destP, 1000h
	add	word_4EE46, 1
	jmp	short loc_27668
d3cmp_outputToBuffer endp
