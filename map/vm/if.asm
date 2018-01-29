; This function	is the mechanism behind	an if-then
; clause in the	code.
; Attributes: bp-based frame

mapvm_if	proc far

	memOff=	word ptr  6
	memSeg=	word ptr  8
	rval= word ptr	0Ah

	FUNC_ENTER

	cmp	[bp+rval], 0
	jz	short loc_1926C

	cmp	gs:breakAfterFunc, 0
	jz	short loc_1925F

	push	[bp+memSeg]
	push	[bp+memOff]
	CALL(map_getDataOffsetP)
	mov	[bp+memOff], ax
	mov	[bp+memSeg], dx
	jmp	short l_return

loc_1925F:
	mov	gs:breakAfterFunc, 1
	jmp	short l_return

loc_1926C:
	cmp	gs:breakAfterFunc, 0
	jz	short l_return
	add	[bp+memOff], 2

l_return:
	mov	ax, [bp+memOff]
	mov	dx, [bp+memSeg]
	FUNC_EXIT
	retf
mapvm_if	endp
