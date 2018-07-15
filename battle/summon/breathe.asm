; Attributes: bp-based frame

bat_summonBreathAttack proc far

	stringBufferP = dword ptr -118h
	stringBuffer = word ptr -114h
	argP= dword ptr	-14h
	counter= word ptr -10h
	argList= byte ptr -0Ch
	var_A= byte ptr -0Ah
	var_8= byte ptr -8
	slotP= dword ptr -4
	slotNumber=	word ptr  6
	damage=	byte ptr  8

	FUNC_ENTER(114h)
	push	di
	push	si

	; Get the breather's name
	push	[bp+slotNumber]
	PUSH_STACK_ADDRESS(stringBuffer)
	CALL(bat_getAttackerName, near)
	SAVE_STACK_DWORD(dx, ax, stringBufferP)

	CHARINDEX(ax, STACKVAR(slotNumber))
	add	ax, offset party
	mov	word ptr [bp+slotP], ax
	mov	word ptr [bp+slotP+2], seg seg027

	lfs	bx, [bp+slotP]
	cmp	fs:[bx+summonStat_t.hostileFlag], 0
	jz	short l_targetEnemy

	mov	ax, 7
	push	ax
	CALL(bat_getRandomChar, near)
	jmp	short l_targetSet

l_targetEnemy:
	mov	al, 80h

l_targetSet:
	mov	gs:bat_curTarget, al
	lea	ax, [bp+argList]
	mov	word ptr [bp+argP], ax
	mov	word ptr [bp+argP+2], ss

	mov	[bp+counter], 0
l_setAttackDataLoop:
	mov	bx, [bp+counter]
	mov	al, byte ptr breathAttack.specialAttack[bx]
	lfs	si, [bp+argP]
	mov	fs:[bx+si], al
	inc	[bp+counter]
	cmp	[bp+counter], 7
	jl	short l_setAttackDataLoop

	lfs	bx, [bp+slotP]
	mov	al, fs:[bx+summonStat_t.breathFlag]
	mov	[bp+var_A], al

	; Add the fire/breath string
	sub	ah, ah
	xor	al, 0Ah
	push	ax
	PUSH_STACK_DWORD(stringBufferP)
	PUSH_OFFSET(s_firesBreathes)
	PLURALIZE(stringBufferP)

	; NULL terminate the string
	NULL_TERMINATE(STACKVAR(stringBufferP))

	PUSH_STACK_ADDRESS(stringBuffer)
	PRINTSTRING
	
	mov	al, [bp+damage]
	mov	[bp+var_8], al

	lfs	bx, [bp+slotP]
	mov	al, fs:[bx+summonStat_t.breathRange]
	sub	ah, ah
	push	ax
	sub	sp, 8
	lea	si, [bp+argList]
	mov	di, sp
	push	ss
	pop	es
	movsw
	movsw
	movsw
	movsb
	push	[bp+slotNumber]
	CALL(bat_doBreathAttack)

	pop	si
	pop	di
	FUNC_EXIT
	retf
bat_summonBreathAttack endp
