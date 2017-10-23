; The state of the 0x46 progress flag determines the items
; that are in the storage building.

; itemList is a string with all of the items in the storage building
; strcat'd together separated by 0
;
; itemListP is a list of pointers to the individual item strings;

; Attributes: bp-based frame

storage_createItemList proc far

	itemListLength= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	itemNumber= word ptr	-2
	itemList= dword ptr  6
	itemListP= dword ptr  0Ah
	arg_8= dword ptr  0Eh

	FUNC_ENTER
	CHKSTK(8)
	push	si

	mov	[bp+itemListLength], 0
	mov	ax, 46h	
	push	ax
	CALL(checkProgressFlags, 2)
	or	ax, ax
	jz	short l_flagNotSet
	mov	ax, 28
	jmp	short l_loopEntry
l_flagNotSet:
	mov	ax, 18

l_loopEntry:
	mov	[bp+var_6], ax
	mov	[bp+var_4], 0

l_loopHead:
	mov	bx, [bp+var_4]
	mov	ax, bx
	shl	bx, 1
	add	bx, ax
	mov	al, strg_inventory[bx]
	sub	ah, ah
	mov	[bp+itemNumber], ax
	or	ax, ax
	jz	short l_loopTest
	mov	bx, [bp+itemListLength]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+itemListP]
	mov	ax, word ptr [bp+itemList]
	mov	dx, word ptr [bp+itemList+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	mov	bx, [bp+itemNumber]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (itemStr+2)[bx]
	push	word ptr itemStr[bx]
	push	word ptr [bp+itemList+2]
	push	word ptr [bp+itemList]
	STRCAT(itemList)
	NULL_TERMINATE(STACKVAR(itemList))
	mov	bx, [bp+itemListLength]
	inc	[bp+itemListLength]
	shl	bx, 1
	lfs	si, [bp+arg_8]
	mov	ax, [bp+var_4]
	mov	fs:[bx+si], ax

l_loopTest:
	inc	[bp+var_4]
	mov	ax, [bp+var_6]
	cmp	[bp+var_4], ax
	jl	l_loopHead

l_return:
	mov	ax, [bp+itemListLength]
	jmp	short $+2
	pop	si
	mov	sp, bp
	pop	bp
	retf
storage_createItemList endp
