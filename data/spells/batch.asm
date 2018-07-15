define(`END', `0')dnl
batchSpellList	db spell_greaterRevelation	;   0
		db spell_mysticalArmor		;   1
		db spell_sorcerorSight		;   2
		db spell_majorLevitation	;   3
		db spell_kielsCompass		;   4
		db END				;   5
		db spell_beyondDeath		;   6
		db spell_regeneration		;   7
		db END				;   8
		db BITMASK(spell_witherfist, 80h)		;   9
		db spell_sandstorm		;  10
		db END				;  11
undefine(`END')dnl
