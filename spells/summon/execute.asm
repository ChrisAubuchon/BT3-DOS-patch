; Attributes: bp-based frame

summon_execute proc far

	spellCaster= byte ptr	 6
	spellNumber= word ptr	 8

	FUNC_ENTER
	CHKSTK

	test	gs:disbelieveFlags, disb_nosummon
	jz	short loc_25E96
	PUSH_OFFSET(s_butItFizzledNl)
	PRINTSTRING
	jmp	short l_return

loc_25E96:
	test	[bp+spellCaster], 80h
	jz	short loc_25EA8
	push	[bp+spellNumber]
	CALL(summon_monSummon, near)
	jmp	short l_return

loc_25EA8:
	push	[bp+spellNumber]
	CALL(summon_partySummon, near)

l_return:
	FUNC_EXIT
	retf
summon_execute endp
