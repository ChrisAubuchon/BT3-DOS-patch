; Attributes: bp-based frame

doVictoryMaybe proc far

	var_A38= word ptr -0A38h
	var_A36= word ptr -0A36h
	var_266= word ptr -266h
	var_264= word ptr -264h
	var_262= word ptr -262h
	fd= word ptr -260h
	var_25E= word ptr -25Eh
	var_25C= word ptr -25Ch
	var_25A= word ptr -25Ah
	var_258= word ptr -258h
	var_256= word ptr -256h

	FUNC_ENTER
	CHKSTK(0A38h)
	push	si

	mov	[bp+var_262], 0
loc_16745:
	push	[bp+var_262]
	CALL(sub_17920, 2)
	inc	[bp+var_262]
	cmp	[bp+var_262], 5
	jl	short loc_16745

loc_1675E:
	mov	gs:byte_422A0, 0
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	CALL(_mallocMaybe, 4)
	mov	[bp+var_25E], ax
	mov	[bp+var_25C], dx

loc_1677F:
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_victory)
	CALL(openFile, 6)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_167BC

	PUSH_OFFSET(s_insertDisk)		; Change disks if necessary
	PRINTSTRING
	push	dseg_0
	push	disk1
	PRINTSTRING
	IOWAIT

loc_167BC:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1677F
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fd]
	CALL(_read, 0Ah)
	push	[bp+fd]
	CLOSE

	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(d3comp, 8)

	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, [bp+var_25E]
	mov	dx, [bp+var_25C]
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	IOWAIT
	mov	[bp+var_25A], 0

	jmp	short loc_16836
loc_16832:
	inc	[bp+var_25A]
loc_16836:
	cmp	[bp+var_25A], 5
	jge	loc_1690F
loc_16840:
	PUSH_STACK_ADDRESS(var_258)
	PUSH_STACK_ADDRESS(var_A36)
	mov	bx, [bp+var_25A]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (victoryMessageList+2)[bx]
	push	word ptr victoryMessageList[bx]
	NEAR_CALL(text_wrapLongString, 0Ch)
	mov	[bp+var_A38], ax

	mov	[bp+var_262], 0FFF8h
	jmp	short loc_16879
loc_16875:
	inc	[bp+var_262]
loc_16879:
	mov	ax, [bp+var_A38]
	sub	ax, 4
	cmp	ax, [bp+var_262]
	jle	loc_16832

	mov	ax, 0Bh
	push	ax
	mov	ax, 0BEh 
	push	ax
	mov	ax, 0A1h 
	push	ax
	mov	ax, 7Eh	
	push	ax
	mov	ax, 0Ah
	push	ax
	call	far ptr	sub_3E96B
	add	sp, 0Ah
	mov	[bp+var_264], 0

loc_168AD:
	mov	ax, [bp+var_264]
	add	ax, [bp+var_262]
	mov	[bp+var_266], ax
	or	ax, ax
	jl	short loc_168FC
	mov	ax, [bp+var_A38]
	cmp	[bp+var_266], ax
	jge	short loc_168FC
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_264]
	mov	cl, 3
	shl	ax, cl
	add	ax, 7Eh	
	push	ax
	mov	ax, 0Dh
	push	ax
	mov	si, [bp+var_266]
	shl	si, 1
	shl	si, 1
	push	[bp+si+var_256]
	push	[bp+si+var_258]
	NEAR_CALL(sub_16F1E, 0Ah)
loc_168FC:
	inc	[bp+var_264]
	cmp	[bp+var_264], 8
	jl	short loc_168AD

loc_168FE:
	mov	ax, 2
	push	ax
	NEAR_CALL(timedGetKey, 2)
	jmp	loc_16875

loc_1690F:
	sub	ax, ax
	push	ax
	PUSH_OFFSET(s_bardscr)
	CALL(openFile, 6)
	mov	[bp+fd], ax
	inc	ax
	jnz	short loc_1694C

	PUSH_OFFSET(s_insertDisk)
	PRINTSTRING
	push	dseg_0
	push	disk1
	PRINTSTRING
	mov	ax, 0FFFFh
	push	ax
	NEAR_CALL(timedGetKey, 2)

loc_1694C:
	cmp	[bp+fd], 0FFFFh
	jz	short loc_1690F
	mov	ax, 80E8h
	sub	dx, dx
	push	dx
	push	ax
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	push	[bp+fd]
	CALL(_read, 0Ah)
	push	[bp+fd]
	CLOSE
	push	[bp+var_25C]
	push	[bp+var_25E]
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	CALL(d3comp, 8)
	mov	ax, offset g_rosterCharacterBuffer
	mov	dx, seg	seg022
	push	dx
	push	ax
	mov	ax, [bp+var_25E]
	mov	dx, [bp+var_25C]
	add	ax, 0Dh
	push	dx
	push	ax
	call	far ptr	sub_3E97D
	add	sp, 8
	push	[bp+var_25C]
	push	[bp+var_25E]
	CALL(_freeMaybe, 4)
	CALL(sub_116CC)
	mov	buildingRvalMaybe, 1

	pop	si
	mov	sp, bp
	pop	bp
	retf
doVictoryMaybe endp
