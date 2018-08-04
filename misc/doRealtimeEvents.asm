; Attributes: bp-based frame

doRealtimeEvents proc far

	loopCounter= word ptr	-2

	FUNC_ENTER(2)
	push	si

	; Only update the animation when g_clockTicks has been updated.
	;
	mov	ax, gs:g_animationClockTimer
	cmp	g_clockTicks, ax
	jz	short l_checkPoisonTimer

	mov	ax, g_clockTicks
	mov	gs:g_animationClockTimer, ax
	CALL(gfx_animate)

l_checkPoisonTimer:
	mov	ax, g_clockTicks
	mov	cl, 5
	sar	ax, cl
	cmp	gs:g_twoSecondTimer, ax
	jz	short l_check15sTimer

	mov	gs:g_twoSecondTimer, ax
	mov	si, ax
	mov	cl, 4
	sar	si, cl

	cmp	gs:g_thirtySecondTimer, si
	jz	short l_check15sTimer
	mov	gs:g_thirtySecondTimer, si

	cmp	gs:advanceTimeFlag, 0
	jnz	short l_check15sTimer
	CALL(bat_partyApplyPoison)

l_check15sTimer:
	cmp	gs:advanceTimeFlag, 0
	jnz	l_checkTwoMinuteTimer

	mov	si, gs:g_twoSecondTimer
	mov	cl, 4
	sar	si, cl
	cmp	gs:g_fifteenSecondTimer, si
	jz	l_checkTwoMinuteTimer
	mov	gs:g_fifteenSecondTimer, si

	cmp	g_songDuration, 0		; Song timer
	jz	short l_checkIconTimers
	mov	al, g_songDuration
	dec	g_songDuration
	cmp	al, 1
	jnz	short l_checkIconTimers
	CALL(endNoncombatSong)

l_checkIconTimers:
	mov	ax, gs:g_iconAnimationTimer
	dec	gs:g_iconAnimationTimer
	cmp	ax, 1
	jg	short l_checkSpptRegenTimer
	mov	gs:g_iconAnimationTimer, 10
	mov	[bp+loopCounter], 0

l_iconLoopEntry:
	mov	bx, [bp+loopCounter]
	cmp	lightDuration[bx], 0
	jz	short l_iconLoopIncrement
	cmp	lightDuration[bx], 0FFh
	jz	short l_iconLoopIncrement
	mov	al, lightDuration[bx]
	dec	lightDuration[bx]
	cmp	al, 1
	jnz	short l_iconLoopIncrement
	push	[bp+loopCounter]
	CALL(icon_deactivate)
l_iconLoopIncrement:
	inc	[bp+loopCounter]

	cmp	[bp+loopCounter], 5
	jl	short l_iconLoopEntry

l_checkSpptRegenTimer:
	cmp	inDungeonMaybe, 0
	jnz	short l_checkOnRegenSquare

	cmp	gs:g_isNightFlag, 0
	jz	short l_applySpptRegen

l_checkOnRegenSquare:
	cmp	gs:regenSpptSq,	0
	jz	short l_applyEquipmentEffects

l_applySpptRegen:
	CALL(party_applySpptRegen)
	cmp	gs:g_songRegenerateSppt, 0
	jz	short l_applyEquipmentEffects
	CALL(party_applySpptRegen)

l_applyEquipmentEffects:
	CALL(party_applyEquipmentEffects)
	cmp	gs:g_squareHpRegenFlag, 0
	jz	l_unusedDrainHpCheck
	CALL(party_regenHp)

l_unusedDrainHpCheck:
	cmp	gs:g_unusedDrainHpFlag, 0
	jz	short l_checkTwoMinuteTimer

	CALL(dunsq_drainHp)

l_checkTwoMinuteTimer:
	mov	ax, gs:g_twoSecondTimer
	mov	cl, 6
	sar	ax, cl
	cmp	gs:g_twoMinuteTimer, ax
	jz	short l_return
	mov	gs:g_twoMinuteTimer, ax
	cmp	gs:advanceTimeFlag, 0
	jnz	short l_return

	mov	al, g_currentHour
	inc	g_currentHour
	cmp	al, 23
	jb	short l_checkTimeOfDayChange
	mov	g_currentHour, 0		; Set to midnight

l_checkTimeOfDayChange:
	cmp	g_currentHour, 6
	jb	short l_setIsNightToNight

	cmp	g_currentHour, 18
	jbe	short l_setIsNightToDay

l_setIsNightToNight:
	mov	al, 1
	jmp	short l_setIsNight

l_setIsNightToDay:
	sub	al, al

l_setIsNight:
	mov	gs:g_isNightFlag, al

l_return:
	pop	si
	FUNC_EXIT
	retf
doRealtimeEvents endp
