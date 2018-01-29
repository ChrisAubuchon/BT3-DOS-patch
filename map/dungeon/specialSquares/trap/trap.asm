; Attributes: bp-based frame

dunsq_doTrap proc far

	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(10Ch)
	push	si

	CALL(trap_levitationCheck, near)
	mov	[bp+var_102], ax
	or	ax, ax
	jz	l_return

loc_24DCB:
	CALL(random)
	and	ax, 3
	mov	[bp+var_10A], ax
	cmp	ax, 3
	jz	short loc_24DCB

	mov	al, levelNoMaybe
	sub	ah, ah
	and	ax, 7
	shl	ax, 1
	shl	ax, 1
	or	ax, [bp+var_10A]
	mov	gs:trapIndex, ax
	PUSH_OFFSET(s_hitTrap)
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(strcat)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	bx, gs:trapIndex
	mov	al, g_trapIndexByLevel[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (trapTypeString+2)[bx]
	push	word ptr trapTypeString[bx]
	push	dx
	push	[bp+var_106]
	CALL(strcat)
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	mov	bx, gs:trapIndex
	mov	al, byte_4B258[bx]
	cbw
	push	ax
	CALL(dice_doYDX)
	mov	[bp+var_10C], ax

	mov	si, gs:trapIndex
	shl	si, 1
	mov	al, trapSaveList._low[si]
	mov	gs:monGroups.breathSaveLo, al
	mov	al, trapSaveList._high[si]
	mov	gs:monGroups.breathSaveHi, al

	mov	[bp+var_108], 0
loc_24E97:
	push	[bp+var_10C]
	push	[bp+var_108]
	CALL(trap_doDamage)
	inc	[bp+var_108]
	cmp	[bp+var_108], 7
	jl	short loc_24E97

l_return:
	mov	byte ptr g_printPartyFlag, 0
	sub	ax, ax
	push	ax
	push	sq_east
	push	sq_north
	CALL(spGeo_removeTrap)
	mov	ax, [bp+var_102]

	pop	si
	FUNC_EXIT
	retf
dunsq_doTrap endp
