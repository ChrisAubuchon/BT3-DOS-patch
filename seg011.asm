; Segment type:	Pure code
seg011 segment word public 'CODE' use16
	assume cs:seg011
;org 1
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_229C1:
align 2
; Attributes: bp-based frame

song_getNonCombatSinger	proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	call	clearTextWindow
	mov	ax, offset aWhoWillPlay?
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_6], ax
	or	ax, ax
	jl	short loc_22A5A
	push	ax
	push	cs
	call	near ptr sing_getSongSubtractor
	add	sp, 2
	mov	[bp+var_4], ax
	push	[bp+var_6]
	push	cs
	call	near ptr _canSingSong
	add	sp, 2
	or	ax, ax
	jz	short loc_22A4E
	cmp	[bp+var_4], 0
	jl	short loc_22A4E
	call	clearTextWindow
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	cs
	call	near ptr song_getSong
	add	sp, 4
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_22A4E
	push	cs
	call	near ptr sub_22DA1
	push	[bp+var_2]
	push	[bp+var_6]
	push	cs
	call	near ptr sub_22CD5
	add	sp, 4
	push	cs
	call	near ptr song_doNoncombatEffect
	mov	al, byte ptr [bp+var_4]
	mov	cx, ax
	getCharP	[bp+var_6], bx
	sub	gs:roster.specAbil[bx],	cl
loc_22A4E:
	wait4IO
loc_22A5A:
	call	clearTextWindow
	mov	sp, bp
	pop	bp
	retf
song_getNonCombatSinger	endp

; Attributes: bp-based frame

_canSingSong proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+charNo], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_22A85
	sub	ax, ax
	jmp	short loc_22AF4
loc_22A85:
	getCharP	[bp+charNo], bx
	cmp	gs:roster.class[bx], class_bard
	jz	short loc_22AA6
	mov	ax, offset aNotABard
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_22AF4
loc_22AA6:
	mov	ax, itType_instrument
	push	ax
	push	[bp+charNo]
	call	inven_hasTypeEquipped
	add	sp, 4
	or	ax, ax
	jz	short loc_22AE3
	getCharP	[bp+charNo], bx
	cmp	gs:roster.specAbil[bx],	0
	jz	short loc_22AD2
	mov	ax, 1
	jmp	short loc_22AF4
loc_22AD2:
	mov	ax, offset aYourThroatIsDr
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short loc_22AF4
loc_22AE3:
	mov	ax, offset aYouArenTUsingA
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	sub	ax, ax
	jmp	short $+2
loc_22AF4:
	mov	sp, bp
	pop	bp
	retf
_canSingSong endp

; This function	returns	1 if the character is active,
; a bard and has an instrument equipped. 0 otherwise.
; Attributes: bp-based frame

_charCanPlaySong proc far

	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+charNo], si
	test	gs:roster.status[si], stat_dead	or stat_stoned or stat_paralyzed
	jnz	short loc_22B1F
	cmp	gs:roster.class[si], class_bard
	jz	short loc_22B23
loc_22B1F:
	sub	ax, ax
	jmp	short loc_22B34
loc_22B23:
	mov	ax, itType_instrument
	push	ax
	push	[bp+charNo]
	call	inven_hasTypeEquipped
	add	sp, 4
	jmp	short $+2
loc_22B34:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_charCanPlaySong endp

; This function	returns	the amount of songs that
; should be subtracted from the	bards' songsLeft
; field. If an item with itemEff_freeSinging is
; equipped, return 0. If the bard has songs left,
; return 1. Otherwise return -1.
; Attributes: bp-based frame

sing_getSongSubtractor proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, itemEff_freeSinging
	push	ax
	push	[bp+arg_0]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_22B5A
	sub	ax, ax
	jmp	short loc_22B78
loc_22B5A:
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.specAbil[bx],	0
	jz	short loc_22B73
	mov	ax, 1
	jmp	short loc_22B76
loc_22B73:
	mov	ax, 0FFFFh
loc_22B76:
	jmp	short $+2
loc_22B78:
	mov	sp, bp
	pop	bp
	retf
sing_getSongSubtractor endp

; Attributes: bp-based frame

song_getSong proc far

	var_22C= word ptr -22Ch
	var_72=	word ptr -72h
	string=	word ptr -34h
	counter= word ptr -1Ch
	stringP= dword ptr -1Ah
	var_16=	word ptr -16h
	var_14=	word ptr -14h
	var_12=	word ptr -12h
	var_10=	word ptr -10h
	charNo=	word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 34h	
	call	someStackOperation
	push	si
	sub	ax, ax
	mov	[bp+var_12], ax
	mov	[bp+var_16], ax
	mov	[bp+counter], ax
	jmp	short loc_22B98
loc_22B95:
	inc	[bp+counter]
loc_22B98:
	cmp	[bp+counter], 8
	jl	short loc_22BA1
	jmp	loc_22C40
loc_22BA1:
	getCharP	[bp+charNo], bx
	mov	al, gs:(roster.specAbil+1)[bx]
	sub	ah, ah
	mov	bx, [bp+counter]
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_22C3D
	lea	ax, [bp+string]
	mov	word ptr [bp+stringP], ax
	mov	word ptr [bp+stringP+2], ss
	mov	si, [bp+var_16]
	shl	si, 1
	mov	ax, bx
	mov	[bp+si+var_10],	ax
	lfs	bx, [bp+stringP]
	inc	word ptr [bp+stringP]
	mov	ax, [bp+var_16]
	inc	[bp+var_16]
	add	al, '1'
	mov	fs:[bx], al
	lfs	bx, [bp+stringP]
	inc	word ptr [bp+stringP]
	mov	byte ptr fs:[bx], ')'
	mov	bx, [bp+counter]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (songNames+2)[bx]
	push	word ptr songNames[bx]
	push	word ptr [bp+stringP+2]
	push	word ptr [bp+stringP]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+stringP], ax
	mov	word ptr [bp+stringP+2], dx
	lea	ax, [bp+string]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	bl, gs:txt_numLines
	sub	bh, bh
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_12], ax
loc_22C3D:
	jmp	loc_22B95
loc_22C40:
	mov	ax, bitMask16bit+16h
	or	[bp+var_12], ax
	cmp	[bp+arg_2], 0
	jz	short loc_22C5E
	mov	ax, offset aStopPlayingASo
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_22C5E:
	push	[bp+var_12]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_14], ax
	cmp	ax, 1Bh
	jz	short loc_22C76
	cmp	ax, 119h
	jnz	short loc_22C7B
loc_22C76:
	mov	ax, 0FFFFh
	jmp	short loc_22CD0
loc_22C7B:
	cmp	[bp+arg_2], 0
	jz	short loc_22C96
	cmp	[bp+var_14], 'S'
	jnz	short loc_22C96
	push	[bp+charNo]
	push	cs
	call	near ptr song_stopPlaying
	add	sp, 2
	mov	ax, 0FFFFh
	jmp	short loc_22CD0
loc_22C96:
	cmp	[bp+var_14], 10Eh
	jl	short loc_22CB3
	mov	ax, [bp+var_16]
	add	ax, 10Eh
	cmp	ax, [bp+var_14]
	jl	short loc_22CB3
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_22C]
	jmp	short loc_22CD0
loc_22CB3:
	cmp	[bp+var_14], '0'
	jle	short loc_22CCE
	mov	ax, [bp+var_16]
	add	ax, '0'
	cmp	ax, [bp+var_14]
	jl	short loc_22CCE
	mov	si, [bp+var_14]
	shl	si, 1
	mov	ax, [bp+si+var_72]
	jmp	short loc_22CD0
loc_22CCE:
	jmp	short loc_22C5E
loc_22CD0:
	pop	si
	mov	sp, bp
	pop	bp
	retf
song_getSong endp

; Attributes: bp-based frame

sub_22CD5 proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	al, byte ptr [bp+arg_0]
	mov	gs:byte_41E62, al
	mov	byte_4EEBC, 5
	mov	al, [bp+arg_2]
	inc	al
	mov	gs:byte_4266B, al
	mov	al, [bp+arg_2]
	mov	gs:byte_42420, al
	call	song_endMusic
	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	mov	bx, word ptr [bp+arg_2]
	shl	bx, 1
	shl	bx, 1
	push	gs:musicBufs._segment[bx]
	push	word ptr gs:musicBufs._offset[bx]
	call	d3comp
	add	sp, 8
	mov	ax, itType_instrument
	push	ax
	push	[bp+arg_0]
	call	inven_getTypeEqSlot
	add	sp, 4
	mov	[bp+var_4], ax
	inc	ax
	jz	short loc_22D59
	mov	bx, [bp+var_4]
	mov	al, byte_48820[bx]
	cbw
	mov	[bp+var_2], ax
	jmp	short loc_22D5E
loc_22D59:
	mov	[bp+var_2], 0
loc_22D5E:
	push	[bp+var_2]
	mov	ax, offset byte_40420
	mov	dx, seg	seg026
	push	dx
	push	ax
	call	song_initSound
	add	sp, 6
	mov	sp, bp
	pop	bp
	retf
sub_22CD5 endp

; Attributes: bp-based frame

song_stopPlaying proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:byte_41E62
	sub	ah, ah
	cmp	ax, [bp+arg_0]
	jnz	short loc_22D9D
	cmp	gs:byte_4266B, ah
	jz	short loc_22D9D
	push	cs
	call	near ptr sub_22DA1
loc_22D9D:
	mov	sp, bp
	pop	bp
	retf
song_stopPlaying endp

; Attributes: bp-based frame

sub_22DA1 proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	cs
	call	near ptr song_endNoncombatEffect
	call	song_endMusic
	mov	sp, bp
	pop	bp
	retf
sub_22DA1 endp

; Attributes: bp-based frame

song_doNoncombatEffect proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	al, gs:byte_42420
	sub	ah, ah
	jmp	loc_22EA5
loc_22DCF:
	mov	gs:songAntiMonster, 1
	jmp	loc_22ED1
loc_22DDC:
	mov	al, charSize
	mul	gs:byte_41E62
	mov	bx, ax
	cmp	gs:roster.level[bx], 60
	jnb	short loc_22E11
	mov	al, charSize
	mul	gs:byte_41E62
	mov	bx, ax
	mov	ax, gs:roster.level[bx]
	shr	ax, 1
	shr	ax, 1
	jmp	short loc_22E13
loc_22E11:
	mov	al, 15
loc_22E13:
	mov	gs:songACBonus,	al
	or	al, al
	jnz	short loc_22E24
	inc	gs:songACBonus
loc_22E24:
	mov	byte ptr word_44166,	0
	jmp	loc_22ED1
loc_22E31:
	mov	gs:songRegenSppt, 1
	jmp	loc_22ED1
loc_22E3E:
	mov	lightDistance, 5
	mov	lightDuration, 0FFh
	mov	gs:gl_detectSecretDoorFlag, 0FFh
	sub	ax, ax
	push	ax
	call	icon_activate
	add	sp, 2
	jmp	short loc_22ED1
loc_22E69:
	mov	compassDuration, 0FFh
	mov	ax, 1
	push	ax
	call	icon_activate
	add	sp, 2
	jmp	short loc_22ED1
loc_22E81:
	mov	gs:songHalfDamage, 1
	mov	shieldDuration, 0FFh
	mov	ax, 3
	push	ax
	call	icon_activate
	add	sp, 2
loc_22EA1:
	jmp	short loc_22ED1
	jmp	short loc_22ED1
loc_22EA5:
	cmp	ax, song_safety
	jnz	short loc_22EAD
	jmp	loc_22DCF
loc_22EAD:
	cmp	ax, song_sanctuary
	jnz	short loc_22EB5
	jmp	loc_22DDC
loc_22EB5:
	cmp	ax, song_duotime
	jnz	short loc_22EBD
	jmp	loc_22E31
loc_22EBD:
	cmp	ax, song_watchwood
	jnz	short loc_22EC5
	jmp	loc_22E3E
loc_22EC5:
	cmp	ax, song_overture
	jz	short loc_22E69
	cmp	ax, song_shield
	jz	short loc_22E81
	jmp	short loc_22EA1
loc_22ED1:
	mov	sp, bp
	pop	bp
	retf
song_doNoncombatEffect endp

; Attributes: bp-based frame

song_endNoncombatEffect	proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	gs:byte_4266B, 0
	jnz	short loc_22EEE
	jmp	loc_22F9A
loc_22EEE:
	mov	gs:byte_4266B, 0
	cmp	gs:byte_41E62, 7
	jb	short loc_22F03
	jmp	loc_22F9A
loc_22F03:
	mov	al, gs:byte_42420
	sub	ah, ah
	jmp	short loc_22F7A
loc_22F0F:
	mov	gs:songAntiMonster, 0
	jmp	short loc_22F9A
loc_22F1B:
	mov	gs:songACBonus,	0
	mov	byte ptr word_44166,	0
	jmp	short loc_22F9A
loc_22F31:
	mov	gs:songRegenSppt, 0
	jmp	short loc_22F9A
loc_22F3D:
	mov	lightDistance, 0
	sub	ax, ax
	push	ax
	call	sub_17920
	add	sp, 2
	mov	gs:gl_detectSecretDoorFlag, 0
	jmp	short loc_22F9A
loc_22F5E:
	mov	ax, 1
	push	ax
	call	sub_17920
	add	sp, 2
	jmp	short loc_22F9A
loc_22F6C:
	mov	gs:songHalfDamage, 0
loc_22F76:
	jmp	short loc_22F9A
	jmp	short loc_22F9A
loc_22F7A:
	cmp	ax, song_safety
	jz	short loc_22F0F
	cmp	ax, song_sanctuary
	jz	short loc_22F1B
	cmp	ax, song_duotime
	jz	short loc_22F31
	cmp	ax, song_watchwood
	jz	short loc_22F3D
	cmp	ax, song_overture
	jz	short loc_22F5E
	cmp	ax, song_shield
	jz	short loc_22F6C
	jmp	short loc_22F76
loc_22F9A:
	mov	sp, bp
	pop	bp
locret_22F9D:
	retf
song_endNoncombatEffect	endp

seg011 ends
