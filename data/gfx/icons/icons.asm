; The horizontal offset of the icon
;
g_iconXOffset	db 80		; icon_light
		db 92		; icon_compass
		db 108		; icon_areaEnchant
		db 124		; icon_shield
		db 136		; icon_levitation
		db 0

; Pixel height of the icon
;
g_iconHeight	db 19		; icon_light
		db 26		; icon_compass
		db 17		; icon_areaEnchant
		db 20		; icon_shield
		db 16		; icon_levitation
		db 0

; Pixel width of the icon
;
g_iconWidth	db 12		; icon_light
		db 16		; icon_compass
		db 16		; icon_areaEnchant
		db 12		; icon_shield
		db 20		; icon_levitation
		db 0

; Pointers to buffers holding pixel data
;
g_iconDataPointers	dd g_iconLight			; icon_light
			dd g_iconCompass		; icon_compass
			dd g_iconAreaEnchant		; icon_areaEnchant
			dd g_iconShield			; icon_shield
			dd g_iconLevitation		; icon_levitation

; Length of each icons data cell
;
g_iconCellDataLength	dw 228		; icon_light
			dw 416		; icon_compass
			dw 272		; icon_areaEnchant
			dw 240		; icon_shield
			dw 320		; icon_levitation

; The last drawn cell of the icon. g_iconCurrentCell is
; incremented to animate the icon. The value stored here
; is compared to g_iconCurrentCell and if they are different
; then the new current cell is drawn and this value is updated.
;
g_iconLastDrawnCell	db 0		; icon_light
			db 0		; icon_compass
			db 0		; icon_areaEnchant
			db 0		; icon_shield
			db 0		; icon_levitation
			db 0

; The realtime event cycles between icon updates.
; The compass and shield icons are not animated
;
g_iconAnimationDelay	db 2		; icon_light
			db 0		; icon_compass
			db 4		; icon_areaEnchant
			db 0		; icon_shield
			db 3		; icon_levitation
			db 0

; The current delay value. When the icon is updated, these values
; are set to the corresponding values in g_iconAnimationDelay. They
; are decremented every realtime event cycle. When the counter reaches
; zero the animation is updated.
;
g_iconCurrentDelay	db 0		; icon_light
			db 0		; icon_compass
			db 0		; icon_areaEnchant
			db 0		; icon_shield
			db 0		; icon_levitation
			db 0

; The index into the data buffers of the cell that clears the 
; icon.
;
g_iconClearIndex	db 4		; icon_light
			db 4		; icon_compass
			db 4		; icon_areaEnchant
			db 1		; icon_shield
			db 4		; icon_levitation
			db 0

; Current animation cell of the icon
;
g_iconCurrentCell	db 0		; icon_light
			db 0		; icon_compass
			db 0		; icon_areaEnchant
			db 0		; icon_shield
			db 0		; icon_levitation
			db 0
