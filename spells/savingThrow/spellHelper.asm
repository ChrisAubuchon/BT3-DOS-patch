; Attributes: bp-based frame

spellSavingThrowHelper proc far

        spellCaster= word ptr  6

	FUNC_ENTER

        cmp     [bp+spellCaster], 80h
        jl      short l_partyCaster

        mov     gs:bat_curTarget, 0		; Saving throw target is first party slot
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	CALL(savingThrowCheck, near)
        or      ax, ax
        jnz     short l_firstCharFailedSave
        sub     ax, ax
        jmp     short l_return
l_firstCharFailedSave:
        cmp     gs:partySecondSlot._name, 0
        jnz     short l_secondCharExists
        mov     ax, 1
        jmp     short l_return
l_secondCharExists:
        mov     gs:bat_curTarget, 1
l_partyCaster:
        sub     ax, ax				; Saving throw type is 0 for spell
        push    ax
        push    [bp+spellCaster]
	CALL(savingThrowCheck, near)
l_return:
	FUNC_EXIT
        retf
spellSavingThrowHelper endp
