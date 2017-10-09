; Segment type:	Pure code
seg025 segment para public 'DATA' use16
	assume cs:seg025
	assume es:nothing, ss:nothing, ds:seg025, fs:nothing, gs:nothing

music_driver proc far
	jmp	near ptr _music_driver
music_driver endp

j_music_init    proc near
                jmp     music_init
j_music_init    endp

j_music_end     proc near
                jmp     music_end
j_music_end     endp

j_music_end_0   proc near
                jmp     music_end
j_music_end_0   endp

j_music_end_1   proc near
                jmp     music_end
j_music_end_1   endp

j_music_end_2   proc near
                jmp     music_end
j_music_end_2   endp

musicSeg dw 0
noteFreqs dw 21248, 16368, 11776, 7440,	3344, 65008, 61360, 57920
dw 54656, 51600, 48704,	45968, 43392, 40952, 38656, 36488
dw 34440, 32504, 30680,	28960, 27328, 25800, 24352, 22984
dw 21696, 20476, 19328,	18244, 17220, 16252, 15340, 14480
dw 13664, 12900, 12176,	11492, 10848, 10238, 9664, 9122
dw 8610, 8126, 7670, 7240, 6832, 6450, 6088, 5746
dw 5424, 5119, 4832, 4561, 4305, 4063, 3835, 3620
dw 3416, 3225, 3044, 2873, 2712, 2559, 2416, 2280
dw 2152, 2031, 1917, 1810, 1708, 1612, 1522, 1436
dw 1356, 1279, 1208, 1140, 1076, 1015, 958, 905
dw 854,	806, 761, 718, 678, 639, 604, 570
dw 538,	507, 479, 452, 427, 403, 380, 359
byte_3FB24 db 1
byte_3FB25 db 0
byte_3FB26 db 0
byte_3FB27 db 0
word_3FB28 dw 0
word_3FB2A dw 0
baseNote dw 0
word_3FB2E dw 0
byte_3FB30 db 0
byte_3FB31 db 0
noteDurationMaybe db 0
byte_3FB33 db 0
byte_3FB34 db 0
musicOn	db 0
db    0
db    0
byte_3FB38 db 1
db    0
off_3FB3A dw offset music_playNote
dw offset music_init
dw offset music_end
dw offset _music_speakerOff
dw offset sub_3FBC5

_music_driver proc far
	push	bx
	push	cx
	push	dx
	push	di
	push	si
	push	ds
	push	cs
	pop	ds
	mov	si, bx
	xor	bh, bh
	mov	bl, ah
	shl	bl, 1
	call	off_3FB3A[bx]
	pop	ds
	assume ds:dseg
	pop	si
	pop	di
	pop	dx
	pop	cx
	pop	bx
	retf
_music_driver endp

	assume ds:seg025
music_init proc	near
	cli
	mov	musicSeg, cx
	push	es
	mov	es, cx
	mov	ax, es:0
	mov	baseNote, ax
	mov	word_3FB2E, ax
	xor	di, di
loc_3FB73:
	mov	al, es:[di+4Bh]
	mov	byte_3FB24[di],	al
	inc	di
	cmp	di, 2
	jnz	short loc_3FB73
	pop	es
	mov	byte_3FB26, 0
	mov	byte_3FB27, 0
	mov	word_3FB2A, 0
	mov	noteDurationMaybe, 0
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	or	al, 3
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	mov	al, 0B6h 
	out	43h, al		; Timer	8253-5 (AT: 8254.2).
	mov	ax, 2
	out	42h, al		; Timer	8253-5 (AT: 8254.2).
	mov	al, ah
	out	42h, al		; Timer	8253-5 (AT: 8254.2).
	mov	musicOn, 1
	sti
	retn
music_init endp

music_end proc near
	cli
	mov	musicOn, 0
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	sti
	retn
music_end endp

sub_3FBC5 proc near
	cli
	mov	byte_3FB38, 1
	sti
	retn
sub_3FBC5 endp

_music_speakerOff proc near
	cli
	mov	byte_3FB38, 0
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	sti
	retn
_music_speakerOff endp

music_playNote proc near
	cmp	musicOn, 1
	jz	short loc_3FBE5
	jmp	locret_3FC96
loc_3FBE5:
	mov	es, musicSeg
	mov	si, baseNote
	cmp	noteDurationMaybe, 0
	jz	short loc_3FBFB
	dec	noteDurationMaybe
	jmp	loc_3FC92
loc_3FBFB:
	mov	al, es:[si]
	inc	si
	test	al, al
	js	short loc_3FC1B
	mov	ah, byte_3FB30
	dec	si
	cmp	byte_3FB33, 0
	jz	short loc_3FC34
	inc	si
	cmp	byte_3FB34, 0
	jz	short loc_3FC18
	inc	si
loc_3FC18:
	jmp	short loc_3FC7F
db  90h	; ê
loc_3FC1B:
	cmp	al, 0FCh	; is 0x80, the song loops. Otherwise the song is
			; over.
	jnz	short loc_3FC22
	jmp	short loc_3FC97
db  90h	; ê
loc_3FC22:
	mov	ah, al
	and	ah, 0Fh
	mov	byte_3FB31, ah
	mov	ah, al
	and	ah, 0F0h
	mov	byte_3FB30, ah
loc_3FC34:
	cmp	ah, 0E0h
	jnz	short loc_3FC48
	mov	byte_3FB34, 1
	mov	byte_3FB33, 1
	inc	si
	inc	si
	jmp	short loc_3FC7F
db  90h	; ê
loc_3FC48:
	mov	byte_3FB33, 0
	mov	byte_3FB34, 1
	cmp	ah, 0C0h
	jnz	short loc_3FC60
	mov	byte_3FB34, 0
	inc	si
	jmp	short loc_3FC7F
db 90h
loc_3FC60:
	cmp	ah, 90h
	jnz	short loc_3FC68
	jmp	short loc_3FCB3
db  90h	; ê
loc_3FC68:
	cmp	ah, 80h
	jnz	short loc_3FC70
	jmp	loc_3FD0A
loc_3FC70:
	inc	si
	inc	si
	mov	byte_3FB34, 1
	mov	byte_3FB33, 1
	jmp	short loc_3FC7F
db  90h	; ê
loc_3FC7F:
	mov	al, es:[si]
	inc	si
	cmp	al, 0
	jnz	short loc_3FC8A
	jmp	loc_3FBFB
loc_3FC8A:
	dec	al
	mov	noteDurationMaybe, al
	jmp	short loc_3FC92
db  90h	; ê
loc_3FC92:
	mov	baseNote, si
locret_3FC96:
	retn
loc_3FC97:
	mov	al, es:[si]
	inc	si
	cmp	al, 80h
	jz	short loc_3FCAC
	mov	musicOn, 0
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	jmp	short locret_3FC96
loc_3FCAC:
	mov	si, word_3FB2E
	jmp	loc_3FBFB
loc_3FCB3:
	mov	bl, es:[si+1]
	cmp	bl, 0
	jnz	short loc_3FCBF
	jmp	short loc_3FD0A
db  90h	; ê
loc_3FCBF:
	xor	di, di
	xor	cx, cx
	mov	bl, es:[si]
	inc	si
	inc	si
	mov	al, byte_3FB31
	cmp	al, byte_3FB24
	jnz	short loc_3FD07
	mov	byte_3FB26, 1
	mov	byte_3FB27, bl
	add	bl, byte_3FB25
	shl	bl, 1
	xor	bh, bh
	mov	bx, noteFreqs[bx]
	mov	word_3FB28, bx
	cmp	byte_3FB38, 1
	jz	short loc_3FCF9
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	jmp	short loc_3FC7F
loc_3FCF9:		; PC/XT	PPI port B bits:
	in	al, 61h		; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	or	al, 3
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	mov	ax, bx
	out	42h, al		; Timer	8253-5 (AT: 8254.2).
	mov	al, ah
	out	42h, al		; Timer	8253-5 (AT: 8254.2).
loc_3FD07:
	jmp	loc_3FC7F
loc_3FD0A:
	xor	di, di
	xor	cx, cx
	mov	bl, es:[si]
	inc	si
	inc	si
	mov	al, byte_3FB31
	cmp	al, byte_3FB24
	jnz	short loc_3FD27
	mov	byte_3FB26[di],	0
	in	al, 61h		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
	and	al, 0FCh
	out	61h, al		; PC/XT	PPI port B bits:
			; 0: Tmr 2 gate	ÕÀÕ OR	03H=spkr ON
			; 1: Tmr 2 data	Õº  AND	0fcH=spkr OFF
			; 3: 1=read high switches
			; 4: 0=enable RAM parity checking
			; 5: 0=enable I/O channel check
			; 6: 0=hold keyboard clock low
			; 7: 0=enable kbrd
loc_3FD27:
	jmp	loc_3FC7F
music_playNote endp

byte_3FD2A db 0C3h, 0E9h, 18h, 2, 0E9h,	30h, 2,	0E9h
db 0A4h, 2, 0E9h, 0A1h,	2, 0E9h, 9Eh, 2
db 0E9h, 9Bh, 2, 6 dup(0), 0FAh, 3, 0C0h
db 3, 8Ah, 3, 58h, 3, 28h, 3, 0FAh, 2, 0D0h
db 2, 0A6h, 2, 80h, 2, 5Ch, 2, 3Ch, 2, 1Ah
db 2, 0FCh, 1, 0E0h, 1,	0C5h, 1, 0ACh, 1
db 94h,	1, 7Dh,	1, 68h,	1, 53h,	1, 40h,	1
db 2Eh,	1, 1Eh,	1, 0Dh,	1, 0FEh, 0, 0F0h
db 0, 0E3h, 0, 0D6h, 0,	0CAh, 0, 0BEh, 0
db 0B4h, 0, 0AAh, 0, 0A0h, 0, 97h, 0, 8Fh
db 0, 87h, 0, 7Fh, 0, 78h, 0, 71h, 0, 6Bh
db 0, 65h, 0, 5Fh, 0, 5Ah, 0, 55h, 0, 50h
db 0, 4Bh, 0, 47h, 0, 43h, 0, 3Fh, 0, 3Ch
db 0, 38h, 2 dup(0), 1,	2, 3, 4, 5, 6, 7
db 8, 9, 0Ah, 0Bh, 0Ch,	0Dh, 0Eh, 0Fh, 10h
db 6 dup(0), 10h, 0D9h,	0, 0DEh, 0, 0D9h
db 0, 0DEh, 0, 0C0h, 0,	0C0h, 0, 0D9h, 0
db 0DEh, 0, 0DEh, 0, 0D9h, 0, 0DEh, 0, 0DEh
db 0, 0C0h, 0, 0DEh, 0,	0D4h, 0, 0DEh, 0
db 0CFh, 0, 0CAh, 0, 0CFh, 0, 0CAh, 0, 0EDh
db 0, 0F5h, 0, 6Dh, 1, 0, 5Fh, 1, 6Dh, 1
db 0, 3Eh, 1, 6Dh, 1, 0, 44h, 1, 6Dh, 1
db 0, 4Eh, 1, 86h, 1, 1Eh, 0FBh, 0, 62h
db 1, 78h, 1Eh,	1, 6Dh,	1, 0, 3, 1, 76h
db 1, 5Ah, 13h,	1, 76h,	1, 0, 2Eh, 1, 6Dh
db 2 dup(1), 3Ah, 56h, 3, 7, 8,	9, 0Ah,	0FFh
db 2, 5, 2 dup(6), 3 dup(7), 0FFh, 2, 3
db 5, 6, 7, 2 dup(8), 2	dup(9),	0Ah, 0Bh
db 0Ch,	0Dh, 0Eh, 0Fh, 0FFh, 1,	5, 7, 9
db 0Ah,	0Bh, 0Ch, 0Dh, 0Eh, 0Fh, 0FFh, 1
db 5, 6, 7, 8, 2 dup(9), 2 dup(0Ah), 2 dup(0Bh)
db 0Ch,	0Dh, 0Eh, 0Fh, 0FFh, 1,	4, 0Bh,	5
db 0Ch,	6, 0Bh,	7, 0Ch,	9, 0Bh,	0Ch, 0Dh
db 0Eh,	0Fh, 0FFh, 1, 3, 6, 2 dup(0Fh),	0FFh
db 1, 5, 6, 7, 8, 9, 0Ah, 0Bh, 0Fh, 0FFh
db 1, 3, 4, 5, 6, 7, 2 dup(8), 9, 0Ah, 0Bh
db 2 dup(0Ch), 0Dh, 0Eh, 0Fh, 0FFh, 1, 6
db 0Fh,	0FFh, 0, 1, 2, 2 dup(1), 0, 0FFh
db 2 dup(0FEh),	0FFh, 80h, 0, 1, 2, 1, 0
db 0FFh, 0FEh, 0FFh, 80h, 0, 2 dup(1), 2
db 3, 2	dup(2),	1, 0, 1, 2 dup(0FFh), 2	dup(0FEh)
db 0FFh, 80h, 0FEh, 0FDh, 0FCh,	0FBh, 0FAh
db 0F9h, 0F8h, 0F7h, 0F6h, 0F5h, 0F4h, 0F3h
db 0F2h, 0F1h, 0F0h, 0EFh, 0EEh, 0EDh, 0ECh
db 0EBh, 0EAh, 80h, 1, 4, 0FFh,	9, 3 dup(0C4h)
db 4Dh dup(0), 80h, 0A0h, 0C0h,	0, 90h,	0B0h
db 0D0h, 0F0h, 17h dup(0), 1, 0, 0E9h, 2
db 36h,	2, 0ADh, 2, 0CDh, 2, 0C5h, 2, 53h
db 51h,	52h, 57h, 56h, 1Eh, 0Eh, 1Fh, 8Bh
db 0F3h, 32h, 0FFh, 8Ah, 0DCh, 0D0h, 0E3h
db 0FFh, 97h, 11h, 2, 1Fh, 5Eh,	5Fh, 5Ah
db 59h,	5Bh, 0CBh, 0FAh, 0A2h, 10h, 2, 89h
db 0Eh,	12h, 0,	6, 8Eh,	0C1h, 26h, 0A1h
db 2 dup(0), 0A3h, 0, 2, 0A3h, 2 dup(2)
db 33h,	0FFh, 26h, 8Ah,	45h, 43h, 88h, 85h
db 9Ch,	1, 47h,	83h, 0FFh, 8, 75h, 0F2h
db 7, 33h, 0FFh, 8Bh, 0DFh, 0D1h, 0E3h,	0C6h
db 85h,	0A4h, 1, 0, 0C6h, 85h, 0A8h, 1,	0
db 0C7h, 87h, 0F8h, 1, 2 dup(0), 0C6h, 85h
db 0BCh, 1, 0Fh, 0C6h, 85h, 0D4h, 1, 0,	0C6h
db 85h,	0C0h, 1, 0, 0C6h, 85h, 0B4h, 1,	0
db 47h,	83h, 0FFh, 4, 75h, 0D2h, 0B0h, 9Fh
db 0E6h, 0C0h, 0B0h, 0BFh, 0E6h, 0C0h, 0B0h
db 0DFh, 0E6h, 0C0h, 0B0h, 0FFh, 0E6h, 0C0h
db 0C6h, 2 dup(6), 2, 0, 0C6h, 6, 0Ah, 2
db 0, 0C6h, 6, 9, 2, 1,	0FBh, 0C3h, 0FAh
db 0C6h, 6, 9, 2, 0, 0B0h, 9Fh,	0E6h, 0C0h
db 0B0h, 0BFh, 0E6h, 0C0h, 0B0h, 0DFh, 0E6h
db 0C0h, 0B0h, 0FFh, 0E6h, 0C0h, 0FBh, 0C3h
db 0FAh, 0C6h, 6, 0Fh, 2, 1, 0FBh, 0C3h
db 0FAh, 0C6h, 6, 0Fh, 2, 0, 0C6h, 6, 0B4h
db 1, 0, 0C6h, 6, 0B5h,	1, 0, 0C6h, 6, 0B6h
db 1, 0, 0C6h, 6, 0B7h,	1, 0, 0EBh, 0CAh
db 80h,	3Eh, 9,	2, 1, 74h, 3, 0E9h, 2 dup(1)
db 8Eh,	6, 12h,	0, 8Bh,	36h, 0,	2, 33h,	0FFh
db 80h,	3Eh, 6,	2, 0, 74h, 7, 0FEh, 0Eh
db 6, 2, 0E9h, 0C4h, 0,	26h, 8Ah, 4, 46h
db 84h,	0C0h, 78h, 18h,	8Ah, 26h, 4, 2,	4Eh
db 80h,	3Eh, 7,	2, 0, 74h, 25h,	46h, 80h
db 3Eh,	8, 2, 0, 74h, 1, 46h, 0E9h, 91h
db 0, 3Ch, 0FCh, 75h, 3, 0E9h, 0E3h, 0,	8Ah
db 0E0h, 80h, 0E4h, 0Fh, 88h, 26h, 5, 2
db 8Ah,	0E0h, 80h, 0E4h, 0F0h, 88h, 26h
db 4, 2, 80h, 0FCh, 0E0h, 75h, 3Dh, 0C6h
db 6, 8, 2, 1, 26h, 8Ah, 14h, 46h, 26h,	8Ah
db 34h,	46h, 0D0h, 0EEh, 73h, 3, 80h, 0CAh
db 80h,	89h, 16h, 0Dh, 2, 0A0h,	5, 2, 33h
db 0FFh, 3Ah, 85h, 9Ch,	1, 75h,	11h, 80h
db 0BDh, 0A4h, 2 dup(1), 75h, 0Ah, 0C6h
db 85h,	0C0h, 2	dup(1),	57h, 0E8h, 0B0h
db 2, 5Fh, 47h,	83h, 0FFh, 3, 75h, 0E3h
db 0EBh, 37h, 90h, 0C6h, 6, 7, 2, 0, 0C6h
db 6, 8, 2, 1, 80h, 0FCh, 0C0h,	75h, 8,	0C6h
db 6, 8, 2, 0, 0EBh, 59h, 90h, 80h, 0FCh
db 90h,	75h, 3,	0E9h, 96h, 0, 80h, 0FCh
db 80h,	75h, 3,	0E9h, 94h, 1, 2	dup(46h)
db 0C6h, 6, 8, 2, 1, 0C6h, 6, 7, 2, 1, 0EBh
db 1, 90h, 26h,	8Ah, 4,	46h, 3Ch, 0, 75h
db 3, 0E9h, 44h, 0FFh, 0FEh, 0C8h, 0A2h
db 6, 2, 0EBh, 1, 90h, 89h, 36h, 0, 2, 33h
db 0FFh, 8Bh, 0DFh, 0D1h, 0E3h,	53h, 0E8h
db 6Ah,	2, 5Bh,	0C6h, 85h, 0C0h, 1, 0, 80h
db 0BDh, 0A4h, 2 dup(1), 75h, 4, 0FFh, 87h
db 0F8h, 1, 47h, 83h, 0FFh, 4, 75h, 0E1h
db 0C3h, 33h, 0FFh, 26h, 8Ah, 1Ch, 46h,	0A0h
db 5, 2, 3Ch, 9, 74h, 0Bh, 3Ah,	85h, 9Ch
db 1, 75h, 5, 57h, 0E8h, 0E1h, 1, 5Fh, 47h
db 83h,	0FFh, 4, 75h, 0E8h, 0EBh, 0A7h,	26h
db 8Ah,	4, 46h,	3Ch, 80h, 74h, 17h, 0C6h
db 6, 9, 2, 0, 0B0h, 9Fh, 0E6h,	0C0h, 0B0h
db 0BFh, 0E6h, 0C0h, 0B0h, 0DFh, 0E6h, 0C0h
db 0B0h, 0FFh, 0E6h, 0C0h, 0EBh, 0C0h, 8Bh
db 36h,	2 dup(2), 0E9h,	0D0h, 0FEh, 26h
db 8Ah,	5Ch, 1,	80h, 0FBh, 0, 75h, 3, 0E9h
db 0FAh, 0, 33h, 0FFh, 26h, 8Ah, 1Ch, 46h
db 26h,	8Ah, 24h, 46h, 0A0h, 5,	2, 3Ch,	9
db 75h,	3, 0E9h, 2Dh, 1, 3Ah, 85h, 9Ch,	1
db 74h,	3, 0E9h, 8Ch, 0, 80h, 0BDh, 0A4h
db 2 dup(1), 75h, 3, 0E9h, 82h,	0, 57h,	0C6h
db 85h,	0A4h, 2	dup(1),	88h, 9Dh, 0A8h,	1
db 2, 9Dh, 0A0h, 1, 80h, 0FBh, 0, 7Dh, 0Bh
db 80h,	0C3h, 0Ch, 80h,	0FBh, 0, 7Ch, 0F8h
db 0EBh, 0Eh, 90h, 80h,	0FBh, 32h, 7Eh,	8
db 80h,	0EBh, 0Ch, 80h,	0FBh, 32h, 7Fh,	0F3h
db 0D0h, 0E3h, 32h, 0FFh, 8Bh, 9Fh, 18h
db 0, 0E8h, 2Bh, 1, 8Ah, 85h, 0ACh, 1, 88h
db 85h,	0B0h, 1, 8Ah, 85h, 0B8h, 1, 88h
db 85h,	0BCh, 1, 80h, 3Eh, 0Fh,	2, 1, 74h
db 10h,	0C6h, 85h, 0B4h, 1, 0, 0B0h, 0Fh
db 0Ah,	85h, 0F4h, 1, 0E6h, 0C0h, 0EBh,	0Ch
db 90h,	0C6h, 85h, 0B4h, 2 dup(1), 0Ah,	85h
db 0F4h, 1, 0E6h, 0C0h,	0D1h, 0E7h, 8Bh
db 85h,	0C4h, 1, 89h, 85h, 0CCh, 1, 89h
db 9Dh,	0E8h, 1, 8Bh, 85h, 0E0h, 1, 89h
db 85h,	0D8h, 1, 5Fh, 0E9h, 0CCh, 0FEh,	47h
db 83h,	0FFh, 4, 74h, 3, 0E9h, 62h, 0FFh
db 53h,	33h, 0FFh, 33h,	0D2h, 0C7h, 6, 0Bh
db 2, 2	dup(0FFh), 8Bh,	0DFh, 0D1h, 0E3h
db 3Ah,	85h, 9Ch, 1, 75h, 0Eh, 8Bh, 8Fh
db 0F8h, 1, 3Bh, 0D1h, 73h, 6, 8Bh, 0D1h
db 89h,	3Eh, 0Bh, 2, 47h, 83h, 0FFh, 4,	75h
db 0E2h, 83h, 3Eh, 0Bh,	2, 0FFh, 75h, 4
db 5Bh,	0E9h, 8Fh, 0FEh, 8Bh, 0Eh, 0Bh,	2
db 8Bh,	0F9h, 8Bh, 0DFh, 0D1h, 0E3h, 0C7h
db 87h,	0F8h, 1, 2 dup(0), 5Bh,	0E9h, 2Dh
db 0FFh, 33h, 0FFh, 26h, 8Ah, 1Ch, 2 dup(46h)
db 0A0h, 5, 2, 3Ah, 85h, 9Ch, 1, 75h, 2Eh
db 38h,	9Dh, 0A8h, 1, 75h, 28h,	57h, 0C6h
db 85h,	0A4h, 1, 0, 0C6h, 85h, 0A8h, 1,	0
db 0B0h, 0Fh, 88h, 85h,	0BCh, 1, 0Ah, 85h
db 0F4h, 1, 0E6h, 0C0h,	0C6h, 85h, 0B4h
db 1, 0, 0D1h, 0E7h, 0C7h, 85h,	0F8h, 1
db 2 dup(0), 5Fh, 0E9h,	3Dh, 0FEh, 47h,	83h
db 0FFh, 4, 75h, 0C6h, 0E9h, 34h, 0FEh,	80h
db 0FBh, 24h, 74h, 8, 80h, 0FBh, 26h, 74h
db 16h,	0E9h, 27h, 0FEh, 0BFh, 3, 0, 0B3h
db 11h,	0E8h, 50h, 0, 0BFh, 3, 0, 0B0h,	2 dup(0E6h)
db 0C0h, 57h, 0E9h, 0FCh, 0FEh,	0BFh, 3
db 0, 0B3h, 17h, 0E8h, 3Dh, 0, 0BFh, 3,	0
db 0B0h, 0E4h, 0E6h, 0C0h, 57h,	2 dup(0E9h)
db 0FEh, 52h, 8Bh, 0D0h, 24h, 0Fh, 0D1h
db 0E2h, 0D1h, 0E2h, 0D1h, 0E2h, 0D1h, 0E2h
db 8Ah,	0E6h, 80h, 0E4h, 3Fh, 5Ah, 0C3h
db 8Bh,	0C3h, 8Bh, 0D0h, 24h, 0Fh, 0D1h
db 0E2h, 0D1h, 0E2h, 0D1h, 0E2h, 0D1h, 0E2h
db 8Ah,	0E6h, 80h, 0E4h, 3Fh, 0Ah, 85h,	0F0h
db 1, 0E6h, 0C0h, 8Ah, 0C4h, 0E6h, 0C0h
db 0C3h, 53h, 56h, 32h,	0FFh, 80h, 0FBh
db 0FFh, 75h, 4, 8Ah, 1Eh, 10h,	2, 8Ah,	9Fh
db 7Eh,	0, 0D0h, 0E3h, 8Bh, 9Fh, 96h, 0
db 8Bh,	37h, 8Ah, 4Ch, 0FFh, 88h, 8Dh, 0ACh
db 1, 8Ah, 0Ch,	88h, 8Dh, 0B8h,	1, 0D1h
db 0E7h, 89h, 0B5h, 0C4h, 1, 8Bh, 77h, 2
db 89h,	0B5h, 0E0h, 1, 0D1h, 0EFh, 8Ah,	4Fh
db 4, 88h, 8Dh,	0D4h, 1, 5Eh, 5Bh, 0C3h
db 50h,	8Bh, 0DFh, 0D1h, 0E3h, 8Bh, 87h
db 0E8h, 1, 0BAh, 0, 20h, 0F7h,	0E2h, 0F7h
db 36h,	0Dh, 2,	8Bh, 0D8h, 50h,	0E8h, 8Bh
db 0FFh, 2 dup(58h), 0C3h, 32h,	0E4h, 80h
db 0BDh, 0B4h, 1, 0, 74h, 26h, 0FEh, 8Dh
db 0B0h, 1, 75h, 20h, 8Ah, 85h,	0ACh, 1
db 88h,	85h, 0B0h, 1, 8Bh, 0B7h, 0CCh, 1
db 8Ah,	4, 3Ch,	0FFh, 74h, 0Eh,	0FFh, 87h
db 0CCh, 1, 88h, 85h, 0BCh, 1, 0Ah, 85h
db 0F4h, 1, 0E6h, 0C0h,	8Ah, 95h, 0D4h,	1
db 80h,	0FAh, 0, 74h, 39h, 80h,	0BDh, 0C0h
db 2 dup(1), 74h, 32h, 8Bh, 87h, 0E8h, 1
db 8Bh,	0C8h, 0F6h, 0F2h, 8Bh, 0B7h, 0D8h
db 1, 8Ah, 14h,	80h, 0FAh, 80h,	75h, 6,	8Bh
db 0B7h, 0E0h, 1, 8Ah, 14h, 32h, 0E4h, 0F6h
db 0EAh, 3, 0C1h, 46h, 89h, 0B7h, 0D8h,	1
db 8Bh,	0D8h, 81h, 0FBh, 0FFh, 3, 72h, 3
db 0BBh, 0FFh, 3, 0E8h,	17h, 0FFh, 0C3h
db 0E9h, 18h, 2, 0E9h, 30h, 2, 0E9h, 0A5h
db 2, 0E9h, 0A2h, 2, 0E9h, 9Fh,	2, 0E9h
db 9Ch,	2, 6 dup(0), 0FAh, 3, 0C0h, 3, 8Ah
db 3, 58h, 3, 28h, 3, 0FAh, 2, 0D0h, 2,	0A6h
db 2, 80h, 2, 5Ch, 2, 3Ch, 2, 1Ah, 2, 0Bh dup(0)
db    0
seg025 ends
