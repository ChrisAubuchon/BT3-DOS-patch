include(`constants.m4')
s_Warrior	db 'Warrior',0
s_Wizard	db 'Wizard',0
s_Sorcerer	db 'Sorcerer',0
s_Conjurer	db 'Conjurer',0
s_Magician	db 'Magician',0
s_Rogue		db 'Rogue',0
s_Bard		db 'Bard',0
s_Paladin	db 'Paladin',0
s_Hunter	db 'Hunter',0
s_Monk		db 'Monk',0
s_Archmage	db 'Archmage',0
s_Chronomancer	db 'Chronomancer',0
s_Geomancer	db 'Geomancer',0
s_Monster	db 'Monster',0
s_Illusion	db 'Illusion',0

g_classString	dd s_Warrior		; 0
		dd s_Wizard		; 1
		dd s_Sorcerer		; 2
		dd s_Conjurer		; 3
		dd s_Magician		; 4
		dd s_Rogue		; 5
		dd s_Bard		; 6
		dd s_Paladin		; 7
		dd s_Hunter		; 8
		dd s_Monk		; 9
		dd s_Archmage		; 10
		dd s_Chronomancer	; 11
		dd s_Geomancer		; 12
		dd s_Monster		; 13
		dd s_Illusion		; 14

g_classPictureNumber	db bigpic_maleWarrior, bigpic_femaleWarrior		;   0
			db bigpic_maleWizard,  bigpic_femaleWizard		;   1
			db bigpic_maleWizard,  bigpic_femaleWizard		;   2
			db bigpic_maleWizard,  bigpic_femaleWizard		;   3
			db bigpic_maleWizard,  bigpic_femaleWizard		;   4
			db bigpic_maleWarrior, bigpic_femaleWarrior		;   5
			db bigpic_maleWarrior, bigpic_femaleWarrior		;   6
			db bigpic_maleWarrior, bigpic_femaleWarrior		;   7
			db bigpic_maleWarrior, bigpic_femaleWarrior		;   8
			db bigpic_maleWarrior, bigpic_femaleWarrior		;   9
			db bigpic_maleWizard,  bigpic_femaleWizard		;  10

dnl	The value g_classStartingInventoryIndex[class] is used as an index into
dnl	g_classStartingInventory. Each entry is copied into the new characters
dnl	inventory. The end of the starting inventory is denoted by END
dnl
g_classStartingInventoryIndex	db 6		;   0
				db 42		;   1
				db 42		;   2
				db 42		;   3
				db 42		;   4
				db 32		;   5
				db 0		;   6
				db 6		;   7
				db 6		;   8
				db 22		;   9
				db 42		;  10
				db 0		;  11

define(`ITEM', `$1, $2, $3')dnl
define(`NONE', `0FFh')dnl
define(`END', `0FEh')dnl
define(`SPIRITS', `4')dnl
define(`WATER', `0')dnl
g_classStartingInventory	db ITEM(itemFlag_equipped,	item_mandolin,		NONE)		;   0	Ba
				db ITEM(SPIRITS,		item_wineskin,		10)		;   3
				db ITEM(itemFlag_equipped,	item_broadsword,	NONE)		;   6	Wa, Pa, Hu
				db ITEM(itemFlag_equipped,	item_scaleArmor,	NONE)		;   9
				db ITEM(itemFlag_equipped,	item_buckler,		NONE)		;  12
				db ITEM(itemFlag_equipped,	item_helm,		NONE)		;  15
				db ITEM(itemFlag_equipped,	item_leatherGloves,	NONE)		;  18
				db END									;  21
				db ITEM(itemFlag_equipped,	item_shortsword,	NONE)		;  22	Mo
				db ITEM(itemFlag_equipped,	item_leatherArmor,	NONE)		;  25
				db ITEM(WATER,			item_canteen,		10)		;  28
				db END									;  31
				db ITEM(itemFlag_equipped,	item_shortsword,	NONE)		;  32	Ro
				db ITEM(itemFlag_equipped,	item_leatherArmor,	NONE)		;  35
				db ITEM(itemFlag_equipped,	item_buckler,		NONE)		;  38
				db END									;  41
				db ITEM(itemFlag_equipped,	item_robes,		NONE)		;  42	Wi, So, Co, Ma, Ar
				db ITEM(itemFlag_equipped,	item_staff,		NONE)		;  45
				db ITEM(itemFlag_equipped,	item_lamp,		1)		;  48
				db END									;  52
undefine(`ITEM', `NONE', `END', `SPIRITS', `WATER')dnl
