; Attributes: bp-based frame

_updateFlags proc far

	flagNumber=	word ptr -6
	flagMaskIndex=	word ptr -4
	flagMask=	word ptr -2
	flagData=	word ptr  6
	initialMask=	byte ptr  8

	FUNC_ENTER(6)

	mov	ax, [bp+flagData]
	mov	cl, 3
	shr	ax, cl
	mov	[bp+flagNumber], ax

	mov	ax, [bp+flagData]
	and	ax, 7
	mov	[bp+flagMaskIndex], ax

	mov	bx, [bp+flagNumber]
	mov	al, g_gameProgressFlags[bx]
	sub	ah, ah
	mov	bx, [bp+flagMaskIndex]
	mov	cl, flagMaskList[bx]
	sub	ch, ch
	and	ax, cx
	mov	[bp+flagMask], ax

	mov	al, byteMaskList[bx]
	and	al, [bp+initialMask]
	or	al, byte ptr [bp+flagMask]
	mov	bx, [bp+flagNumber]
	mov	g_gameProgressFlags[bx], al
	FUNC_EXIT
	retf
_updateFlags endp
