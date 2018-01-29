; This function	looks for a monster group that matches
; the summonData.name given by summonNo. It returns
; the matching group number. If	not found, it returns
; 0xffff
;
; Attributes: bp-based frame

summon_getMatchMonGroup proc far

	groupCounter= word ptr	-2
	summonNo= word ptr  6

	FUNC_ENTER(2)

	mov	[bp+groupCounter], 0
loc_2600B:
	MONINDEX(ax, STACKVAR(summonNo))
	add	ax, offset summonData
	push	ds
	push	ax
	MONINDEX(ax, STACKVAR(groupCounter), bx)
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	CALL(vm_strcmp)
	or	ax, ax
	jnz	l_returnValue
	inc	[bp+groupCounter]
	cmp	[bp+groupCounter], 4
	jl	short loc_2600B

l_returnValue:
	mov	ax, [bp+groupCounter]
	jmp	short l_return

l_returnFail:
	mov	ax, 0FFFFh

l_return:
	mov	sp, bp
	pop	bp
	retf
summon_getMatchMonGroup endp
