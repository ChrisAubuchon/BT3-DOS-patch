; Attributes: bp-based frame

printLocation proc far

	pacesNorth= word ptr -126h
	unmaskedLocationName= word ptr -124h
	entranceIndex= word ptr -110h
	levelP= dword ptr -10Eh
	stringBufferP= dword ptr -10Ah
	nsPluralFlag= word ptr -106h
	timeIndex= word ptr -104h
	pacesEast= word ptr -102h
	stringBuffer= word ptr -100h

	FUNC_ENTER(126h)

	mov	[bp+levelP], offset g_rosterCharacterBuffer
	mov	[bp+levelP+2], seg seg022
	PUSH_OFFSET(s_youreIn)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT(stringBufferP)

	cmp	g_locationNumber, 0
	jnz	short l_skipThe

	PUSH_OFFSET(s_the)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

l_skipThe:
	PUSH_STACK_ADDRESS(unmaskedLocationName)
	PUSH_STACK_DWORD(levelP)
	CALL(unmaskString)

	PUSH_STACK_ADDRESS(unmaskedLocationName)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)

	mov	bx, g_locationNumber
	mov	al, g_locationDeltaNorth[bx]
	cbw
	mov	cx, g_sqNorth
	sub	cx, ax
	mov	[bp+pacesNorth], cx
	or	cx, cx
	jz	loc_121CD

	PUSH_OFFSET(s_spAndsp)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	cmp	[bp+pacesNorth], 0
	jge	short loc_1216A

	mov	ax, [bp+pacesNorth]
	neg	ax
	mov	[bp+pacesNorth], ax
	mov	[bp+nsPluralFlag], 1
	jmp	short loc_12170
loc_1216A:
	mov	[bp+nsPluralFlag], 0
loc_12170:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesNorth]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)

	mov	ax, [bp+pacesNorth]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_paces)
	PLURALIZE(stringBufferP)

	push	[bp+nsPluralFlag]
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_northSouth)
	PLURALIZE(stringBufferP)

loc_121CD:
	mov	bx, g_locationNumber
	mov	al, g_locationDeltaEast[bx]
	cbw
	mov	cx, g_sqEast
	sub	cx, ax
	mov	[bp+pacesEast], cx
	or	cx, cx
	jz	loc_1228A

	PUSH_OFFSET(s_spAndsp)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	cmp	[bp+pacesEast], 0
	jge	short loc_12227
	mov	ax, [bp+pacesEast]
	neg	ax
	mov	[bp+pacesEast], ax
	mov	[bp+nsPluralFlag], 1
	jmp	short loc_1222D
loc_12227:
	mov	[bp+nsPluralFlag], 0
loc_1222D:
	sub	ax, ax
	push	ax
	mov	ax, [bp+pacesEast]
	cwd
	push	dx
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	ITOA(stringBufferP)
	mov	ax, [bp+pacesEast]
	dec	ax
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_paces)
	PLURALIZE(stringBufferP)

	push	[bp+nsPluralFlag]
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_eastWest)
	PLURALIZE(stringBufferP)
loc_1228A:
	mov	bx, g_locationNumber
	mov	al, g_locationReferenceMap[bx]
	cbw
	mov	[bp+entranceIndex], ax

	mov	bl, g_currentHour
	sub	bh, bh
	mov	al, g_locationTimeMap[bx]
	cbw
	mov	[bp+timeIndex], ax

	mov	ax, [bp+pacesEast]
	or	ax, [bp+pacesNorth]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_ofAtThe)
	PLURALIZE(stringBufferP)
	mov	bx, [bp+entranceIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_locationStrings+2)[bx]
	push	word ptr g_locationStrings[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_OFFSET(s_itsNow)
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	mov	bx, [bp+timeIndex]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (g_timeOfDayList+2)[bx]
	push	word ptr g_timeOfDayList[bx]
	PUSH_STACK_DWORD(stringBufferP)
	STRCAT(stringBufferP)
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING(true)
	IOWAIT

	FUNC_EXIT
	retf
printLocation endp
