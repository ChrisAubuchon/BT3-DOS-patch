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
byte_41E62	db 0
byte_41E63	db 0
charActionList db 7	dup(0)		   ; 0
unk_41E6B	db	0
word_41E6C	dw 0
trapIndex	dw 0
byte_41E70	db 0
byte_41E71	db 0
strengthBonus	db 7 dup(0)	      ;	0
byte_41E79	db 0
mapWidth	db 0
align 2
batRewardLo	dw 0
batRewardHi	dw 0
mapHeight	db 0
byte_41E81	db 0
roster		character_t <>
stru_41EFA	character_t <>
		character_t <>
		character_t <>
		character_t <>
		character_t <>
rosterTail	character_t <>
newCharBuffer	character_t <>
byte_42242	db 0
		db 0
byte_42244	db 0
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
byte_42270	db 0
		db 0
		db 0
		db 0
byte_42274	db 0
		db 0
byte_42276	db 0
		db 0
		db 0
		db 0
		db 0
		db 0
		db 0
		db 0
byte_4227E	db 0
		db 0
byte_42280	db 6	dup(0)		   ; 0
byte_42286	db 0
align 2
byte_42288	db 0
wildWrapFlag	db	0
		db    0
byte_4228B	db 0
mapRval		dw 0
byte_4228E	db 0
align 2
mapDataOff	dw 0
mapDataSeg	dw 0
word_42294	dw 0
byte_42296	db 0
align 2
word_42298	dw 0
byte_4229A	db 0
sqRegenHPFlag	db 0
byte_4229C	db 4	dup(0)		   ; 0
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
byte_42334	db 0
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
bigpicImageNo	db 0
align 2
monGroups	mon_t <>
stru_42372	mon_t <>
		mon_t <>
		mon_t <>
levelChangedFlag	dw 0
summonMeleeDamage	dw 0
regenSpptSq	db 0
align 2
summonMeleeType	dw 0
word_4240A	dw 0
word_4240C	dw 0
disbelieveFlags	db 0
align 2
word_42410	dw 0
damageAmount	dw 0
stuckFlag	db 0
align 2
word_42416	dw 0
db    0
byte_42419	db 0
byte_4241A	db 0
txt_numLines	db 0
songAntiMonster	db 0
align 2
word_4241E	dw 0
byte_42420	db 0
db    0
byte_42422	db 4	dup(0)		   ; 0
mfunc_ioBuf	db 10h dup(0)	    ; 0
dword_42436	dd 0
word_4243A	dw 0
word_4243C	dw 0
word_4243E	dw 0
byte_42440	db 0
runAwayFlag	db 0
songRegenHP	db 0
db    0
byte_42444	db 7	dup(0)
align 2
word_4244C	dw 0
byte_4244E	db 0
align 2
advanceTimeFlag	dw 0
breakAfterFunc	dw 0
sq_antiMagicFlag		db 0
align 2
word_42456	dw 0
byte_42458	db 0
align 2
word_4245A	dw 0
monHpList	dw 80h dup(0)		  ; 0
songCanRun	db 0
byte_4255D	db 0
byte_4255E	db 0
align 2
word_42560	dw 0
word_42562	dw 0
word_42564	dw 0
byte_42566	db 0
byte_42567	db 0
songACBonus	db 0
songHalfDamage	db 0
bat_monPriorityList dw 80h dup(0)	    ; 0
		db    0
byte_4266B	db 0
align 8
seg027 ends