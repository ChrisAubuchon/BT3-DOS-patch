divert(`-1')
# A damage spell stores its range in g_spellExtraData. Some spells
# also affect groups further away but at a lesser effect. To denote
# that type of spell, 80h is OR'd with the range
#
define(`RANGE', `ifelse(`$2', `diminishing', `BITMASK($1, 80h)', `$1')')

# A detection spell (Area Enchant, Locate Traps) stores a number that is
# an index into the detectByteStartList array. 
define(`DETECT_INDEX', `$1')

# Shield spells store the AC bonus
#
define(`SHIELD_BONUS', `$1')

# Heal spells have the 80h bit set if the spells heals the entire party.
# The lower 7 bits are an index into a jump table for statuses to heal
#
define(`HEAL', `ifelse(`$2', `all', `BITMASK($1, 80h)', `$1')')

define(`NONE', `0')

divert`'
g_spellExtraData	db NONE				;   0
			db RANGE(1)			;   1
			db NONE				;   2
			db 0Ah				;   3
			db NONE				;   4
			db HEAL(0)			;   5
			db NONE				;   6
			db NONE				;   7
			db RANGE(2)			;   8
			db NONE				;   9
			db HEAL(1)			;  10
			db NONE				;  11
			db RANGE(3, diminishing)	;  12
			db HEAL(1, all)			;  13
			db NONE				;  14
			db HEAL(1)			;  15
			db NONE				;  16
			db NONE				;  17
			db NONE				;  18
			db NONE				;  19
			db HEAL(0)			;  20
			db NONE				;  21
			db RANGE(1)			;  22
			db NONE				;  23
			db DETECT_INDEX(1)		;  24
			db SHIELD_BONUS(2)		;  25
			db NONE				;  26
			db RANGE(4, diminishing)	;  27
			db RANGE(7)			;  28
			db RANGE(3, diminishing)	;  29
			db NONE				;  30
			db 1				;  31
			db NONE				;  32
			db SHIELD_BONUS(2)		;  33
			db HEAL(1, all)			;  34
			db RANGE(1)			;  35
			db RANGE(5)			;  36
			db HEAL(2)			;  37
			db RANGE(4, diminishing)	;  38
			db NONE				;  39
			db DETECT_INDEX(0)		;  40
			db NONE				;  41
			db NONE				;  42
			db NONE				;  43
			db NONE				;  44
			db NONE				;  45
			db DETECT_INDEX(2)		;  46
			db NONE				;  47
			db NONE				;  48
			db NONE				;  49
			db RANGE(3, diminishing)	;  50
			db NONE				;  51
			db DETECT_INDEX(2)		;  52
			db RANGE(4)			;  53
			db NONE				;  54
			db RANGE(10)			;  55
			db 0Ah				;  56
			db NONE				;  57
			db RANGE(1)			;  58
			db NONE				;  59
			db RANGE(3)			;  60
			db RANGE(3)			;  61
			db HEAL(3)			;  62
			db NONE				;  63
			db NONE				;  64
			db NONE				;  65
			db RANGE(7)			;  66
			db NONE				;  67
			db HEAL(4)			;  68
			db RANGE(5)			;  69
			db RANGE(5, diminishing)	;  70
			db NONE				;  71
			db NONE				;  72
			db NONE				;  73
			db NONE				;  74
			db RANGE(6)			;  75
			db HEAL(6, all)			;  76
			db NONE				;  77
			db RANGE(10)			;  78
			db HEAL(0)			;  79
			db NONE				;  80
			db NONE				;  81
			db RANGE(2)			;  82
			db RANGE(8)			;  83
			db NONE				;  84
			db NONE				;  85
			db RANGE(8)			;  86
			db RANGE(5)			;  87
			db NONE				;  88
			db NONE				;  89
			db NONE				;  90
			db RANGE(3)			;  91
			db NONE				;  92
			db NONE				;  93
			db NONE				;  94
			db HEAL(5)			;  95
			db NONE				;  96
			db NONE				;  97
			db NONE				;  98
			db NONE				;  99
			db NONE				; 100
			db NONE				; 101
			db SHIELD_BONUS(4)		; 102
			db RANGE(10)			; 103
			db NONE				; 104
			db NONE				; 105
			db RANGE(4, diminishing)	; 106
			db NONE				; 107
			db NONE				; 108
			db RANGE(10)			; 109
			db NONE				; 110
			db NONE				; 111
			db RANGE(6)			; 112
			db NONE				; 113
			db NONE				; 114
			db NONE				; 115
			db NONE				; 116
			db RANGE(10)			; 117
			db 85h				; 118
			db RANGE(5)			; 119
			db RANGE(10)			; 120
			db 5				; 121
			db NONE				; 122
			db 0Ah				; 123
			db RANGE(10)			; 124
			db NONE				; 125
			db 1				; 126
			db 1				; 127
			db NONE				; 128
			db NONE				; 129
			db NONE				; 130
			db NONE				; 131
			db NONE				; 132
			db NONE				; 133
			db NONE				; 134
			db NONE				; 135
undefine(`RANGE', `DETECT_INDEX', `SHIELD_BONUS', `HEAL', `NONE')dnl

