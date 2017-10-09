; Segment type:	Pure code
seg010 segment word public 'CODE' use16
	assume cs:seg010
;org 9
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_1FC89:
align 2
; Attributes: bp-based frame

castSpell proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	cmp	[bp+arg_0], 0
	jz	short loc_1FCAA
	mov	ax, [bp+arg_0]
	sub	ax, 3B00h
	mov	cl, 8
	sar	ax, cl
	mov	[bp+var_6], ax
	jmp	short loc_1FCBF
loc_1FCAA:
	mov	ax, offset aWhoWillCastASp
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_6], ax
loc_1FCBF:
	cmp	[bp+var_6], 0
	jge	short loc_1FCC8
	jmp	loc_1FD85
loc_1FCC8:
	getCharP	[bp+var_6], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1FCE1
	sub	ax, ax
	jmp	loc_1FD8A
loc_1FCE1:
	getCharP	[bp+var_6], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	cmp	mageSpellIndex[bx], 0FFh
	jnz	short loc_1FD14
	mov	ax, offset aThouArtNotAS_0
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD14:
	sub	ax, ax
	push	ax
	push	[bp+var_6]
	push	cs
	call	near ptr anotherCastSpell
	add	sp, 4
	mov	[bp+var_4], ax
	or	ax, ax
	jge	short loc_1FD2C
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD2C:
	cmp	[bp+var_4], 4
	jge	short loc_1FD5A
	mov	ax, offset aCastAt
	push	ds
	push	ax
	push	[bp+var_4]
	call	getTarget
	add	sp, 6
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_1FD4F
	sub	ax, ax
	jmp	short loc_1FD8A
loc_1FD4F:
	mov	al, byte ptr [bp+var_2]
	mov	gs:bat_curTarget, al
loc_1FD5A:
	call	clearTextWindow
	mov	ax, 1
	push	ax
	sub	ax, ax
	push	ax
	push	curSpellNo
	push	[bp+var_6]
	push	cs
	call	near ptr doCastSpell
	add	sp, 8
	delayNoTable	2
loc_1FD85:
	mov	ax, 1
	jmp	short $+2
loc_1FD8A:
	mov	sp, bp
	pop	bp
	retf
castSpell endp

; Attributes: bp-based frame

anotherCastSpell proc far

	var_306= word ptr -306h
	var_304= word ptr -304h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 306h
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned or stat_paralyzed
	jz	short loc_1FDB4
	mov	ax, 0FFFFh
	jmp	loc_1FECF
loc_1FDB4:
	mov	al, spell_mouseClicked
	sub	ah, ah
	or	ax, ax
	jnz	loc_mouse_spell_select

	push	[bp+arg_0]
	call	txt_castSpell
	add	sp, 2
	cmp	ax, 0FFFFh
	je	loc_1FECF
	jmp	loc_anotherCastSpell_spellFound

loc_mouse_spell_select:
	mov	[bp+var_106], 0
	mov	[bp+var_104], 0
	jmp	short loc_1FDC6
loc_1FDC2:
	inc	[bp+var_104]
loc_1FDC6:
	cmp	[bp+var_104], 7Eh
	jge	short loc_1FE1A
	push	[bp+var_104]
	push	[bp+arg_0]
	call	mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_1FE18
	mov	si, [bp+var_106]
	shl	si, 1
	mov	ax, [bp+var_104]
	mov	[bp+si+var_100], ax
	mov	bx, [bp+var_104]
	mov	cl, 3
	shl	bx, cl
	mov	ax, word ptr spellString.fullName[bx]
	mov	dx, word ptr (spellString.fullName+2)[bx]
	mov	si, [bp+var_106]
	inc	[bp+var_106]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_306], ax
	mov	[bp+si+var_304], dx
loc_1FE18:
	jmp	short loc_1FDC2
loc_1FE1A:
	cmp	[bp+var_106], 0
	jz	short loc_1FE3E
	push	[bp+var_106]
	lea	ax, [bp+var_306]
	push	ss
	push	ax
	mov	ax, offset aSpellToCast
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_102], ax
	jmp	short loc_1FE5F
loc_1FE3E:
	mov	ax, offset aYouDonTKnowAny
	mov	dx, seg	dseg
	push	dx
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	mov	ax, 0FFFFh
	jmp	short loc_1FECF
loc_1FE5F:
	cmp	[bp+var_102], 0
	jge	short loc_1FE6B
	mov	ax, 0FFFFh
	jmp	short loc_1FECF
loc_1FE6B:
	mov	si, [bp+var_102]
	shl	si, 1
	mov	ax, [bp+si+var_100]

loc_anotherCastSpell_spellFound:
	mov	curSpellNo, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr getSpptRequired
	add	sp, 4
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.currentSppt[bx], cx
	jnb	short loc_1FEBB
	mov	ax, offset aNotEnoughSpellPoint
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	mov	ax, 0FFFFh
	jmp	short loc_1FECF
loc_1FEBB:
	mov	bx, curSpellNo
	mov	al, byte_47F94[bx]
	sub	ah, ah
	and	ax, 7
	jmp	short $+2
loc_1FECF:
	pop	si
	mov	sp, bp
	pop	bp
	retf
anotherCastSpell endp

; This function	gets the spell points required for
; a particular spell. It takes into account equipment
; that the player has equipped.
; If the player	has 0xc	effect equipped, the required
; spell	points are divided by 4.
; If the player	has 0x4	effect equipped, the required
; spell	points are halved.
; Attributes: bp-based frame

getSpptRequired	proc far

	var_2= word ptr	-2
	playerNo= word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spptRequired[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	ax, itemEff_quaterSpptUse
	push	ax
	push	[bp+playerNo]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1FF07
	mov	ax, [bp+var_2]
	sar	ax, 1
	sar	ax, 1
	jmp	short loc_1FF26
loc_1FF07:
	mov	ax, itemEff_halfSpptUsage
	push	ax
	push	[bp+playerNo]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_1FF21
	mov	ax, [bp+var_2]
	sar	ax, 1
	jmp	short loc_1FF26
loc_1FF21:
	mov	ax, [bp+var_2]
	jmp	short $+2
loc_1FF26:
	mov	sp, bp
	pop	bp
	retf
getSpptRequired	endp

; Attributes: bp-based frame

doCastSpell proc far

	var_108= word ptr -108h
	var_8= dword ptr -8
	partySlotNumber=	word ptr  6
	spellNo= word ptr  8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	[bp+partySlotNumber]
	lea	ax, [bp+var_108]
	push	ss
	push	ax
	call	bat_getAttackerName
	add	sp, 6
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], dx
	lfs	bx, [bp+var_8]
	inc	word ptr [bp+var_8]
	mov	byte ptr fs:[bx], ' '
	cmp	[bp+spellNo], 7Eh 
	jge	short loc_1FFA8
	mov	ax, offset aCastsASpell
	push	ds
	push	ax
	push	word ptr [bp+var_8+2]
	push	word ptr [bp+var_8]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], dx
	lfs	bx, [bp+var_8]
	inc	word ptr [bp+var_8]
	mov	byte ptr fs:[bx], 20h ;	' '
	mov	bx, [bp+spellNo]
	mov	cl, 3
	shl	bx, cl
	push	word ptr (spellString.fullName+2)[bx]
	push	word ptr spellString.fullName[bx]
	push	word ptr [bp+var_8+2]
	push	word ptr [bp+var_8]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_8], ax
	mov	word ptr [bp+var_8+2], dx
loc_1FFA8:
	cmp	[bp+arg_6], 0
	jz	short loc_20000
	push	[bp+spellNo]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _sp_checkSPPT
	add	sp, 4
	or	ax, ax
	jz	short loc_doCastSpell_fizzled
	mov	al, gs:sq_antiMagicFlag
	sub	ah, ah
	or	ax, ax
	jz	short loc_20000

loc_doCastSpell_fizzled:
;	mov	word ptr [bp+var_8+2], dx
	lfs	bx, [bp+var_8]
	inc	word ptr [bp+var_8]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_108]
	push	ss
	push	ax
	call	printString
	add	sp, 4

	call	printSpellFizzled

	sub	ax, ax
	jmp	short loc_20023
loc_20000:
	lea	ax, [bp+var_108]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	push	[bp+arg_4]
	push	[bp+spellNo]
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr spell_cast
	add	sp, 6
	mov	ax, 1
	jmp	short $+2
loc_20023:
	mov	sp, bp
	pop	bp
	retf
doCastSpell endp

include spells/light.asm
include spells/possess.asm
include spells/damage.asm
include battle/dobreath.asm
include spells/trapzap.asm

; Attributes: bp-based frame

sp_freezeFoes proc far

	partySlotNumber=	word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr sub_20A3B
	add	sp, 2
	or	ax, ax
	jz	short loc_20A37
	cmp	[bp+partySlotNumber], 80h
	jge	short loc_20A27
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 3
	add	gs:byte_42270[bx], al
	add	gs:byte_41E70, 2
	jmp	short loc_20A37
loc_20A27:
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_42274, al
loc_20A37:
	mov	sp, bp
	pop	bp
	retf
sp_freezeFoes endp

; Attributes: bp-based frame

sub_20A3B proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jl	short loc_20A86
	mov	gs:bat_curTarget, 0
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
	or	ax, ax
	jnz	short loc_20A6B
	sub	ax, ax
	jmp	short loc_20A95
loc_20A6B:
	cmp	gs:stru_41EFA._name, 0
	jnz	short loc_20A7C
	mov	ax, 1
	jmp	short loc_20A95
loc_20A7C:
	mov	gs:bat_curTarget, 1
loc_20A86:
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
	jmp	short $+2
loc_20A95:
	mov	sp, bp
	pop	bp
	retf
sub_20A3B endp

; Attributes: bp-based frame

savingThrowCheck proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr _savingThrowCheck
	add	sp, 4
	mov	[bp+var_4], ax
	mov	gs:byte_4228E, 0
	push	[bp+arg_2]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	cs
	call	near ptr _savingThrowCheck
	add	sp, 4
	mov	[bp+var_6], ax
	mov	al, gs:byte_41E63
	sub	ah, ah
	add	ax, [bp+var_6]
	push	ax
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	mov	[bp+var_6], ax
	mov	gs:byte_41E63, 0
	mov	ax, [bp+var_4]
	sub	ax, [bp+var_6]
	mov	[bp+var_2], ax
	or	ax, ax
	jge	short loc_20B09
	sub	ax, ax
	jmp	short loc_20B19
loc_20B09:
	cmp	[bp+var_2], 4
	jle	short loc_20B14
	mov	ax, 2
	jmp	short loc_20B17
loc_20B14:
	mov	ax, 1
loc_20B17:
	jmp	short $+2
loc_20B19:
	mov	sp, bp
	pop	bp
	retf
savingThrowCheck endp

; Attributes: bp-based frame

_savingThrowCheck proc far

	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	charP= dword ptr -4
	indexNo= word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	cmp	[bp+indexNo], 80h
	jl	short loc_20BA1
	and	[bp+indexNo], 7Fh
	cmp	gs:byte_4228E, 0
	jz	short loc_20B49
	mov	al, gs:byte_4228E
	sub	ah, ah
	jmp	loc_20C78
loc_20B49:
	cmp	[bp+arg_2], 0

	; FIXED - This was "jz short loc_20B6F". This matches behavior on the
	; Apple II. The function was using the wrong hi/lo values for spells.
	; This pretty much made the final battles with Rock Demons impossible.
	;
	jnz	short loc_20B6F
	getMonP	[bp+indexNo], si
	mov	al, gs:monGroups.breathSaveLo[si]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	al, gs:monGroups.breathSaveHi[si]
	mov	[bp+var_A], ax
	jmp	short loc_20B8D
loc_20B6F:
	getMonP	[bp+indexNo], si
	mov	al, gs:monGroups.spellSaveLo[si]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	al, gs:monGroups.spellSaveHi[si]
	mov	[bp+var_A], ax
loc_20B8D:
	push	[bp+var_A]
	push	[bp+var_6]
	call	randomBetweenXandY
	add	sp, 4
	jmp	loc_20C78
	jmp	loc_20C61
loc_20BA1:
	getCharP	[bp+indexNo], si
	cmp	gs:roster.class[si], class_monster
	jb	short loc_20C01
	add	ax, offset roster
	mov	word ptr [bp+charP], ax
	mov	word ptr [bp+charP+2], seg seg027
	cmp	[bp+arg_2], 0
	jnz	short loc_20BDB
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.breathSaveLo]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	al, fs:[bx+summonStat_t.breathSaveHi]
	mov	[bp+var_A], ax
	jmp	short loc_20BEE
loc_20BDB:
	lfs	bx, [bp+charP]
	mov	al, fs:[bx+summonStat_t.spellSaveLo]
	sub	ah, ah
	mov	[bp+var_6], ax
	mov	al, fs:[bx+summonStat_t.spellSaveHi]
	mov	[bp+var_A], ax
loc_20BEE:
	push	[bp+var_A]
	push	[bp+var_6]
	call	randomBetweenXandY
	add	sp, 4
	mov	[bp+var_8], ax
	jmp	short loc_20C61
loc_20C01:
	getCharP	[bp+indexNo], bx
	mov	ax, gs:roster.level[bx]
	shr	ax, 1
	mov	[bp+var_8], ax
	mov	ax, itemEff_alwaysHide
	push	ax
	push	[bp+indexNo]
	call	hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_20C2E
	add	[bp+var_8], 2
loc_20C2E:
	getCharP	[bp+indexNo], si
	mov	ax, 41h	
	push	ax
	call	dice_doYDX
	add	sp, 2
	mov	bl, gs:roster.class[si]
	sub	bh, bh
	mov	cl, byte_484BE[bx]
	sub	ch, ch
	mov	dl, gs:roster.luck[si]
	sub	dh, dh
	add	cx, dx
	add	cx, ax
	add	[bp+var_8], cx
loc_20C61:
	mov	al, gs:antiMagicFlag
	sub	ah, ah
	add	ax, [bp+var_8]
	push	ax
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	jmp	short $+2
loc_20C78:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_savingThrowCheck endp

; This function	returns	the passed value or 255
; depending on which is	lower. This is equivalent
; to the C statement:
; (val)	<= 255 ? (val) : 255
; Attributes: bp-based frame

_returnXor255 proc far

	val= word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+val]
	cmp	ax, 255
	jle	short loc_20C92
	mov	ax, 255
loc_20C92:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
_returnXor255 endp

; Attributes: bp-based frame

sp_compassSpell	proc far

	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	compassDuration, al
	mov	ax, icon_compass
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_compassSpell	endp

; Attributes: bp-based frame

sp_healSpell proc far

	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	spellNo= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+partySlotNumber], 80h
	jge	short loc_20D2D
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	cmp	ax, 80h		; 0x80 here means to heal all party members
	jge	short loc_20CFA
	push	bx
	mov	al, gs:bat_curTarget
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _doHeal
	add	sp, 6
	jmp	short loc_20D2D
loc_20CFA:
	mov	gs:bat_curTarget, 0
	jmp	short loc_20D0F
loc_20D06:
	inc	gs:bat_curTarget
loc_20D0F:
	cmp	gs:bat_curTarget, 7
	jnb	short loc_20D2D
	push	[bp+spellNo]
	mov	al, gs:bat_curTarget
	sub	ah, ah
	push	ax
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr _doHeal
	add	sp, 6
	jmp	short loc_20D06
loc_20D2D:
	mov	sp, bp
	pop	bp
	retf
sp_healSpell endp

; Attributes: bp-based frame

_doHeal	proc far

	hpToHeal= word ptr -6
	effectFlag= word ptr -4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	target=	word ptr  8
	spellNo= word ptr  0Ah

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	mov	bx, [bp+spellNo]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+effectFlag], ax
	mov	[bp+hpToHeal], 0
	cmp	ax, 0FDh	; effectFlag < 0xfd means to heal effectFlagd4
			; hit points.
	jge	short loc_20D60
	push	ax
	push	cs
	call	near ptr rnd_Xd4
	add	sp, 2
	mov	[bp+hpToHeal], ax
	jmp	short loc_20D97
loc_20D60:
	cmp	[bp+effectFlag], 0FEh ;	points of damage. This is the magaician	spell
			; Quick	fix
	jnz	short loc_20D6E
	mov	[bp+hpToHeal], 8
	jmp	short loc_20D97
loc_20D6E:
	getCharP	[bp+partySlotNumber], bx
	mov	ax, gs:roster.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	mov	[bp+var_2], ax
	push	ax
	push	cs
	call	near ptr rnd_Xd4
	add	sp, 2
	mov	[bp+hpToHeal], ax
loc_20D97:
	getCharP	[bp+target], si
	mov	ax, [bp+hpToHeal]
	add	gs:roster.currentHP[si], ax
	mov	ax, gs:roster.maxHP[si]
	cmp	gs:roster.currentHP[si], ax
	ja	short loc_20DBE
	cmp	[bp+effectFlag], 0FDh
	jnz	short loc_20DD0
loc_20DBE:
	getCharP	[bp+target], si
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
loc_20DD0:
	mov	bx, [bp+spellNo]
	mov	al, spellExtraFlags[bx]
	sub	ah, ah
	and	ax, 7Fh
	jmp	loc_20EE0
	jmp	loc_20EFB
restoration:
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0AEh
	jmp	loc_20EFB
cureStoned:
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_stoned
	jz	short loc_20E23
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0F3h
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
loc_20E23:
	jmp	loc_20EFB
curePossession:
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_possessed
	jz	short loc_20E52
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0DFh
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
loc_20E52:
	jmp	loc_20EFB
cureDeath:
	getCharP	[bp+target], bx
	test	gs:roster.status[bx], stat_dead
	jz	short loc_20E81
	getCharP	[bp+target], bx
	and	gs:roster.status[bx], 0FBh
	push	[bp+target]
	push	cs
	call	near ptr _sp_postHeal
	add	sp, 2
loc_20E81:
	jmp	short loc_20EFB
cureOld:
	getCharP	[bp+target], si
	test	gs:roster.status[si], stat_old
	jz	short loc_20EB8
	and	gs:roster.status[si], 0FDh
	mov	ax, 5
	push	ax
	lea	ax, roster.strength[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, roster.savedST[si]
	push	dx
	push	ax
	call	_doAgeStatus
	add	sp, 0Ah
loc_20EB8:
	jmp	short loc_20EFB
loc_20EBA:
	getCharP	[bp+target], si
	and	gs:roster.status[si], 0AAh
	mov	gs:roster.hostileFlag[si], 0
loc_20ED2:
	jmp	short loc_20EFB
	mov	byte ptr word_44166,	0
	jmp	short loc_20EFB
loc_20EE0:
	cmp	ax, 6
	ja	short loc_20ED2
	add	ax, ax
	xchg	ax, bx
	jmp	cs:off_20EED[bx]
off_20EED dw offset loc_20EFB
off_20EEF dw offset restoration
dw offset cureStoned
dw offset curePossession
dw offset cureDeath
dw offset cureOld
dw offset loc_20EBA
loc_20EFB:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_doHeal	endp

; This function	does some standard cleanup after
; healing. If currentHP	is zero	then it	sets it
; to one like after a Beyond Death spell. It
; calms	summoned members and sets the attack priority
; for the round	to zero.
; Attributes: bp-based frame

_sp_postHeal proc far

	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+partySlotNumber], bx
	cmp	gs:roster.currentHP[bx], 0
	jnz	short loc_20F2D
	getCharP	[bp+partySlotNumber], bx
	mov	gs:roster.currentHP[bx], 1
loc_20F2D:
	getCharP	[bp+partySlotNumber], bx
	mov	gs:roster.hostileFlag[bx], 0
	mov	bx, [bp+partySlotNumber]
	mov	gs:charActionList[bx], 0
	mov	sp, bp
	pop	bp
	retf
_sp_postHeal endp

; Attributes: bp-based frame

sp_levitation proc far

	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	levitationDuration, al
	mov	ax, icon_levitation
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_levitation endp

; Attributes: bp-based frame

sp_summonSpell proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+arg_0]
	call	doSummon
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sp_summonSpell endp

; Attributes: bp-based frame

sp_teleport proc far

	var_116= word ptr -116h
	var_16=	dword ptr -16h
	counter= word ptr -12h
	var_10=	dword ptr -10h
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	teleDeltaList= word ptr	-6
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 116h
	call	someStackOperation
	push	di
	push	si
	mov	word ptr [bp+var_16], offset characterIOBuf
	mov	word ptr [bp+var_16+2],	seg seg022
	cmp	inDungeonMaybe, 0
	jnz	short loc_20FCB
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printSpellFizzled
	add	sp, 4
	jmp	loc_21200
loc_20FCB:
	mov	word_4EE66, 0
	mov	[bp+var_A], 0
	mov	[bp+counter], 0
	jmp	short loc_20FE5
loc_20FE2:
	inc	[bp+counter]
loc_20FE5:
	cmp	[bp+counter], 3
	jge	short loc_20FF7
	mov	si, [bp+counter]
	shl	si, 1
	mov	[bp+si+teleDeltaList], 0
	jmp	short loc_20FE2
loc_20FF7:
	call	clearTextWindow
	mov	ax, offset aTeleportUseArr
	push	ds
	push	ax
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2],	dx
	mov	al, gs:txt_numLines
	sub	ah, ah
	mov	[bp+var_C], ax
	mov	al, levFlags
	and	ax, 10h
	push	ax
	push	dx
	push	word ptr [bp+var_10]
	mov	ax, offset aDownUp
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_10], ax
	mov	word ptr [bp+var_10+2],	dx
	lfs	bx, [bp+var_10]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_116]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	mov	al, byte ptr [bp+var_C]
	add	al, 3
	mov	gs:txt_numLines, al
	mov	[bp+counter], 0
	jmp	short loc_21071
loc_2106E:
	inc	[bp+counter]
loc_21071:
	cmp	[bp+counter], 3
	jge	short loc_210A1
	mov	ax, [bp+counter]
	cmp	[bp+var_A], ax
	jnz	short loc_21084
	mov	ax, 1
	jmp	short loc_21086
loc_21084:
	sub	ax, ax
loc_21086:
	push	ax
	mov	si, [bp+counter]
	shl	si, 1
	push	[bp+si+teleDeltaList]
	push	cs
	call	near ptr _sp_teleportPrintNum
	add	sp, 4
	inc	gs:txt_numLines
	jmp	short loc_2106E
loc_210A1:
	sub	ax, ax
	push	ax
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_8], ax
	jmp	short loc_210E5
loc_210B1:
	inc	[bp+var_A]
	jmp	short loc_210FB
loc_210B6:
	mov	si, [bp+var_A]
	shl	si, 1
	mov	ax, word_484CC[si]
	cmp	[bp+si+teleDeltaList], ax
	jge	short loc_210C7
	inc	[bp+si+teleDeltaList]
loc_210C7:
	jmp	short loc_210FB
loc_210C9:
	mov	si, [bp+var_A]
	shl	si, 1
	mov	ax, word_484CC[si]
	neg	ax
	cmp	[bp+si+teleDeltaList], ax
	jle	short loc_210DC
	dec	[bp+si+teleDeltaList]
loc_210DC:
	jmp	short loc_210FB
loc_210DE:
	jmp	loc_21200
loc_210E1:
	jmp	short loc_210FB
	jmp	short loc_210FB
loc_210E5:
	cmp	ax, dosKeys_ESC
	jz	short loc_210DE
	cmp	ax, ' '
	jz	short loc_210B1
	cmp	ax, dosKeys_upArrow
	jz	short loc_210B6
	cmp	ax, dosKeys_downArrow
	jz	short loc_210C9
	jmp	short loc_210E1
loc_210FB:
	cmp	[bp+var_A], 3
	jge	short loc_21104
	jmp	loc_20FF7
loc_21104:
	mov	ax, offset aTeleport?
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getYesNo
	or	ax, ax
	jnz	short loc_21136
	mov	ax, offset aTeleportCancel
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	loc_21200
loc_21136:
	mov	ax, dunLevelNum
	add	ax, [bp+teleDeltaList+4]
	push	ax
	mov	ax, sq_east
	add	ax, [bp+teleDeltaList+2]
	push	ax
	mov	ax, sq_north
	add	ax, [bp+teleDeltaList]
	push	ax
	push	cs
	call	near ptr _sp_doTeleport
	add	sp, 6
	or	ax, ax
	jnz	short loc_21168
	jmp	loc_211F3
loc_21168:
	mov	ax, offset aTeleportSucces
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+teleDeltaList]
	add	sq_north, ax
	mov	ax, [bp+teleDeltaList+2]
	add	sq_east, ax
	mov	ax, [bp+teleDeltaList+4]
	add	dunLevelNum,	ax
	mov	di, dunLevelNum
	lfs	bx, [bp+var_16]
	mov	al, fs:[bx+di+12h]
	sub	ah, ah
	mov	si, ax
	cmp	dunLevelIndex, si
	jz	short loc_211F1
	mov	dunLevelIndex, si
	mov	buildingRvalMaybe, 4
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	sq_north, ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	sq_east, ax
	mov	gs:levelChangedFlag, 1
loc_211F1:
	jmp	short loc_21200
loc_211F3:
	mov	ax, offset aTeleportFailed
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_21200:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
sp_teleport endp

; Attributes: bp-based frame

_sp_doTeleport proc far

	var_1A=	dword ptr -1Ah
	var_16=	word ptr -16h
	var_14=	dword ptr -14h
	var_10=	word ptr -10h
	var_E= dword ptr -0Eh
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	sqN= word ptr  6
	sqE= word ptr  8
	level= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 1Ah
	call	someStackOperation
	push	si
	cmp	[bp+level], 0
	jl	short loc_2121E
	cmp	[bp+level], 7
	jle	short loc_21223
loc_2121E:
	sub	ax, ax
	jmp	loc_2136C
loc_21223:
	mov	word ptr [bp+var_E], offset characterIOBuf
	mov	word ptr [bp+var_E+2], seg seg022
	lfs	bx, [bp+var_E]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, [bp+sqN]
	mov	[bp+var_16], ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, [bp+sqE]
	mov	[bp+var_A], ax
	mov	si, [bp+level]
	test	fs:[bx+si+dun_t.dunLevel], 80h
	jz	short loc_21255
	sub	ax, ax
	jmp	loc_2136C
loc_21255:
	mov	si, [bp+level]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	cmp	ax, dunLevelIndex
	jnz	short loc_21276
	mov	ax, bx
	mov	dx, word ptr [bp+var_E+2]
	mov	word ptr [bp+var_14], ax
	mov	word ptr [bp+var_14+2],	dx
	jmp	short loc_212A2
loc_21276:
	mov	ax, 0FA0h
	push	ax
	call	_mallocMaybe
	add	sp, 2
	mov	word ptr [bp+var_14], ax
	mov	word ptr [bp+var_14+2],	dx
	push	dx
	push	ax
	mov	si, [bp+level]
	lfs	bx, [bp+var_E]
	mov	al, fs:[bx+si+dun_t.dunLevel]
	sub	ah, ah
	add	ax, 0Ah
	push	ax
	call	readLevelData
	add	sp, 6
loc_212A2:
	lfs	bx, [bp+var_14]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	sub	[bp+var_16], ax
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	sub	[bp+var_A], ax
	cmp	[bp+var_16], 0
	jl	short loc_212D5
	mov	al, fs:[bx+dun_t._height]
	sub	ah, ah
	cmp	ax, [bp+var_16]
	jbe	short loc_212D5
	cmp	[bp+var_A], 0
	jl	short loc_212D5
	mov	al, fs:[bx+dun_t._width]
	cmp	ax, [bp+var_A]
	ja	short loc_212F6
loc_212D5:
	mov	ax, word ptr [bp+var_E]
	mov	dx, word ptr [bp+var_E+2]
	cmp	bx, ax
	jnz	short loc_212E4
	cmp	word ptr [bp+var_14+2],	dx
	jz	short loc_212F2
loc_212E4:
	push	word ptr [bp+var_14+2]
	push	word ptr [bp+var_14]
	call	_freeMaybe
	add	sp, 4
loc_212F2:
	sub	ax, ax
	jmp	short loc_2136C
loc_212F6:
	mov	ax, word ptr [bp+var_14]
	mov	dx, word ptr [bp+var_14+2]
	add	ax, 24h	
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	mov	ax, [bp+var_16]
	shl	ax, 1
	add	ax, [bp+var_8]
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	mov	ah, fs:[bx+1]
	sub	al, al
	mov	cl, fs:[bx]
	sub	ch, ch
	add	ax, cx
	add	ax, word ptr [bp+var_14]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	si, [bp+var_A]
	mov	ax, si
	shl	si, 1
	shl	si, 1
	add	si, ax
	lfs	bx, [bp+var_4]
	mov	al, fs:[bx+si+4]
	and	al, 20h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	mov	[bp+var_10], cx
	mov	ax, word ptr [bp+var_E]
	mov	dx, word ptr [bp+var_E+2]
	cmp	word ptr [bp+var_14], ax
	jnz	short loc_21359
	cmp	word ptr [bp+var_14+2],	dx
	jz	short loc_21367
loc_21359:
	push	word ptr [bp+var_14+2]
	push	word ptr [bp+var_14]
	call	_freeMaybe
	add	sp, 4
loc_21367:
	mov	ax, [bp+var_10]
	jmp	short $+2
loc_2136C:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_doTeleport endp

; Attributes: bp-based frame

_sp_teleportPrintNum proc far

	var_24=	dword ptr -24h
	var_20=	word ptr -20h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 24h	
	call	someStackOperation
	sub	ax, ax
	push	ax
	mov	ax, [bp+arg_0]
	cwd
	push	dx
	push	ax
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_24], ax
	mov	word ptr [bp+var_24+2],	dx
	cmp	[bp+arg_2], 0
	jz	short loc_213A8
	lfs	bx, [bp+var_24]
	inc	word ptr [bp+var_24]
	mov	byte ptr fs:[bx], '<'
loc_213A8:
	lfs	bx, [bp+var_24]
	mov	byte ptr fs:[bx], 0
	mov	gs:byte_42419, 30h 
	lea	ax, [bp+var_20]
	push	ss
	push	ax
	call	sub_16595
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_sp_teleportPrintNum endp

; Attributes: bp-based frame
sp_farFoes proc	far

	var_5A=	word ptr -5Ah
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 5Ah	
	call	someStackOperation
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_20A3B
	add	sp, 2
	or	ax, ax
	jnz	short loc_213E6
	jmp	loc_214C2
loc_213E6:
	test	byte ptr [bp+arg_0], 80h
	jz	short loc_2143B
	mov	[bp+var_A], 0
	jmp	short loc_213F6
loc_213F3:
	inc	[bp+var_A]
loc_213F6:
	cmp	[bp+var_A], 4
	jge	short loc_21439
	getMonP	[bp+var_A], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+arg_2]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	cmp	ax, 9
	jle	short loc_2142A
	mov	[bp+var_2], 9
loc_2142A:
	push	[bp+var_2]
	push	[bp+var_A]
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
	jmp	short loc_213F3
loc_21439:
	jmp	short loc_21486
loc_2143B:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_A], ax
	getMonP	[bp+var_A], bx
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	bx, [bp+arg_2]
	mov	cl, spellEffectFlags[bx]
	sub	ch, ch
	add	ax, cx
	mov	[bp+var_2], ax
	cmp	ax, 9
	jle	short loc_21479
	mov	[bp+var_2], 9
loc_21479:
	push	[bp+var_2]
	push	[bp+var_A]
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
loc_21486:
	mov	ax, offset aAndTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+var_5A]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	mov	ax, offset aFartherAway
	push	ds
	push	ax
	push	dx
	push	[bp+var_8]
	call	_strcat
	add	sp, 8
	mov	[bp+var_8], ax
	mov	[bp+var_6], dx
	lea	ax, [bp+var_5A]
	push	ss
	push	ax
	call	printString
	add	sp, 4
loc_214C2:
	delayWithTable
	mov	sp, bp
	pop	bp
	retf
sp_farFoes endp

; Attributes: bp-based frame
_sp_setMonDistance proc	far

	arg_0= word ptr	 6
	arg_2= byte ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getMonP	[bp+arg_0], si
	cmp	byte ptr gs:monGroups._name[si], 0
	jz	short loc_21500
	mov	al, gs:monGroups.distance[si]
	and	al, 0F0h
	or	al, [bp+arg_2]
	mov	gs:monGroups.distance[si], al
loc_21500:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_setMonDistance endp

; Attributes: bp-based frame

sp_vorpalPlating proc far

	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7Fh
	add	gs:vorpalPlateBonus[bx], al
	mov	sp, bp
	pop	bp
	retf
sp_vorpalPlating endp

; Attributes: bp-based frame

sp_areaEnchant proc far

	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	detectDuration, al
	mov	al, spellExtraFlags[bx]
	mov	detectType, al
	mov	ax, icon_areaEnchant
	push	ax
	call	icon_activate
	add	sp, 2
	mov	sp, bp
	pop	bp
	retf
sp_areaEnchant endp

; Attributes: bp-based frame

sp_shieldSpell proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jl	short loc_2158D
	mov	bx, [bp+arg_2]
	mov	al, spellExtraFlags[bx]
	mov	bx, [bp+arg_0]
	and	bx, 3
	sub	gs:byte_42270[bx], al
	jmp	short loc_215BE
loc_2158D:
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	shieldDuration, al
	mov	al, spellExtraFlags[bx]
	mov	byte_4EECB, al
	mov	ax, icon_shield
	push	ax
	call	icon_activate
	add	sp, 2
	mov	byte ptr word_44166,	0
loc_215BE:
	mov	sp, bp
	pop	bp
	retf
sp_shieldSpell endp

; Attributes: bp-based frame

sp_strengthBonus proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	test	byte ptr [bp+arg_0], 80h
	jz	short loc_215EA
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+arg_0]
	and	bx, 3
	mov	gs:byte_42422[bx], al
	jmp	short loc_21606
loc_215EA:
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	bl, gs:bat_curTarget
	and	bx, 7
	mov	gs:strengthBonus[bx], al
loc_21606:
	mov	sp, bp
	pop	bp
	retf
sp_strengthBonus endp

; Attributes: bp-based frame

sp_phaseDoor proc far

	var_8= word ptr	-8
	var_6= dword ptr -6
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	cmp	inDungeonMaybe, 0
	jnz	short loc_21624
	jmp	loc_216E2
loc_21624:
	push	sq_north
	push	sq_east
	call	dun_getWalls
	add	sp, 4
	mov	[bp+var_2], ax
	mov	ax, dirFacing
	dec	ax
	push	ax
	push	[bp+var_2]
	call	sub_27E13
	add	sp, 4
	mov	[bp+var_8], ax
	mov	al, byte ptr [bp+var_8]
	and	al, 0Fh
	cmp	al, 9
	jb	short loc_21671
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printSpellFizzled
	add	sp, 4
	jmp	short loc_216EF
loc_21671:
	mov	gs:wallIsPhased, 1
	mov	bx, [bp+arg_2]
	cmp	spellEffectFlags[bx], 80h
	jb	short loc_216E0
	mov	bx, sq_north
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, sq_east
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+var_6], ax
	mov	word ptr [bp+var_6+2], dx
	test	byte ptr dirFacing, 2
	jz	short loc_216C8
	inc	word ptr [bp+var_6]
loc_216C8:
	test	byte ptr dirFacing, 1
	jz	short loc_216D9
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0F0h
	jmp	short loc_216E0
loc_216D9:
	lfs	bx, [bp+var_6]
	and	byte ptr fs:[bx], 0Fh
loc_216E0:
	jmp	short loc_216EF
loc_216E2:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printSpellFizzled
	add	sp, 4
loc_216EF:
	mov	sp, bp
	pop	bp
	retf
sp_phaseDoor endp

; Attributes: bp-based frame
sp_acBonus proc	far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jge	short loc_21716
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_4244E, al
	jmp	short loc_2172C
loc_21716:
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	mov	bx, [bp+arg_0]
	and	bx, 3
	sub	gs:byte_42270[bx], al
loc_2172C:
	mov	sp, bp
	pop	bp
	retf
sp_acBonus endp

; Attributes: bp-based frame

sp_disbelieve proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	cmp	[bp+arg_0], 80h
	jge	short loc_2179D
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	or	gs:disbelieveFlags, al
	cmp	gs:disbelieveFlags, disb_disruptill
	jb	l_return
	mov	[bp+var_2], 0
loc_21762:
	getCharP	[bp+arg_0], si
	cmp	gs:(roster.specAbil+3)[si], 0
	jz	short l_nextChar
	mov	ax, 0Ch
	push	ax
	mov	ax, offset aDopplganger
	push	ds
	push	ax
	lea	ax, roster._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	_memcpy
	add	sp, 0Ah
l_nextChar:
	inc	[bp+var_2]
	cmp	[bp+var_2], 7
	jl	short loc_21762
	jmp	short l_return
loc_2179D:
	mov	bx, [bp+arg_2]
	test	spellEffectFlags[bx], disb_nosummon
	jz	short loc_217B3
	or	gs:disbelieveFlags, disb_nosummon
	jmp	short l_return
loc_217B3:
	mov	al, byte ptr [bp+arg_0]
	mov	gs:monDisbelieveFlag, al
l_return:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_disbelieve endp

; Attributes: bp-based frame

sp_scrySight proc far

	var_11A= word ptr -11Ah
	var_118= word ptr -118h
	var_116= word ptr -116h
	var_114= word ptr -114h
	var_112= word ptr -112h
	var_110= dword ptr -110h
	var_10C= word ptr -10Ch
	var_C= word ptr	-0Ch
	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 11Ah
	call	someStackOperation
	push	si
	mov	[bp+var_6], 0
	mov	word ptr [bp+var_110], offset characterIOBuf
	mov	word ptr [bp+var_110+2], seg seg022
	lfs	bx, [bp+var_110]
	mov	al, fs:(characterIOBuf+11h)[bx]
	sub	ah, ah
	mov	[bp+var_118], ax
	mov	ax, offset aYouFace
	push	ds
	push	ax
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	bx, dirFacing
	shl	bx, 1
	shl	bx, 1
	push	word ptr (dirStringList+2)[bx]
	push	word ptr dirStringList[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_118], 0
	jnz	short loc_21840
	jmp	loc_218D5
loc_21840:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	mov	ax, offset aAndAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_118]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_118]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset aLevelS
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	al, levFlags
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	dx
	push	[bp+var_116]
	mov	ax, offset aAboveBelow
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_218D5:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqN]
	cbw
	add	ax, sq_north
	mov	[bp+var_2], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47EDC[bx]
	cbw
	mov	cx, [bp+var_2]
	sub	cx, ax
	mov	[bp+var_11A], cx
	or	cx, cx
	jnz	short loc_2190D
	jmp	loc_219BD
loc_2190D:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset aAndAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jl	short loc_21945
	mov	ax, [bp+var_11A]
	jmp	short loc_2194B
loc_21945:
	mov	ax, [bp+var_11A]
	neg	ax
loc_2194B:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset aPaceS
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_11A], 0
	jge	short loc_2199D
	mov	ax, 1
	jmp	short loc_2199F
loc_2199D:
	sub	ax, ax
loc_2199F:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset aNorthSouth
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_219BD:
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+dun_t.deltaSqE]
	cbw
	add	ax, sq_east
	mov	[bp+var_8], ax
	mov	si, [bp+var_118]
	mov	bl, fs:[bx+si+12h]
	sub	bh, bh
	mov	al, byte_47F1A[bx]
	cbw
	mov	cx, [bp+var_8]
	sub	cx, ax
	mov	[bp+var_4], cx
	or	cx, cx
	jnz	short loc_219F4
	jmp	loc_21AA0
loc_219F4:
	mov	ax, [bp+var_6]
	inc	[bp+var_6]
	cmp	ax, 1
	sbb	cx, cx
	neg	cx
	push	cx
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset aAndAre
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jl	short loc_21A2A
	mov	ax, [bp+var_4]
	jmp	short loc_21A2F
loc_21A2A:
	mov	ax, [bp+var_4]
	neg	ax
loc_21A2F:
	mov	[bp+var_112], ax
	sub	ax, ax
	push	ax
	mov	ax, [bp+var_112]
	cwd
	push	dx
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	_itoa
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	ax, [bp+var_112]
	dec	ax
	push	ax
	push	dx
	push	[bp+var_116]
	mov	ax, offset aPaceS
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	cmp	[bp+var_4], 0
	jge	short loc_21A80
	mov	ax, 1
	jmp	short loc_21A82
loc_21A80:
	sub	ax, ax
loc_21A82:
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	mov	ax, offset aEastWest
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
loc_21AA0:
	cmp	[bp+var_6], 0
	jz	short loc_21AAB
	mov	ax, offset aOf
	jmp	short loc_21AAE
loc_21AAB:
	mov	ax, offset aAndAreAt
loc_21AAE:
	mov	[bp+var_C], ax
	mov	[bp+var_A], ds
	push	ds
	push	ax
	push	[bp+var_114]
	push	[bp+var_116]
	call	_strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	mov	si, [bp+var_118]
	lfs	bx, [bp+var_110]
	mov	al, fs:[bx+si+12h]
	sub	ah, ah
	mov	[bp+var_112], ax
	mov	bx, ax
	mov	al, byte_47F58[bx]
	cbw
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (scryBaseStringList+2)[bx]
	push	word ptr scryBaseStringList[bx]
	push	dx
	push	[bp+var_116]
	call	_strcat
	add	sp, 8
	mov	[bp+var_116], ax
	mov	[bp+var_114], dx
	lea	ax, [bp+var_10C]
	push	ss
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_scrySight endp

; Attributes: bp-based frame

sp_antiMagic proc far

	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:antiMagicFlag, al
	mov	sp, bp
	pop	bp
	retf
sp_antiMagic endp

; Attributes: bp-based frame

sp_wordOfFear proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_20A3B
	add	sp, 2
	or	ax, ax
	jz	short loc_21BA8
	cmp	[bp+arg_0], 80h
	jge	short loc_21B98
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	si, 3
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_4229C[si], al
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E50[si], al
	jmp	short loc_21BA8
loc_21B98:
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_42567, al
loc_21BA8:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_wordOfFear endp

; Attributes: bp-based frame

sp_spellbind proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	sub	ax, ax
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr savingThrowCheck
	add	sp, 4
	or	ax, ax
	jnz	short loc_21BCD
	jmp	loc_21C63
loc_21BCD:
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_21BFB
	cmp	[bp+arg_0], 80h
	jge	short loc_21BE4
	sub	al, al
	jmp	short loc_21BE6
loc_21BE4:
	mov	al, 1
loc_21BE6:
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	mov	gs:roster.hostileFlag[bx], cl
	jmp	short loc_21C61
loc_21BFB:
	call	findEmptyRosterNum
	mov	[bp+var_2], ax
	cmp	ax, 7
	jge	short loc_21C54
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	cx, 30h	
	mul	cx
	mov	si, ax
	test	gs:monGroups.groupSize[si], 1Fh
	jz	short loc_21C54
	test	gs:monGroups.flags[si],	10h
	jz	short loc_21C54
	dec	gs:monGroups.groupSize[si]
	lea	ax, monGroups._name[si]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_2]
	push	cs
	call	near ptr _sp_convertMonToSummon
	add	sp, 6
	mov	byte ptr word_44166,	0
	jmp	short loc_21C61
loc_21C54:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printNoEffect
	add	sp, 4
loc_21C61:
	jmp	short loc_21C70
loc_21C63:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printNoEffect
	add	sp, 4
loc_21C70:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_spellbind endp

; This function	takes the data from the	mon_t data
; type and converts it to the summonStat_t data	type.
; Attributes: bp-based frame

_sp_convertMonToSummon proc far

	var_56=	word ptr -56h
	var_1A=	dword ptr -1Ah
	counter= word ptr -16h
	var_14=	word ptr -14h
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= dword ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 1Ah
	call	someStackOperation
	push	si
	getCharIndex	ax, [bp+arg_0]
	add	ax, offset roster
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	seg seg027
	mov	ax, charSize
	push	ax
	sub	ax, ax
	push	ax
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_memset
	add	sp, 8
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	call	decryptName
	add	sp, 8
	sub	ax, ax
	push	ax
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.breathSaveLo]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.breathSaveLo], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.breathSaveHi]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.breathSaveHi], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.oppPriorityLo]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.priorityLo], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.oppPriorityHi]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.priorityHi], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.picIndex]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.picIndex], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.breathFlag]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.breathFlag], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.breathRange]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.breathRange], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.toHitLo]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.toHitLo], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.toHitHi]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.toHitHi], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.spellSaveLo]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.spellSaveLo], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.spellSaveHi]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.spellSaveHi], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.strongElement]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.strongElement], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.weakElement]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.weakElement], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.repelFlags]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.repelFlags], al
	mov	[bp+counter], 0
	jmp	short loc_21DB6
loc_21DB3:
	inc	[bp+counter]
loc_21DB6:
	cmp	[bp+counter], 8
	jge	short loc_21DCF
	mov	si, [bp+counter]
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+si+mon_t.attackType._type]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+si+summonStat_t.attacks._type], al
	jmp	short loc_21DB3
loc_21DCF:
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.packedGenAc]
	and	al, 3Fh
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.acBase], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.packedGenAc]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.pronoun], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.groupSize]
	sub	ah, ah
	mov	cl, 5
	shr	ax, cl
	and	al, 7
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.numAttacks], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 0Fh
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.field_5E], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.flags]
	sub	ah, ah
	mov	cl, 6
	shr	ax, cl
	and	al, 3
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.field_5F], al
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.flags]
	and	al, 10h
	cmp	al, 1
	sbb	cx, cx
	inc	cx
	add	cl, 0Dh
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.class], cl
	lfs	bx, [bp+arg_2]
	mov	al, fs:[bx+mon_t.hpDice]
	sub	ah, ah
	push	ax
	call	dice_doYDX
	add	sp, 2
	lfs	bx, [bp+arg_2]
	mov	cx, fs:[bx+mon_t.hpBase]
	add	cx, ax
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+summonStat_t.curHP], cx
	lfs	bx, [bp+var_1A]
	mov	ax, fs:[bx+summonStat_t.curHP]
	mov	fs:[bx+summonStat_t.maxHP], ax
	mov	[bp+counter], 0
	jmp	short loc_21E80
loc_21E7D:
	inc	[bp+counter]
loc_21E80:
	cmp	[bp+counter], 6
	jge	short loc_21E93
	mov	si, [bp+counter]
	lfs	bx, [bp+var_1A]
	mov	fs:[bx+si+summonStat_t.chronoQuest], 0FFh
	jmp	short loc_21E7D
loc_21E93:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_convertMonToSummon endp

; Attributes: bp-based frame
sp_haltFoe proc	far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_20A3B
	add	sp, 2
	or	ax, ax
	jz	short loc_21ED8
	cmp	[bp+arg_0], 80h
	jge	short loc_21EC2
	inc	gs:monFrozenFlag
	jmp	short loc_21ED8
loc_21EC2:
	inc	gs:partyFrozenFlag
	mov	ax, offset aAndThePartyFre
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_21ED8:
	mov	sp, bp
	pop	bp
	retf
sp_haltFoe endp

; Attributes: bp-based frame

sp_meleeMen proc far

	var_56=	word ptr -56h
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 56h	
	call	someStackOperation
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_20A3B
	add	sp, 2
	or	ax, ax
	jz	short loc_21F64
	test	byte ptr [bp+arg_0], 80h
	jz	short loc_21F0F
	mov	ax, 1
	push	ax
	mov	ax, [bp+arg_0]
	and	ax, 3
	push	ax
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
	jmp	short loc_21F28
loc_21F0F:
	mov	ax, 1
	push	ax
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	push	ax
	push	cs
	call	near ptr _sp_setMonDistance
	add	sp, 4
loc_21F28:
	mov	ax, offset aAndTheFoesAre
	push	ds
	push	ax
	lea	ax, [bp+var_56]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	mov	ax, offset aCloser
	push	ds
	push	ax
	push	dx
	push	[bp+var_4]
	call	_strcat
	add	sp, 8
	mov	[bp+var_4], ax
	mov	[bp+var_2], dx
	lea	ax, [bp+var_56]
	push	ss
	push	ax
	call	printString
	add	sp, 4
loc_21F64:
	mov	sp, bp
	pop	bp
	retf
sp_meleeMen endp

; Attributes: bp-based frame

sp_batchspell proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
loc_21F7F:
	mov	bx, [bp+var_4]
	inc	[bp+var_4]
	mov	al, byte_484D2[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	or	ax, ax
	jz	short loc_21F9F
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_22821
	add	sp, 4
	jmp	short loc_21F7F
loc_21F9F:
	mov	sp, bp
	pop	bp
	retf
sp_batchspell endp

; Attributes: bp-based frame

sp_camaraderie proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_21FB8
loc_21FB5:
	inc	[bp+var_2]
loc_21FB8:
	cmp	[bp+var_2], 7
	jge	short loc_21FEE
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.hostileFlag[bx], 0
	jz	short loc_21FEC
	call	_random
	and	al, 1
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	mov	gs:roster.hostileFlag[bx], cl
loc_21FEC:
	jmp	short loc_21FB5
loc_21FEE:
	mov	sp, bp
	pop	bp
	retf
sp_camaraderie endp

; Attributes: bp-based frame

printSpellFizzled proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aButItFizzled
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printSpellFizzled endp

; Attributes: bp-based frame

sp_luckSpell proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	add	gs:byte_41E70, al
	push	bx
	push	[bp+arg_0]
	push	cs
	call	near ptr sp_antiMagic
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
sp_luckSpell endp

; Attributes: bp-based frame

sp_identifySpell proc far

	var_F4=	word ptr -0F4h
	var_34=	word ptr -34h
	var_32=	word ptr -32h
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0F4h
	call	someStackOperation
	call	clearTextWindow
	and	[bp+arg_0], 7Fh
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	lea	ax, [bp+var_F4]
	push	ss
	push	ax
	push	[bp+arg_0]
	call	sub_188E8
	add	sp, 0Ah
	mov	[bp+var_34], ax
	or	ax, ax
	jnz	short loc_22080
	mov	al, byte ptr aYourPocketsAreEm
	cbw
	push	ax
	call	printString
	add	sp, 2
	mov	[bp+var_2], 0FFFFh
	jmp	short loc_22098
loc_22080:
	push	[bp+var_34]
	lea	ax, [bp+var_32]
	push	ss
	push	ax
	mov	ax, offset aWhichItem?
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_2], ax
loc_22098:
	cmp	[bp+var_2], 0
	jge	short loc_220AD
	mov	ax, offset aSpellAborted_
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	jmp	short loc_220D5
loc_220AD:
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+var_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	byte ptr gs:[bx+62h], 3Fh
	mov	ax, offset aItemHasBeenIde
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
loc_220D5:
	mov	sp, bp
	pop	bp
	retf
sp_identifySpell endp

; Attributes: bp-based frame

sp_earthMaw proc far

	var_108= word ptr -108h
	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h

	push	bp
	mov	bp, sp
	mov	ax, 108h
	call	someStackOperation
	push	si
	mov	ax, offset aAndTheEarthSwa
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_2215E
	mov	[bp+var_108], 0
	jmp	short loc_22118
loc_22114:
	inc	[bp+var_108]
loc_22118:
	cmp	[bp+var_108], 7
	jge	short loc_2213B
	getCharP	[bp+var_108], si
	or	gs:roster.status[si], stat_dead
	mov	gs:roster.currentHP[si], 0
	jmp	short loc_22114
loc_2213B:
	call	sub_22DA1
	mov	ax, offset aTheParty
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	jmp	loc_221F0
loc_2215E:
	mov	al, gs:bat_curTarget
	sub	ah, ah
	mov	si, ax
	and	ax, 3
	mov	cx, monStruSize
	mul	cx
	mov	bx, ax
	mov	al, gs:monGroups.groupSize[bx]
	sub	ah, ah
	and	ax, 1Eh
	dec	ax
	push	ax
	push	si
	push	[bp+var_104]
	push	[bp+var_106]
	push	cs
	call	near ptr bat_getTargetName
	add	sp, 8
	mov	[bp+var_106], ax
	mov	[bp+var_104], dx
	mov	al, gs:bat_curTarget
	sub	ah, ah
	and	ax, 3
	mov	[bp+var_102], ax
	getMonP	[bp+var_102], bx
	and	gs:monGroups.groupSize[bx], 0E0h
	mov	[bp+var_108], 0
	jmp	short loc_221CC
loc_221C8:
	inc	[bp+var_108]
loc_221CC:
	cmp	[bp+var_108], 32
	jge	short loc_221F0
	mov	bx, [bp+var_102]
	mov	cl, 6
	shl	bx, cl
	mov	ax, [bp+var_108]
	shl	ax, 1
	add	bx, ax
	mov	gs:bat_monPriorityList[bx], 0
	jmp	short loc_221C8
loc_221F0:
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
sp_earthMaw endp

; Attributes: bp-based frame

printNoEffect proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aButItHadNoEffe
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printNoEffect endp

; Attributes: bp-based frame

sp_divineIntervention proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+var_2], 0
	jmp	short loc_22233
loc_22230:
	inc	[bp+var_2]
loc_22233:
	cmp	[bp+var_2], 7
	jge	short loc_2226B
	getCharP	[bp+var_2], bx
	cmp	gs:roster.class[bx], class_illusion
	jnz	short loc_2225B
	getCharP	[bp+var_2], bx
	mov	gs:roster.class[bx], class_monster
loc_2225B:
	getCharP	[bp+var_2], bx
	and	gs:roster.status[bx], stat_old or stat_unknown
	mov	ax, gs:roster.maxHP[bx]
	mov	gs:roster.currentHP[bx], ax
	jmp	short loc_22230
loc_2226B:
	cmp	gs:byte_422A4, 0
	jz	short loc_222BB
	mov	al, 14h
	mov	gs:byte_42440, al
	mov	gs:byte_41E70, al
	mov	gs:antiMagicFlag, al
	mov	gs:byte_4244E, al
	mov	gs:songExtraAttack, 8
	mov	gs:bat_curTarget, 80h
	mov	ax, 0CEh 
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_22821
	add	sp, 4
loc_222BB:
	mov	sp, bp
	pop	bp
	retf
sp_divineIntervention endp

; Attributes: bp-based frame

dun_removeTrap proc far

	var_4= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 2
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	and	byte ptr fs:[bx], 0EFh
	mov	sp, bp
	pop	bp
	retf
dun_removeTrap endp

dun_maskSquare proc far

	var_4=	dword ptr -4
	row=	word ptr 6
	column=	word ptr 8
	_byte=	word ptr 0Ah
	_mask=  byte ptr 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, [bp+_byte]
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	al, [bp+_mask]
	lfs	bx, [bp+var_4]
	and	byte ptr fs:[bx], al
	mov	sp, bp
	pop	bp
	retf
dun_maskSquare endp
	

; Attributes: bp-based frame

sub_22300 proc far

	sqP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	add	ax, 4
	mov	word ptr [bp+sqP], ax
	mov	word ptr [bp+sqP+2], dx
	lfs	bx, [bp+sqP]
	or	byte ptr fs:[bx], 1
	mov	sp, bp
	pop	bp
	retf
sub_22300 endp

; Attributes: bp-based frame
dun_revealSpSquare proc	far

	sqP= dword ptr -4
	row= word ptr  6
	column=	word ptr  8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	mov	bx, [bp+row]
	shl	bx, 1
	shl	bx, 1
	mov	ax, word ptr gs:rowOffset[bx]
	mov	dx, word ptr gs:(rowOffset+2)[bx]
	mov	cx, [bp+column]
	mov	bx, cx
	shl	cx, 1
	shl	cx, 1
	add	cx, bx
	add	ax, cx
	mov	word ptr [bp+sqP], ax
	mov	word ptr [bp+sqP+2], dx
	mov	bx, [bp+arg_4]
	mov	bl, geoSpMasks[bx-2]._byte
	sub	bh, bh
	lfs	si, [bp+sqP]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	bx, [bp+arg_4]
	mov	cl, geoSpMasks[bx-2].bitmask
	sub	ch, ch
	test	ax, cx
	jz	short loc_2239C
	mov	bx, si
	or	byte ptr fs:[bx+4], 4
	jmp	short loc_223A4
loc_2239C:
	lfs	bx, [bp+sqP]
	and	byte ptr fs:[bx+4], 0FBh
loc_223A4:
	pop	si
	mov	sp, bp
	pop	bp
	retf
dun_revealSpSquare endp

; Attributes: bp-based frame

sp_geomancerSpell proc far

	row= word ptr -8
	var_6= word ptr	-6
	var_4= word ptr	-4
	column=	word ptr -2
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	cmp	inDungeonMaybe, 0
	jz	short loc_2241E
	mov	bx, [bp+arg_2]
	mov	al, spellEffectFlags[bx]
	sub	ah, ah
	mov	[bp+var_6], ax
	sar	ax, 1
	mov	[bp+var_4], ax
	mov	[bp+row], 0
	jmp	short loc_223DB
loc_223D8:
	inc	[bp+row]
loc_223DB:
	mov	al, dunHeight
	sub	ah, ah
	cmp	ax, [bp+row]
	jbe	short loc_2241E
	mov	[bp+column], 0
	jmp	short loc_223F4
loc_223F1:
	inc	[bp+column]
loc_223F4:
	mov	al, dunWidth
	sub	ah, ah
	cmp	ax, [bp+column]
	jbe	short loc_2241C
	push	[bp+var_6]
	push	[bp+column]
	push	[bp+row]
	mov	bx, [bp+var_4]
	shl	bx, 1
	shl	bx, 1
	call	geoSpList[bx]
	add	sp, 6
	jmp	short loc_223F1
loc_2241C:
	jmp	short loc_223D8
loc_2241E:
	mov	sp, bp
	pop	bp
	retf
sp_geomancerSpell endp

; Attributes: bp-based frame

_sp_useLightObj	proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aMakesALight
	push	ds
	push	ax
	call	printString
	add	sp, 4
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr sp_lightSpell
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_sp_useLightObj	endp

; Attributes: bp-based frame

_sp_useAcorn proc far

	arg_0= byte ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aAteIt_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	al, [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	word ptr [bp+arg_0]
	push	cs
	call	near ptr sub_22821
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
_sp_useAcorn endp

; Attributes: bp-based frame

_sp_useWineskin	proc far

	var_106= word ptr -106h
	var_104= word ptr -104h
	var_102= word ptr -102h
	var_100= word ptr -100h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 106h
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	mov	al, gs:byte_4227E
	sub	ah, ah
	add	bx, ax
	mov	al, gs:roster.inventory.itemFlags[bx]
	shr	ax, 1
	shr	ax, 1
	and	ax, 7
	mov	[bp+var_106], ax
	mov	ax, offset aDrinksAndFeels
	push	ds
	push	ax
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	mov	bx, [bp+var_106]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (off_47D32+2)[bx]
	push	word ptr off_47D32[bx]
	push	dx
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_104], ax
	mov	[bp+var_102], dx
	lea	ax, [bp+var_100]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	cmp	[bp+var_106], 1
	jnz	short loc_2252F
	getCharP	[bp+arg_0], si
	cmp	gs:roster.class[si], class_bard
	jnz	short loc_2252F
	push	gs:roster.level[si]
	push	cs
	call	near ptr _returnXor255
	add	sp, 2
	mov	gs:roster.specAbil[si],	al
	jmp	short loc_22548
loc_2252F:
	mov	al, byte ptr [bp+arg_0]
	mov	gs:bat_curTarget, al
	mov	ax, 94h	
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_22821
	add	sp, 4
loc_22548:
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_useWineskin	endp

; Attributes: bp-based frame

printCantFindUse proc far
	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, offset aCanTSeemToFind
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printCantFindUse endp

; Attributes: bp-based frame

_sp_useWeapon proc far

	var_10=	word ptr -10h
	var_E= byte ptr	-0Eh
	var_D= byte ptr	-0Dh
	var_C= byte ptr	-0Ch
	var_B= byte ptr	-0Bh
	var_A= byte ptr	-0Ah
	var_9= byte ptr	-9
	var_8= byte ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	push	di
	push	si
	getCharP	[bp+partySlotNumber], bx
	mov	al, gs:byte_4227E
	sub	ah, ah
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	mov	[bp+var_6], ax
	mov	[bp+var_10], 31
	jmp	short loc_2259F
loc_2259C:
	dec	[bp+var_10]
loc_2259F:
	cmp	[bp+var_10], 0
	jge	short loc_225A8
	jmp	loc_22632
loc_225A8:
	mov	bx, [bp+var_10]
	mov	al, byte_48382[bx]
	sub	ah, ah
	cmp	ax, [bp+var_6]
	jnz	short loc_2262F
	cmp	bx, 17h
	jge	short loc_225C0
	mov	ax, offset aCastsAWeapon
	jmp	short loc_225C3
loc_225C0:
	mov	ax, offset aBreathes
loc_225C3:
	mov	[bp+var_4], ax
	mov	[bp+var_2], ds
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, [bp+var_10]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	shl	ax, 1
	mov	si, ax
	mov	al, byte ptr weaponDamageList.effectStrIndex[si]
	mov	[bp+var_E], al
	mov	al, weaponDamageList.elements[si]
	mov	[bp+var_D], al
	mov	[bp+var_C], 10h
	mov	[bp+var_B], 0
	mov	al, weaponDamageList.repelFlags[si]
	mov	[bp+var_A], al
	mov	al, weaponDamageList.damage[si]
	mov	[bp+var_9], al
	mov	al, weaponDamageList.targetFlags[si]
	mov	[bp+var_8], al
	mov	al, weaponDamageList.levelMult[si]
	sub	ah, ah
	push	ax
	sub	sp, 8
	push	si
	lea	si, [bp+var_E]
	mov	di, sp
	add	di, 2
	push	ss
	pop	es
	assume es:nothing
	movsw
	movsw
	movsw
	movsb
	pop	si
	push	[bp+partySlotNumber]
	push	cs
	call	near ptr bat_doBreathAttack
	add	sp, 0Ch
loc_2262F:
	jmp	loc_2259C
loc_22632:
	pop	si
	pop	di
	mov	sp, bp
	pop	bp
	retf
_sp_useWeapon endp

; Attributes: bp-based frame
_sp_reenergizeMage proc	far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], si
	mov	ax, gs:roster.maxSppt[si]
	mov	gs:roster.currentSppt[si], ax
	mov	ax, offset aIsReEnergized
	push	ds
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
_sp_reenergizeMage endp

; Attributes: bp-based frame

_sp_useFigurine	proc far

	counter= word ptr -4
	itemNo=	word ptr -2
	partySlotNumber=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	ax, offset aInvokesAFiguri
	push	ds
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+partySlotNumber], bx
	mov	al, gs:byte_4227E
	sub	ah, ah
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	mov	[bp+itemNo], ax
	mov	[bp+counter], 8
	jmp	short loc_226AD
loc_226AA:
	dec	[bp+counter]
loc_226AD:
	cmp	[bp+counter], 0
	jle	short loc_226D5
	mov	bx, [bp+counter]
	mov	al, figurineItemNo[bx]
	sub	ah, ah
	cmp	ax, [bp+itemNo]
	jnz	short loc_226D3
	mov	al, byte_483AC[bx]
	push	ax
	push	[bp+partySlotNumber]
	call	doSummon
	add	sp, 4
	jmp	short loc_226D5
loc_226D3:
	jmp	short loc_226AA
loc_226D5:
	mov	sp, bp
	pop	bp
	retf
_sp_useFigurine	endp

; Attributes: bp-based frame

rnd_Xd4	proc far

	rval= word ptr -2
	numOfDice= word	ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+rval], 0
	jmp	short loc_226EE
loc_226EB:
	dec	[bp+numOfDice]
loc_226EE:
	cmp	[bp+numOfDice],	0
	jle	short loc_22702
	call	_random
	and	ax, 3
	inc	ax
	add	[bp+rval], ax
	jmp	short loc_226EB
loc_22702:
	mov	ax, [bp+rval]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
rnd_Xd4	endp

; Attributes: bp-based frame
bat_isPartyInRange proc	far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	rangeMaybe= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	cmp	gs:bat_curTarget, 80h
	jnb	short loc_2272E
	cmp	[bp+partySlotNumber], 80h
	jge	short loc_2272E
	mov	ax, 1
	jmp	short loc_227A2
loc_2272E:
	test	byte ptr [bp+rangeMaybe], 80h
	jz	short loc_22744
	mov	ax, [bp+rangeMaybe]
	and	ax, 7Fh
	mov	[bp+var_8], ax
	shl	ax, 1
	mov	[bp+var_2], ax
	jmp	short loc_2274F
loc_22744:
	mov	ax, [bp+rangeMaybe]
	mov	[bp+var_8], ax
	mov	[bp+var_2], 0
loc_2274F:
	cmp	gs:bat_curTarget, 80h
	jb	short loc_22763
	mov	al, gs:bat_curTarget
	sub	ah, ah
	jmp	short loc_22766
loc_22763:
	mov	ax, [bp+partySlotNumber]
loc_22766:
	mov	[bp+var_6], ax
	and	ax, 3
	getMonIndex	cx, cx
	mov	bx, ax
	mov	al, gs:monGroups.distance[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_4], ax
	mov	ax, [bp+var_8]
	cmp	[bp+var_4], ax
	jg	short loc_22791
	mov	ax, 1
	jmp	short loc_227A2
loc_22791:
	mov	ax, [bp+var_2]
	cmp	[bp+var_4], ax
	jg	short loc_2279E
	mov	ax, 2
	jmp	short loc_227A0
loc_2279E:
	sub	ax, ax
loc_227A0:
	jmp	short $+2
loc_227A2:
	mov	sp, bp
	pop	bp
	retf
bat_isPartyInRange endp

; Attributes: bp-based frame
spell_cast proc	far

	var_2= word ptr	-2
	partySlotNumber=	word ptr  6
	spellNo= word ptr  8
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_4], 0
	jnz	short loc_227E2
	mov	ax, [bp+spellNo]
	mov	curSpellNo, ax
	mov	ax, 1
	push	ax
	push	gs:mapDataSeg
	push	gs:mapDataOff
	call	map_execute
	add	sp, 6
	or	ax, ax
	jz	short loc_227E2
	jmp	short loc_2281D
loc_227E2:
	cmp	[bp+arg_4], 0
	jz	short loc_227F8
	mov	bx, [bp+spellNo]
	test	byte_47F94[bx],	8
	jnz	short loc_227F6
	sub	ax, ax
	jmp	short loc_2281D
loc_227F6:
	jmp	short loc_22806
loc_227F8:
	mov	bx, [bp+spellNo]
	test	byte_47F94[bx],	10h
	jnz	short loc_22806
	sub	ax, ax
	jmp	short loc_2281D
loc_22806:
	push	[bp+spellNo]
	push	[bp+partySlotNumber]
	mov	bx, [bp+spellNo]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	mov	[bp+var_2], ax
loc_2281D:
	mov	sp, bp
	pop	bp
	retf
spell_cast endp

; Attributes: bp-based frame

sub_22821 proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	mov	al, byte_4EEC3
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	al, byte_4EEC4
	mov	[bp+var_6], ax
	cmp	[bp+arg_2], 80h
	jge	short loc_2285D
	mov	byte_4EEC3, ah
	mov	byte_4EEC4, ah
loc_2285D:
	and	[bp+arg_2], 7Fh
	push	[bp+arg_2]
	push	[bp+arg_0]
	mov	bx, [bp+arg_2]
	shl	bx, 1
	shl	bx, 1
	call	spellFuncList[bx]
	add	sp, 4
	mov	[bp+var_2], ax
	mov	al, byte ptr [bp+var_4]
	mov	byte_4EEC3, al
	mov	al, byte ptr [bp+var_6]
	mov	byte_4EEC4, al
	mov	sp, bp
	pop	bp
	retf
sub_22821 endp

; Attributes: bp-based frame

_sp_checkSPPT proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	cmp	[bp+arg_0], 80h
	jl	short loc_228A9
	mov	ax, 1
	jmp	short loc_228E9
loc_228A9:
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr getSpptRequired
	add	sp, 4
	mov	[bp+var_2], ax
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.currentSppt[bx], cx
	jnb	short loc_228D2
	sub	ax, ax
	jmp	short loc_228E9
loc_228D2:
	mov	ax, [bp+var_2]
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	sub	gs:roster.currentSppt[bx], cx
	mov	ax, 1
	jmp	short $+2
loc_228E9:
	mov	sp, bp
	pop	bp
	retf
_sp_checkSPPT endp

; Attributes: bp-based frame

bat_getTargetName proc far

	var_10=	word ptr -10h
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 10h
	call	someStackOperation
	cmp	[bp+arg_4], 80h
	jge	short loc_22927
	getCharP	[bp+arg_4], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	jmp	loc_229B5
loc_22927:
	and	[bp+arg_4], 3
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	getMonP	[bp+arg_4], bx
	lea	ax, monGroups._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	decryptName
	add	sp, 8
	cmp	[bp+arg_6], 0
	jz	short loc_2296A
	mov	ax, offset aSome
	push	ds
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
	jmp	short loc_22999
loc_2296A:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'a'
	mov	al, byte ptr [bp+var_10]
	cbw
	push	ax
	call	str_startsWithVowel
	add	sp, 2
	or	ax, ax
	jz	short loc_2298F
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 'n'
loc_2298F:
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], ' '
loc_22999:
	push	[bp+arg_6]
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	lea	ax, [bp+var_10]
	push	ss
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+arg_0], ax
	mov	word ptr [bp+arg_0+2], dx
loc_229B5:
	mov	ax, word ptr [bp+arg_0]
	mov	dx, word ptr [bp+arg_0+2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
locret_229C0:
	retf
bat_getTargetName endp

seg010 ends
