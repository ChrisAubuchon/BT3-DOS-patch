; This function	returns	the number of classes that
; a mage has learned a spell level as. This is used,
; for example, to ensure that a	mage has learned two
; classes before changing to a wizard.
; Attributes: bp-based frame

mage_countClassesGained	proc far

	classCount= word ptr -4
	loopCounter= word ptr -2
	slotNumber= word ptr	 6

	FUNC_ENTER(4)

	mov	[bp+classCount], 0
	mov	[bp+loopCounter], 0
l_loop:
	mov	ax, [bp+loopCounter]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	push	ax
	push	[bp+slotNumber]
	CALL(mage_hasBeenClass, near)
	or	ax, ax
	jz	short l_next
	inc	[bp+classCount]
	jmp	short l_loop

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 6
	jl	short l_loop

	mov	ax, [bp+classCount]
	FUNC_EXIT
	retf
mage_countClassesGained	endp
