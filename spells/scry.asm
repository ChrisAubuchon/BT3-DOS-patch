; Attributes: bp-based frame

; XXX - Not low hanging fruit
; DWORD - var_114 & var_116
; UNUSED - var_A & var_C

sp_scrySight proc far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	var_116= word ptr -116h
	var_114= word ptr -114h
	var_112= word ptr -112h
	var_110= dword ptr -110h
	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	FUNC_ENTER(11Ah)
	push	si

	mov	[bp+var_6], 0
	mov	word ptr [bp+var_110], offset g_rosterCharacterBuffer
	mov	word ptr [bp+var_110+2], seg seg022
	lfs	bx, [bp+var_110]
	mov	al, fs:(g_rosterCharacterBuffer+11h)[bx]
	sub	ah, ah
	mov	[bp+var_118], ax
	PUSH_OFFSET(s_youFace)
	PUSH_STACK_ADDRESS(var_10C)
	STRCAT
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	bx, g_direction
	shl	bx, 1
	shl	bx, 1
	push	word ptr (dirStringList+2)[bx]
	push	word ptr dirStringList[bx]
	push	dx
	push	ax
	STRCAT
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_118], 0
	jz	loc_218D5
loc_21840:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	PUSH_OFFSET(s_andAre)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_118]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	ITOA
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_118]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	PUSH_OFFSET(s_levels)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	al, g_levelFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	PUSH_OFFSET(s_aboveBelow)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_218D5:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, sq_north
	mov	[bp+var_2], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47EDC[bx]
	cbw
	mov	cx, [bp+var_2]
	sub	cx, ax
	mov	[bp+var_11A], cx
	or	cx, cx
	jz	loc_219BD
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	PUSH_OFFSET(s_andAre)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jl	short loc_21945
	mov	ax, [bp+var_11A]
	jmp	short loc_2194B
loc_21945:
	mov	ax, [bp+var_11A]
	neg	ax
loc_2194B:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	ITOA
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	PUSH_OFFSET(s_paces)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jge	short loc_2199D
	mov	ax, 1
	jmp	short loc_2199F
loc_2199D:
	sub	ax, ax
loc_2199F:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	PUSH_OFFSET(s_northSouth)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_219BD:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, sq_east
	mov	[bp+var_8], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47F1A[bx]
	cbw
	mov	cx, [bp+var_8]
	sub	cx, ax
	mov	[bp+var_4], cx
	or	cx, cx
	jnz	short loc_219F4
	jmp	loc_21AA0
loc_219F4:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	PUSH_OFFSET(s_andAre)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jl	short loc_21A2A
	mov	ax, [bp+var_4]
	jmp	short loc_21A2F
loc_21A2A:
	mov	ax, [bp+var_4]
	neg	ax
loc_21A2F:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	ITOA
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	PUSH_OFFSET(s_paces)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jge	short loc_21A80
	mov	ax, 1
	jmp	short loc_21A82
loc_21A80:
	sub	ax, ax
loc_21A82:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	PUSH_OFFSET(s_eastWest)
	PLURALIZE
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_21AA0:
	cmp	[bp+var_6], 0
	jz	short loc_21AAB
	mov	ax, offset s_of
	jmp	short loc_21AAE
loc_21AAB:
	mov	ax, offset s_andAreAt
loc_21AAE:
	mov	[bp+var_C], ax
	mov	[bp+var_A], ds
	push	ds
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	STRCAT
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	si, [bp+var_118]
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+si+12h]
	sub	ah, ah
	mov	[bp+var_112], ax
	mov	bx, ax
	mov	al, byte_47F58[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (scryBaseStringList+2)[bx]
	push	word ptr scryBaseStringList[bx]
	push	dx
	push	[bp+var_116]
	STRCAT
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	PRINTSTRING(true)
	IOWAIT

	pop	si
	FUNC_EXIT
	retf
sp_scrySight endp
