; Attributes: bp-based frame

openFile proc far

	var_2= word ptr	-2
	arg_0= dword ptr	 6

	FUNC_ENTER(2)

loc_14D40:
	mov	ax, 2
	push	ax
	PUSH_STACK_DWORD(arg_0)
	CALL(open)
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_14D81
	mov	ax, offset s_insertDisk
	mov	dx, seg	dseg
	push	dx
	push	ax
	PRINTSTRING
	PRINTOFFSET(s_diskTwo)
	IOWAIT

loc_14D81:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_14D40
	mov	ax, [bp+var_2]

	FUNC_EXIT
	retf
openFile endp
