s_drinkLessThirsty	db 'less thirsty.',0Ah,0Ah,0
s_drinkHicHappier	db '(hic) happier.',0Ah,0Ah,0
s_drinkRefreshed	db 'refreshed!',0Ah,0Ah,0
s_drinkTerrible		db 'terrible.',0Ah,0Ah,0

g_drinkStringList	dd s_drinkLessThirsty		;   0
			dd s_drinkHicHappier		;   1
			dd s_drinkRefreshed		;   2
			dd s_drinkTerrible		;   3
			dd s_drinkTerrible		;   4

s_ateIt			db 'ate it.',0Ah,0Ah,0
s_drinksAndFeels	db 'drinks and feels ',0

s_cantFindUse		db 'can',27h,'t seem to find a use for the item.',0Ah,0Ah,0
s_invokesFigurine	db 'invokes a figurine ',0
s_isReenergized		db 'is re-energized!',0Ah,0Ah,0
s_castAt		db 'Cast at ',0
s_whoWillCast		db 'Who will cast a spell?',0
s_dontKnowThatSpell	db 'You don',27h,'t know that spell!',0
s_noSpellByThatName	db 'No spell by that name.', 0
s_notEnoughSppt		db 'Not enough spell points!',0
s_spellToCast		db 'Spell to cast:',0
s_castsASpell		db 'casts a spell',0
s_butItFizzled		db 'but it fizzled!',0
s_butItFizzledNl	db 'but it fizzled!',0Ah,0Ah,0
s_makesLight		db 'makes a light',0
s_notSpellcaster	db 'Thou art not a spellcaster',0
