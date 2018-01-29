; This function	returns	0 if there is a	character
; in the party whose level is less than	the passed
; in level. If there is	not it returns 1.
; Attributes: bp-based frame

vm_partyUnderLevel proc far

	rval= word ptr -4
	slotNumber= word ptr -2
	level= word ptr	 6

	FUNC_ENTER(4)
	push	si

	mov	[bp+rval], 1
	mov	[bp+slotNumber], 0

l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	mov	ax, [bp+level]
	cmp	gs:party.level[si], ax
	jnb	short l_next
	mov	[bp+rval], 0
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	mov	ax, [bp+rval]
	pop	si
	FUNC_EXIT
	retf
vm_partyUnderLevel endp
