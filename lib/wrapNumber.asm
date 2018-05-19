; This function	returns	arg_0 mod to be between
; 0 and	arg_2. This handles negative numbers
; intuitively.
; Attributes: bp-based frame
wrapNumber proc	far

	arg_0= word ptr	 6
	arg_2= byte ptr	 8

	FUNC_ENTER
	push	si

loc_11673:
	cmp	[bp+arg_0], 0
	jge	short loc_11682
	mov	al, [bp+arg_2]
	cbw
	add	[bp+arg_0], ax
	jmp	short loc_11673

loc_11682:
	mov	al, [bp+arg_2]
	cbw
	mov	si, ax
	cmp	[bp+arg_0], si
	jl	short l_return
	sub	[bp+arg_0], si
	jmp	short loc_11682

l_return:
	mov	ax, [bp+arg_0]
	pop	si
	FUNC_EXIT
	retf
wrapNumber endp
