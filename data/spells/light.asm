g_lightDistanceList	db 3			; 0 splf_mageflame
			db 4			; 1 splf_lesserrev
			db 5			; 2 splf_greaterrev
			db 5			; 3 splf_cateyes
			db 2			; 4
			db 2			; 5

; This is a holdover from previous games. A value of 0xFF indicates
; that secret doors are visible.
g_lightDetectionList	db 0			; 0 splf_mageflame
			db 0FFh			; 1 splf_lesserrev
			db 0FFh			; 2 splf_greaterrev
			db 0			; 3 splf_cateyes
			db 0			; 4
			db 0			; 5

define(`INFINITE', `0FFh')dnl
g_lightDurationList	db 4			; 0 splf_mageflame
			db 0Ch			; 1 splf_lesserrev
			db 10h			; 2 splf_greaterrev
			db INFINITE		; 3 splf_cateyes
			db 4			; 4
			db 8			; 5
undefine(`INFINITE')dnl
