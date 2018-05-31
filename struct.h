invSlot_t struc	; (sizeof=0x3)
itemFlags db ?		; base 10
itemNo db ?
itemCount db ?
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
_name db 16 dup(?)
strength db ?		; base 10
intelligence db	?	; base 10
dexterity db ?		; base 10
constitution db	?	; base 10
luck db	?		; base 10
experience dd ?
gold dd	?
level dw ?
maxLevel dw ?
currentHP dw ?		; These	might be flip-flopped
maxHP dw ?
currentSppt dw ?
maxSppt	dw ?
class db ?
race db	?		; base 10
gender db ?		; 0 for	female.	1 for male
picIndex db ?		; base 10
status db ?
ac db ?			; base 10
acBase db ?
inventory invSlot_t 12 dup({?,?,?})
spells db 16 dup(?)
specAbil db 4 dup(?)
hostileFlag db ?
numAttacks db ?
savedST	db ?
savedIQ	db ?
savedDX	db ?
savedCN	db ?
savedLK	db ?
strongElement db ?
weakElement db ?
	repelFlags db ?
chronoQuest db 6 dup(?)
character_t ends

summonStat_t struc ; (sizeof=0x78)
_name db 16 dup(?)	; string(C)
field_10 db ?
field_11 db ?
field_12 db ?
field_13 db ?
field_14 db ?
breathSaveLo db	?
breathSaveHi db	?
priorityLo db ?
priorityHi db ?
gold dd	?
field_1D db ?
field_1E db ?
field_1F db ?
field_20 db ?
curHP dw ?
maxHP dw ?
field_25 db ?
field_26 db ?
field_27 db ?
field_28 db ?
class db ?
field_2A db ?
pronoun	db ?
picIndex db ?
status db ?
field_2E db ?
acBase db ?
field_30 invSlot_t 12 dup({?,?,?})
attacks	monAttackStru 4 dup({?,?})
breathFlag db ?
breathRange db ?
field_5E db ?
field_5F db ?
toHitLo	db ?
toHitHi	db ?
spellSaveLo db ?
spellSaveHi db ?
field_64 db ?
field_65 db ?
field_66 db ?
field_67 db ?
hostileFlag db ?
numAttacks db ?
field_6A db ?
field_6B db ?
field_6C db ?
field_6D db ?
field_6E db ?
strongElement db ?
weakElement db ?
	repelFlags db ?
chronoQuest db 6 dup(?)
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
effectStrIndex db ?
elements db ?		; Damage is halved or doubled based on the bitmask
			; here...
breathFlag db ?
	repelFlags db ?		; This field holds a bitmask for targetting certain
			; types. If the	mask is	not set	in the target the
			; target repels	the spell
damage db ?
targetFlags db ?
levelMult db ?		; If this flag is zero then the	damage is multiplied
			; by the character level
breathAtt_t ends

anotherBreathAtt_t struc ; (sizeof=0x6)
effectStrIndex db ?
elements db ?
	repelFlags db ?
damage db ?
targetFlags db ?
levelMult db ?
anotherBreathAtt_t ends

spellAdvance struc ; (sizeof=0x2)
levelBase db ?		; base 10
numSpells db ?		; base 10
spellAdvance ends

tavernLoc_t struc ; (sizeof=0x5)
sqN db ?		; base 10
sqE db ?		; base 10
location db ?		; base 10
field_3	db ?		; base 10
field_4	db ?		; base 10
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
