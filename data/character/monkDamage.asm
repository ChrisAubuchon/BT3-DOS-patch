dnl	The index into this array is (monkLevel >> 2) with a max of 15.
dnl	A level 60 monk does 16d32 damage
dnl
g_monkDamageDice	db DICE_XDY(1, dice_d4)		;   0
			db DICE_XDY(2, dice_d4)		;   1
			db DICE_XDY(3, dice_d4)		;   2
			db DICE_XDY(4, dice_d4)		;   3
			db DICE_XDY(5, dice_d4)		;   4
			db DICE_XDY(6, dice_d4)		;   5
			db DICE_XDY(7, dice_d4)		;   6
			db DICE_XDY(8, dice_d4)		;   7
			db DICE_XDY(9, dice_d16)	;   8
			db DICE_XDY(10, dice_d16)	;   9
			db DICE_XDY(11, dice_d16)	;  10
			db DICE_XDY(12, dice_d16)	;  11
			db DICE_XDY(13, dice_d16)	;  12
			db DICE_XDY(14, dice_d16)	;  13
			db DICE_XDY(15, dice_d16)	;  14
			db DICE_XDY(16, dice_d32)	;  15
