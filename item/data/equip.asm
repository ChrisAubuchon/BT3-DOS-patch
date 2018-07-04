classEquipMask	db equip_warrior
		db equip_wizard
		db equip_sorcerer
		db equip_conjurer
		db equip_magician
		db equip_rogue
		db equip_bard
		db equip_paladin
		db equip_hunter
		db equip_monk
		db equip_archmage
		db equip_chronomancer
		db equip_geomancer
		db equip_monster
		db equip_monster
		db 0

divert(`-1')
define(`WA', `equip_warrior')
define(`WI', `equip_wizard')
define(`SO', `equip_sorcerer')
define(`CO', `equip_conjurer')
define(`MA', `equip_magician')
define(`RO', `equip_rogue')
define(`BA', `equip_bard')
define(`PA', `equip_paladin')
define(`HU', `equip_hunter')
define(`MO', `equip_monk')
define(`AR', `equip_archmage')
define(`CH', `0')dnl			CHronomancer and GEomancer are composites.
define(`GE', `0')dnl			Set them to 0 so the masks come out correctly
divert`'dnl
itemEquipMask   db equip_none						;   0
		db equip_all						;   1
		db equip_all						;   2
		db BITMASK(WA, BA, PA, HU, MO, GE)			;   3
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;   4
		db equip_all						;   5
		db BITMASK(WA, BA, PA, HU, MO, GE)			;   6
		db BITMASK(WA, PA, HU, MO, GE)				;   7
                db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;   8
		db equip_all						;   9
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  10
		db BITMASK(WA, BA, PA, HU, GE)				;  11
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  12
		db BITMASK(WA, BA, PA, HU, MO, GE)			;  13
		db BITMASK(WA, BA, PA, HU, GE)				;  14
		db BITMASK(WA, PA, HU, GE)				;  15
                db equip_all						;  16
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  17
		db equip_all						;  18
		db BITMASK(WA, PA, HU, GE)				;  19
		db BITMASK(BA)						;  20
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  21
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  22
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  23
                db BITMASK(WA, RO, BA, PA, HU, GE)			;  24
		db BITMASK(WA, BA, PA, HU, MO, GE)			;  25
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  26
		db equip_all						;  27
		db BITMASK(WI, SO, CO, MA, RO, AR, CH, GE)		;  28
		db BITMASK(BA)						;  29
		db BITMASK(BA)						;  30
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  31
                db equip_all						;  32
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  33
		db BITMASK(WA, BA, PA, GE)				;  34
		db BITMASK(WA, BA, PA, HU, MO, GE)			;  35
		db BITMASK(WA, RO, BA, HU, MO, GE)			;  36
		db BITMASK(WA, PA, HU, GE)				;  37
		db equip_all						;  38
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  39
                db equip_all						;  40
		db BITMASK(BA)						;  41
		db BITMASK(WA, BA, PA, HU, GE)				;  42
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  43
		db BITMASK(WA, BA, PA, HU, GE)				;  44
		db equip_all						;  45
		db BITMASK(WI, SO, CO, MA, RO, MO, AR, CH, GE)		;  46
		db BITMASK(WA, BA, PA, HU, GE)				;  47
                db BITMASK(WA, RO, BA, PA, HU, GE)			;  48
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  49
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  50
		db BITMASK(WA, PA, GE)					;  51
		db BITMASK(PA)						;  52
		db BITMASK(WA, RO, BA, MO, GE)				;  53
		db equip_all						;  54
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  55
                db equip_all						;  56
		db BITMASK(WA, BA, PA, HU, GE)				;  57
		db BITMASK(HU)						;  58
		db BITMASK(WA, PA, HU, GE)				;  59
		db BITMASK(WI, SO, CO, MA, RO, AR, CH, GE)		;  60
		db equip_all						;  61
		db BITMASK(PA)						;  62
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  63
                db equip_all						;  64
		db BITMASK(RO)						;  65
		db BITMASK(WA, BA, PA, HU, GE)				;  66
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  67
		db BITMASK(WI, SO, CO, MA, RO, AR, CH, GE)		;  68
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  69
		db BITMASK(BA)						;  70
		db BITMASK(BA)						;  71
                db BITMASK(WA, PA, HU, GE)				;  72
		db BITMASK(WA, BA, PA, HU, GE)				;  73
		db BITMASK(BA)						;  74
		db BITMASK(WA, PA, HU, GE)				;  75
		db equip_all						;  76
		db BITMASK(BA)						;  77
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  78
		db BITMASK(WI, SO, CO, MA, MO, AR, CH, GE)		;  79
                db BITMASK(WA, PA, HU, GE)				;  80
		db BITMASK(WA, WI, SO, CO, MA, RO, BA, PA, AR, CH, GE)	;  81
		db equip_all						;  82
		db BITMASK(WA, RO, BA, PA, HU, GE)			;  83
		db BITMASK(WA, BA, PA, GE)				;  84
		db BITMASK(WA, PA, GE)					;  85
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  86
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  87
                db BITMASK(WA, PA, HU, GE)				;  88
		db BITMASK(WA, BA, PA, HU, GE)				;  89
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  90
		db BITMASK(BA)						;  91
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			;  92
		db BITMASK(BA)						;  93
		db BITMASK(BA)						;  94
		db BITMASK(WI, SO, CO, MA, HU, AR, CH, GE)		;  95
                db BITMASK(BA)						;  96
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			;  97
		db equip_all						;  98
		db equip_all						;  99
		db equip_all						; 100
		db BITMASK(WA, PA, HU, GE)				; 101
		db BITMASK(WI, SO, CO, MA, BA, PA, AR, CH, GE)		; 102
		db equip_all						; 103
                db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 104
		db equip_all						; 105
		db equip_all						; 106
		db BITMASK(WA, PA, GE)					; 107
		db BITMASK(WA, PA, HU, GE)				; 108
		db equip_all						; 109
		db equip_all						; 110
		db equip_all						; 111
                db equip_all						; 112
		db equip_all						; 113
		db equip_all						; 114
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 115
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 116
		db equip_all						; 117
		db equip_all						; 118
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 119
                db equip_all						; 120
		db equip_all						; 121
		db equip_all						; 122
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 123
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 124
		db equip_all						; 125
		db BITMASK(WA, PA, GE)					; 126
		db BITMASK(WA, BA, PA, GE)				; 127
                db BITMASK(WA, PA, HU, GE)				; 128
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 129
		db BITMASK(BA)						; 130
		db BITMASK(WA, RO, BA, PA, HU, GE)			; 131
		db BITMASK(PA)						; 132
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 133
		db BITMASK(HU)						; 134
		db BITMASK(WA, PA, HU, GE)				; 135
                db equip_all						; 136
		db equip_all						; 137
		db BITMASK(MO)						; 138
		db BITMASK(HU)						; 139
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 140
		db BITMASK(HU)						; 141
		db BITMASK(WA, PA, HU, MO, GE)				; 142
		db BITMASK(MO)						; 143
                db BITMASK(MO)						; 144
		db equip_all						; 145
		db equip_all						; 146
		db equip_all						; 147
		db equip_all						; 148
		db equip_all						; 149
		db equip_all						; 150
		db equip_all						; 151
                db BITMASK(WA, PA, GE)					; 152
		db BITMASK(WA, PA, HU, GE)				; 153
		db equip_all						; 154
		db equip_all						; 155
		db BITMASK(RO)						; 156
		db BITMASK(RO)						; 157
		db BITMASK(WA, PA, HU, GE)				; 158
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 159
                db BITMASK(WA, BA, PA, HU, GE)				; 160
		db BITMASK(WA, BA, PA, HU, GE)				; 161
		db equip_all						; 162
		db equip_all						; 163
		db equip_all						; 164
		db equip_all						; 165
		db equip_all						; 166
		db equip_all						; 167
                db equip_all						; 168
		db equip_all						; 169
		db equip_all						; 170
		db BITMASK(RO)						; 171
		db BITMASK(PA)						; 172
		db BITMASK(RO)						; 173
		db BITMASK(RO)						; 174
		db BITMASK(RO)						; 175
                db BITMASK(RO)						; 176
		db BITMASK(RO)						; 177
		db equip_all						; 178
		db equip_all						; 179
		db equip_all						; 180
		db BITMASK(WA, BA, PA, HU, GE)				; 181
		db equip_all						; 182
		db equip_all						; 183
                db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 184
		db equip_all						; 185
		db BITMASK(BA)						; 186
		db BITMASK(AR, CH, GE)					; 187
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 188
		db BITMASK(WI, SO, CO, MA, RO, AR, CH, GE)		; 189
		db equip_all						; 190
		db BITMASK(BA)						; 191
                db BITMASK(RO)						; 192
		db BITMASK(WA, GE)					; 193
		db BITMASK(BA)						; 194
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 195
		db BITMASK(WA, BA, PA, GE)				; 196
		db BITMASK(WA, PA, GE)					; 197
		db BITMASK(BA)						; 198
		db BITMASK(HU)						; 199
                db BITMASK(WA, GE)					; 200
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 201
		db equip_all						; 202
		db BITMASK(AR, CH, GE)					; 203
		db BITMASK(AR, CH, GE)					; 204
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 205
		db BITMASK(RO)						; 206
		db BITMASK(RO)						; 207
                db BITMASK(RO)						; 208
		db BITMASK(BA)						; 209
		db BITMASK(BA)						; 210
		db BITMASK(PA)						; 211
		db BITMASK(WA, PA, HU, GE)				; 212
		db BITMASK(WA, PA, GE)					; 213
		db BITMASK(WA, PA, GE)					; 214
		db equip_all						; 215
                db BITMASK(WI, SO, CO, MA, RO, AR, CH, GE)		; 216
		db BITMASK(HU)						; 217
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 218
		db BITMASK(AR, CH, GE)					; 219
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 220
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 221
		db BITMASK(BA)						; 222
		db equip_all						; 223
                db equip_all						; 224
		db equip_all						; 225
		db equip_all						; 226
		db equip_all						; 227
		db equip_all						; 228
		db equip_all						; 229
		db equip_all						; 230
		db equip_all						; 231
                db equip_all						; 232
		db equip_all						; 233
		db equip_all						; 234
		db equip_all						; 235
		db equip_all						; 236
		db equip_all						; 237
		db equip_all						; 238
		db equip_all						; 239
                db BITMASK(WA, PA, HU, GE)				; 240
		db BITMASK(WA, GE)					; 241
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 242
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 243
		db BITMASK(WA, RO, BA, PA, HU, MO, GE)			; 244
		db BITMASK(WA, PA, GE)					; 245
		db BITMASK(HU)						; 246
		db BITMASK(WI, SO, CO, MA, AR, CH, GE)			; 247
                db BITMASK(BA)						; 248
		db equip_all						; 249
		db equip_all						; 250
		db equip_all						; 251
		db equip_all						; 252
		db equip_all						; 253
		db equip_all						; 254
		db equip_all						; 255
divert(`-1')
undefine(`WA')
undefine(`WI')
undefine(`SO')
undefine(`CO')
undefine(`MA')
undefine(`RO')
undefine(`BA')
undefine(`PA')
undefine(`HU')
undefine(`MO')
undefine(`AR')
undefine(`CH')
undefine(`GE')
divert`'dnl
