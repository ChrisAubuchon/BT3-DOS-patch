; Attributes: bp-based frame

printCantFindUse proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push_ds_string aCanTSeemToFind
	func_printString
	mov	sp, bp
	pop	bp
	retf
printCantFindUse endp
