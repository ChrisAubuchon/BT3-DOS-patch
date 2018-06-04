aThereIsAChestHere_Wil db 'There is a chest here. Will you:',0Ah,0Ah
		db '@Examine chest',0Ah
		db '@Open chest',0Ah
		db '@Disarm chest',0Ah
		db '@Trap Zap',0Ah
		db '@Leave chest',0
s_whoWillCastTrzp	db 'Who will cast a TRZP?',0
s_dontKnowThatSpell_	db 'You don',27h,'t know that spell.',0
		db    0
s_needTwoSpellPoints	db 'You need at least 2 spell points.',0
s_whoWillExamine	db 'Who will examine it?',0
		db    0
s_looksLike	db 'It looks like a ',0
		db    0
s_alreadyExamined	db 'That character has already checked.'
		db 0
s_foundNothing	db 'You found nothing.',0
		db    0
s_whoWillDisarm	db 'Who will disarm it?',0
s_enterTrapName	db 'Enter trap name:',0
		db    0
s_disarmFailed	db 'Disarm failed!',0
		db    0
s_youDisarmedIt	db 'You disarmed it!',0
		db    0
s_whoWillOpen	db 'Who will open it?',0
s_youSetOff	db 'You set off a ',0
		db    0

define(`ALL', `80h')
g_chestTrapFlags	db specialAttack_poison		; 0
			db specialAttack_poison		; 1
			db specialAttack_none		; 2
			db ALL				; 3
			db specialAttack_poison		; 4
			db specialAttack_poison		; 5
			db ALL				; 6
			db specialAttack_nutsify	; 7
			db specialAttack_poison		; 8
			db specialAttack_poison		; 9
			db ALL				; 10
			db specialAttack_spptDrain	; 11
			db specialAttack_poison or ALL	; 12
			db ALL				; 13
			db specialAttack_poison or ALL	; 14
			db specialAttack_poison or ALL	; 15
			db specialAttack_poison		; 16
			db specialAttack_nutsify	; 17
			db specialAttack_none		; 18
			db specialAttack_stone		; 19
			db specialAttack_poison or ALL	; 20
			db specialAttack_age    or ALL	; 21
			db 8				; 22
			db ALL				; 23
			db specialAttack_poison or ALL	; 24
			db specialAttack_poison or ALL	; 25
			db specialAttack_poison or ALL	; 26
			db specialAttack_poison or ALL	; 27
			db specialAttack_poison or ALL	; 28
			db specialAttack_poison or ALL	; 29
			db specialAttack_poison or ALL	; 30
			db specialAttack_poison or ALL	; 31
undefine(`ALL')
g_chestTrapDice	db 41h, 41h, 44h, 41h,	43h, 43h, 46h, 42h; 0
		db 45h,	45h, 47h, 46h, 47h, 48h, 47h, 47h; 8
		db 49h,	47h, 49h, 21h, 49h, 47h, 45h, 49h; 16
		db 49h,	49h, 49h, 49h, 49h, 49h, 49h, 49h; 24
g_chestTrapSaveData	saveStru 4 dup(<0Fh,	0Fh>); 0
		saveStru 4 dup(<13h, 13h>); 4
		saveStru 4 dup(<15h, 15h>); 8
		saveStru 4 dup(<18h, 18h>); 12
		saveStru 4 dup(<26h, 26h>); 16
		saveStru <27h, 27h>	; 20
		saveStru <28h, 28h>	; 21
		saveStru <27h, 27h>	; 22
		saveStru 9 dup(<28h, 28h>); 23
aChest		db 'Chest!',0
		db    0
g_chestTrapIndexToName	db 0		;  0 - Poison needle
			db 1		;  1 - Poison blades
			db 2		;  2 - Blades
			db 3		;  3 - Shockwave
			db 0		;  4 - Poison needle
			db 1		;  5 - Poison blades
			db 3		;  6 - Shockwave
			db 4		;  7 - Crazy cloud
			db 0		;  8 - Poison needle
			db 1		;  9 - Poison blades
			db 6		; 10 - Shocks
			db 5		; 11 - Vortex
			db 7		; 12 - Poison darts
			db 8		; 13 - Acid burst
			db 9		; 14 - Gas cloud
			db 9		; 15 - Gas cloud
			db 0Ah		; 16 - Poison Spikes
			db 0Bh		; 17 - Mind blast
			db 0Ch		; 18 - Mind jab
			db 0Dh		; 19 - Basilisk snare
			db 0Eh		; 20 - Death blades
			db 0Fh		; 21 - Codger bomb
			db 10h		; 22 - Swindler
			db 11h		; 23 - Hammer
			db 0Eh		; 24 - Death blades
			db 0Eh		; 25 - Death blades
			db 0Eh		; 26 - Death blades
			db 0Eh		; 27 - Death blades
			db 0Eh		; 28 - Death blades
			db 0Eh		; 29 - Death blades
			db 0Eh		; 30 - Death blades
			db 0Eh		; 31 - Death blades

s_chestPoisonNeedle	db 'Poison Needle',0
s_chestPoisonBlades	db 'Poison Blades',0
s_chestBlades		db 'Blades',0
s_chestShockwave	db 'Shock Wave',0
s_chestCrazyCloud	db 'Crazycloud',0
s_chestVortex		db 'Vortex',0
s_chestShocks		db 'Shocks',0
s_chestPoisonDarts	db 'Poison Darts',0
s_chestAcidBurst	db 'Acid Burst',0
s_chestGasCloud		db 'Gas Cloud',0
s_chestPoisonSpikes	db 'Poison Spikes',0
s_chestMindBlast	db 'Mind Blast',0
s_chestMindJab		db 'Mind Jab',0
s_chestBasiliskSnare	db 'Basilisk Snare',0
s_chestDeathBlades	db 'Death Blades',0
s_chestCodgerBomb	db 'Codger Bomb',0
s_chestSwindler		db 'Swindler',0
s_chestHammer		db 'Hammer',0
			db    0
g_chestTrapName	dd s_chestPoisonNeedle		; 0
		dd s_chestPoisonBlades		; 1
		dd s_chestBlades		; 2
		dd s_chestShockwave		; 3
		dd s_chestCrazyCloud		; 4
		dd s_chestVortex		; 5
		dd s_chestShocks		; 6
		dd s_chestPoisonDarts		; 7
		dd s_chestAcidBurst		; 8
		dd s_chestGasCloud		; 9
		dd s_chestPoisonSpikes		; 10
		dd s_chestMindBlast		; 11
		dd s_chestMindJab		; 12
		dd s_chestBasiliskSnare		; 13
		dd s_chestDeathBlades		; 14
		dd s_chestCodgerBomb		; 15
		dd s_chestSwindler		; 16
		dd s_chestHammer		; 17
g_chestActionFunctions	dd chest_examine, chest_open,	chest_disarm, chest_trapZap, chest_returnOne
