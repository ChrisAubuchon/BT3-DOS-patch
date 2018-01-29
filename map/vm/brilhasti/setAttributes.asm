; Attributes: bp-based frame

brilhasti_setAttributes proc far

	attributeIndex= word ptr	-2
	attributeP= dword ptr  6
	attributeValue= word ptr	 0Ah

	FUNC_ENTER(2)
	push	si

	mov	[bp+attributeIndex], 0
l_loop:
	mov	bx, [bp+attributeIndex]
	lfs	si, [bp+attributeP]
	mov	al, fs:[bx+si]
	cbw
	cmp	ax, [bp+attributeValue]
	jge	short l_next
	mov	al, byte ptr [bp+attributeValue]
	mov	fs:[bx+si], al
l_next:
	inc	[bp+attributeIndex]
	cmp	[bp+attributeIndex], 5
	jl	short l_loop

	pop	si
	FUNC_EXIT
	retf
brilhasti_setAttributes endp
