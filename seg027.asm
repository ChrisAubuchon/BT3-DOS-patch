; Segment type:	Regular
seg027 segment para public 'DATA' use16
	assume cs:seg027
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_41E50	db 4 dup(0)		; 0
songRegenSppt	db 0
monDisbelieveFlag	db 0
isNight		db 0
byte_41E57	db 0
vorpalPlateBonus	db 7 dup(0)
align 2
antiMagicFlag	db 0
gl_detectSecretDoorFlag	db 0
g_currentSinger	db 0
byte_41E63	db 0
g_charActionList db 7	dup(0)		   ; 0
unk_41E6B	db	0
word_41E6C	dw 0
trapIndex	dw 0
g_charFreezeToHitBonus	db 0
byte_41E71	db 0
g_strengthSpellBonus	db 7 dup(0)	      ;	0
byte_41E79	db 0
mapWidth	db 0
align 2
batRewardLo	dw 0
batRewardHi	dw 0
mapHeight	db 0
byte_41E81	db 0
party		character_t <>
partySecondSlot	character_t <>
		character_t <>
		character_t <>
		character_t <>
		character_t <>
partyTail	character_t <>
newCharBuffer	character_t <>
g_lastDetectSqN	db 0
		db 0
g_batCharActionTarget	db 0
		db 0
		db 0
		db 0
		db 0
		db 0
		db 0
		db 0
bat_curSong	db 0
bat_curTarget	db 0
musicBufs	memoryPointer	8 dup(<0>)
monFrozenFlag	db 0
		db 0
g_monFreezeAcPenalty	db 0
		db 0
		db 0
		db 0
g_charFreezeAcPenalty	db 0
		db 0
g_batCharSpellTarget	db 7 	dup(0)
		db 0
g_usedItemSlotNumber	db 0
		db 0

; Range that a character can execute a melee attack. Increment when
; a rogue successfully hides 
g_characterMeleeDistance	db 7	dup(0)
align 2
g_userSlotNumber	db 0
g_wildWrapFlag	db	0
		db    0
g_batNoCryFlag	db 0
mapRval		dw 0
byte_4228E	db 0
align 2
mapDataOff	dw 0
mapDataSeg	dw 0
word_42294	dw 0
byte_42296	db 0
align 2
g_chestExamined	dw 0
byte_4229A	db 0
sqRegenHPFlag	db 0
monSpellToHitPenalty	db 4	dup(0)		   ; 0
byte_422A0	db 0
align 2
specialAttackVal	dw 0
byte_422A4	db 0
		db    0
bat_charPriority 	db 7 dup(0)		 ; 0
		db 0
wallIsPhased	db 0
		db 0
rowOffset	dd 20h dup(0)		  ; 0 ;	This array holds the offsets into the maps-lo|hi-XX
			; file for the rows. This makes	it easy	to index into
			; the map. To access a square rowOffset[sqNorth]+sqEast
word_42330	dw 0
partyFrozenFlag	db 0
		db    0
g_batCharUseISlotNumber	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
songExtraAttack	db 0
align 2
word_4233E	dw 0
bigpicCellNumber	db 0
align 2
monGroups	mon_t <>
g_monGroupsNext	mon_t <>
		mon_t <>
		mon_t <>
levelChangedFlag	dw 0
summonMeleeDamage	dw 0
regenSpptSq	db 0
align 2
summonMeleeType	dw 0
bigpicCellData_off	dw 0
bigpicCellData_seg	dw 0
g_disbelieveFlags	db 0
align 2
word_42410	dw 0
g_damageAmount	dw 0
stuckFlag	db 0
align 2
g_inventoryPackStart	dw 0
db    0
g_currentCharPosition	db 0
g_text_clearFlag	db 0
txt_numLines	db 0
songAntiMonster	db 0
align 2
g_currentMouseIcon	dw 0
g_currentSong	db 0
db    0
monAttackBonus	db 4	dup(0)		   ; 0
mfunc_ioBuf	db 10h dup(0)	    ; 0
g_currentVmFunction	dd 0
word_4243A	dw 0
word_4243C	dw 0
word_4243E	dw 0
g_divineDamageBonus	db 0
g_runAwayFlag	db 0
songRegenHP	db 0
db    0
byte_42444	db 7	dup(0)
align 2
g_inventoryPackTarget	dw 0
partySpellAcBonus	db 0
align 2
advanceTimeFlag	dw 0
breakAfterFunc	dw 0
sq_antiMagicFlag		db 0
align 2
word_42456	dw 0
g_nonRandomBattleFlag	db 0
align 2
word_4245A	dw 0
g_monHpList	dw 80h dup(0)		  ; 0
songCanRun	db 0
g_lastDetectSqE	db 0
align 2
word_42560	dw 0
word_42562	dw 0
word_42564	dw 0
g_lastDetectDirection	db 0
g_monsterWOFBonus	db 0
g_songAcBonus	db 0
songHalfDamage	db 0
bat_monPriorityList dw 80h dup(0)	    ; 0
bat_monBeenHitList dw 80h dup(0)
		db    0
g_currentSongPlusOne	db 0
align 8
seg027 ends
