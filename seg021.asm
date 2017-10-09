; Segment type:	Regular
seg021 segment para public 'DATA' use16
	assume cs:seg021
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
byte_2BE30 db 0, 10h, 20h, 30h,	40h, 50h, 60h, 70h; 0
db 80h,	90h, 0A0h, 0B0h, 0C0h, 0D0h, 0E0h, 0F0h; 8
db 1, 11h, 21h,	31h, 41h, 51h, 61h, 71h; 16
db 81h,	91h, 0A1h, 0B1h, 0C1h, 0D1h, 0E1h, 0F1h; 24
db 2, 12h, 22h,	32h, 42h, 52h, 62h, 72h; 32
db 82h,	92h, 0A2h, 0B2h, 0C2h, 0D2h, 0E2h, 0F2h; 40
db 3, 13h, 23h,	33h, 43h, 53h, 63h, 73h; 48
db 83h,	93h, 0A3h, 0B3h, 0C3h, 0D3h, 0E3h, 0F3h; 56
db 4, 14h, 24h,	34h, 44h, 54h, 64h, 74h; 64
db 84h,	94h, 0A4h, 0B4h, 0C4h, 0D4h, 0E4h, 0F4h; 72
db 5, 15h, 25h,	35h, 45h, 55h, 65h, 75h; 80
db 85h,	95h, 0A5h, 0B5h, 0C5h, 0D5h, 0E5h, 0F5h; 88
db 6, 16h, 26h,	36h, 46h, 56h, 66h, 76h; 96
db 86h,	96h, 0A6h, 0B6h, 0C6h, 0D6h, 0E6h, 0F6h; 104
db 7, 17h, 27h,	37h, 47h, 57h, 67h, 77h; 112
db 87h,	97h, 0A7h, 0B7h, 0C7h, 0D7h, 0E7h, 0F7h; 120
db 8, 18h, 28h,	38h, 48h, 58h, 68h, 78h; 128
db 88h,	98h, 0A8h, 0B8h, 0C8h, 0D8h, 0E8h, 0F8h; 136
db 9, 19h, 29h,	39h, 49h, 59h, 69h, 79h; 144
db 89h,	99h, 0A9h, 0B9h, 0C9h, 0D9h, 0E9h, 0F9h; 152
db 0Ah,	1Ah, 2Ah, 3Ah, 4Ah, 5Ah, 6Ah, 7Ah; 160
db 8Ah,	9Ah, 0AAh, 0BAh, 0CAh, 0DAh, 0EAh, 0FAh; 168
db 0Bh,	1Bh, 2Bh, 3Bh, 4Bh, 5Bh, 6Bh, 7Bh; 176
db 8Bh,	9Bh, 0ABh, 0BBh, 0CBh, 0DBh, 0EBh, 0FBh; 184
db 0Ch,	1Ch, 2Ch, 3Ch, 4Ch, 5Ch, 6Ch, 7Ch; 192
db 8Ch,	9Ch, 0ACh, 0BCh, 0CCh, 0DCh, 0ECh, 0FCh; 200
db 0Dh,	1Dh, 2Dh, 3Dh, 4Dh, 5Dh, 6Dh, 7Dh; 208
db 8Dh,	9Dh, 0ADh, 0BDh, 0CDh, 0DDh, 0EDh, 0FDh; 216
db 0Eh,	1Eh, 2Eh, 3Eh, 4Eh, 5Eh, 6Eh, 7Eh; 224
db 8Eh,	9Eh, 0AEh, 0BEh, 0CEh, 0DEh, 0EEh, 0FEh; 232
db 0Fh,	1Fh, 2Fh, 3Fh, 4Fh, 5Fh, 6Fh, 7Fh; 240
db 8Fh,	9Fh, 0AFh, 0BFh, 0CFh, 0DFh, 0EFh, 0FFh; 248
word_2BF30 dw 0
word_2BF32 dw 0
byte_2BF34 db 100h dup(0)	   ; 0
byte_2C034 db 100h dup(0)	   ; 0
byte_2C134 db 100h dup(0)	   ; 0
byte_2C234 db 100h dup(0)	   ; 0
byte_2C334 db 100h dup(0)	   ; 0
bigpicBuf db 268Ch dup(0)	  ; 0
seg021 ends
