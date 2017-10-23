; This function	returns	the index of the character
; in the saved character list matching "name". If the
; name is not found it returns 0xffff
; Attributes: bp-based frame

roster_nameExists proc far

	counter= word ptr -2
	nameOffset= word ptr  6
	nameString= word ptr  8

	FUNC_ENTER
	CHKSTK(2)
	mov	[bp+counter], 0
l_loopEntry:
	CHARINDEX(ax, STACKVAR(counter), bx)
	lea	ax, g_rosterCharacterBuffer[bx]
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+nameString]
	push	[bp+nameOffset]
	STRCMP
	or	ax, ax
	jz	short l_returnValue
	inc	[bp+counter]
	cmp	[bp+counter], 75
	jl	short l_loopEntry
	mov	ax, 0FFFFh
	jmp	short l_return

l_returnValue:
	mov	ax, [bp+counter]
l_return:
	FUNC_EXIT
	retf
roster_nameExists endp

