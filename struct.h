invSlot_t struc	; (sizeof=0x3)
	itemFlags	db ?		; base 10
	itemNo		db ?
	itemCount	db ?
invSlot_t ends

monAttackStru struc ; (sizeof=0x2)
_type db ?
damage db ?
monAttackStru ends

spellString_t struc ; (sizeof=0x8)
abbreviation dd	?	; offset (00042670)
fullName dd ?		; offset (00042670)
spellString_t ends

character_t struc ; (sizeof=0x78)
	_name		db 16 dup(?)			; 0-15
	strength	db ?				; 16
	intelligence	db ?				; 17
	dexterity	db ?				; 18
	constitution	db ?				; 19
	luck		db ?				; 20
	experience	dd ?				; 21-24
	gold		dd ?				; 25-28
	level		dw ?				; 29-30
	maxLevel	dw ?				; 31-32
	currentHP	dw ?				; 33-34
	maxHP		dw ?				; 35-36
	currentSppt	dw ?				; 37-38
	maxSppt		dw ?				; 39-40
	class		db ?				; 41
	race		db ?				; 42
	gender		db ?				; 43		0 for	female.	1 for male
	picIndex	db ?				; 44
	status		db ?				; 45
	ac		db ?				; 46
	acBase		db ?				; 47
	inventory	invSlot_t 12 dup({?,?,?})	; 48-83
	spells		db 16 dup(?)			; 84-99
	specAbil	db 4 dup(?)			; 100-103
	hostileFlag	db ?				; 104
	numAttacks	db ?				; 105
	savedST		db ?				; 106
	savedIQ		db ?				; 107
	savedDX		db ?				; 108
	savedCN		db ?				; 109
	savedLK		db ?				; 110
	strongElement	db ?				; 111
	weakElement	db ?				; 112
	repelFlags	db ?				; 113
	chronoQuest	db 6 dup(?)			; 114-119
character_t ends

summonStat_t struc ; (sizeof=0x78)
	_name		db 16 dup(?)			; 0-15
	field_10	db ?				; 16
	field_11	db ?				; 17
	field_12	db ?				; 18
	field_13	db ?				; 19
	field_14	db ?				; 20
	breathSaveLo	db ?				; 21
	breathSaveHi	db ?				; 22
	priorityLo	db ?				; 23
	priorityHi	db ?				; 24
	gold		dd ?				; 25-28
	field_1D	db ?				; 29
	field_1E	db ?				; 30
	field_1F	db ?				; 31
	field_20	db ?				; 32
	curHP		dw ?				; 33-34
	maxHP		dw ?				; 35-36
	field_25	db ?				; 37
	field_26	db ?				; 38
	field_27	db ?				; 39
	field_28	db ?				; 40
	class		db ?				; 41
	field_2A	db ?				; 42
	pronoun		db ?				; 43
	picIndex	db ?				; 44
	status		db ?				; 45
	field_2E	db ?				; 46
	acBase		db ?				; 47
	field_30	invSlot_t 12 dup({?,?,?})	; 48-83
	attacks		monAttackStru 4	dup({?,?})	; 84-91
	breathFlag	db ?				; 92
	breathRange	db ?				; 93
	field_5E	db ?				; 94
	field_5F	db ?				; 95
	toHitLo		db ?				; 96
	toHitHi		db ?				; 97
	spellSaveLo	db ?				; 98
	spellSaveHi	db ?				; 99
	field_64	db ?				; 100
	field_65	db ?				; 101
	field_66	db ?				; 102
	field_67	db ?				; 103
	hostileFlag	db ?				; 104
	numAttacks	db ?				; 105
	field_6A	db ?				; 106
	field_6B	db ?				; 107
	field_6C	db ?				; 108
	field_6D	db ?				; 109
	field_6E	db ?				; 110
	strongElement	db ?				; 111
	weakElement	db ?				; 112
	repelFlags	db ?				; 113
	chronoQuest	db 6 dup(?)			; 114-119
summonStat_t ends

startingAttrBase struc ; (sizeof=0xA)
male_st	db ?		; base 10
male_iq	db ?		; base 10
male_dx	db ?		; base 10
male_cn	db ?		; base 10
male_lk	db ?		; base 10
female_st db ?		; base 10
female_iq db ?		; base 10
female_dx db ?		; base 10
female_cn db ?		; base 10
female_lk db ?		; base 10
startingAttrBase ends

startingClass_t	struc ;	(sizeof=0xA)
canBeWarrior db	?
canBeWizard db ?
canBeSorcerer db ?
canBeConjurer db ?
canBeMagician db ?
canBeRogue db ?
canBeBard db ?
canBePaladin db	?
canBeHunter db ?
canBeMonk db ?
startingClass_t	ends

bii_char_t struc ; (sizeof=0x67)
_name db 16 dup(?)	; string(C)
fileType db ?
status dw ?
race db	?
class db ?
strength db ?
intelligence db	?
dexterity db ?
constitution db	?
luck db	?
maxST db ?
maxIQ db ?
maxDX db ?
maxCN db ?
maxLK db ?
sum_magicResist	dw ?
ac dw ?
maxHp dw ?
currentHP dw ?
maxSppt	dw ?
currentSppt dw ?
inventory dw 8 dup(?)
field_3B db ?
field_3C db ?
field_3D db ?
field_3E db ?
field_3F db ?
field_40 db ?
field_41 db ?
field_42 db ?
experience dd ?
gold dd	?
level db ?
maxLevel db ?
sorcLevel db ?
conjLevel db ?
magiLevel db ?
wizdLevel db ?
archLevel db ?
field_52 db ?
field_53 db ?
field_54 db ?
field_55 db ?
songsLeft db ?
field_57 db ?
doppelgangerFlag db ?
field_59 db ?
numAttacks db ?
field_5B db ?
field_5C db ?
field_5D db ?
field_5E db ?
field_5F db ?
sum_attackTypes	db 4 dup(?)
field_64 db ?
specialStatus db ?
dmgRange db ?
bii_char_t ends

bi_char_t struc	; (sizeof=0x6D)
_name db 16 dup(?)	; string(C)
field_10 db ?
status dw ?
race dw	?
class dw ?
strength dw ?
intelligence dw	?
dexterity dw ?
constitution dw	?
luck dw	?
maxST dw ?
maxIQ dw ?
maxDX dw ?
maxCN dw ?
maxLK dw ?
ac dw ?
maxHP dw ?
currentHP dw ?
currentSppt dw ?
maxSppt	dw ?
inventory dw 8 dup(?)
experience dd ?
gold dd	?
level dw ?
field_4F dw ?
sorcLevel db ?
conjLevel db ?
magiLevel db ?
wizdLevel db ?
field_55 dw ?
field_57 dw ?
field_59 dw ?
field_5B dw ?
songsLeft dw ?
field_5F dw ?
field_61 dw ?
field_63 dw ?
numAttacks dw ?
field_67 dw ?
field_69 dw ?
field_6B dw ?
bi_char_t ends

levelFile_t struc ; (sizeof=0x2)
fileType db ?		
; enum levelFile
fileIndexMaybe db ?	; base 10
levelFile_t ends

memoryPointer struc ; (sizeof=0x4)
_offset	dw ?
_segment dw ?		; seg
memoryPointer ends

map_t struc ; (sizeof=0x19)
_name db 16 dup(?)	; string(C)
_width db ?
_height	db ?
wrapFlag db ?
monsterIndex db	?
levFlags db ?
dataOffset dw ?
rowOffset dw ?
map_t ends

dun_t struc ; (sizeof=0x22)
_name db 16 dup(?)	; string(C)
levFlags db ?
levelNum db ?
dunLevel db 8 dup(?)
exitSqN	db ?
exitSqE	db ?
exitLocation db	?
monIndex db ?
_width db ?
_height	db ?
deltaSqE db ?
deltaSqN db ?
dun_t ends

dunSq_t struct ; (sizeof=0x5)
	walls		dw ?
	flags		dw ?
	extraFlags	db ?
dunSq_t ends

viewStruct struc ; (sizeof=0x2)
deltaEast db ?		; base 10
deltaNorth db ?		; base 10
viewStruct ends

coordinate_t struc	; (sizeof=0x2)
column	db ?		; base 10
row	db ?		; base 10
coordinate_t ends

campStru_t struc ; (sizeof=0x9)
hasEmptySlot db	?
notEmpty db ?
isEmpty	db ?
canSaveChar db ?
canSaveChar_1 db ?
field_5	db ?
field_6	db ?
field_7	db ?
hasInactSlot db	?
campStru_t ends

mon_t struc ; (sizeof=0x30)
_name db 16 dup(?)	; string(C)
hpDice db ?
hpBase dw ?
distance db ?				; Low 4 bits is current distance 
					; High 4 is amount to advance
packedGenAc db ?
groupSize db ?
attackType monAttackStru 4 dup({?,?})
breathFlag db ?
breathRange db ?
picIndex db ?
rewardLo db ?
rewardMid db ?
rewardHi db ?
flags db ?
breathSaveLo db	?
breathSaveHi db	?
oppPriorityLo db ?
oppPriorityHi db ?
strongElement db ?
weakElement db ?
	repelFlags db ?
toHitLo	db ?
toHitHi	db ?
spellSaveLo db ?
spellSaveHi db ?
mon_t ends

breathAtt_t struc ; (sizeof=0x7)
	specialAttack	db ?
	elements	db ?		; Damage is halved or doubled based on the bitmask
					; here...
	attackString	db ?
	repelFlags	db ?
	damage		db ?
	breathFlags	db ?
	levelMultiplier	db ?		; If this flag is zero then the	damage is multiplied
					; by the character level
breathAtt_t ends

weaponDamage_t struc ; (sizeof=0x6)
	specialAttack	db ?
	elements	db ?
	damage		db ?
	breathFlags	db ?
	levelMultiplier	db ?
	attackRange	db ?
weaponDamage_t ends

spellAdvance struc ; (sizeof=0x2)
levelBase db ?		; base 10
numSpells db ?		; base 10
spellAdvance ends

tavernLoc_t struc ; (sizeof=0x5)
sqN db ?		; base 10
sqE db ?		; base 10
location db ?		; base 10
field_3	db ?		; base 10
sayingBase	db ?		; base 10
tavernLoc_t ends

templeLoc_t struc ; (sizeof=0x4)
sqN db ?		; base 10
sqE db ?		; base 10
location db ?		; base 10
field_3	db ?		; base 10
templeLoc_t ends

saveStru struc ; (sizeof=0x2)
lo db ?
hi db ?
saveStru ends

geomanSp_t struc ; (sizeof=0x2)
_byte db ?
bitmask	db ?
geomanSp_t ends

sprintfStru	struc ; (sizeof=0xB)
	inString_0	dd ?
	stringLength	dw ?
	inString_1	dd ?
	someChar	db ?
sprintfStru	ends

mouseBox_t	struc ; (sizeof=0x8)
	_top		dw ?
	_left		dw ?
	_bottom		dw ?
	_right		dw ?
mouseBox_t	ends

trapSave_t	struc
	_low		db ?
	_high		db ?
trapSave_t	ends

characterAction_t	struc
	attackOpt	db ?
	defendOpt	db ?
	partyAttackOpt	db ?
	castOpt		db ?
	useOpt		db ?
	hideOpt		db ?
	songOpt		db ?
characterAction_t	ends

partyAction_t		struc
	meleeOpt	db ?
	advanceOpt	db ?
	runOpt		db ?
partyAction_t		ends
