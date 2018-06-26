; Attributes: bp-based frame

bat_partyRunAction proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)

	cmp	gs:songCanRun, 0
	jnz	short l_returnOne

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), bx)
	cmp	byte ptr gs:party._name[bx], 0
	jz	short l_next
	mov	ax, itemEff_alwaysRunAway
	push	ax
	push	[bp+loopCounter]
	CALL(character_isEffectEquipped)
	or	ax, ax
	jz	short l_returnOne
l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

	CALL(random)
	sub	ah, ah
	cmp	ax, 0C0h 
	jle	short l_returnOne

	sub	ax, ax
	mov	gs:g_runAwayFlag, al
	jmp	short l_return

l_returnOne:
	mov	gs:g_runAwayFlag, 1
	mov	ax, 1

l_return:
	FUNC_EXIT
	retf
bat_partyRunAction endp
