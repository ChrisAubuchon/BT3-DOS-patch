; Attributes: bp-based frame

_sp_useFigurine	proc far

	loopCounter= word ptr -4
	itemNo=	word ptr -2
	spellCaster=	word ptr  6

	FUNC_ENTER
	CHKSTK(4)

	PUSH_OFFSET(s_invokesFigurine)
	PRINTSTRING
	CHARINDEX(ax, STACKVAR(spellCaster), bx)
	mov	al, gs:g_usedItemSlotNumber
	sub	ah, ah
	add	bx, ax
	mov	al, gs:party.inventory.itemNo[bx]
	mov	[bp+itemNo], ax

	mov	[bp+loopCounter], 8
l_loopEnter:
	mov	bx, [bp+loopCounter]
	mov	al, figurineItemNo[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNo]
	jnz	short l_loopEnter
	mov	al, byte_483AC[bx]
	push	ax
	push	[bp+spellCaster]
	CALL(summon_execute)
	dec	[bp+loopCounter]
	cmp	[bp+loopCounter], 0
	jg	l_loopEnter

	FUNC_EXIT
	retf
_sp_useFigurine	endp
