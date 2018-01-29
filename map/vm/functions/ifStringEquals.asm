; Attributes: bp-based frame

mfunc_ifStringEquals proc far

	rval= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(2)
	mov	ax, offset mfunc_ioBuf
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(vm_strcmp, near)
	mov	[bp+rval], ax

l_skipString:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	cmp	byte ptr fs:[bx], 0FFh
	jnz	short l_skipString

	push	[bp+rval]
	push	fs
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	FUNC_EXIT
	retf
mfunc_ifStringEquals endp
