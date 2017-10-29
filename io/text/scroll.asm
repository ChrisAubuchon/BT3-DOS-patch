; Attributes: bp-based frame

text_scroll proc far
	push	bp
	mov	bp, sp
	mov	ax, 50h	
	push	ax
	call	far ptr	sub_3E980
	add	sp, 2
	mov	ax, 50h	
	push	ax
	call	far ptr	sub_3E980
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
text_scroll endp
