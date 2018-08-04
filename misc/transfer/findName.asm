; Only used when attempting to transfer a party. Since a party
; definition can have names that don't exist in the thieves.inf
; file, this function searches the thieves.inf for the given
; name.
;
; Attributes: bp-based frame

transfer_findName proc far

	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	FUNC_ENTER(2)
	mov	[bp+var_2], 0

l_loop:
	CHARINDEX(ax, STACKVAR(var_2))
	add	ax, word ptr [bp+arg_4]
	mov	dx, word ptr [bp+arg_4+2]
	push	dx
	push	ax
	PUSH_STACK_DWORD(arg_0)
	CALL(strcmp)
	or	ax, ax
	jz	short l_returnValue
	inc	[bp+var_2]
	cmp	[bp+var_2], 75
	jge	short l_returnFailed
	jmp	short l_loop

l_returnValue:
	mov	ax, [bp+var_2]
	jmp	short l_return

l_returnFailed:
	mov	ax, 0FFFFh

l_return:
	FUNC_EXIT
	retf
transfer_findName endp
