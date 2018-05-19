; Returns the address of the new node
;
; Returns 0 on failure
;
huf_newNode proc near
	mov	ax, ds:huf_nodeListTail
	cmp	ax, 300h
	jge	short l_returnFail

	mov	bx, ax
	inc	ax
	mov	ds:huf_nodeListTail, ax
	mov	ax, bx
	shl	ax, 1
	shl	ax, 1
	add	ax, bx
	add	ax, (offset huf_treeData+5)
	mov	bx, ax
	mov	word ptr [bx], 0
	retn

l_returnFail:
	sub	ax, ax
	retn
huf_newNode endp
