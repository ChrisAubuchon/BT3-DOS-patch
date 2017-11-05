; DWORD - var_108 & var_10A, var_10E & var_10C
; Attributes: bp-based frame

printLocation proc far

	pacesNorth= word ptr -126h
	unmaskedLocationName= word ptr -124h
	var_110= word ptr -110h
	var_10E= word ptr -10Eh
	var_10C= word ptr -10Ch
	var_10A= word ptr -10Ah
	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	pacesEast= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(126h)

	mov	[bp+var_10E], offset g_rosterCharacterBuffer
	mov	[bp+var_10C], seg seg022
	PUSH_OFFSET(s_youreIn)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	cmp	currentLocationMaybe, 0
	jnz	short l_skipThe

	PUSH_OFFSET(s_the)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

l_skipThe:
	PUSH_STACK_ADDRESS(unmaskedLocationName)
	push	[bp+var_10C]
	push	[bp+var_10E]
	CALL(unmaskString)

	PUSH_STACK_ADDRESS(unmaskedLocationName)
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	mov	bx, currentLocationMaybe
	mov	al, byte_428A6[bx]
	cbw
	mov	cx, sq_north
	sub	cx, ax
	mov	[bp+pacesNorth], cx
	or	cx, cx
	jz	loc_121CD

	PUSH_OFFSET(s_spAndsp)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+pacesNorth], 0
	jge	short loc_1216A

	mov	ax, [bp+pacesNorth]
	neg	ax
	mov	[bp+pacesNorth], ax
	mov	[bp+var_106], 1
	jmp	short loc_12170
loc_1216A:
	mov	[bp+var_106], 0
loc_12170:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesNorth]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	CALL(itoa)
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

	mov	ax, [bp+pacesNorth]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	PUSH_OFFSET(s_paces)
	PLURALIZE

	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	PUSH_OFFSET(s_northSouth)
	PLURALIZE
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx

loc_121CD:
	mov	bx, currentLocationMaybe
	mov	al, byte_428B0[bx]
	cbw
	mov	cx, sq_east
	sub	cx, ax
	mov	[bp+pacesEast], cx
	or	cx, cx
	jz	loc_1228A

	PUSH_OFFSET(s_spAndsp)
	push	[bp+var_108]
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	cmp	[bp+pacesEast], 0
	jge	short loc_12227
	mov	ax, [bp+pacesEast]
	neg	ax
	mov	[bp+pacesEast], ax
	mov	[bp+var_106], 1
	jmp	short loc_1222D
loc_12227:
	mov	[bp+var_106], 0
loc_1222D:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesEast]
	cwd
	push	dx
	push	ax
	push	[bp+var_108]
	push	[bp+var_10A]
	ITOA
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	ax, [bp+pacesEast]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_10A]
	PUSH_OFFSET(s_paces)
	PLURALIZE
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	push	[bp+var_106]
	push	dx
	push	ax
	PUSH_OFFSET(s_eastWest)
	PLURALIZE
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
loc_1228A:
	mov	bx, currentLocationMaybe
	mov	al, byte_428BA[bx]
	cbw
	mov	[bp+var_110], ax
	mov	bl, g_currentHour
	sub	bh, bh
	mov	al, byte_428C4[bx]
	cbw
	mov	[bp+var_104], ax
	mov	ax, [bp+pacesEast]
	or	ax, [bp+pacesNorth]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_108]
	push	[bp+var_10A]
	PUSH_OFFSET(s_ofAtThe)
	PLURALIZE
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_110]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (locationString+2)[bx]
	push	word ptr locationString[bx]
	push	dx
	push	ax
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_OFFSET(s_itsNow)
	push	dx
	push	[bp+var_10A]
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	mov	bx, [bp+var_104]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (timeOfDay+2)[bx]
	push	word ptr timeOfDay[bx]
	push	dx
	push	ax
	STRCAT
	mov	[bp+var_10A], ax
	mov	[bp+var_108], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	IOWAIT

	FUNC_EXIT
	retf
printLocation endp
