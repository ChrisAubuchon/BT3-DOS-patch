; Attributes: bp-based frame

lib_printRuntimeError proc far
	push	bp
	mov	bp, sp
	mov	ax, 0FCh 
	push	ax
	call	lib_printError
	cmp	word_4F02A, 0
	jz	short loc_284D9
	call	dword ptr unk_4F028
loc_284D9:
	mov	ax, 0FFh
	push	ax
	call	lib_printError
	mov	sp, bp
	pop	bp
	retf
lib_printRuntimeError endp
