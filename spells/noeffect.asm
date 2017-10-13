; Attributes: bp-based frame

printNoEffect proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push_ds_string aButItHadNoEffe
	func_printString
	mov	sp, bp
	pop	bp
	retf
printNoEffect endp
