define(`TRUE', `0FFh')dnl
define(`FALSE', `0')dnl

; The dun_buildView functions loops through this list and entries that
; are FALSE are not drawn.
;
; This is essentially:
;   for(x = 0; x < 62; x++) {
;     if (g_topologyEnabled == FALSE)
;       next;
;
g_topologyEnabled	db FALSE	;   0
			db FALSE	;   1
			db FALSE	;   2
			db FALSE	;   3
			db FALSE	;   4
			db FALSE	;   5
			db FALSE	;   6
			db FALSE	;   7
			db FALSE	;   8
			db FALSE	;   9
			db FALSE	;  10
			db FALSE	;  11
			db FALSE	;  12
			db FALSE	;  13
			db FALSE	;  14
			db TRUE		;  15
			db TRUE		;  16
			db TRUE		;  17
			db FALSE	;  18
			db FALSE	;  19
			db FALSE	;  20
			db FALSE	;  21
			db FALSE	;  22
			db FALSE	;  23
			db FALSE	;  24
			db FALSE	;  25
			db FALSE	;  26
			db TRUE		;  27
			db TRUE		;  28
			db FALSE	;  29
			db FALSE	;  30
			db TRUE		;  31
			db TRUE		;  32
			db TRUE		;  33
			db FALSE	;  34
			db FALSE	;  35
			db FALSE	;  36
			db FALSE	;  37
			db FALSE	;  38
			db FALSE	;  39
			db FALSE	;  40
			db FALSE	;  41
			db TRUE		;  42
			db TRUE		;  43
			db FALSE	;  44
			db TRUE		;  45
			db TRUE		;  46
			db TRUE		;  47
			db FALSE	;  48
			db FALSE	;  49
			db FALSE	;  50
			db FALSE	;  51
			db FALSE	;  52
			db FALSE	;  53
			db TRUE		;  54
			db TRUE		;  55
			db TRUE		;  56
			db TRUE		;  57
			db TRUE		;  58
			db TRUE		;  59
			db TRUE		;  60
			db FALSE	;  61
undefine(`TRUE', `FALSE')dnl
