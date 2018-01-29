; Attributes: bp-based frame

cp_compareStrings proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	FUNC_ENTER(2)
	push	si

	mov	ax, [bp+arg_8]
	mov	[bp+var_2], ax
l_loop:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	al, fs:[bx]
	mov	bx, [bp+var_2]
	lfs	si, [bp+arg_4]
	cmp	fs:[bx+si], al
;	jnz	short l_returnFail		; Uncomment to enable copy protection
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short l_loop
	jmp	short l_returnSuccess

l_returnFail:
	sub	ax, ax
	jmp	short l_return

l_returnSuccess:
	mov	ax, 1

l_return:
	pop	si
	FUNC_EXIT
	retf
cp_compareStrings endp

