; Attributes: bp-based frame
bat_partyGetActionOptions proc	far

	arg_0= dword ptr  6

	FUNC_ENTER

	CALL(bat_monGroupInMeleeRange, near)
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+partyAction_t.meleeOpt], 1
	mov	byte ptr fs:[bx+partyAction_t.advanceOpt], al
	mov	byte ptr fs:[bx+partyAction_t.runOpt], 1

	FUNC_EXIT
	retf
bat_partyGetActionOptions endp

