; Attributes: bp-based frame

; Returns:
;   0 - saving throw succeeded
;   1 - saving throw failed
;   2 - saving throw failed badly
;

savingThrowCheck proc far

	targetSaveValue= word ptr	-6
	sourceSaveValue= word ptr	-4
	saveDifference= word ptr	-2
	saveSource= word ptr	 6
	saveType= word ptr	 8

	FUNC_ENTER(6)

	sub	ax, ax
	push	ax
	push	[bp+saveSource]
	CALL(savingThrow_calculate, near)
	mov	[bp+sourceSaveValue], ax

	mov	gs:g_debugSavingThrowValue, 0			; Doesnt seem to do anything

	push	[bp+saveType]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	CALL(savingThrow_calculate, near)
	mov	[bp+targetSaveValue], ax

	; Add a save bonus is the party target is in range of the diminished
	; effect attack
	;
	mov	al, gs:g_diminishingEffectSaveBonus
	sub	ah, ah
	add	ax, [bp+targetSaveValue]

	push	ax
	CALL(lib_maxFF, near)
	mov	[bp+targetSaveValue], ax
	mov	gs:g_diminishingEffectSaveBonus, 0
	mov	ax, [bp+sourceSaveValue]
	sub	ax, [bp+targetSaveValue]
	mov	[bp+saveDifference], ax
	or	ax, ax
	jge	short l_saveFailed
	sub	ax, ax
	jmp	short l_return
l_saveFailed:
	cmp	[bp+saveDifference], 4
	jle	short l_return_one
	mov	ax, 2
	jmp	short l_return
l_return_one:
	mov	ax, 1
l_return:
	FUNC_EXIT
	retf
savingThrowCheck endp
