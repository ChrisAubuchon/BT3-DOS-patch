; This function counts the digits in arg_0
;
; Attributes: bp-based frame

_itoa_countDigits proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_2], 0
	jge	short loc_1619D
	mov	[bp+var_2], 2
	jmp	short loc_161A2
loc_1619D:
	mov	[bp+var_2], 1
loc_161A2:
	jmp	short loc_161A7
loc_161A4:
	inc	[bp+var_2]
loc_161A7:
	mov	ax, 0Ah
	cwd
	push	dx
	push	ax
	lea	ax, [bp+arg_0]
	push	ax
	call	_32bitDivide
	or	dx, ax
	jnz	short loc_161A4
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_itoa_countDigits endp

