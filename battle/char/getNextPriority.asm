; This function	returns	the highest priority in	the
; party. The character number with the highest
; priority is returned via membuf.
; Attributes: bp-based frame

bat_charGetNextPriority proc far

	char= word ptr -6
	slotNumber=	word ptr -4
	highestPriority= word ptr -2
	membuf=	dword ptr  6

	FUNC_ENTER(6)
	push	si

	mov	[bp+highestPriority], 0
	mov	[bp+char], 0

	mov	[bp+slotNumber], 0
l_loop:
	mov	bx, [bp+slotNumber]
	mov	al, gs:g_battleCharacterPriorities[bx]
	sub	ah, ah
	mov	si, ax
	cmp	[bp+highestPriority], si
	jnb	short l_next
	mov	[bp+highestPriority], si
	mov	ax, bx
	mov	[bp+char], ax

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	lfs	bx, [bp+membuf]
	mov	ax, [bp+char]
	mov	fs:[bx], ax
	mov	ax, [bp+highestPriority]

	pop	si
	FUNC_EXIT
	retf
bat_charGetNextPriority endp
