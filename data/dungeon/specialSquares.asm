g_specialSquareFunctions	dd dunsq_battleCheck		;   0
				dd dunsq_doTrap			;   1
				dd dunsq_doDarkness		;   2
				dd dunsq_doSpinner		;   3
				dd dunsq_antiMagic		;   4
				dd dunsq_drainHp		;   5
				dd dunsq_somethingOdd		;   6
				dd dunsq_doSilence		;   7
				dd dunsq_regenSppt		;   8
				dd dunsq_drainSppt		;   9
				dd dunsq_monHostile		;  10
				dd dunsq_doStuck		;  11
				dd dunsq_regenHP		;  12
				dd dunsq_explosion		;  13
				dd dunsq_portalAbove		;  14
				dd dunsq_portalBelow		;  15

; Dungeon square flags are stored as bitmasks in three bytes.
; The following two arrays have the byte index and bitmask for
; the special squares in g_specialSquareFunctions.
;
; Example code:
;   for (i = 0; i < 16; i++) {
;     if (flags[g_specialSquareByteList[i] & g_specialSquareMaskList[i]) {
;	g_specialSquareFunctions[i]();
;     }
;   }
;
g_specialSquareByteList	db 0		;   0
			db 0		;   1
			db 0		;   2
			db 1		;   3
			db 1		;   4
			db 1		;   5
			db 1		;   6
			db 1		;   7
			db 1		;   8
			db 1		;   9
			db 1		;  10
			db 2		;  11
			db 2		;  12
			db 2		;  13
			db 0		;  14
			db 0		;  15

g_specialSquareMaskList	db 80h		;   0
			db 10h		;   1
			db 8		;   2
			db 1		;   3
			db 2		;   4
			db 4		;   5
			db 8		;   6
			db 10h		;   7
			db 20h		;   8
			db 40h		;   9
			db 80h		;  10
			db 80h		;  11
			db 40h		;  12
			db 10h		;  13
			db 40h		;  14
			db 20h		;  15
