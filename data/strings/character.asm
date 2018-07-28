; Various character screen strings
;
s_spellPoints	db 'Spell Points:',0
s_expr		db 'Expr:',0
s_gold		db 'Gold:',0
s_poolGold	db 0Ah,0Ah
		db '     Pool  gold',0Ah
		db '     Trade gold',0
s_tradeGoldToWhom	db 'Trade gold to whom?',0
s_howMuchGoldToTrade	db 'How much gold will you trade?',0
s_done		db 'Done!',0
s_inventory	db 'Inventory',0

s_inventoryVarString	db ' Do you wish to:',0Ah
			db 0Ah,0Ah,0Ah
			db '@Trade the item',0Ah
			db '@Discard the item',0Ah
			db '@Equip the item',0Ah
			db '@Unequip the item',0Ah
			db '@Identify the item',0
s_itsFilledWith		db 0Ah,'It',27h,'s filled with ',0
s_triesToIdentify	db ' tries to identify the item...',0Ah
			db 'and /succeed\fail\s!!',0
s_whoDoes		db 'Who does ',0
s_wantToGiveItTo	db ' want to give it to?',0
s_dontKnowAnySpells	db 'You don',27h,'t know any spells.',0
s_knownSpells		db 'Known spells',0
s_rogueAbilities	db 'Rogue abilities',0
s_disarmTraps		db 'Disarm traps ',0
s_identifyChest		db 'Identify chest ',0
s_identifyItem		db 'Identify item ',0
s_hideInShadows		db 'Hide in shadows ',0
s_criticalHit		db 'Critical hit ',0
s_bardAbilities		db 'Bard abilities',0
s_tunesLeft		db 'Number of tunes left: ',0
s_hunterAbilities	db 'Hunter abilities',0
s_pocketsAreEmpty	db 'Your pockets are empty.',0
s_attributeAbbreviations	db 'StIQDxCnLkHP',0
s_isAn			db ' is a/n \ ',0
s_level			db 'Level',0
g_itemFlagCharacters	db ' ', '|', '^', '?', 0, 0	; This is a list of characters used 
							; in the inventory string for flags.
			
			
			
