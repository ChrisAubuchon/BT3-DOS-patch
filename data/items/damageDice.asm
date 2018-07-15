divert(`-1')
define(`NONE', `0')
divert`'dnl
itemDamageDice	db NONE				; 0
		db NONE				; 1
		db NONE				; 2
		db DICE_XDY(2, dice_d4)		; 3
		db DICE_XDY(1, dice_d8)		; 4
		db NONE				; 5
		db DICE_XDY(2, dice_d4)		; 6
		db DICE_XDY(1, dice_d16)	; 7
		db NONE				; 8
		db DICE_XDY(1, dice_d8)		; 9
		db NONE				; 10
		db NONE				; 11
		db NONE				; 12
		db NONE				; 13
		db NONE				; 14
		db NONE				; 15
		db NONE				; 16
		db NONE				; 17
		db NONE				; 18
		db NONE				; 19
		db NONE				; 20
		db DICE_XDY(1, dice_d8)		; 21
		db NONE				; 22
		db DICE_XDY(2, dice_d4)		; 23
		db NONE				; 24
		db NONE				; 25
		db NONE				; 26
		db NONE				; 27
		db NONE				; 28
		db DICE_XDY(2, dice_d8)		; 29
		db NONE				; 30
		db NONE				; 31
		db NONE				; 32
		db NONE				; 33
		db NONE				; 34
		db DICE_XDY(2, dice_d4)		; 35
		db NONE				; 36
		db NONE				; 37
		db NONE				; 38
		db DICE_XDY(1, dice_d16)	; 39
		db NONE				; 40
		db NONE				; 41
		db DICE_XDY(5, dice_d4)		; 42
		db NONE				; 43
		db DICE_XDY(3, dice_d8)		; 44
		db DICE_XDY(1, dice_d16)	; 45
		db NONE				; 46
		db DICE_XDY(3, dice_d8)		; 47
		db DICE_XDY(2, dice_d4)		; 48
		db NONE				; 49
		db NONE				; 50
		db NONE				; 51
		db DICE_XDY(3, dice_d16)	; 52
		db NONE				; 53
		db NONE				; 54
		db NONE				; 55
		db NONE				; 56
		db NONE				; 57
		db NONE				; 58
		db NONE				; 59
		db NONE				; 60
		db NONE				; 61
		db NONE				; 62
		db DICE_XDY(3, dice_d8)		; 63
		db DICE_XDY(4, dice_d8)		; 64
		db DICE_XDY(21, dice_d4)	; 65
		db DICE_XDY(2, dice_d8)		; 66
		db NONE				; 67
		db NONE				; 68
		db DICE_XDY(3, dice_d4)		; 69
		db NONE				; 70
		db NONE				; 71
		db DICE_XDY(2, dice_d4)		; 72
		db NONE				; 73
		db NONE				; 74
		db NONE				; 75
		db NONE				; 76
		db NONE				; 77
		db DICE_XDY(3, dice_d4)		; 78
		db DICE_XDY(5, dice_d4)		; 79
		db DICE_XDY(3, dice_d16)	; 80
		db DICE_XDY(3, dice_d8)		; 81
		db DICE_XDY(2, dice_d16)	; 82
		db NONE				; 83
		db NONE				; 84
		db NONE				; 85
		db NONE				; 86
		db NONE				; 87
		db NONE				; 88
		db DICE_XDY(3, dice_d16)	; 89
		db NONE				; 90
		db NONE				; 91
		db NONE				; 92
		db NONE				; 93
		db NONE				; 94
		db NONE				; 95
		db NONE				; 96
		db NONE				; 97
		db NONE				; 98
		db NONE				; 99
		db NONE				; 100
		db DICE_XDY(2, dice_d4)		; 101
		db NONE				; 102
		db NONE				; 103
		db NONE				; 104
		db NONE				; 105
		db NONE				; 106
		db DICE_XDY(4, dice_d16)	; 107
		db NONE				; 108
		db NONE				; 109
		db NONE				; 110
		db NONE				; 111
		db NONE				; 112
		db NONE				; 113
		db NONE				; 114
		db NONE				; 115
		db NONE				; 116
		db NONE				; 117
		db NONE				; 118
		db DICE_XDY(5, dice_d16)	; 119
		db NONE				; 120
		db NONE				; 121
		db NONE				; 122
		db NONE				; 123
		db NONE				; 124
		db NONE				; 125
		db NONE				; 126
		db NONE				; 127
		db NONE				; 128
		db DICE_XDY(4, dice_d16)	; 129
		db NONE				; 130
		db DICE_XDY(9, dice_d8)		; 131
		db DICE_XDY(4, dice_d16)	; 132
		db NONE				; 133
		db NONE				; 134
		db NONE				; 135
		db NONE				; 136
		db NONE				; 137
		db NONE				; 138
		db NONE				; 139
		db DICE_XDY(7, dice_d4)		; 140
		db NONE				; 141
		db DICE_XDY(9, dice_d8)		; 142
		db NONE				; 143
		db NONE				; 144
		db NONE				; 145
		db NONE				; 146
		db NONE				; 147
		db NONE				; 148
		db NONE				; 149
		db NONE				; 150
		db NONE				; 151
		db DICE_XDY(4, dice_d16)	; 152
		db NONE				; 153
		db NONE				; 154
		db NONE				; 155
		db NONE				; 156
		db NONE				; 157
		db NONE				; 158
		db NONE				; 159
		db NONE				; 160
		db NONE				; 161
		db NONE				; 162
		db NONE				; 163
		db NONE				; 164
		db NONE				; 165
		db NONE				; 166
		db NONE				; 167
		db NONE				; 168
		db NONE				; 169
		db NONE				; 170
		db DICE_XDY(6, dice_d64)	; 171
		db DICE_XDY(8, dice_d32)	; 172
		db DICE_XDY(3, dice_d16)	; 173
		db DICE_XDY(10, dice_d32)	; 174
		db DICE_XDY(10, dice_d16)	; 175
		db DICE_XDY(8, dice_d64)	; 176
		db DICE_XDY(1, dice_d4)		; 177
		db NONE				; 178
		db NONE				; 179
		db NONE				; 180
		db NONE				; 181
		db NONE				; 182
		db NONE				; 183
		db DICE_XDY(4, dice_d8)		; 184
		db NONE				; 185
		db NONE				; 186
		db DICE_XDY(4, dice_d16)	; 187
		db NONE				; 188
		db NONE				; 189
		db NONE				; 190
		db DICE_XDY(4, dice_d16)	; 191
		db DICE_XDY(3, dice_d16)	; 192
		db DICE_XDY(4, dice_d16)	; 193
		db NONE				; 194
		db NONE				; 195
		db NONE				; 196
		db NONE				; 197
		db NONE				; 198
		db NONE				; 199
		db DICE_XDY(4, dice_d16)	; 200
		db NONE				; 201
		db NONE				; 202
		db NONE				; 203
		db NONE				; 204
		db NONE				; 205
		db NONE				; 206
		db NONE				; 207
		db NONE				; 208
		db NONE				; 209
		db NONE				; 210
		db NONE				; 211
		db DICE_XDY(8, dice_d32)	; 212
		db NONE				; 213
		db DICE_XDY(2, dice_d32)	; 214
		db NONE				; 215
		db NONE				; 216
		db NONE				; 217
		db NONE				; 218
		db DICE_XDY(8, dice_d4)		; 219
		db NONE				; 220
		db DICE_XDY(4, dice_d16)	; 221
		db NONE				; 222
		db NONE				; 223
		db NONE				; 224
		db NONE				; 225
		db NONE				; 226
		db NONE				; 227
		db NONE				; 228
		db NONE				; 229
		db NONE				; 230
		db NONE				; 231
		db NONE				; 232
		db NONE				; 233
		db NONE				; 234
		db NONE				; 235
		db NONE				; 236
		db NONE				; 237
		db NONE				; 238
		db NONE				; 239
		db NONE				; 240
		db NONE				; 241
		db NONE				; 242
		db NONE				; 243
		db NONE				; 244
		db DICE_XDY(10, dice_d32)	; 245
		db DICE_XDY(10, dice_d64)	; 246
		db DICE_XDY(10, dice_d4)	; 247
		db NONE				; 248
		db NONE				; 249
		db NONE				; 250
		db NONE				; 251
		db NONE				; 252
		db NONE				; 253
		db NONE				; 254
		db NONE				; 255
divert(`-1')
undefine(`NONE')
divert`'dnl
