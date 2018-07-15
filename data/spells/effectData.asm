divert(`-1')

define(`NONE', 0)

# The effect data for a damage spell is an offset into damageSpellData.
# The DAMAGESPELL macro takes an array index and multiplies it by the sizeof
# the breathAtt_t macro.
#
define(`DAMAGESPELL', `toIntel(eval(`$1 * 7'))')

# Summon macro is an index into the summonData array ORd with 80h if
# the summoned monster is an illusion
#
define(`SUMMON', `ifelse(`$2', `', `$1', `BITMASK($1, $2)')')
define(`ILLUSION', `80h')

# An infinite duration is denoted by 0FFh. Anything else is copied
# in raw
#
define(`DURATION', `ifelse(`$1', `infinite', `0FFH', `$1')')

# A value of 80h phases the wall the entire time the party is on the
# level
#
define(`PHASE', `ifelse(`$1', `permanent', `80h', `$1')')

# Geomancer spell index is multiplied by 2 to be a word array index
#
define(`GEOMANCER', `eval($1 * 2)')

# These macros just write the data unmodified. I think it makes it easier
# to identify the spell type with the macro
#
define(`FREEZEPENALTY', `$1')
define(`HEALD4', `$1')
define(`MOVEDISTANCE', `$1')
define(`VORPAL_BONUS', `$1')
define(`STRENGTH_BONUS', `$1')
define(`ANTIMAGIC', `$1')
define(`ACBONUS', `$1')
define(`TOHIT_PENALTY', `$1')
define(`BATCH_INDEX', `$1')
define(`LUCK_BONUS', `$1')
divert`'dnl
g_spellEffectData	db splf_mageflame	;   0
			db DAMAGESPELL(26)	;   1
			db NONE			;   2
			db FREEZEPENALTY(2)	;   3
			db DURATION(20h)	;   4
			db HEALD4(4)		;   5
			db splf_lesserrev	;   6
			db DURATION(4)		;   7
			db DAMAGESPELL(6)	;   8
			db SUMMON(0)		;   9
			db HEALD4(10)		;  10
			db splf_greaterrev	;  11
			db DAMAGESPELL(7)	;  12
			db HEALD4(10)		;  13
			db DURATION(infinite)	;  14
			db heal_fullHeal	;  15
			db NONE			;  16
			db MOVEDISTANCE(4)	;  17
			db SUMMON(1)		;  18
			db VORPAL_BONUS(2)	;  19
			db heal_quickfix	;  20
			db NONE			;  21
			db DAMAGESPELL(15)	;  22
			db VORPAL_BONUS(4)	;  23
			db DURATION(4)		;  24
			db DURATION(4)		;  25
			db STRENGTH_BONUS(7)	;  26
			db DAMAGESPELL(8)	;  27
			db DAMAGESPELL(24)	;  28
			db DAMAGESPELL(9)	;  29
			db ANTIMAGIC(2)		;  30
			db STRENGTH_BONUS(10)	;  31
			db PHASE(0)		;  32
			db DURATION(infinite)	;  33
			db heal_fullHeal	;  34
			db DAMAGESPELL(25)	;  35
			db DAMAGESPELL(16)	;  36
			db HEALD4(0)		;  37
			db DAMAGESPELL(27)	;  38
			db ACBONUS(1)		;  39
			db DURATION(4)		;  40
			db disb_disbelieve	;  41
			db SUMMON(2, ILLUSION)	;  42
			db TOHIT_PENALTY(1)	;  43
			db SUMMON(3, ILLUSION)	;  44
			db ACBONUS(4)		;  45
			db DURATION(6)		;  46
			db splf_cateyes		;  47
			db SUMMON(4, ILLUSION)	;  48
			db disb_disruptill	;  49
			db DAMAGESPELL(0)	;  50
			db SUMMON(5, ILLUSION)	;  51
			db DURATION(infinite)	;  52
			db DAMAGESPELL(3)	;  53
			db SUMMON(6, ILLUSION)	;  54
			db DAMAGESPELL(17)	;  55
			db disb_nosummon	;  56
			db SUMMON(7)		;  57
			db DAMAGESPELL(10)	;  58
			db SUMMON(8)		;  59
			db DAMAGESPELL(28)	;  60
			db DAMAGESPELL(11)	;  61
			db HEALD4(0)		;  62
			db SUMMON(9)		;  63
			db 0E0h			;  64
			db NONE			;  65
			db DAMAGESPELL(29)	;  66
			db SUMMON(10)		;  67
			db HEALD4(0)		;  68
			db DAMAGESPELL(12)	;  69
			db DAMAGESPELL(18)	;  70
			db NONE			;  71
			db NONE			;  72
			db BATCH_INDEX(0)	;  73
			db NONE			;  74
			db DAMAGESPELL(13)	;  75
			db heal_fullHeal	;  76
			db SUMMON(11)		;  77
			db DAMAGESPELL(1)	;  78
			db heal_levelMul	;  79
			db NONE			;  80
			db NONE			;  81
			db DAMAGESPELL(14)	;  82
			db DAMAGESPELL(19)	;  83
			db NONE			;  84
			db NONE			;  85
			db DAMAGESPELL(20)	;  86
			db DAMAGESPELL(34)	;  87
			db NONE			;  88
			db NONE			;  89
			db LUCK_BONUS(8)	;  90
			db DAMAGESPELL(30)	;  91
			db NONE			;  92
			db NONE			;  93
			db NONE			;  94
			db HEALD4(0)		;  95
			db NONE			;  96
			db NONE			;  97
			db BATCH_INDEX(6)	;  98
			db BATCH_INDEX(9)	;  99
			db NONE			; 100
			db NONE			; 101
			db DURATION(infinite)	; 102
			db DAMAGESPELL(4)	; 103
			db NONE			; 104
			db NONE			; 105
			db DAMAGESPELL(21)	; 106
			db GEOMANCER(3)		; 107
			db GEOMANCER(0)		; 108
			db DAMAGESPELL(23)	; 109
			db SUMMON(12)		; 110
			db PHASE(permanent)	; 111
			db DAMAGESPELL(31)	; 112
			db GEOMANCER(4)		; 113
			db GEOMANCER(2)		; 114
			db MOVEDISTANCE(6)	; 115
			db GEOMANCER(1)		; 116
			db DAMAGESPELL(33)	; 117
			db GEOMANCER(5)		; 118
			db DAMAGESPELL(22)	; 119
			db DAMAGESPELL(2)	; 120
			db NONE			; 121
			db NONE			; 122
			db 5			; 123
			db DAMAGESPELL(5)	; 124
			db NONE			; 125
			db 4			; 126
			db 5			; 127
			db NONE			; 128
			db NONE			; 129
			db NONE			; 130
			db NONE			; 131
			db NONE			; 132
			db NONE			; 133
			db NONE			; 134
			db NONE			; 135
undefine(`NONE', `DAMAGESPELL', `SUMMON', `ILLUSION')dnl
undefine(`DURATION', `PHASE', `GEOMANCER')dnl
undefine(`FREEZEPENALTY', `HEALD4', `MOVEDISTANCE')dnl
undefine(`VORPAL_BONUS', `STRENGTH_BONUS', `ANTIMAGIC', `ACBONUS')dnl
undefine(`TOHIT_PENALTY', `BATCH_INDEX', `LUCK_BONUS')dnl
