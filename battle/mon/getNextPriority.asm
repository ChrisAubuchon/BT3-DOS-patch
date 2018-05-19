; This function	returns	the highest attack priority
; in the monster groups. The monster group and
; monster index	is returned in rGroup and rMon
; respectively.
; Attributes: bp-based frame

bat_monGetNextPriority proc far

	highMon= word ptr -0Ch
	monNo= word ptr	-0Ah
	groupNo= word ptr -8
	highPri= word ptr -6
	highGroup= word	ptr -4
	groupSize= word ptr	-2
	rGroup=	dword ptr  6
	rMon= dword ptr	 0Ah

	FUNC_ENTER(0Ch)
	push	si

	sub	ax, ax
	mov	[bp+highMon], ax
	mov	[bp+highGroup],	ax
	mov	[bp+highPri], ax
	mov	[bp+groupNo], ax

l_groupLoop:
	MONINDEX(ax, STACKVAR(groupNo), bx)
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Fh
	mov	[bp+groupSize], ax
	or	ax, ax
	jz	short l_groupLoopNext
	mov	[bp+monNo], 0

l_monsterLoop:
	mov	bx, [bp+groupNo]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+monNo]
	shl	ax, 1
	add	bx, ax
	mov	si, gs:bat_monPriorityList[bx]
	cmp	[bp+highPri], si
	jge	short l_monsterLoopNext
	mov	[bp+highPri], si
	mov	ax, [bp+groupNo]
	mov	[bp+highGroup],	ax
	mov	ax, [bp+monNo]
	mov	[bp+highMon], ax

l_monsterLoopNext:
	inc	[bp+monNo]
	mov	ax, [bp+groupSize]
	cmp	[bp+monNo], ax
	jl	short l_monsterLoop

l_groupLoopNext:
	inc	[bp+groupNo]
	cmp	[bp+groupNo], 4
	jl	short l_groupLoop

	lfs	bx, [bp+rGroup]
	mov	ax, [bp+highGroup]
	mov	fs:[bx], ax
	lfs	bx, [bp+rMon]
	mov	ax, [bp+highMon]
	mov	fs:[bx], ax
	mov	ax, [bp+highPri]

	pop	si
	FUNC_EXIT
	retf
bat_monGetNextPriority endp

