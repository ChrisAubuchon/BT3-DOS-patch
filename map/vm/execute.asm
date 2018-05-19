; Attributes: bp-based frame
;
; This function executes the level code based on the current square
; the party is on.
;
; There are some special values that affect function execution:
;   A sqN value of 7Fh executes the function regardless of the current sq_north value
;   A sqN value of FFh executes the function regardless of the current sq_north value iff
;     the vm_execute function is called as the result of a spell being cast. (spellFlag != 0)
;   A sqE value of FFh executes the function regardless of the current sq_east value

vm_execute proc far

	dataP= dword ptr -0Ch
	opcode=	word ptr -8
	functionCount= word	ptr -6
	sqN= word ptr -4
	sqE=	word ptr -2
	squareListP=	dword ptr  6
	spellFlag= word	ptr  0Ah

	FUNC_ENTER(0Ch)

	push	word ptr [bp+squareListP+2]
	push	word ptr [bp+squareListP]
	CALL(map_getDataOffsetP)
	mov	word ptr [bp+squareListP], ax
	mov	word ptr [bp+squareListP+2],	dx

	lfs	bx, [bp+squareListP]
	inc	word ptr [bp+squareListP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+functionCount],	ax
	mov	gs:mapRval, 0

l_loop:
	mov	ax, [bp+functionCount]
	dec	[bp+functionCount]
	or	ax, ax
	jz	l_returnRval

	lfs	bx, [bp+squareListP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+sqN], ax

	; Remove the high bit from the sqN value if a spell is cast. This is used
	; to convert values of FFh to 7Fh to pass the check at l_compareNorthCoordinate
	;
	cmp	[bp+spellFlag],	0
	jz	short l_compareNorthCoordinate
	xor	byte ptr [bp+sqN], 80h

l_compareNorthCoordinate:
	mov	al, fs:[bx+1]
	sub	ah, ah
	mov	[bp+sqE], ax

	cmp	[bp+sqN], 7Fh 			; A sqN value of 7Fh always succeeds
	jz	short l_compareEastCoordinate	
	mov	ax, [bp+sqN]
	cmp	sq_north, ax
	jnz	l_next

l_compareEastCoordinate:
	cmp	[bp+sqE], 0FFh			; A sqE value of FFh always succeeds
	jz	short l_getCodeAddress
	mov	ax, [bp+sqE]
	cmp	sq_east, ax
	jnz	l_next

l_getCodeAddress:
	mov	ax, word ptr [bp+squareListP]
	mov	dx, word ptr [bp+squareListP+2]
	add	ax, 2
	push	dx
	push	ax
	CALL(map_getDataOffsetP)
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx

l_getOpcode:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+opcode], ax
	cmp	ax, 0FFh
	jnz	short l_verifyOpcode
	mov	gs:breakAfterFunc, 0
	jmp	short l_checkReturn

l_verifyOpcode:
	mov	ax, [bp+opcode]
	and	ax, 80h
	mov	gs:breakAfterFunc, ax
	and	[bp+opcode], 7Fh
	cmp	[bp+opcode], 46h
	jbe	short l_executeOpcode
	PUSH_OFFSET(s_badOpcode)
	PRINTSTRING
	IOWAIT
	jmp	short l_return

l_executeOpcode:
	mov	bx, [bp+opcode]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr vm_functionList[bx]
	mov	dx, word ptr (vm_functionList+2)[bx]
	mov	word ptr gs:g_currentVmFunction, ax
	mov	word ptr gs:g_currentVmFunction+2, dx
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	call	gs:g_currentVmFunction
	add	sp, 4
	mov	word ptr [bp+dataP], ax
	mov	word ptr [bp+dataP+2], dx

l_checkReturn:
	cmp	gs:breakAfterFunc, 0
	jnz	l_getOpcode

	cmp	g_mapRval, 0
	jz	short l_next
	mov	ax, gs:mapRval
	jmp	short l_return

l_next:
	add	word ptr [bp+squareListP], 4
	jmp	l_loop

l_returnRval:
	mov	ax, gs:mapRval
	jmp	short $+2

l_return:
	mov	sp, bp
	pop	bp
	retf
vm_execute endp
