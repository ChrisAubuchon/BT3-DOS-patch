s_detectTrap		db 'A trap is near!',0
s_detectStairs		db 'There are stairs near...',0
s_detectSpecial		db 'Something special is near...',0
s_detectSpinner		db 'A spinner is near...',0
s_detectAntimagic	db 'Your spells waver...',0
s_detectSomethingAhead	db 'Something ahead...',0
s_detectOdd		db 'Odd...',0
s_detectQuiet		db 'Awfully quiet ahead...',0

detectMessages	dd s_detectTrap			; 0
		dd s_detectStairs		; 1
		dd s_detectSpecial		; 2
		dd s_detectSpinner		; 3
		dd s_detectAntimagic		; 4
		dd s_detectSomethingAhead	; 5
		dd s_detectOdd			; 6
		dd s_detectQuiet		; 7
