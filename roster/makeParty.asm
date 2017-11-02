; Attributes: bp-based frame

; Create the party in the roster's party buffer
;
; DWORD - arg_2 & arg_4

roster_makeParty proc far

	var_6= word ptr	-6
	partyBufP= dword ptr -4
	partyIndexNumber= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah

	FUNC_ENTER
	CHKSTK(6)
	mov	ax, [bp+partyIndexNumber]
	mov	cl, 7
	shl	ax, cl
	add	ax, offset g_rosterPartyBuffer
	mov	word ptr [bp+partyBufP], ax
	mov	word ptr [bp+partyBufP+2], seg seg022
	lfs	bx, [bp+partyBufP]
	mov	byte ptr fs:[bx], '>'
	push	[bp+arg_4]
	push	[bp+arg_2]
	mov	ax, word ptr [bp+partyBufP]
	mov	dx, word ptr [bp+partyBufP+2]
	inc	ax
	push	dx
	push	ax
	CALL(_strcpy)
	mov	[bp+var_6], 0
	jmp	short loc_1333C
loc_13339:
	inc	[bp+var_6]
loc_1333C:
	cmp	[bp+var_6], 7
	jge	short loc_1336F
	CHARINDEX(ax, STACKVAR(var_6), bx)
	lea	ax, party._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	mov	ax, [bp+var_6]
	mov	cl, 4
	shl	ax, cl
	add	ax, word ptr [bp+partyBufP]
	mov	dx, word ptr [bp+partyBufP+2]
	add	ax, 10h
	push	dx
	push	ax
	CALL(_strcpy)
	jmp	short loc_13339
loc_1336F:
	FUNC_EXIT
	retf
roster_makeParty endp
