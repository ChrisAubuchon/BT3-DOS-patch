; Attributes: bp-based frame

; DWORD - var_2 & var_4

sp_meleeMen proc far

	stringBuffer=	word ptr -56h
	var_4= word ptr	-4
	var_2= word ptr	-2
	spellCaster= word ptr	 6

	FUNC_ENTER
	CHKSTK(56h)

	push	[bp+spellCaster]
	NEAR_CALL(spellSavingThrowHelper,2)
	or	ax, ax
	jz	short l_return

	test	byte ptr [bp+spellCaster], 80h
	jz	short l_partyCaster
	mov	ax, 1
	push	ax
	mov	ax, [bp+spellCaster]
	and	ax, 3
	push	ax
	NEAR_CALL(_sp_setMonDistance,4)
	jmp	short l_printMessage
l_partyCaster:
	mov	ax, 1
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	push	ax
	NEAR_CALL(_sp_setMonDistance, 4)
l_printMessage:
	PUSH_OFFSET(s_andTheFoesAre)
	PUSH_STACK_ADDRESS(stringBuffer)
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	PUSH_OFFSET(s_closer)
	push	ax
	push	dx
	push	[bp+var_4]
	STRCAT
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
l_return:
	mov	sp, bp
	pop	bp
	retf
sp_meleeMen endp
