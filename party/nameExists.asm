; Returns the character	number of the character	name.
; Returns -1 if	there is no character by the provided
; name in the party
;
; DWORD - _offset & _segment
;

; Attributes: bp-based frame

party_nameExists	proc far

	loopCounter= word ptr	-2
	_offset= word ptr  6
	_segment= word ptr  8

	FUNC_ENTER
	CHKSTK(2)
	mov	[bp+loopCounter], 0
l_loopEntry:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+_segment]
	push	[bp+_offset]
	CALL(strcmp)
	or	ax, ax
	jz	l_returnValue
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	l_loopEntry
	mov	ax, 0FFFFh
	jmp	l_return
l_returnValue:
	mov	ax, [bp+loopCounter]
l_return:
	FUNC_EXIT
	retf
party_nameExists	endp
