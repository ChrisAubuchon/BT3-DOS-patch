; Attributes: bp-based frame

mfunc_utility proc far

	dataP= dword ptr  6

	FUNC_ENTER

	lfs	bx, [bp+dataP]
	inc	word ptr [bp+dataP]
	mov	al, fs:[bx]
	sub	ah, ah
	cmp	ax, 3
	jz	short l_geomancer_convert
	cmp	ax, 4
	jz	short l_doScrySite
	cmp	ax, 5
	jz	short l_doVictory
	cmp	ax, 9
	jz	short l_copyProtection
	jmp	short l_notImplemented

l_geomancer_convert:
	mov	al, gs:g_userSlotNumber
	sub	ah, ah
	push	ax
	CALL(geomancer_convert, far)
	jmp	short l_returnSuccess

l_doScrySite:
	cmp	inDungeonMaybe, 0
	jz	short l_printLocation
	CALL(brilhasti_doBonus)
	jmp	short l_returnSuccess
l_printLocation:
	CALL(printLocation)
	jmp	short l_returnSuccess

l_doVictory:
	CALL(doVictoryMaybe)
	jmp	short l_returnSuccess

l_copyProtection:
	CALL(copyProtection)
	mov	gs:breakAfterFunc, ax
	jmp	short l_returnSuccess

l_notImplemented:
	push	word ptr [bp+dataP+2]
	push	word ptr [bp+dataP]
	CALL(mfunc_notImplemented, near)
	jmp	short l_return

l_returnSuccess:
	mov	ax, word ptr [bp+dataP]
	mov	dx, word ptr [bp+dataP+2]

l_return:
	mov	sp, bp
	pop	bp
	retf
mfunc_utility endp
