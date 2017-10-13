printSpellFizzled proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aButItFizzled
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printSpellFizzled endp
