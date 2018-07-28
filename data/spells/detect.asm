; This array has the starting index into the g_detectByte
; array for the detect spell type
;
g_detectStartList	db 0		;   0
			db 2		;   1
			db 4		;   2
			db 0		;   3

; This array holds the flag byte to detect certain
; types of squares
;
define(`END', `0FFh')dnl
g_detectByte	db detectByte_trap		;   0
		db END				;   1
		db detectByte_stairs		;   2
		db END				;   3
		db detectByte_trap		;   4
		db detectByte_stairs		;   5
		db detectByte_special		;   6
		db detectByte_spinner		;   7
		db detectByte_antiMagic		;   8
		db detectByte_something		;   9
		db detectByte_odd		;  10
		db detectByte_quiet		;  11
		db detectByte_regenSppt		;  12
		db END				;  13
undefine(`END')dnl

; This array holds the bitmasks to detect certain types of squares
;
define(`END', `0')
g_detectMask	db detectMask_trap		;   0
		db END				;   1
		db detectMask_stairs		;   2
		db END				;   3
		db detectMask_trap		;   4
		db detectMask_stairs		;   5
		db detectMask_special		;   6
		db detectMask_spinner		;   7
		db detectMask_antiMagic		;   8
		db detectMask_something		;   9
		db detectMask_odd		;  10
		db detectMask_quiet		;  11
		db detectMask_regenSppt		;  12
		db END				;  13
undefine(`END')dnl

define(`END', `0')dnl
g_detectMessageIndex	db detectMessage_trap		;   0
			db END				;   1
			db detectMessage_stairs		;   2
			db END				;   3
			db detectMessage_trap		;   4
			db detectMessage_stairs		;   5
			db detectMessage_special	;   6
			db detectMessage_spinner	;   7
			db detectMessage_antiMagic	;   8
			db detectMessage_something	;   9
			db detectMessage_odd		;  10
			db detectMessage_quiet		;  11
			db detectMessage_something	;  12
			db END				;  13
undefine(`END')dnl
