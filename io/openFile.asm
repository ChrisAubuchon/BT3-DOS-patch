; Attributes: bp-based frame

; DWORD - arg_0 & arg_2

openFile proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	FUNC_ENTER(2)

loc_14D40:
	mov	ax, 2
	push	ax
	push	[bp+arg_2]
	push	[bp+arg_0]
	CALL(open)
	mov	[bp+var_2], ax
	inc	ax
	jnz	short loc_14D81
	mov	ax, offset s_insertDisk
	mov	dx, seg	dseg
	push	dx
	push	ax
	PRINTSTRING
	PUSH_OFFSET(s_diskTwo)
	PRINTSTRING
	IOWAIT
loc_14D81:
	cmp	[bp+var_2], 0FFFFh
	jz	short loc_14D40
	mov	ax, [bp+var_2]

	FUNC_EXIT
	retf
openFile endp
