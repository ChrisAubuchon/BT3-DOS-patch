dnl	Indices 0-22 are weapons that can be cast. "X casts a weapon."
dnl	23-31 are weapons that breathe.
dnl
g_useableWeaponList	db item_waraxe		;   0
			db item_spear		;   1
			db item_arrows		;   2
			db item_mithrilAxe	;   3
			db item_shuriken	;   4
			db item_spellSpear	;   5
			db item_kaelsAxe	;   6
			db item_mithrilArrows	;   7
			db item_boomerang	;   8
			db item_deathStars	;   9
			db item_agsArrows	;  10
			db item_zenArrows	;  11
			db item_songAxe		;  12
			db item_aramsKnife	;  13
			db item_thorsHammer	;  14
			db item_nightspear	;  15
			db item_arrowsOfLife	;  16
			db item_fireSpear	;  17
			db item_lightstar	;  18
			db item_stealthArrows	;  19
			db item_blackArrows	;  20
			db item_thievesDart	;  21
			db item_holyMissile	;  22
			db item_fireHorn	;  23
			db item_frostHorn	;  24
			db item_dragonShield	;  25
			db item_dragonWand	;  26
			db item_flameHorn	;  27
			db item_deathhorn	;  28
			db item_cliLyre		;  29
			db item_hornOfGods	;  30
			db item_wandOfFury	;  31
			db 0

dnl	Used weapon attack structure
dnl		Field 1:	Special attack value
dnl		Field 2:	Element of the attack
dnl		Field 3:	Damage Dice
dnl		Field 4:	Breath Flags (e.g. breath_allFoes, breath_oneGroup)
dnl		Field 5:	Level multiplier - Number of times to roll
dnl		Field 6:	Range of the attack
dnl
define(`WEAPON', `weaponDamage_t <$1, $2, $3, $4, $5, $6>')dnl
g_weaponDamageList	WEAPON(specialAttack_none,	element_phys,	DICE_XDY(6, dice_d4),	BITMASK(2),			1,	2)		;   0
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(5, dice_d4),	BITMASK(2),			1,	2)		;   1
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(3, dice_d4),	BITMASK(2),			1,	3)		;   2
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(7, dice_d4),	BITMASK(2),			1,	3)		;   3
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(4, dice_d4),	BITMASK(2),			1,	3)		;   4
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(8, dice_d4),	BITMASK(2),			1,	4)		;   5
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(9, dice_d4),	BITMASK(2),			1,	4)		;   6
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(9, dice_d4),	BITMASK(2),			1,	5)		;   7
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(12, dice_d4),	BITMASK(2),			1,	4)		;   8
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(16, dice_d4),	BITMASK(2),			1,	6)		;   9
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(24, dice_d4),	BITMASK(2),			1,	9)		;  10
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(20, dice_d4),	BITMASK(2),			2,	7)		;  11
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(16, dice_d4),	BITMASK(2),			4,	8)		;  12
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(16, dice_d4),	BITMASK(2),			8,	9)		;  13
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(16, dice_d4),	BITMASK(2),			2,	7)		;  14
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(20, dice_d4),	BITMASK(2),			2,	7)		;  15
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(25, dice_d4),	BITMASK(2),			8,	5)		;  16
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(25, dice_d4),	BITMASK(2),			4,	6)		;  17
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(25, dice_d4),	BITMASK(2),			4,	6)		;  18
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(25, dice_d4),	BITMASK(2),			8,	6)		;  19
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(25, dice_d4),	BITMASK(2, breath_oneGroup),	8,	9)		;  20
			WEAPON(specialAttack_critical,	element_phys,	DICE_XDY(1, dice_d4),	BITMASK(2),			1,	3)		;  21
			WEAPON(specialAttack_none,	element_holy,	DICE_XDY(16, dice_d4),	BITMASK(2),			10h,	8)		;  22
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(10, dice_d4),	BITMASK(2, breath_oneGroup),	1,	3)		;  23
			WEAPON(specialAttack_none,	element_cold,	DICE_XDY(24, dice_d4),	BITMASK(2, breath_oneGroup),	1,	4)		;  24
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(16, dice_d4),	BITMASK(2, breath_oneGroup),	2,	6)		;  25
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(16, dice_d4),	BITMASK(2, breath_oneGroup),	6,	6)		;  26
			WEAPON(specialAttack_none,	element_fire,	DICE_XDY(16, dice_d4),	BITMASK(2, breath_oneGroup),	8,	5)		;  27
			WEAPON(specialAttack_critical,	element_death,	DICE_XDY(16, dice_d4),	BITMASK(2, breath_oneGroup),	10h,	6)		;  28
			WEAPON(specialAttack_none,	element_none,	DICE_XDY(18, dice_d4),	BITMASK(2, breath_oneGroup),	0Ah,	7)		;  29
			WEAPON(specialAttack_none,	element_holy,	DICE_XDY(16, dice_d4),	BITMASK(2, breath_oneGroup),	20h,	7)		;  30
			WEAPON(specialAttack_none,	element_phys,	DICE_XDY(6, dice_d4),	BITMASK(2),			1,	2)		;  31
undefine(`WEAPON')dnl
