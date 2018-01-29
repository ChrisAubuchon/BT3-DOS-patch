; Attributes: bp-based frame

dunsq_antiMagic	proc far

	l_effectIndex= word ptr	-2

	FUNC_ENTER(2)

	inc	gs:sq_antiMagicFlag

	; Change to 1 to skip over lightDuration
	mov	[bp+l_effectIndex], 1
l_loop:
	mov	bx, [bp+l_effectIndex]
	cmp	lightDuration[bx], 0
	jz	short l_next
	push	[bp+l_effectIndex]
	CALL(icon_deactivate)

l_next:
	inc	[bp+l_effectIndex]
	cmp	[bp+l_effectIndex], 5
	jl	short l_loop


	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax
	FUNC_EXIT
	retf
dunsq_antiMagic	endp
