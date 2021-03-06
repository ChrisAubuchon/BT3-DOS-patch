; Attributes: bp-based frame

getYesNo proc far

	inputKey= word ptr	-6
	mouseOffset= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(6)
	push	di
	push	si

	CALL(txt_newLine, near)
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	si, ax
	mov	di, si
	shl	di, 1
	mov	ax, g_mouseLineMaskList[di+2]
	or	ax, g_mouseLineMaskList[di]
	mov	[bp+var_2], ax
	mov	[bp+mouseOffset], si
	PUSH_OFFSET(s_yesNo)
	PRINTSTRING
l_loopEntry:
	push	[bp+var_2]
	CALL(getKey)
	mov	[bp+inputKey], ax
	cmp	ax, 10Eh
	jl	short loc_14E0B
	cmp	ax, 119h
	jg	short loc_14E0B
	mov	ax, [bp+mouseOffset]
	sub	[bp+inputKey], ax

loc_14E0B:
	mov	ax, [bp+inputKey]
	cmp	ax, 'N'
	jz	short l_clearAndReturnZero
	cmp	ax, 'Y'	
	jz	short l_clearAndReturnOne
	cmp	ax, 10Eh
	jz	short l_clearAndReturnOne
	cmp	ax, 10Fh
	jz	short l_clearAndReturnZero
	jmp	short l_loopEntry

l_clearAndReturnOne:
	CALL(text_clear, near)
	mov	ax, 1
	jmp	short l_return

l_clearAndReturnZero:
	CALL(text_clear, near)
	sub	ax, ax
	jmp	short l_return

l_return:
	pop	si
	pop	di
	FUNC_EXIT
	retf
getYesNo endp

