; Attributes: bp-based frame

readSlotNumber proc far

	inputKey= word ptr	-2

	FUNC_ENTER
	CHKSTK

l_loopEntry:
	mov	ax, 2000h
	push	ax
	GETKEY
	mov	[bp+inputKey], ax
	cmp	ax, dosKeys_ESC
	jz	l_returnMinusOne
	cmp	[bp+inputKey], '0'
	jle	short l_loopEntry
	cmp	[bp+inputKey], '8'
	jge	short l_loopEntry
	sub	[bp+inputKey], '1'	
	CHARINDEX(ax, STACKVAR(inputKey), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_loopEntry
	mov	ax, [bp+inputKey]
	jmp	short l_return
l_returnMinusOne:
	mov ax, 0FFFFh
l_return:
	FUNC_EXIT
	retf
readSlotNumber endp
