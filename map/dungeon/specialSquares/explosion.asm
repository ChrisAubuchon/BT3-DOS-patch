; Attributes: bp-based frame

dunsq_explosion proc far
	FUNC_ENTER
	cmp	lightDuration, 0
	jz	short l_return
	PUSH_OFFSET(s_explosion)
	PRINTSTRING(true)
	CALL(dunsq_drainHp, near)
l_return:
	mov	ax, 1
	FUNC_EXIT
	retf
dunsq_explosion endp
