divert(`-1')
# Abbreviate spellcast_ macros to fit better
define(`TP', `spellcast_targetParty')
define(`TM', `spellcast_targetMon')
define(`UT', `spellcast_untargetted')
define(`SO', `spellcast_spellOnly')
define(`NC', `spellcast_noncombatCastable')
define(`PO', `spellcast_partyOnly')
divert`'dnl
g_spellCastFlags	db BITMASK(NC, SO, UT)			;   0
			db BITMASK(SO, TM, TP)			;   1
			db BITMASK(NC, UT)			;   2
			db BITMASK(SO, TM)			;   3
			db BITMASK(NC, SO, UT)			;   4
			db BITMASK(PO, NC, SO)			;   5
			db BITMASK(NC, SO, UT)			;   6
			db BITMASK(NC, SO, UT)			;   7
			db BITMASK(SO, TM)			;   8
			db BITMASK(NC, SO, UT)			;   9
			db BITMASK(PO, NC, SO)			;  10
			db BITMASK(NC, SO, UT)			;  11
			db BITMASK(SO, TM)			;  12
			db BITMASK(PO, NC, SO, UT)		;  13
			db BITMASK(NC, SO, UT)			;  14
			db BITMASK(PO, NC, SO)			;  15
			db BITMASK(NC, UT)			;  16
			db BITMASK(SO, TM)			;  17
			db BITMASK(NC, SO, UT)			;  18
			db BITMASK(PO, SO)			;  19
			db BITMASK(PO, NC, SO)			;  20
			db BITMASK(NC, UT)			;  21
			db BITMASK(SO, TM, TP)			;  22
			db BITMASK(PO, SO)			;  23
			db BITMASK(NC, SO, UT)			;  24
			db BITMASK(NC, SO, UT)			;  25
			db BITMASK(PO, SO)			;  26
			db BITMASK(SO, TM)			;  27
			db BITMASK(SO, TM, TP)			;  28
			db BITMASK(SO, TM)			;  29
			db BITMASK(SO, UT)			;  30
			db BITMASK(PO, SO, UT)			;  31
			db BITMASK(NC, UT)			;  32
			db BITMASK(NC, SO, UT)			;  33
			db BITMASK(PO, NC, SO, UT)		;  34
			db BITMASK(SO, TM, TP)			;  35
			db BITMASK(SO, TM)			;  36
			db BITMASK(PO, NC, SO)			;  37
			db BITMASK(SO, TM, TP)			;  38
			db BITMASK(SO, UT)			;  39
			db BITMASK(NC, SO, UT)			;  40
			db BITMASK(SO, UT)			;  41
			db BITMASK(NC, SO, UT)			;  42
			db BITMASK(SO, TM)			;  43
			db BITMASK(NC, SO, UT)			;  44
			db BITMASK(SO, UT)			;  45
			db BITMASK(NC, SO, UT)			;  46
			db BITMASK(NC, SO, UT)			;  47
			db BITMASK(NC, SO, UT)			;  48
			db BITMASK(SO, UT)			;  49
			db BITMASK(SO, UT)			;  50
			db BITMASK(NC, SO, UT)			;  51
			db BITMASK(NC, SO, UT)			;  52
			db BITMASK(SO, UT)			;  53
			db BITMASK(NC, SO, UT)			;  54
			db BITMASK(SO, TM)			;  55
			db BITMASK(0C0h, PO, NC, SO, UT)	;  56
			db BITMASK(NC, SO, UT)			;  57
			db BITMASK(SO, TM)			;  58
			db BITMASK(NC, SO, UT)			;  59
			db BITMASK(SO, TM, TP)			;  60
			db BITMASK(SO, TM)			;  61
			db BITMASK(PO, NC, SO)			;  62
			db BITMASK(NC, SO, UT)			;  63
			db BITMASK(SO)				;  64
			db BITMASK(SO, TM)			;  65
			db BITMASK(SO, TM, TP)			;  66
			db BITMASK(NC, SO, UT)			;  67
			db BITMASK(PO, NC, SO)			;  68
			db BITMASK(SO, TM)			;  69
			db BITMASK(SO, TM)			;  70
			db BITMASK(SO, UT)			;  71
			db BITMASK(SO, TM)			;  72
			db BITMASK(NC, SO, UT)			;  73
			db BITMASK(SO, UT)			;  74
			db BITMASK(SO, TM)			;  75
			db BITMASK(NC, SO, UT)			;  76
			db BITMASK(NC, SO, UT)			;  77
			db BITMASK(SO, UT)			;  78
			db BITMASK(PO, NC, SO)			;  79
			db BITMASK(NC, SO, UT)			;  80
			db BITMASK(NC, SO, UT)			;  81
			db BITMASK(SO, TM)			;  82
			db BITMASK(SO, TM)			;  83
			db BITMASK(NC, SO, UT)			;  84
			db BITMASK(NC, SO, UT)			;  85
			db BITMASK(SO, TM)			;  86
			db BITMASK(SO, UT)			;  87
			db BITMASK(NC, SO, UT)			;  88
			db BITMASK(NC, SO, UT)			;  89
			db BITMASK(SO, UT)			;  90
			db BITMASK(SO, TM, TP)			;  91
			db BITMASK(NC, SO, UT)			;  92
			db BITMASK(NC, SO, UT)			;  93
			db BITMASK(NC, UT)			;  94
			db BITMASK(PO, NC, SO)			;  95
			db BITMASK(NC, SO, UT)			;  96
			db BITMASK(NC, SO, UT)			;  97
			db BITMASK(PO, NC, SO)			;  98
			db BITMASK(SO, TM)			;  99
			db BITMASK(NC, SO, UT)			; 100
			db BITMASK(NC, SO, UT)			; 101
			db BITMASK(NC, SO, UT)			; 102
			db BITMASK(SO, UT)			; 103
			db BITMASK(NC, SO, UT)			; 104
			db BITMASK(NC, SO, UT)			; 105
			db BITMASK(SO, TM)			; 106
			db BITMASK(NC, UT)			; 107
			db BITMASK(NC, UT)			; 108
			db BITMASK(SO, UT)			; 109
			db BITMASK(NC, SO, UT)			; 110
			db BITMASK(NC, UT)			; 111
			db BITMASK(SO, TM, TP)			; 112
			db BITMASK(NC, UT)			; 113
			db BITMASK(NC, UT)			; 114
			db BITMASK(SO, TM)			; 115
			db BITMASK(NC, UT)			; 116
			db BITMASK(SO, TM, TP)			; 117
			db BITMASK(NC, UT)			; 118
			db BITMASK(SO, TM)			; 119
			db BITMASK(SO, UT)			; 120
			db BITMASK(SO, TM)			; 121
			db BITMASK(NC, UT)			; 122
			db BITMASK(0C0h, PO, NC, SO, UT)	; 123
			db BITMASK(SO, UT)			; 124
			db BITMASK(NC, SO, UT)			; 125
			db BITMASK(NC, SO, UT)			; 126
			db BITMASK(NC, SO, UT)			; 127
			db BITMASK(NC, SO, UT)			; 128
			db BITMASK(NC, SO, UT)			; 129
			db BITMASK(NC, SO, UT)			; 130
			db BITMASK(SO, TM, TP)			; 131
			db BITMASK(NC, SO, UT)			; 132
			db BITMASK(SO, TM)			; 133
			db BITMASK(NC, SO, UT)			; 134
			db BITMASK(SO, UT)			; 135
undefine(`TP', `TM', `UT', `SO', `NC', `PO')dnl
