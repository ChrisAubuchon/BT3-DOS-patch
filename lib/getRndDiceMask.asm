; Attributes: bp-based frame

getRndDiceMask proc far

	var_2= word ptr	-2
	arg_1= byte ptr	 7

	FUNC_ENTER(2)
	push	si

	mov	[bp+arg_1], 0
	mov	[bp+var_2], 0
loc_1D2CF:
	cmp	[bp+var_2], 8
	jge	short loc_1D2F1
	mov	bx, [bp+var_2]
	mov	al, diceMaskList[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+6],	si
	ja	short loc_1D2EF
	jmp	short l_return
loc_1D2EF:
	inc	[bp+var_2]
	jmp	short loc_1D2CF
loc_1D2F1:
	PUSH_OFFSET(s_badDiceMaskRange)
	CALL(printMessageAndExit)

l_return:
	pop	si
	FUNC_EXIT
	retf
getRndDiceMask endp
