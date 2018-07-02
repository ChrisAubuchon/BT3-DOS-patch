s_templeGreeting	db 'Welcome, oh weary ones, to our humble temple.',0Ah
			db 'Dost thou wish to...',0Ah
			db 'Heal a character',0Ah
			db 'Pool thy gold',0Ah
			db 'Exit temple',0

s_whomGathersGold	db 'Whom shall gather thy gold?',0
s_hathAllTheGold	db ' now hath all the gold.',0
s_whoNeedsHealing	db 'Who needeth healing?',0
			db    0
s_isInBadShape		db ' is in bad shape, indeed. ',0
			db    0
s_templeGoldForfeit	db ' in gold. Who will forfeit the gold?',0
			db    0
s_sorryButWithoutProper	db 'Sorry, but without proper sacrifice the prayer will fail.',0
s_layHands		db 'The priests lay hands on ',0
s_elipsis		db '...',0
s_elipsisAnd		db '...and ',0
s_isHealed		db ' is healed!',0
s_drainedOfLife		db ' hath been drained of life force. ',0
			db    0
s_thouMustSacrifice	db	'Thou must sacrifice ',0
			db    0
s_dontNeedHealing	db ' does not require any healing.',0
			db    0
s_hasWounds		db ' has wounds which need tending. ',0
			db    0
s_donationWillBe	db 'The donation will be ',0

temple_healPrice	dw 0			; 0
			dw 400			; 1
			dw 300			; 2
			dw 900			; 3
			dw 1120			; 4
			dw 220			; 5
			dw 500			; 6
			dw 600			; 7
			dw 900			; 8

s_shrine		db 'Shrine',0
s_forestLawn		db 'Forest Lawn',0
s_alliria		db 'Alliria',0
s_twilightTemple	db 'Twilight Tmp',0

g_templeLocations	templeLoc_t <  8,   1,   0, 0>		; 0
			templeLoc_t < 10,   4,   3, 2>		; 1
			templeLoc_t <  2,   7,   6, 4>		; 2
			templeLoc_t <255, 255, 255, 6>		; 3

templeTitles		dd s_shrine					; 0
			dd s_forestLawn					; 1
			dd s_alliria					; 2
			dd s_twilightTemple				; 3

templeStatusBitmasks	db 2, 1, 10h, 40h, 20h, 8, 4, 0
templeHealPriceIndex	db 2, 1,   5,   7,   6, 4, 3, 0

statusHealMask		db 0FFh, 0FEh, 0FDh, 3, 3, 0EFh, 0DFh, 0BFh, 0FFh, 0
