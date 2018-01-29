; Attributes: bp-based frame

mfunc_ifInBox proc far

	sqE= word ptr	-0Ch
	sqN= word ptr	-0Ah
	northLowerBound= word ptr	-8
	eastLowerBound= word ptr	-6
	northUpperBound= word ptr	-4
	eastUpperBound= word ptr	-2
	dataP= dword ptr  6

	FUNC_ENTER(0Ch)
	push	si

	mov	ax, sq_north
	mov	[bp+sqN], ax
	mov	ax, sq_east
	mov	[bp+sqE], ax
	cmp	inDungeonMaybe, 0
	jnz	short l_skipWildernessOffset
	mov	si, g_direction
	shl	si, 1
	mov	ax, dirDeltaN[si]
	sub	[bp+sqN], ax
	mov	ax, dirDeltaE[si]
	add	[bp+sqE], ax
l_skipWildernessOffset:
	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	mov	[bp+northLowerBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+eastLowerBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+northUpperBound], ax

	mov	bx, word ptr [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	mov	[bp+eastUpperBound], ax

	mov	ax, [bp+northLowerBound]
	cmp	[bp+sqN], ax
	jl	short l_returnZero

	mov	ax, [bp+northUpperBound]
	cmp	[bp+sqN], ax
	jg	short l_returnZero

	mov	ax, [bp+eastLowerBound]
	cmp	[bp+sqE], ax
	jl	short l_returnZero

	mov	ax, [bp+eastUpperBound]
	cmp	[bp+sqE], ax
	jg	short l_returnZero

	mov	ax, 1
	jmp	short l_return
l_returnZero:
	sub	ax, ax
l_return:
	push	ax
	push	fs
	push	word ptr [bp+dataP]
	CALL(mapvm_if, near)
	pop	si
	FUNC_EXIT
	retf
mfunc_ifInBox endp
