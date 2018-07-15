; Attributes: bp-based frame

_sp_useFigurine	proc far

	loopCounter= word ptr -4
	itemNo=	word ptr -2
	spellCaster=	word ptr  6

	FUNC_ENTER(4)

	PRINTOFFSET(s_invokesFigurine)
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	mov	[bp+itemNo], ax

	mov	[bp+loopCounter], 8
l_loopEnter:
	mov	bx, [bp+loopCounter]
	mov	al, g_figurineItemList[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNo]
	jnz	short l_loopNext
	mov	al, g_figurineSummonList[bx]
	push	ax
	push	[bp+spellCaster]
	CALL(summon_execute)

l_loopNext:
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jge	l_loopEnter

	FUNC_EXIT
	retf
_sp_useFigurine	endp
