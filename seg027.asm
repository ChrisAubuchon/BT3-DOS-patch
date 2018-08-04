byte_41E50	db 4 dup(0)		; 0
g_songRegenerateSppt	db 0
g_monsterDisbelieveFlag	db 0
g_isNightFlag		db 0
byte_41E57	db 0				; Unused
g_vorpalPlateBonus	db 7 dup(0)
align 2
g_spellAntiMagicValue	db 0
g_detectSecretDoorFlag	db 0
g_currentSinger	db 0
g_diminishingEffectSaveBonus	db 0
g_charActionList db 7	dup(0)		   ; 0
unk_41E6B	db	0			; Unused

include(`data/timers.asm')

g_trapIndex	dw 0
g_charFreezeToHitBonus	db 0
byte_41E71	db 0				; Unused
g_strengthSpellBonus	db 7 dup(0)	      ;	0
byte_41E79	db 0				; Unused
g_wildMapWidth	db 0
g_wildMapHeight	db 0
g_battleXpReward	dd 0
g_unusedDrainHpFlag	db 0
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
g_userSlotNumber	db 0
g_wildWrapFlag	db	0
		db    0
g_batNoCryFlag	db 0
mapRval		dw 0

; Might be a debugging flag. When non-zero (and not set to zero in savingThrowCheck)
; forces savingThrow_calculate to return the value set.
;
g_debugSavingThrowValue	db 0
g_mapData	dd 0
g_noPauseFlag	db 0
g_chestExamined	dw 0
byte_4229A	db 0				; Unused
g_squareHpRegenFlag	db 0
g_monsterSpellToHitPenalty	db 4	dup(0)		   ; 0
g_hideMouseInBigpicFlag	db 0
g_specialAttackValue	dw 0
g_inBattleFlag	db 0
		db    0
g_battleCharacterPriorities 	db 7 dup(0)		 ; 0
		db 0
g_wallPhasedFlag	db 0
		db 0
g_rowOffset	dd 20h dup(0)		; This array holds the offsets into the maps-lo|hi-XX
					; file for the rows. This makes	it easy	to index into
					; the map. To access a square g_rowOffset[sqNorth]+sqEast
g_partyFrozenFlag	db 0
		db    0
g_batCharUseISlotNumber	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
g_songExtraAttackFlag	db 0
g_bigpicAnimationCelNumber	db 0
g_monGroups	mon_t <>
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
g_damageAmount	dw 0
stuckFlag	db 0
g_inventoryPackStart	dw 0
db    0
g_currentCharPosition	db 0
g_text_clearFlag	db 0
txt_numLines	db 0
songAntiMonster	db 0
g_currentMouseIcon	dw 0
g_currentSong	db 0
db    0
monAttackBonus	db 4	dup(0)		   ; 0
mfunc_ioBuf	db 10h dup(0)	    ; 0
g_currentVmFunction	dd 0
g_configuredFlag	dw 0
g_avConfiguration	dw 0
g_unusedConfiguration	dw 0
g_divineDamageBonus	db 0
g_runAwayFlag	db 0
songRegenHP	db 0
db    0
g_unusedBattleAcBonus	db 7	dup(0)
g_inventoryPackTarget	dw 0
partySpellAcBonus	db 0
advanceTimeFlag	dw 0
breakAfterFunc	dw 0
g_squareAntiMagicFlag		db 0
g_nonRandomBattleFlag	db 0
g_bigpicCelTimer	dw 0
g_monHpList	dw 80h dup(0)		  ; 0
songCanRun	db 0
g_lastDetectSqE	db 0
g_bigpicLongerCelDelay	dw 0
word_42562	dd 0
g_lastDetectDirection	db 0
g_monsterWOFBonus	db 0
g_songAcBonus	db 0
songHalfDamage	db 0
bat_monPriorityList dw 80h dup(0)	    ; 0
bat_monBeenHitList dw 80h dup(0)
		db    0
g_currentSongPlusOne	db 0
align 8
