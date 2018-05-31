; Attributes: bp-based frame

bat_charIsBreathAttackable proc far
        partySlotNumber=        word ptr  6
        specialAttackIndex= word ptr  8

	FUNC_ENTER
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)

        cmp     byte ptr gs:party._name[bx], 0			; if partySlot.isEmpty
	jz	l_return_zero					;   return 0
	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)
        test    gs:party.status[bx], stat_dead or stat_stoned	; if !partySlot.isDead and !partySlot.isStoned
	jz	l_return_one					;   return 1

	CHARINDEX(ax, STACKVAR(partySlotNumber), bx)		; Character is either dead or stoned
        test    gs:party.status[bx], stat_stoned		; if partySlot.isStoned
	jnz	l_return_zero					;   return 0

								; Character is dead
        cmp     [bp+specialAttackIndex], speAtt_possess		; if specialAttackIndex != speAtt_possess
        jnz     short l_return_zero				;   return 0
l_return_one:
	mov	ax, 1
	jmp	l_return
l_return_zero:
        sub     ax, ax
l_return:
	FUNC_EXIT
        retf
bat_charIsBreathAttackable endp
