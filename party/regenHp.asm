party_regenHp	proc far
	push		cx
	xor		cx, cx

l_loop:
	CHARINDEX(ax, cx, bx)
	test		gs:party.status[si], stat_dead or stat_stoned
	jnz		l_next
	mov		al, g_levelNumber
	sub		ah, ah
	add		gs:party.currentHP[bx], ax
	mov		ax, gs:party.maxHP[bx]
	cmp		party.currentHP[bx], ax
	jbe		l_next
	mov		gs:party.currentHP[bx], ax

l_next:
	inc		cx
	cmp		cx, 7
	jl		l_loop

	pop		cx
	retf
party_regenHp	endp
