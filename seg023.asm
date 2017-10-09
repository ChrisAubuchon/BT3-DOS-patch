; Segment type:	Regular
seg023 segment para public 'DATA' use16
	assume cs:seg023
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing
graphicsBuf db 4A38h dup(0)	    ; 0
monsterBuf db 480h dup(0)	   ; 0
byte_3BA68 db 11C4h dup(0)	   ; 0
iconLight db 474h dup(0)	  ; 0
iconCompass db 820h dup(0)	    ; 0
iconAreaEnchant	db 550h	dup(0)		; 0
iconShield db 1E0h dup(0)	   ; 0
iconLevitation db 640h dup(0)	       ; 0
byte_3E630 db 0, 0, 0, 0, 0, 0,	0, 0, 60h, 0F0h; 0
db 0F0h, 60h, 60h, 0, 60h, 0, 0D8h, 0D8h, 0D8h,	0; 10
db 0, 0, 0, 0, 6Ch, 6Ch, 0FEh, 6Ch, 0FEh, 6Ch; 20
db 6Ch,	0, 30h,	7Ch, 0C0h, 78h,	0Ch, 0F8h, 30h,	0; 30
db 0, 0C6h, 0CCh, 18h, 30h, 66h, 0C6h, 0, 38h, 6Ch; 40
db 38h,	76h, 0DCh, 0CCh, 76h, 0, 60h, 60h, 0C0h, 0; 50
db 0, 0, 0, 0, 30h, 60h, 0C0h, 0C0h, 0C0h, 60h;	60
db 30h,	0, 0C0h, 60h, 30h, 30h,	30h, 60h, 0C0h,	0; 70
db 0, 0CCh, 78h, 0FCh, 78h, 0CCh, 0, 0,	0, 30h;	80
db 30h,	0FCh, 30h, 30h,	0, 0, 0, 0, 0, 0; 90
db 0, 60h, 60h,	0C0h, 0, 0, 0, 0F8h, 0,	0; 100
db 0, 0, 0, 0, 0, 0, 0,	60h, 60h, 0; 110
db 0, 0Ch, 18h,	30h, 60h, 0C0h,	80h, 0,	7Ch, 0C6h; 120
db 0CEh, 0DEh, 0F6h, 0E6h, 7Ch,	0, 30h,	70h, 30h, 30h; 130
db 30h,	30h, 0FCh, 0, 78h, 0CCh, 0Ch, 38h, 60h,	0CCh; 140
db 0FCh, 0, 78h, 0CCh, 0Ch, 38h, 0Ch, 0CCh, 78h, 0; 150
db 1Ch,	3Ch, 6Ch, 0CCh,	0FEh, 0Ch, 1Eh,	0, 0FCh, 0C0h; 160
db 0F8h, 0Ch, 0Ch, 0CCh, 78h, 0, 38h, 60h, 0C0h, 0F8h; 170
db 0CCh, 0CCh, 78h, 0, 0FCh, 0CCh, 0Ch,	18h, 30h, 30h; 180
db 30h,	0, 78h,	0CCh, 0CCh, 78h, 0CCh, 0CCh, 78h, 0; 190
db 78h,	0CCh, 0CCh, 7Ch, 0Ch, 18h, 70h,	0, 0, 0C0h; 200
db 0C0h, 0, 0, 0C0h, 0C0h, 0, 0, 60h, 60h, 0; 210
db 0, 60h, 60h,	0C0h, 18h, 30h,	60h, 0C0h, 60h,	30h; 220
db 18h,	0, 0, 0, 0F8h, 0, 0, 0F8h, 0, 0; 230
db 0C0h, 60h, 30h, 18h,	30h, 60h, 0C0h,	0, 78h,	0CCh; 240
db 0Ch,	18h, 30h, 0, 30h, 0, 7Ch, 0C6h,	0DEh, 0DEh; 250
db 0DEh, 0C0h, 78h, 0, 30h, 78h, 0CCh, 0CCh, 0FCh, 0CCh; 260
db 0CCh, 0, 0FCh, 66h, 66h, 7Ch, 66h, 66h, 0FCh, 0; 270
db 3Ch,	66h, 0C0h, 0C0h, 0C0h, 66h, 3Ch, 0, 0F8h, 6Ch; 280
db 66h,	66h, 66h, 6Ch, 0F8h, 0,	0FEh, 62h, 68h,	78h; 290
db 68h,	62h, 0FEh, 0, 0FEh, 62h, 68h, 78h, 68h,	60h; 300
db 0F0h, 0, 3Ch, 66h, 0C0h, 0C0h, 0CEh,	66h, 3Eh, 0; 310
db 0CCh, 0CCh, 0CCh, 0FCh, 0CCh, 0CCh, 0CCh, 0,	78h, 30h; 320
db 30h,	30h, 30h, 30h, 78h, 0, 1Eh, 0Ch, 0Ch, 0Ch; 330
db 0CCh, 0CCh, 78h, 0, 0E6h, 66h, 6Ch, 78h, 6Ch, 66h; 340
db 0E6h, 0, 0F0h, 60h, 60h, 60h, 62h, 66h, 0FEh, 0; 350
db 0C6h, 0EEh, 0FEh, 0FEh, 0D6h, 0C6h, 0C6h, 0,	0C6h, 0E6h; 360
db 0F6h, 0DEh, 0CEh, 0C6h, 0C6h, 0, 38h, 6Ch, 0C6h, 0C6h; 370
db 0C6h, 6Ch, 38h, 0, 0FCh, 66h, 66h, 7Ch, 60h,	60h; 380
db 0F0h, 0, 78h, 0CCh, 0CCh, 0CCh, 0DCh, 78h, 1Ch, 0; 390
db 0FCh, 66h, 66h, 7Ch,	6Ch, 66h, 0E6h,	0, 78h,	0CCh; 400
db 0E0h, 70h, 1Ch, 0CCh, 78h, 0, 0FCh, 0B4h, 30h, 30h; 410
db 30h,	30h, 78h, 0, 0CCh, 0CCh, 0CCh, 0CCh, 0CCh, 0CCh; 420
db 0FCh, 0, 0CCh, 0CCh,	0CCh, 0CCh, 0CCh, 78h, 30h, 0; 430
db 0C6h, 0C6h, 0C6h, 0D6h, 0FEh, 0EEh, 0C6h, 0,	0C6h, 0C6h; 440
db 6Ch,	38h, 38h, 6Ch, 0C6h, 0,	0CCh, 0CCh, 0CCh, 78h; 450
db 30h,	30h, 78h, 0, 0FEh, 0C6h, 8Ch, 18h, 32h,	66h; 460
db 0FEh, 0, 0F0h, 0C0h,	0C0h, 0C0h, 0C0h, 0C0h,	0F0h, 0; 470
db 0, 0C0h, 60h, 30h, 18h, 0Ch,	4, 0, 0F0h, 30h; 480
db 30h,	30h, 30h, 30h, 0F0h, 0,	10h, 38h, 6Ch, 0C6h; 490
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0; 500
db 0, 0FFh, 0C0h, 0C0h,	60h, 0,	0, 0, 0, 0; 510
db 0, 0, 0F0h, 18h, 0F8h, 98h, 0E8h, 0,	0C0h, 0C0h; 520
db 0C0h, 0F0h, 0D8h, 0D8h, 0F0h, 0, 0, 0, 0F0h,	0D0h; 530
db 0C0h, 0D0h, 0F0h, 0,	38h, 18h, 18h, 78h, 0D8h, 0D8h;	540
db 78h,	0, 0, 0, 70h, 0D8h, 0F8h, 0C0h,	70h, 0;	550
db 38h,	68h, 60h, 0F0h,	60h, 60h, 0F0h,	0, 0, 0; 560
db 68h,	0D8h, 0D8h, 0F8h, 18h, 0F0h, 0C0h, 0C0h, 0C0h, 0F0h; 570
db 0D8h, 0D8h, 0D8h, 0,	0C0h, 0, 0C0h, 0C0h, 0C0h, 0C0h; 580
db 0C0h, 0, 18h, 0, 18h, 18h, 18h, 0D8h, 0D8h, 0F0h; 590
db 0C0h, 0C0h, 0C8h, 0D8h, 0F0h, 0D8h, 0C8h, 0,	0E0h, 60h; 600
db 60h,	60h, 60h, 60h, 0F0h, 0,	0, 0, 0CCh, 0FEh; 610
db 0FEh, 0D6h, 0C6h, 0,	0, 0, 0F0h, 0D8h, 0D8h,	0D8h; 620
db 0D8h, 0, 0, 0, 70h, 0D8h, 0D8h, 0D8h, 70h, 0; 630
db 0, 0, 70h, 0D8h, 0D8h, 0F0h,	0C0h, 0C0h, 0, 0; 640
db 78h,	0D8h, 0D8h, 78h, 18h, 38h, 0, 0, 70h, 0D8h; 650
db 0C0h, 0C0h, 0E0h, 0,	0, 0, 78h, 0C0h, 70h, 18h; 660
db 0F0h, 0, 20h, 60h, 0F8h, 60h, 60h, 68h, 30h,	0; 670
db 0, 0, 0D8h, 0D8h, 0D8h, 0D8h, 0F8h, 0, 0, 0;	680
db 0D8h, 0D8h, 0D8h, 70h, 20h, 0, 0, 0,	88h, 0A8h; 690
db 0A8h, 0A8h, 0F8h, 0,	0, 0, 88h, 0D8h, 70h, 0D8h; 700
db 88h,	0, 0, 0, 0D8h, 0D8h, 0D8h, 0F8h, 18h, 0F0h; 710
db 0, 0, 0F8h, 30h, 60h, 0C8h, 0F8h, 0,	38h, 60h; 720
db 60h,	0C0h, 60h, 60h,	38h, 0,	0C0h, 0C0h, 0C0h, 0; 730
db 0C0h, 0C0h, 0C0h, 0,	0E0h, 30h, 30h,	18h, 30h, 30h; 740
db 0E0h, 0, 76h, 0DCh, 0, 0, 0,	0, 0, 0; 750
db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 7Eh,	42h; 760
db 42h,	42h, 42h, 42h, 42h, 7Eh, 18h, 3Ch, 7Eh,	0FFh; 770
db 18h,	18h, 18h, 18h, 18h, 18h, 18h, 18h, 0FFh, 7Eh; 780
db 3Ch,	18h		; 790
byte_3E948 db 8, 8, 8, 89h, 8, 8, 8, 8;	0
seg023 ends
