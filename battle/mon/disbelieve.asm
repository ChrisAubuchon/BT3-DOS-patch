; Attributes: bp-based frame

bat_monDisbelieve proc far

	loopCounter=	word ptr -2

	FUNC_ENTER(2)
	push	si

	mov	[bp+loopCounter], 0
l_loop:
	CHARINDEX(ax, STACKVAR(loopCounter), si)
	cmp	byte ptr gs:party._name[si], 0
	jz	short l_next
	cmp	gs:party.class[si], class_illusion
	jnz	short l_next

	; XXX - There are two things that I think are wrong
	; 	about this check.
	;
	;	1. It uses the character in slot 0 for the saving throw check.
	;	   It almost certainly should use the illusions slot number. Probably
	;	   a holdover from BT1 where all summons were in slot 0.
	;
	;	2. By using the character slot as the source and the first monster group
	;	   as the target, the savingThrowCheck function returns 0 if the party's
	;	   saving throw check is LOWER than the monster groups. The party is should
	;	   be the target and the monster group the source. An easy fix would be to
	;	   change the jz to jnz.
	mov	gs:bat_curTarget, 80h
	sub	ax, ax
	push	ax
	push	ax
	CALL(savingThrowCheck)
	or	ax, ax
	jz	short l_next

	inc	gs:g_monsterDisbelieveFlag
	PRINTOFFSET(s_theyDisbelieve)
	DELAY
	jmp	short l_return

l_next:
	inc	[bp+loopCounter]
	cmp	[bp+loopCounter], 7
	jl	short l_loop

l_return:
	pop	si
	FUNC_EXIT
	retf
bat_monDisbelieve endp
