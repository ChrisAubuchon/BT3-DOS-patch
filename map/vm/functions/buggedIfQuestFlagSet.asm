; Attributes: bp-based frame
;
; This function searches the party to see if a particular
; chronomancer quest flag bit is set. If the quest flag bit
; is set, then the rval local variable is set to 1. Otherwise, the
; rval variable is set to 0
;
; The bug is caused by the call to quest_partyHasFlagSet. That function
; performs the same function as this one. In fact, this entire function
; could be replaced with:
;
;	FUNC_ENTER
;	lfs	bx, [bp+dataP]
;	mov	al, fs:[bx]
;	sub	ah, ah
;	push	ax
;	CALL(quest_partyHasFlagSet, near)
;	push	ax
;	push	word ptr [bp+dataP+2]
;	push	word ptr [bp+dataP]
;	FUNC_EXIT
;
; quest_partyHasFlagSet is called with either a 0 or 1 when it SHOULD be called
; by the questData byte from the level.
;
; I've replaced the call to this function in the vm_functionList list with a call to
; mfunc_notImplemented. From my decompiling of the levels, this opcode (3d) is never
; called so it should be safe to do this.

mfunc_buggedIfQuestFlagSet proc far

	questByteNumber= word ptr	-8
	questMaskIndex= word ptr	-6
	rval= word ptr	-4
	slotNumber= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(8)
	lfs	bx, [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	and	ax, 7
	mov	[bp+questMaskIndex], ax

	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	cl, 3
	shr	ax, cl
	mov	[bp+questByteNumber], ax

	mov	[bp+rval], 0
	mov	[bp+slotNumber], 0
l_loop:
	CHARINDEX(ax, STACKVAR(slotNumber), bx)
	add	bx, [bp+questByteNumber]
	mov	al, gs:party.chronoQuest[bx]
	sub	ah, ah
	mov	bx, [bp+questMaskIndex]
	mov	cl, g_byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short l_next
	mov	[bp+rval], 1
	jmp	short l_return

l_next:
	inc	[bp+slotNumber]
	cmp	[bp+slotNumber], 7
	jl	short l_loop

l_return:
	push	[bp+rval]
	CALL(quest_partyHasFlagSet, near)
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_buggedIfQuestFlagSet endp
