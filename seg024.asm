; Segment type:	Pure code
seg024 segment para public 'DATA' use16
	assume cs:seg024
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:nothing

mouseMovedP	dw offset mouse_moved
mouseXP	dw offset mouse_x
mouseYP	dw offset mouse_y
byte_4EF5E_P	dw offset byte_4EF5E
byte_4EF79_P	dw offset byte_4EF79
byte_4EF7A_P	dw offset byte_4EF7A
off_3E95C	dd monsterBuf
off_3E960	dd monsterBuf
characterBitmasksP	dd characterBitmasks

vid_setMode proc near
	jmp	near ptr _vid_setMode
vid_setMode endp

; Attributes: thunk
sub_3E96B proc near
	jmp	near ptr sub_3EF35
sub_3E96B endp

; Attributes: thunk
sub_3E96E proc near
	jmp	near ptr sub_3F426
sub_3E96E endp

; Attributes: thunk
sub_3E971 proc near
	jmp	near ptr sub_3F603
sub_3E971 endp

; Attributes: thunk
sub_3E974 proc near
	jmp	near ptr sub_3F6A9
sub_3E974 endp

; Attributes: thunk
sub_3E977 proc near
	jmp	near ptr sub_3F714
sub_3E977 endp

; Attributes: thunk
gfx_writeCharacter proc near
	jmp	near ptr sub_3F0D2
gfx_writeCharacter endp

; Attributes: thunk
sub_3E97D proc near
	jmp	near ptr sub_3F1CA
sub_3E97D endp

; Attributes: thunk
sub_3E980 proc near
	jmp	near ptr sub_3F2C2
sub_3E980 endp

vid_drawBigpic proc near
	jmp	near ptr _vid_drawBigpic
vid_drawBigpic endp

; Attributes: thunk
sub_3E986 proc near
	jmp	sub_3F490
sub_3E986 endp

; Attributes: thunk

sub_3E989 proc far
	jmp	near ptr sub_3F899
sub_3E989 endp

; Attributes: thunk

sub_3E98C proc far
	jmp	near ptr sub_3F7C1
sub_3E98C endp

; Attributes: thunk
sub_3E98F proc near
	jmp	near ptr sub_3F919
sub_3E98F endp

; Attributes: thunk
j_nullsub_3 proc near
	jmp	near ptr nullsub_3
j_nullsub_3 endp

; Attributes: thunk
j_nullsub_2 proc near
	jmp	near ptr nullsub_2
j_nullsub_2 endp

; Attributes: thunk
vid_setMouseIcon proc near
	jmp	near ptr _vid_setMouseIcon
vid_setMouseIcon endp

; Attributes: thunk

sub_3E99B proc far
	jmp	near ptr sub_3F95D
sub_3E99B endp

byte_3E99E db 0, 1, 2, 3, 4, 5,	6, 7, 8, 9; 0
db 0Ah,	0Bh, 0Ch, 0Dh, 0Eh, 0Fh; 10
unk_3E9AE db	3
dword_3E9AF dd 0A0001F40h
word_3E9B3 dw 0
word_3E9B5 dw 0
word_3E9B7 dw 0
byte_3E9B9 db 0
byte_3E9BA db 0
byte_3E9BB db 0
byte_3E9BC db 0FFh, 7Fh, 3Fh, 1Fh, 0Fh,	7, 3, 1; 0
byte_3E9C4 db 80h,	0C0h, 0E0h, 0F0h, 0F8h,	0FCh, 0FEh, 0FFh; 0
byte_3E9CC db 1, 0, 2, 0, 3, 0, 4, 0, 5, 0; 0
db 6			; 10
byte_3E9D7 db 0
db    7
db 0
db    8
db    0
db    0
db    0
db    0
db    0
db    0
db    0
word_3E9E2 dw 0A000h
vid_mouseY dw 0
vid_mouseX dw 0
vid_mouseIndex dw 0
vid_mouseBuf db	0C0h dup(0)	     ; 0
byte_3EAAA db 0, 0, 31,	192, 63, 240, 127, 248,	117, 248, 123, 248, 126, 88, 97, 152
db 127,	248, 62, 24, 63, 240, 31, 224, 6, 192, 0, 0, 0,	0, 0, 0
db 0, 0, 31, 192, 63, 240, 127,	248, 117, 248, 123, 248, 126, 88, 97, 152
db 127,	248, 62, 24, 63, 240, 31, 224, 6, 192, 0, 0, 0,	0, 0, 0
db 0, 0, 31, 192, 63, 240, 127,	248, 117, 248, 123, 248, 126, 88, 97, 152
db 127,	248, 62, 24, 63, 240, 31, 224, 6, 192, 0, 0, 0,	0, 0, 0
db 0, 0, 31, 192, 32, 48, 94, 8, 68, 8,	73, 232, 94, 72, 64, 136
db 65, 232, 38,	8, 40, 208, 25,	32, 6, 192, 0, 0, 0, 0,	0, 0
db 0, 0, 31, 192, 35, 240, 94, 120, 68,	24, 73,	232, 94, 72, 64, 136
db 65, 232, 38,	8, 43, 208, 25,	96, 6, 192, 0, 0, 0, 0,	0, 0
byte_3EB4A db 0, 0, 1, 0, 3, 128, 7, 192, 15, 224, 31, 240, 7, 192, 7, 192
db 7, 192, 7, 192, 7, 192, 7, 192, 7, 192, 0, 0, 0, 0, 0, 0
db 0, 0, 0, 0, 1, 0, 3,	128, 7,	192, 3,	128, 3,	128, 3,	128
db 3, 128, 3, 128, 3, 128, 3, 128, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 1, 0, 2, 128, 4, 64, 8, 32, 28, 112, 4, 64, 4,	64
db 4, 64, 4, 64, 4, 64,	4, 64, 7, 192, 0, 0, 0,	0, 0, 0
db 0, 0, 1, 0, 3, 128, 7, 192, 15, 224,	31, 240, 7, 192, 4, 64
db 3, 128, 4, 64, 3, 128, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0
byte_3EBEA db 0, 0, 7, 224, 15,	240, 31, 248, 31, 248, 31, 120,	31, 120, 31, 0
db 127,	192, 63, 128, 31, 0, 14, 0, 4, 0, 0, 0,	0, 0, 0, 0
db 0, 0, 0, 0, 7, 224, 15, 240,	14, 48,	14, 48,	14, 0, 14, 0
db 14, 0, 31, 0, 14, 0,	4, 0, 0, 0, 0, 0, 0, 0,	0, 0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 7, 224, 8, 16,	16, 8, 17, 200,	17, 72,	17, 120, 17, 0
db 113,	192, 32, 128, 17, 0, 10, 0, 4, 0, 0, 0,	0, 0, 0, 0
db 0, 0, 0, 0, 8, 0, 0,	0, 30, 128, 1, 0, 31, 0, 17, 0
db 127,	192, 63, 128, 31, 0, 14, 0, 4, 0, 0, 0,	0, 0, 0, 0
byte_3EC8A db 0, 0, 0, 0, 4, 0,	12, 0, 31, 224,	63, 240, 127, 248, 63, 248
db 31, 248, 12,	248, 4,	248, 0,	248, 0,	248, 0,	0, 0, 0, 0, 0
db 0, 0, 0, 0, 0, 0, 0,	0, 8, 0, 31, 224, 63, 240, 31, 240
db 8, 112, 0, 112, 0, 112, 0, 112, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 4, 0, 12, 0, 23,	224, 32, 16, 64, 8, 32,	8
db 23, 136, 12,	136, 4,	136, 0,	136, 0,	248, 0,	0, 0, 0, 0, 0
db 0, 0, 0, 0, 4, 0, 12, 0, 29,	64, 61,	16, 125, 32, 61, 64
db 30, 128, 12,	0, 4, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0
byte_3ED2A db 0, 0, 0, 128, 0, 192, 31,	224, 63, 240, 127, 248,	127, 240, 127, 224
db 124,	192, 124, 128, 124, 0, 124, 0, 0, 0, 0,	0, 0, 0, 0, 0
db 0, 0, 0, 0, 0, 0, 0,	64, 31,	224, 63, 240, 63, 224, 56, 64
db 56, 0, 56, 0, 56, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0, 0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,	0
db 0, 0, 0, 128, 0, 192, 31, 160, 32, 16, 64, 8, 64, 16, 71, 160
db 68, 192, 68,	128, 68, 0, 124, 0, 0, 0, 0, 0,	0, 0, 0, 0
db 0, 0, 0, 128, 0, 192, 10, 224, 34, 240, 18, 248, 10,	240, 5,	224
db 0, 192, 0, 128, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0
byte_3EDCA db 0, 0, 48,	0, 56, 0, 28, 0, 15, 0,	15, 128, 31, 192, 27, 224
db 31, 240, 31,	240, 15, 248, 1, 248, 0, 112, 0, 0, 0, 0, 0, 0
db 0, 0, 48, 0,	24, 0, 12, 0, 7, 0, 11,	128, 27, 192, 19, 224
db 3, 240, 31, 240, 1, 248, 0, 120, 0, 0, 0, 0,	0, 0, 0, 0
db 0, 0, 0, 0, 32, 0, 16, 0, 8,	0, 4, 0, 4, 0, 8, 0
db 28, 0, 0, 0,	14, 0, 1, 128, 0, 112, 0, 0, 0,	0, 0, 0
db 0, 0, 48, 0,	56, 0, 28, 0, 15, 0, 15, 128, 31, 192, 27, 224
db 31, 240, 31,	240, 15, 248, 1, 248, 0, 112, 0, 0, 0, 0, 0, 0
db 0, 0, 48, 0,	24, 0, 12, 0, 7, 0, 11,	128, 27, 192, 19, 224
db 3, 240, 31, 240, 1, 248, 0, 120, 0, 0, 0, 0,	0, 0, 0, 0
byte_3EE6A db 0, 0, 3, 192, 7, 224, 15,	240, 15, 248, 15, 248, 63, 248,	63, 248
db 63, 248, 63,	248, 31, 248, 15, 240, 7, 224, 0, 0, 0,	0, 0, 0
db 0, 0, 0, 0, 1, 64, 5, 64, 5,	80, 5, 80, 7, 240, 23, 240
db 25, 240, 30,	240, 15, 240, 3, 224, 0, 0, 0, 0, 0, 0,	0, 0
db 0, 0, 3, 192, 6, 160, 10, 176, 10, 168, 10, 168, 56,	8, 40, 8
db 38, 8, 33, 8, 16, 8,	12, 16,	7, 224,	0, 0, 0, 0, 0, 0
db 0, 0, 3, 192, 7, 224, 15, 240, 15, 248, 15, 248, 63,	248, 63, 248
db 63, 248, 63,	248, 31, 248, 15, 240, 7, 224, 0, 0, 0,	0, 0, 0
db 0, 0, 0, 0, 1, 64, 5, 64, 5,	80, 5, 80, 7, 240, 23, 240
db 25, 240, 30,	240, 15, 240, 3, 224, 0, 0, 0, 0, 0, 0,	0, 0
off_3EF0A dw offset byte_3EAAA
off_3EF0C dw offset byte_3EAAA
dw offset byte_3EB4A
dw offset byte_3EBEA
dw offset byte_3EC8A
dw offset byte_3ED2A
dw offset byte_3EDCA
dw offset byte_3EE6A
dw offset byte_3EE6A
; Attributes: bp-based frame

_vid_setMode proc far
arg_0= word ptr	 6
	push	bp
	mov	bp, sp
	mov	ax, [bp+arg_0]
	or	ax, ax
	jz	short loc_3EF2E
	mov	ax, 0Dh
	int	10h		; - VIDEO - SET	VIDEO MODE
			; AL = mode
	jmp	short loc_3EF33
db  90h	; ê
loc_3EF2E:
	mov	ax, 3
	int	10h		; - VIDEO - SET	VIDEO MODE
			; AL = mode
loc_3EF33:
	pop	bp
	retf
_vid_setMode endp

; Attributes: bp-based frame

sub_3EF35 proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
arg_6= word ptr	 0Ch
arg_8= byte ptr	 0Eh
	push	bp
	mov	bp, sp
	push	es
	push	ds
	push	si
	push	di
	mov	ax, cs
	mov	ds, ax
	assume ds:seg024
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	mov	bx, ax
	shl	ax, 1
	shl	ax, 1
	add	ax, bx
	mov	cs:word_3E9B3, ax
	mov	ax, [bp+arg_6]
	sub	ax, cx
	inc	ax
	mov	cs:word_3E9B5, ax
	mov	al, [bp+arg_8]
	not	al
	mov	cs:byte_3E9B9, al
	mov	cs:byte_3E9BA, 0
	mov	cs:byte_3E9BB, 1
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	mov	ax, [bp+arg_0]
	mov	bx, ax
	and	bx, 7
	mov	dh, cs:byte_3E9BC[bx]
	mov	cx, [bp+arg_4]
	mov	bx, cx
	and	bx, 7
	mov	dl, cs:byte_3E9C4[bx]
	mov	bx, cx
	mov	cl, 3
	shr	ax, cl
	shr	bx, cl
	add	cs:word_3E9B3, ax
	cmp	ax, bx
	jnz	short loc_3F003
	and	dh, dl
	mov	bl, dh
loc_3EFB1:
	mov	dx, 3C5h
	mov	al, cs:byte_3E9BB
	shl	cs:byte_3E9BB, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, cs:byte_3E9BA
	out	dx, al		; EGA port: graphics controller	data register
	sub	bh, bh
	rcr	cs:byte_3E9B9, 1
	rcl	bh, 1
	dec	bh
	and	bh, bl
	not	bl
	mov	cx, cs:word_3E9B5
	mov	di, cs:word_3E9B3
	mov	ax, ds
	mov	ds, cs:word_3E9E2
	assume ds:nothing
loc_3EFE6:
	and	[di], bl
	or	[di], bh
	add	di, 28h	
	loop	loc_3EFE6
	mov	ds, ax
	assume ds:seg024
	not	bl
	inc	cs:byte_3E9BA
	cmp	cs:byte_3E9BA, 4
	jnz	short loc_3EFB1
	jmp	loc_3F0CC
loc_3F003:
	dec	bx
	cmp	ax, bx
	jnz	short loc_3F05D
	mov	ax, dx
	xchg	al, ah
	mov	bx, ax
loc_3F00E:
	mov	dx, 3C5h
	mov	al, cs:byte_3E9BB
	shl	cs:byte_3E9BB, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, cs:byte_3E9BA
	out	dx, al		; EGA port: graphics controller	data register
	sub	ax, ax
	rcr	cs:byte_3E9B9, 1
	rcl	ax, 1
	dec	ax
	and	ax, bx
	not	bx
	mov	cx, cs:word_3E9B5
	mov	di, cs:word_3E9B3
	push	ds
	mov	ds, cs:word_3E9E2
	assume ds:nothing
loc_3F041:
	and	[di], bx
	or	[di], ax
	add	di, 28h	
	loop	loc_3F041
	pop	ds
	assume ds:dseg
	not	bx
	inc	cs:byte_3E9BA
	cmp	cs:byte_3E9BA, 4
	jnz	short loc_3F00E
	jmp	short loc_3F0CC
db  90h	; ê
loc_3F05D:
	inc	bx
	sub	bx, ax
	dec	bx
	mov	bp, bx
	inc	bx
	neg	bx
	add	bx, 28h	
	mov	si, bx
	not	dx
	mov	bx, dx
	mov	es, cs:word_3E9E2
	assume es:nothing
loc_3F074:
	mov	dx, 3C5h
	mov	al, cs:byte_3E9BB
	shl	cs:byte_3E9BB, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, cs:byte_3E9BA
	out	dx, al		; EGA port: graphics controller	data register
	sub	dx, dx
	rcr	cs:byte_3E9B9, 1
	rcl	dx, 1
	dec	dx
	mov	al, dl
	not	bx
	and	dx, bx
	not	bx
	mov	di, cs:word_3E9B3
	mov	ah, byte ptr cs:word_3E9B5
	push	ds
	mov	ds, cs:word_3E9E2
	assume ds:nothing
loc_3F0AB:
	and	[di], bh
	or	[di], dh
	inc	di
	mov	cx, bp
	rep stosb
	and	[di], bl
	or	[di], dl
	add	di, si
	dec	ah
	jnz	short loc_3F0AB
	pop	ds
	assume ds:dseg
	inc	cs:byte_3E9BA
	cmp	cs:byte_3E9BA, 4
	jnz	short loc_3F074
loc_3F0CC:
	pop	di
	pop	si
	pop	ds
	pop	es
	assume es:nothing
	pop	bp
	retf
sub_3EF35 endp

; Attributes: bp-based frame

sub_3F0D2 proc far
arg_0= word ptr	 6
arg_2= word ptr	 8
arg_4= word ptr	 0Ah
arg_6= byte ptr	 0Ch
	push	bp
	mov	bp, sp
	push	si
	push	di
	push	es
	push	ds
	mov	ax, cs
	mov	es, ax
	assume es:seg024
	lds	si, cs:characterBitmasksP
	mov	ax, [bp+arg_4]
	sub	ah, ah
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	si, ax
	mov	di, offset byte_3E9CC
	mov	cl, byte ptr [bp+arg_2]
	and	cl, 7
	cld
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	sub	ax, ax
	lodsb
	ror	ax, cl
	stosw
	mov	ax, es
	mov	ds, ax
	assume ds:seg024
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	si, offset byte_3E9CC
	mov	dx, [bp+arg_0]
	and	dl, 0FEh
	shl	dx, 1
	shl	dx, 1
	shl	dx, 1
	mov	di, dx
	shl	dx, 1
	shl	dx, 1
	add	di, dx
	mov	ax, [bp+arg_2]
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	add	di, ax
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	mov	bx, 1
	test	[bp+arg_6], 1
	jnz	short loc_3F196
loc_3F169:
	push	si
	push	di
	mov	dx, 3C5h
	mov	al, bl
	shl	bl, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, bh
	inc	bh
	out	dx, al		; EGA port: graphics controller	data register
	mov	cx, 4
loc_3F17E:
	lodsw
	or	es:[di], ax
	lodsw
	or	es:[di+28h], ax
	add	di, 50h	
	loop	loc_3F17E
	pop	di
	pop	si
	cmp	bh, 4
	jnz	short loc_3F169
	jmp	short loc_3F1C4
db  90h	; ê
loc_3F196:
	push	si
	push	di
	mov	dx, 3C5h
	mov	al, bl
	shl	bl, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, bh
	inc	bh
	out	dx, al		; EGA port: graphics controller	data register
	mov	cx, 4
loc_3F1AB:
	lodsw
	not	ax
	and	es:[di], ax
	lodsw
	not	ax
	and	es:[di+28h], ax
	add	di, 50h	
	loop	loc_3F1AB
	pop	di
	pop	si
	cmp	bh, 4
	jnz	short loc_3F196
loc_3F1C4:
	pop	ds
	assume ds:dseg
	pop	es
	assume es:nothing
	pop	di
	pop	si
	pop	bp
	retf
sub_3F0D2 endp

; Attributes: bp-based frame

sub_3F1CA proc far
arg_0= dword ptr  6
arg_4= dword ptr  0Ah
	push	bp
	mov	bp, sp
	push	es
	push	si
	push	di
	push	ds
	lds	si, [bp+arg_0]
	les	di, [bp+arg_4]
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	al, 0Fh
	out	dx, al		; EGA port: sequencer data register
	mov	bx, 8000
	cld
loc_3F1E5:
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	mov	es:[di+5DC0h], dh
	mov	es:[di+3E80h], dl
	mov	es:[di+1F40h], ch
	mov	es:[di], cl
	inc	di
	dec	bx
	jz	short loc_3F280
	jmp	loc_3F1E5
loc_3F280:
	lds	si, [bp+arg_4]
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	bl, 1
	sub	ch, ch
loc_3F28C:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jz	short loc_3F28C
loc_3F294:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jnz	short loc_3F294
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
loc_3F2A2:
	xor	di, di
	mov	al, bl
	shl	bl, 1
	mov	dl, 0C5h 
	out	dx, al		; EGA port: sequencer data register
	mov	bh, 0C8h 
	mov	dl, 14h
loc_3F2AF:
	mov	cl, dl
	rep movsw
	dec	bh
	jnz	short loc_3F2AF
	test	bl, 10h
	jz	short loc_3F2A2
	pop	ds
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	bp
	retf
sub_3F1CA endp

; Attributes: bp-based frame

sub_3F2C2 proc far
	push	bp
	mov	bp, sp
	push	si
	push	di
	push	es
	push	ds
	mov	ax, 0A000h
	mov	ds, ax
	assume ds:nothing
	mov	es, ax
	assume es:nothing
	cld
	mov	cs:byte_3E9BA, 2
loc_3F2D7:
	mov	di, 105h
	mov	si, di
	add	si, 50h	
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
loc_3F2EB:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jz	short loc_3F2EB
loc_3F2F3:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jnz	short loc_3F2F3
	sub	ch, ch
	mov	dx, 3C5h
	mov	al, 0Fh
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	sub	al, al
	out	dx, al		; EGA port: graphics controller	data register
	mov	ax, 16h
	mov	dl, 9
	mov	bl, 60h	
loc_3F310:
	mov	cl, dl
	rep movsw
	add	si, ax
	add	di, ax
	dec	bl
	jnz	short loc_3F310
	dec	cs:byte_3E9BA
	jnz	short loc_3F2D7
	pop	ds
	assume ds:dseg
	pop	es
	assume es:nothing
	pop	di
	pop	si
	pop	bp
	retf
sub_3F2C2 endp

; Attributes: bp-based frame

_vid_drawBigpic	proc far

	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah

	push	bp
	mov	bp, sp
	push	es
	push	si
	push	di
	push	ds
	lds	si, [bp+arg_0]		; source Buffer
	les	di, [bp+arg_4]		; destination buffer
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	al, 0Fh
	out	dx, al		; EGA port: sequencer data register
	mov	bx, 4D0h
loc_3F343:
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	mov	es:[di+0E70h], dh
	mov	es:[di+9A0h], dl
	mov	es:[di+4D0h], ch
	mov	es:[di], cl
	inc	di
	dec	bx
	jz	short loc_3F3DE
	jmp	loc_3F343
loc_3F3DE:
	lds	si, [bp+arg_4]
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	bl, 1
	sub	ch, ch

loc_3F3EA:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jz	short loc_3F3EA
loc_3F3F2:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jnz	short loc_3F3F2
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
loc_3F400:
	mov	di, 25Ah
	mov	al, bl
	shl	bl, 1
	mov	dl, 0C5h 
	out	dx, al		; EGA port: sequencer data register
	mov	bh, 58h	
	mov	ax, 1Ah
	mov	dl, 7
loc_3F411:
	mov	cl, dl
	rep movsw
	add	di, ax
	dec	bh
	jnz	short loc_3F411
	test	bl, 10h
	jz	short loc_3F400
	pop	ds
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	bp
	retf
_vid_drawBigpic	endp

; Attributes: bp-based frame

sub_3F426 proc far
arg_0= word ptr	 6
	push	bp
	mov	bp, sp
	push	di
	push	ds
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	dec	al
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	inc	dx
	sub	al, al
	out	dx, al		; EGA port: graphics controller	data register
	mov	ax, [bp+arg_0]
	mov	cl, 6
	shl	ax, cl
	mov	di, ax
	shl	ax, 1
	shl	ax, 1
	add	di, ax
	add	di, 0DDh 
	mov	cx, 8
	mov	ax, 0A000h
	mov	ds, ax
	assume ds:nothing
	sub	ax, ax
	dec	ax
loc_3F45D:
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], ax
	add	di, 2
	xor	[di], al
	add	di, 18h
	loop	loc_3F45D
	pop	ds
	assume ds:dseg
	pop	di
	pop	bp
	retf
sub_3F426 endp

; Attributes: bp-based frame
sub_3F490 proc near
arg_2= dword ptr  6
arg_6= word ptr	 0Ah
arg_8= byte ptr	 0Ch
arg_A= byte ptr	 0Eh
; FUNCTION CHUNK AT 0C75 SIZE 0000003E BYTES
	push	bp
	mov	bp, sp
	push	es
	push	si
	push	di
	push	ds
	lds	si, [bp+arg_2]
	les	di, cs:dword_3E9AF
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	al, 0Fh
	out	dx, al		; EGA port: sequencer data register
	mov	bl, [bp+arg_8]
loc_3F4AC:
	mov	bh, [bp+arg_A]
	shr	bh, 1
	shr	bh, 1
loc_3F4B3:
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	lodsw
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	ch, 1
	rcl	al, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	ch, 1
	rcl	ah, 1
	rcl	cl, 1
	mov	es:[di+0E70h], dh
	mov	es:[di+9A0h], dl
	mov	es:[di+4D0h], ch
	mov	es:[di], cl
	inc	di
	dec	bh
	jz	short loc_3F54F
	jmp	loc_3F4B3
loc_3F54F:
	dec	bl
	jz	short loc_3F556
	jmp	loc_3F4AC
loc_3F556:
	lds	si, cs:dword_3E9AF
	mov	ax, ds
	mov	es, ax
	assume es:dseg
	mov	ax, [bp+arg_6]
	shr	ax, 1
	shr	ax, 1
	mov	di, ax
	add	di, 11D0h
	mov	word ptr [bp+arg_2+2], di
	mov	bl, 1
	sub	ch, ch
loc_3F573:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jz	short loc_3F573
loc_3F57B:
	mov	dx, 3DAh
	in	al, dx		; Video	status bits:
			; 0: retrace.  1=display is in vert or horiz retrace.
			; 1: 1=light pen is triggered; 0=armed
			; 2: 1=light pen switch	is open; 0=closed
			; 3: 1=vertical	sync pulse is occurring.
	and	al, 8
	jnz	short loc_3F57B
	mov	al, 2
	mov	ah, [bp+arg_8]
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	al, 1
	mov	bx, word ptr cs:dword_3E9AF
	cmp	[bp+arg_A], 0Ch
	jz	short loc_3F5C5
	cmp	[bp+arg_A], 10h
	jz	short loc_3F5E4
	mov	bp, word ptr [bp+arg_2+2]
	sub	ch, ch
loc_3F5A5:
	mov	di, bp
	mov	si, bx
	mov	cl, ah
	out	dx, al		; EGA port: sequencer data register
	shl	al, 1
loc_3F5AE:
	movsw
	movsw
	movsb
	add	di, 23h	
	loop	loc_3F5AE
	add	bx, 4D0h
	test	al, 10h
	jz	short loc_3F5A5
loc_3F5BE::
	pop	ds
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	bp
sub_3F490 endp

; START	OF FUNCTION CHUNK FOR sub_3F603
loc_3F5C3:
	sti
	retf
; END OF FUNCTION CHUNK	FOR sub_3F603
; START	OF FUNCTION CHUNK FOR sub_3F490
loc_3F5C5:
	mov	bp, word ptr [bp+arg_2+2]
	sub	ch, ch
loc_3F5CA:
	mov	di, bp
	mov	si, bx
	mov	cl, ah
	out	dx, al		; EGA port: sequencer data register
	shl	al, 1
loc_3F5D3:
	movsw
	movsb
	add	di, 25h	
	loop	loc_3F5D3
	add	bx, 4D0h
	test	al, 10h
	jz	short loc_3F5CA
	jmp	short loc_3F5BE
loc_3F5E4:
	mov	bp, word ptr [bp+arg_2+2]
	sub	ch, ch
loc_3F5E9:
	mov	di, bp
	mov	si, bx
	mov	cl, ah
	out	dx, al		; EGA port: sequencer data register
	shl	al, 1
loc_3F5F2:
	movsw
	movsw
	add	di, 24h	
	loop	loc_3F5F2
	add	bx, 4D0h
	test	al, 10h
	jz	short loc_3F5E9
	jmp	short loc_3F5BE
; END OF FUNCTION CHUNK	FOR sub_3F490
; Attributes: bp-based frame

sub_3F603 proc far
; FUNCTION CHUNK AT 0C73 SIZE 00000002 BYTES
	cli
	nop
	mov	bx, cs:byte_4EF79_P
	cmp	byte ptr [bx], 0
	jz	short loc_3F5C3
	mov	byte ptr [bx], 0
	mov	bx, cs:byte_4EF5E_P
	cmp	byte ptr [bx], 0
	jz	short loc_3F5C3
	push	bp
	push	si
	push	di
	mov	bp, sp
	mov	bx, cs:byte_4EF7A_P
	mov	byte ptr [bx], 1
	sti
	mov	bx, cs:mouseMovedP
	mov	byte ptr [bx], 0
	push	ds
	push	es
	mov	bx, cs:mouseXP
	mov	ax, [bx]
	mov	cs:vid_mouseX, ax
	shr	ax, 1
	shr	ax, 1
	shr	ax, 1
	mov	si, ax
	mov	bx, cs:mouseYP
	mov	ax, [bx]
	mov	cs:vid_mouseY, ax
	shl	ax, 1
	shl	ax, 1
	shl	ax, 1
	add	si, ax
	shl	ax, 1
	shl	ax, 1
	add	si, ax
	mov	cs:vid_mouseIndex, si
	mov	di, offset vid_mouseBuf
	mov	ax, cs
	mov	es, ax
	assume es:seg024
	mov	ax, 0A000h
	mov	ds, ax
	assume ds:nothing
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	inc	dx
	mov	ax, 400h
	mov	bx, 10h
	mov	bp, 25h	
	cld
loc_3F682:		; EGA port: graphics controller	data register
	out	dx, al
	inc	al
	mov	cx, bx
loc_3F687:
	movsw
	movsb
	add	si, bp
	loop	loc_3F687
	mov	si, es:vid_mouseIndex
	cmp	al, ah
	jnz	short loc_3F682
	pop	es
	assume es:nothing
	pop	ds
	assume ds:dseg
	push	cs
	call	sub_3E977
	mov	bx, cs:byte_4EF7A_P
	mov	byte ptr [bx], 0
	pop	di
	pop	si
	pop	bp
	sti
	retf
sub_3F603 endp


sub_3F6A9 proc far
	cli
	nop
	mov	bx, cs:byte_4EF79_P
	cmp	byte ptr [bx], 0
	jnz	short loc_3F712
	inc	byte ptr [bx]
	mov	bx, cs:byte_4EF5E_P
	cmp	byte ptr [bx], 0
	jz	short loc_3F712
	mov	bx, cs:byte_4EF7A_P
	mov	byte ptr [bx], 1
	sti
	push	bp
	push	es
	push	si
	push	di
	push	ds
	mov	ax, cs
	mov	ds, ax
	assume ds:seg024
	mov	di, cs:vid_mouseIndex
	mov	si, offset vid_mouseBuf
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	ax, 1001h
	mov	bx, 10h
	mov	bp, 25h	
	cld
loc_3F6F1:		; EGA port: sequencer data register
	out	dx, al
	shl	al, 1
	mov	cx, bx
loc_3F6F6:
	movsw
	movsb
	add	di, bp
	loop	loc_3F6F6
	mov	di, cs:vid_mouseIndex
	test	al, ah
	jz	short loc_3F6F1
	pop	ds
	assume ds:dseg
	mov	bx, cs:byte_4EF7A_P
	mov	byte ptr [bx], 0
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	bp
loc_3F712:
	sti
	retf
sub_3F6A9 endp


sub_3F714 proc far
	push	bp
	push	es
	push	si
	push	di
	push	ds
	mov	ax, cs
	mov	ds, ax
	assume ds:seg024
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	mov	bx, 1
	mov	ax, cs:vid_mouseX
	and	al, 7
	mov	ch, al
loc_3F739:
	mov	si, cs:off_3EF0A
	mov	dx, 3CFh
	mov	al, bh
	out	dx, al		; EGA port: graphics controller	data register
	inc	bh
	mov	dx, 3C5h
	mov	al, bl
	out	dx, al		; EGA port: sequencer data register
	shl	bl, 1
	mov	dl, 10h
	mov	di, cs:vid_mouseIndex
loc_3F755:
	lodsb
	mov	cl, ch
	sub	ah, ah
	ror	ax, cl
	not	ax
	and	es:[di], ax
	inc	di
	lodsb
	mov	cl, ch
	sub	ah, ah
	ror	ax, cl
	not	ax
	and	es:[di], ax
	add	di, 27h	
	dec	dl
	jnz	short loc_3F755
	test	bl, 10h
	jz	short loc_3F739
	mov	bx, 1
loc_3F77D:
	mov	dx, 3CFh
	mov	al, bh
	out	dx, al		; EGA port: graphics controller	data register
	inc	bh
	mov	dx, 3C5h
	mov	al, bl
	out	dx, al		; EGA port: sequencer data register
	shl	bl, 1
	mov	dl, 10h
	mov	di, cs:vid_mouseIndex
loc_3F794:
	lodsb
	mov	cl, ch
	sub	ah, ah
	ror	ax, cl
	or	es:[di], ax
	inc	di
	lodsb
	mov	cl, ch
	sub	ah, ah
	ror	ax, cl
	or	es:[di], ax
	add	di, 27h	
	dec	dl
	jnz	short loc_3F794
	test	bl, 10h
	jz	short loc_3F77D
	pop	ds
	assume ds:dseg
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	bp
	retf
sub_3F714 endp

; START	OF FUNCTION CHUNK FOR sub_3F7C1
loc_3F7BB:
	pop	di
	pop	si
	pop	es
	pop	ds
	pop	bp
	retf
; END OF FUNCTION CHUNK	FOR sub_3F7C1
; Attributes: bp-based frame

sub_3F7C1 proc far
arg_2= dword ptr  6
; FUNCTION CHUNK AT 0E6B SIZE 00000006 BYTES
	push	bp
	mov	bp, sp
	push	ds
	push	es
	push	si
	push	di
	lds	si, [bp+arg_2]
loc_3F7CB:
	mov	ax, [si]
	cmp	ax, 0FFFFh
	jz	short loc_3F7BB
	mov	cx, ax
	and	ax, 7F0h
	mov	bx, ax
	shr	bx, 1
	shl	ax, 1
	add	bx, ax
	mov	ax, cx
	and	ax, 0Fh
	add	ax, bx
	add	ax, 25Ah
	and	cx, 7000h
	shl	cx, 1
	or	ax, cx
	mov	[si], ax
	add	si, 2
	rol	cx, 1
	rol	cx, 1
	rol	cx, 1
	inc	cx
loc_3F7FD:
	mov	ax, [si]
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	bh, 1
	rcl	al, 1
	rcl	bl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	bh, 1
	rcl	al, 1
	rcl	bl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	bh, 1
	rcl	ah, 1
	rcl	bl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	bh, 1
	rcl	ah, 1
	rcl	bl, 1
	mov	ax, [si+2]
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	bh, 1
	rcl	al, 1
	rcl	bl, 1
	rcl	al, 1
	rcl	dh, 1
	rcl	al, 1
	rcl	dl, 1
	rcl	al, 1
	rcl	bh, 1
	rcl	al, 1
	rcl	bl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	bh, 1
	rcl	ah, 1
	rcl	bl, 1
	rcl	ah, 1
	rcl	dh, 1
	rcl	ah, 1
	rcl	dl, 1
	rcl	ah, 1
	rcl	bh, 1
	rcl	ah, 1
	rcl	bl, 1
	mov	[si+3],	dh
	mov	[si+2],	dl
	mov	[si+1],	bh
	mov	[si], bl
	add	si, 4
	dec	cx
	jz	short loc_3F896
	jmp	loc_3F7FD
loc_3F896:
	jmp	loc_3F7CB
sub_3F7C1 endp

; Attributes: bp-based frame

sub_3F899 proc far
arg_0= dword ptr  6
	push	bp
	mov	bp, sp
	push	ds
	push	es
	push	si
	push	di
	lds	si, [bp+arg_0]
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	mov	dx, 3C4h
	mov	al, 2
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	mov	dx, 3CEh
	mov	al, 4
	out	dx, al		; EGA: graph 1 and 2 addr reg:
			; read map select.
			; Data bits 0-2	select map # for read mode 00.
	mov	bx, 3C5h
loc_3F8B7:
	lodsw
	cmp	ax, 0FFFFh
	jz	short loc_3F90F
	mov	cx, ax
	rol	cx, 1
	rol	cx, 1
	rol	cx, 1
	and	cx, 7
	inc	cx
	and	ax, 1FFFh
	mov	di, ax
loc_3F8CE:
	mov	dx, bx
	mov	al, 1
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	dec	al
	out	dx, al		; EGA port: graphics controller	data register
	lodsb
	xor	es:[di], al
	mov	dx, bx
	mov	al, 2
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	dec	al
	out	dx, al		; EGA port: graphics controller	data register
	lodsb
	xor	es:[di], al
	mov	dx, bx
	mov	al, 4
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, 2
	out	dx, al		; EGA port: graphics controller	data register
	lodsb
	xor	es:[di], al
	mov	dx, bx
	mov	al, 8
	out	dx, al		; EGA port: sequencer data register
	mov	dx, 3CFh
	mov	al, 3
	out	dx, al		; EGA port: graphics controller	data register
	lodsb
	xor	es:[di], al
	inc	di
	loop	loc_3F8CE
	jmp	short loc_3F8B7
loc_3F90F:
	mov	ax, si
	mov	dx, ds
	pop	di
	pop	si
	pop	es
	assume es:nothing
	pop	ds
	pop	bp
	retf
sub_3F899 endp

; Attributes: bp-based frame

sub_3F919 proc far
	push	bp
	mov	bp, sp
	push	es
	push	di
	mov	al, 2
	mov	dx, 3C4h
	out	dx, al		; EGA: sequencer address reg
			; map mask: data bits 0-3 enable writes	to bit planes 0-3
	inc	dx
	mov	al, 0Fh
	out	dx, al		; EGA port: sequencer data register
	mov	ax, 0A000h
	mov	es, ax
	assume es:nothing
	sub	ax, ax
	mov	di, 25Ah
	mov	dh, 58h	
	mov	bx, 1Ah
	mov	dl, 7
loc_3F939:
	mov	cl, dl
	rep stosw
	add	di, bx
	dec	dh
	jnz	short loc_3F939
	pop	di
	pop	es
	assume es:nothing
	pop	bp
	retf
sub_3F919 endp


nullsub_3 proc far
	retf
nullsub_3 endp


nullsub_2 proc far
	retf
nullsub_2 endp

; Attributes: bp-based frame

_vid_setMouseIcon proc far
arg_0= word ptr	 6
	push	bp
	mov	bp, sp
	mov	bx, [bp+arg_0]
	shl	bx, 1
	mov	bx, cs:off_3EF0C[bx]
	mov	cs:off_3EF0A, bx
	pop	bp
	retf
_vid_setMouseIcon endp


sub_3F95D proc far
	push	bp
	push	ds
	pop	ds
	pop	bp
	retf
sub_3F95D endp

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
db    0
db    0
db    0
db    0
db    0
db    0
db    0
db    0
seg024 ends
