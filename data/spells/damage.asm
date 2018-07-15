define(`DAMAGE', `breathAtt_t <$1, $2, eval($3 * 2), $4, $5, $6, $7>')dnl

damageSpellData	DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	1)		;   0
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			0, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	8)		;   1
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	16)		;   2
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_cold),	1, mtype_none,	DICE_XDY(25, dice_d8),	BITMASK(breath_oneGroup, breath_allFoes),	1)		;   3
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			8, mtype_none,	DICE_XDY(30, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	14)		;   4
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			9, mtype_none,	DICE_XDY(32, dice_d8),	BITMASK(breath_oneGroup, breath_allFoes),	16)		;   5
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(5, dice_d4),	BITMASK(breath_oneGroup),			1)		;   6
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(15, dice_d4),	BITMASK(breath_oneGroup),			1)		;   7
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(10, dice_d4),	BITMASK(breath_oneGroup),			1)		;   8
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_fire),	4, mtype_none,	DICE_XDY(8, dice_d8),	BITMASK(breath_oneGroup),			1)		;   9
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			8, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup),			1)		;  10
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_fire),	4, mtype_none,	DICE_XDY(22, dice_d4),	BITMASK(breath_oneGroup),			1)		;  11
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup),			2)		;  12
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_cold),	1, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup),			4)		;  13
		DAMAGE(specialAttack_age,	BITMASK(element_magic),			3, mtype_none,	DICE_XDY(30, dice_d2),	BITMASK(breath_oneGroup),			10)		;  14
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_holy),	3, mtype_evil,	DICE_XDY(6, dice_d4),	0,						1)		;  15
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_cold),	1, mtype_none,	DICE_XDY(20, dice_d4),	BITMASK(breath_oneGroup),			1)		;  16
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			5, mtype_mage,	DICE_XDY(30, dice_d4),	BITMASK(breath_oneGroup),			2)		;  17
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			8, mtype_demon, DICE_XDY(20, dice_d2),	BITMASK(breath_oneGroup),			10)		;  18
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_cold),	1, mtype_none,	DICE_XDY(25, dice_d8),	BITMASK(breath_oneGroup),			2)		;  19
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_holy),	7, mtype_none,	DICE_XDY(12, dice_d4),	BITMASK(breath_oneGroup),			5)		;  20
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_holy),	0, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup),			8)		;  21
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_fire),	4, mtype_none,	DICE_XDY(30, dice_d4),	BITMASK(breath_oneGroup),			10)		;  22
		DAMAGE(specialAttack_none,	BITMASK(element_magic),			0, mtype_none,	DICE_XDY(15, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	10)		;  23
		DAMAGE(specialAttack_age,	BITMASK(element_magic),			3, mtype_none,	DICE_XDY(15, dice_d4),	0,						1)		;  24
		DAMAGE(specialAttack_critical,	BITMASK(element_magic),			8, mtype_none,	0,			0,						1)		;  25
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_fire),	4, mtype_none,	DICE_XDY(1, dice_d4),	0,						0)		;  26
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(2, dice_d4),	0,						0)		;  27
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_fire),	4, mtype_demon,	DICE_XDY(25, dice_d4),	0,						4)		;  28
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_holy),	3, mtype_none,	DICE_XDY(25, dice_d4),	0,						2)		;  29
		DAMAGE(specialAttack_critical,	BITMASK(element_magic),			8, mtype_none,	0,			0,						1)		;  30
		DAMAGE(specialAttack_stone,	BITMASK(element_magic),			8, mtype_none,	0,			0,						1)		;  31
		DAMAGE(specialAttack_possess,	BITMASK(element_magic),			8, mtype_none,	0,			0,						1)		;  32
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_cold),	1, mtype_none,	DICE_XDY(25, dice_d4),	0,						16)		;  33
		DAMAGE(specialAttack_none,	BITMASK(element_magic, element_death),	2, mtype_none,	DICE_XDY(25, dice_d4),	BITMASK(breath_oneGroup, breath_allFoes),	2)		;  34
		db 0
undefine(`DAMAGE')
