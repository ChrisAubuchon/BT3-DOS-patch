; Various runtime variables
;
breathAttack    breathAtt_t <0, 0, 0, 0, 0, 41h, 1>; 0
                db    0
word_4414E	dw 0FFh
g_printPartyFlag	dw 1
g_soundActiveFlag	dw 1
randomSeed	dw 0
g_locationNumber dw	0
dunLevelIndex	dw 0
g_dunLevelNum	dw 0
g_sqNorth	dw 0
g_sqEast		dw 0
g_direction	dw 0
inDungeonMaybe	dw 0
g_mapRval dw 0
g_sameSquareFlag	dw 0
g_curSpellNumber	dw 0
g_gameProgressFlags	db 7 dup(0)     ; 0
byte_4EE71	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
g_vm_registers	dw 20h dup(0)	    ; 0
g_currentHour	db 0
lightDistance	db 0
g_songDuration	db 0
lightDuration		db 0
compassDuration		db 0
detectDuration		db 0
shieldDuration		db 0
levitationDuration	db 0
g_detectType		db 0
g_levelNumber	db 0
g_levelFlags	db 0
g_dunWidth	db 0
g_dunHeight	db 0
g_monsterGroupCount	db 0
g_partyAttackFlag	db 0
shieldAcBonus	db 0
byte_4EECC	db 0
include(`data/text/minimapCharacters.asm')
s_faster		db 0Ah,'<Faster...>',0Ah,0
s_slower		db 0Ah,'<Slower...>',0Ah,0
txtDelayTable	db 1, 4, 7, 0Bh, 0Eh, 11h, 14h, 17h, 1Ah, 1Dh
txtDelayIndex	db 7
g_tockClicks	dw 0
g_totalClockTicks	dw 0
g_mousePresentFlag1	db 0		; 1 when a mouse is detected
g_mouseButtonDownFlag	db 0		; When 0, register the next mouse button press
					; as a mouse input
align 4
g_mouseButtonDown	db 0
g_mouseButtonClicked	db 0		; When non-zero process the mouse click as an input
spell_mouseClicked	db 0
g_mouseMoved	db 0
g_mouseX		dw 0DCh
g_mouseY		dw 0
word_4EF59	dw 0
word_4EF5B	dw 0
byte_4EF5D	db 0
g_joystickPresentFlag	db 0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db    0
		db  0Ah
		db    0
		db    0
		db    0
		db    0
		db    0
word_4EF6F	dw 3F8h
		db    4
		db    0
		db    0
		db 0B8h	; ¸
		db    1
		db    0
		db    0
		db    0
byte_4EF79	db 1
byte_4EF7A	db 0
align 2
word_4EF7C	dw 0
word_4EF7E	dw 0
off_4EF80	dw offset sub_2843B
word_4EF82	dw 0
		dw seg dseg
		db 4Ch dup(0)
off_4EFD2	dw offset word_4EF82
aC_file_info	db ';C_FILE_INFO',0
dword_4EFE1	dd 0
		db 8 dup(0)
word_4EFED	dw 0
		db 4 dup(0)
word_4EFF3	dw 0
word_4EFF5	dw 0
		db 0
byte_4EFF8	db 0
align 2
word_4EFFA	dw 14h
byte_4EFFC	db 3 dup(81h), 2 dup(1), 0Fh dup(0)
word_4F010	dw 0
word_4F012	dw 0
word_4F014	dw 0
word_4F016	dw 0
word_4F018	dw 0
off_4F01A	dd unk_4F01E
unk_4F01E	db  43h	; C
		db    0
		db    0
		db    0
byte_4F022	db 0
byte_4F023	db 0
dword_4F024	dd 0
unk_4F028	db	0
		db    0
word_4F02A	dw 0
dword_4F02C	dd 0FFFFFFFFh
word_4F030	dw (offset dseg_end+102h)
dword_4F032	dd 0
byte_4F036	db 0, 16h, 2 dup(2), 18h
		db 0Dh, 9, 3 dup(0Ch), 7; 5
		db 8, 2 dup(16h), 0FFh, 12h; 11
		db 0Dh, 12h, 2, 0FFh    ; 16
word_4F04A	dw 0
byte_4F04C	db 200h dup(0)
byte_4F24C	db 200h dup(0)
byte_4F44C	db 200h dup(0)
off_4F64C	dw offset byte_4F04C
		dw seg dseg
		db    0
		db    0
		dd byte_4F04C
		db    1
		db    0
byte_4F658	db 0Ah dup(0), 2, 1
byte_4F664	db 0Ah dup(0), 2 dup(2), 0Ah dup(0), 84h, 3, 0Ah dup(0), 2, 4
		db 0A8h dup(0)
byte_4F730	db 0Ch dup(0)
byte_4F73C	db 1, 2 dup(0), 2, 74h dup(0)
word_4F7B4	dw offset byte_4F730
seg_4F7B6	dw seg dseg
word_4F7B8	dw 0
aNull		db '(null)',0
aNull_0		db '(null)',0
asc_4F7C8	db '+- #',0
align 2
word_4F7CE	dw 0
word_4F7D0	dw 0
align 4
word_4F7D4	dw 0
align 4
word_4F7D8	dw 0
word_4F7DA	dw 0
word_4F7DC	dw 0
word_4F7DE	dw 2000h
word_4F7E0	dw 0
byte_4F7E2	db 0
align 2
off_4F7E4	dd sub_284E6
off_4F7E8	dd sub_284E6
off_4F7EC	dd sub_284E6
off_4F7F0	dd sub_284E6
off_4F7F4	dd sub_284E6
		db    0
		db    0
		db    0
		db    0
		db    1
		db    1
		db    0
sscanf_charFlags	db 32, 32, 32, 32, 32, 32, 32, 32
		db 32, 40, 40, 40, 40, 40, 32, 32
		db 32, 32, 32, 32, 32, 32, 32, 32
		db 32, 32, 32, 32, 32, 32, 32, 32
		db 72, 16, 16, 16, 16, 16, 16, 16
		db 16, 16, 16, 16, 16, 16, 16, 16
		db 132,	132, 132, 132, 132, 132, 132, 132
		db 132,	132, 16, 16, 16, 16, 16, 16
		db 16, 129, 129, 129, 129, 129,	129, 1
		db 1, 1, 1, 1, 1, 1, 1,	1
		db 1, 1, 1, 1, 1, 1, 1,	1
		db 1, 1, 1, 16,	16, 16,	16, 16
		db 16, 130, 130, 130, 130, 130,	130, 2
		db 2, 2, 2, 2, 2, 2, 2,	2
		db 2, 2, 2, 2, 2, 2, 2,	2
		db 2, 2, 2, 16,	16, 16,	16, 32
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0, 0, 0, 0, 0, 0, 0,	0
		db 0
word_4F900	dw 0FFFFh
align 4
unk_4F904	db	0
db    0
word_4F906	dw 0
dword_4F908	dd 0
dword_4F90C	dd 0
off_4F910	dd sub_28846
seg027_41	dw seg seg027
dseg_x		dw seg dseg
seg027_x	dw seg	seg027
seg022_x	dw seg	seg022
seg023_x	dw seg seg023
aNmsg		db '<<NMSG>>'
word_4FC84	dw 0
aR6000StackOver	db 'R6000',0Dh,0Ah
		db '- stack overflow',0Dh,0Ah,0
		dw    3
		db 'R6003',0Dh,0Ah
		db '- integer divide by 0',0Dh,0Ah,0
		dw    9
		db 'R6009',0Dh,0Ah
		db '- not enough space for environment',0Dh,0Ah,0
		dw 0FCh	; ü
		db  0Dh,0Ah,0
		dw 0FFh
		db 'run-time error ',0
		dw    2
		db 'R6002',0Dh,0Ah
		db '- floating point not loaded',0Dh,0Ah,0
		dw    1
		db 'R6001',0Dh,0Ah
		db '- null pointer assignment',0Dh,0Ah,0
		dw 0FFFFh
		dw 0FF00h
g_tavernSayingBase	dw 0
tav_drunkLevel	db 8 dup(0)	       ; 0
curStrByte	db ?
align 2
dataBufOff	dw ?
dataBufSeg	dw ?
bitsLeft	dw ?
_str_capFlag	dw	?
align 4
word_4FD6C	dw ?
sscanf_structP	dd ?
word_4FD72	dw ?
word_4FD74	dw ?
sscanf_argSizeFlag	dw ?
sscanf_charListFlag	dw ?
word_4FD7A	dw ?
dword_4FD7C	dd ?
sscanf_bufp	dd ?
word_4FD84	dw ?
sscanf_buf	db 100h dup(?)
sscanf_minWidth dw ?
sscanf_noAssign dw ?
word_4FE8A	dw ?
word_4FE8C	dw ?
_sscanf_floatBuf	db 42h dup(?)
word_4FED0	dw ?
word_4FED2	dw ?
word_4FED4	dw ?
dword_4FED6	dd ?
word_4FEDA	dw ?
word_4FEDC	dw ?
word_4FEDE	dw ?
word_4FEE0	dw ?
byte_4FEE2	db 0Ch dup(?)
word_4FEEE	dw ?
dword_4FEF0	dd ?
word_4FEF4	dw ?
word_4FEF6	dw ?
word_4FEF8	dw ?
word_4FEFA	dw ?
word_4FEFC	dw ?
word_4FEFE	dw ?
word_4FF00	dw ?
word_4FF02	dw ?
word_4FF04	dw ?
word_4FF06	dw ?
byte_4FF08	db 15Eh dup(?)
word_50066	dw ?
word_50068	dw ?
byte_5006A	db 4 dup(?)
dseg_end	db ?
		db ?
align 8
