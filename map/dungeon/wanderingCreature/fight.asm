; Attributes: bp-based frame
wanderer_fight proc	far
	FUNC_ENTER
	mov	g_monsterGroupCount, 1
	mov	gs:g_nonRandomBattleFlag, 1
	mov	g_battleNoChest, 1
	mov	ax, 1
	FUNC_EXIT
	retf
wanderer_fight endp
