; Segment type:	Pure code
seg006 segment word public 'CODE' use16
	assume cs:seg006
;org 9
	assume es:nothing, ss:nothing, ds:dseg,	fs:nothing, gs:seg027
algn_17B89:
align 2
; Attributes: bp-based frame

rost_updateParty proc far

	charNo=	word ptr -2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	mov	[bp+charNo], 0
	jmp	short loc_17B9F
loc_17B9C:
	inc	[bp+charNo]
loc_17B9F:
	cmp	[bp+charNo], 7
	jge	short loc_17BC5
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jz	short loc_17BC3
	push	[bp+charNo]
	push	cs
	call	near ptr rost_update
	add	sp, 2
loc_17BC3:
	jmp	short loc_17B9C
loc_17BC5:
	mov	sp, bp
	pop	bp
	retf
rost_updateParty endp

; Attributes: bp-based frame

rost_update proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	getCharP	[bp+charNo], bx
	test	gs:roster.status[bx], stat_dead	or stat_stoned
	jz	short loc_17C23
	mov	ax, itemEff_resurrect
	push	ax
	push	[bp+charNo]
	push	cs
	call	near ptr hasEffectEquipped
	add	sp, 4
	or	ax, ax
	jnz	short loc_17C23
	push	cs
	call	near ptr inven_pack
	getCharP	[bp+charNo], bx
	and	gs:roster.status[bx], stat_poisoned or stat_old	or stat_paralyzed or stat_possessed or stat_nuts or stat_unknown
	getCharP	[bp+charNo], si
	mov	ax, gs:roster.maxHP[si]
	mov	gs:roster.currentHP[si], ax
loc_17C23:
	cmp	gs:songHalfDamage, 0
	jz	short loc_17C6D
	mov	al, gs:byte_41E62
	sub	ah, ah
	cmp	ax, [bp+charNo]
	jnz	short loc_17C6D
	getCharP	[bp+charNo], bx
	cmp	gs:roster.level[bx], 60
	jbe	short loc_17C57
	mov	ax, 0Fh
	jmp	short loc_17C68
loc_17C57:
	getCharP	[bp+charNo], bx
	mov	ax, gs:roster.level[bx]
	shr	ax, 1
	shr	ax, 1
loc_17C68:
	mov	[bp+var_6], ax
	jmp	short loc_17C72
loc_17C6D:
	mov	[bp+var_6], 0
loc_17C72:
	push	[bp+charNo]
	push	cs
	call	near ptr sub_17D8E
	add	sp, 2
	push	[bp+charNo]
	mov	si, ax
	push	cs
	call	near ptr rost_getDexACBonus
	add	sp, 2
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	al, gs:roster.acBase[bx]
	sub	ah, ah
	mov	bx, [bp+charNo]
	mov	dl, gs:byte_42444[bx]
	sub	dh, dh
	add	ax, dx
	add	ax, cx
	add	ax, si
	add	ax, [bp+var_6]
	mov	[bp+var_4], ax
	getCharP	bx, bx
	cmp	gs:roster.class[bx], 9
	jnz	short loc_17CE4
	getCharP	[bp+charNo], bx
	mov	ax, gs:roster.level[bx]
	sub	ax, 0FFh
	sbb	cx, cx
	and	ax, cx
	add	ax, 0FFh
	add	[bp+var_4], ax
loc_17CE4:
	mov	al, byte_4EECB
	sub	ah, ah
	mov	cl, gs:byte_4244E
	sub	ch, ch
	add	ax, cx
	mov	cl, gs:songACBonus
	add	ax, cx
	mov	cl, gs:byte_42274
	sub	ax, cx
	mov	[bp+var_2], ax
	or	ax, ax
	jle	short loc_17D1B
	add	[bp+var_4], ax
loc_17D1B:
	mov	al, byte ptr [bp+var_4]
	cmp	ax, 60
	jle	loc_acOkay
	mov	ax, 60

loc_acOkay:
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	gs:roster.ac[bx], cl
	getCharP	[bp+charNo], bx
	cmp	gs:roster.currentHP[bx], 0
	jnz	short loc_17D4F
	getCharP	[bp+charNo], bx
	or	gs:roster.status[bx], stat_dead
loc_17D4F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
rost_update endp

; Attributes: bp-based frame
rost_getDexACBonus proc	far

	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.dexterity[bx]
	sub	ah, ah
	sub	ax, 14
	mov	[bp+var_2], ax
	or	ax, ax
	jle	short loc_17D86
	mov	bx, ax
	mov	al, acDexterityBonus[bx]
	sub	ah, ah
	jmp	short loc_17D88
loc_17D86:
	sub	ax, ax
loc_17D88:
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
rost_getDexACBonus endp

; Attributes: bp-based frame

sub_17D8E proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+var_2], 0
	mov	[bp+var_4], 0
	jmp	short loc_17DA9
loc_17DA5:
	add	[bp+var_4], 3
loc_17DA9:
	cmp	[bp+var_4], 36
	jge	short loc_17DE9
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 1
	jnz	short loc_17DE7
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	bl, gs:roster.inventory.itemNo[bx]
	sub	bh, bh
	mov	al, item_acBonWeapDam[bx]
	sub	ah, ah
	and	ax, 0Fh
	add	[bp+var_2], ax
loc_17DE7:
	jmp	short loc_17DA5
loc_17DE9:
	mov	ax, [bp+var_2]
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_17D8E endp

; Attributes: bp-based frame
;
; Return:
;   0 - has effect and is equipped
;   1 - has effect and not equipped
;  -1 - does not have effect
;

hasEffectEquipped proc far

	rval= word ptr -6
	var_4= word ptr	-4
	var_2= word ptr	-2
	playerNo= word ptr  6
	effectNo= word ptr  8

	push		bp
	mov		bp, sp
	mov		ax, 6
	call		someStackOperation
	mov		[bp+rval], 0FFFFh
	getCharP	[bp+playerNo], bx
	cmp		byte ptr gs:roster._name[bx], 0
	jz		short l_hasEffectEquipped_return
	mov		[bp+var_4], 1
l_hasEffectEquipped_do:
	getCharP	[bp+playerNo], bx
	add		bx, [bp+var_4]
	mov		al, gs:roster.inventory.itemFlags[bx]
	sub		ah, ah
	mov		[bp+var_2], ax
	mov		bx, ax
	mov		al, itemEffectList[bx]
	and		ax, 0Fh
	cmp		ax, [bp+effectNo]
	jnz		l_hasEffectEquipped_while

	; Effect found. Determine if the item is equipped or not.
	;
	mov		[bp+rval], 1
	mov		ax, [bp+var_4]
	dec		ax
	mov		gs:word_42416, ax
	mov		ax, [bp+playerNo]
	mov		gs:word_4244C, ax
	getCharP	[bp+playerNo], bx
	add		bx, [bp+var_4]
	mov		al, gs:roster.acBase[bx]
	and		al, 3
	cmp		al, 1
	jnz		short l_hasEffectEquipped_while
	sub		ax, ax
	mov		[bp+rval], ax
	jmp		short l_hasEffectEquipped_return
l_hasEffectEquipped_while:
	add		[bp+var_4], 3
	cmp		[bp+var_4], 24h
	jl		l_hasEffectEquipped_do
l_hasEffectEquipped_return:
	mov		ax, [bp+rval]
	mov		sp, bp
	pop		bp
	retf
hasEffectEquipped endp

; Attributes: bp-based frame

	inven_pack proc	far
	var_2= word ptr	-2

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	push	si
	mov	ax, gs:word_42416
	mov	[bp+var_2], ax
	jmp	short loc_17EAA
loc_17EA7:
	inc	[bp+var_2]
loc_17EAA:
	cmp	[bp+var_2], 33
	jge	short loc_17ED1
	getCharP	gs:word_4244C, si
	add	si, [bp+var_2]
	mov	al, gs:(roster.inventory.itemFlags+3)[si]
	mov	gs:roster.inventory.itemFlags[si], al
	jmp	short loc_17EA7
loc_17ED1:
	mov	[bp+var_2], 33
	jmp	short loc_17EDB
loc_17ED8:
	inc	[bp+var_2]
loc_17EDB:
	cmp	[bp+var_2], 36
	jge	short loc_17EFE
	getCharP	gs:word_4244C, bx
	add	bx, [bp+var_2]
	mov	gs:roster.inventory.itemFlags[bx], 0
	jmp	short loc_17ED8
loc_17EFE:
	pop	si
	mov	sp, bp
	pop	bp
	retf
inven_pack endp

; Attributes: bp-based frame

inven_addItem proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	charNo=	word ptr  6
	arg_2= word ptr	 8
	arg_4= byte ptr	 0Ah
	arg_6= byte ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	getCharP	[bp+charNo], bx
	cmp	byte ptr gs:roster._name[bx], 0
	jnz	short loc_17F27
	sub	ax, ax
	jmp	loc_17FCC
loc_17F27:
	mov	[bp+var_4], 0
	jmp	short loc_17F32
loc_17F2E:
	add	[bp+var_4], 3
loc_17F32:
	cmp	[bp+var_4], 24h	
	jl	short loc_17F3B
	jmp	loc_17FC8
loc_17F3B:
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_4]
	cmp	gs:roster.inventory.itemNo[bx],	0
	jnz	short loc_17FC5
	getCharP	[bp+charNo], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	mov	al, classEquipMask[bx]
	sub	ah, ah
	mov	bx, [bp+arg_2]
	mov	cl, itemEquipMask[bx]
	sub	ch, ch
	test	ax, cx
	jz	short loc_17F78
	sub	ax, ax
	jmp	short loc_17F7B
loc_17F78:
	mov	ax, itemFlag_unequipable
loc_17F7B:
	mov	[bp+var_2], ax
	mov	al, [bp+arg_4]
	or	al, byte ptr [bp+var_2]
	mov	cx, ax
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_4]
	mov	gs:roster.inventory.itemFlags[bx], cl
	mov	al, byte ptr [bp+arg_2]
	mov	cx, ax
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_4]
	mov	gs:roster.inventory.itemNo[bx],	cl
	mov	al, [bp+arg_6]
	mov	cx, ax
	getCharP	[bp+charNo], bx
	add	bx, [bp+var_4]
	mov	gs:roster.inventory.itemCount[bx], cl
	mov	ax, 1
	jmp	short loc_17FCC
loc_17FC5:
	jmp	loc_17F2E
loc_17FC8:
	sub	ax, ax
	jmp	short $+2
loc_17FCC:
	mov	sp, bp
	pop	bp
	retf
inven_addItem endp

; This function	returns	1 if the item can be
; used.
; Attributes: bp-based frame

item_canBeUsed proc far

	var_2= word ptr	-2
	charNo=	word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	getCharIndex	ax, [bp+charNo]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 2
	jnz	short loc_17FFF
	sub	ax, ax
	jmp	short loc_18073
loc_17FFF:
	getCharIndex	ax, [bp+charNo]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	mov	al, itemSpellNo[bx]
	mov	curSpellNo, ax
	cmp	ax, 0FFh
	jnz	short loc_18031
	sub	ax, ax
	jmp	short loc_18073
loc_18031:
	getCharIndex	ax, [bp+charNo]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:roster.inventory.itemCount[bx], 0
	jnz	short loc_18052
	sub	ax, ax
	jmp	short loc_18073
loc_18052:
	mov	bx, [bp+var_2]
	cmp	itemTypeList[bx], itType_quiver
	jnz	short loc_1806E
	mov	ax, itType_bow
	push	ax
	push	[bp+charNo]
	push	cs
	call	near ptr sub_18077
	add	sp, 4
	jmp	short loc_18073
	jmp	short loc_18073
loc_1806E:
	mov	ax, 1
	jmp	short $+2
loc_18073:
	mov	sp, bp
	pop	bp
	retf
item_canBeUsed endp

; Attributes: bp-based frame

sub_18077 proc far

	var_4= word ptr	-4
	counter= word ptr -2
	playerNo= word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_1808D
loc_18089:
	add	[bp+counter], 3
loc_1808D:
	cmp	[bp+counter], inventorySize
	jge	short loc_180DD
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+arg_2]
	jnz	short loc_180DB
	cmp	[bp+arg_2], itType_weapon
	jnz	short loc_180D6
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, itemFlag_equipped
	jnz	short loc_180DB
loc_180D6:
	mov	ax, 1
	jmp	short loc_180E1
loc_180DB:
	jmp	short loc_18089
loc_180DD:
	sub	ax, ax
	jmp	short $+2
loc_180E1:
	mov	sp, bp
	pop	bp
	retf
sub_18077 endp

; Attributes: bp-based frame

inven_hasTypeEquipped proc far

	var_4= word ptr	-4
	counter= word ptr -2
	playerNo= word ptr  6
	itemType= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_180FB
loc_180F7:
	add	[bp+counter], 3
loc_180FB:
	cmp	[bp+counter], inventorySize
	jge	short loc_18145
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+itemType]
	jnz	short loc_18143
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, itemFlag_equipped
	jnz	short loc_18143
	mov	ax, 1
	jmp	short loc_18149
loc_18143:
	jmp	short loc_180F7
loc_18145:
	sub	ax, ax
	jmp	short $+2
loc_18149:
	mov	sp, bp
	pop	bp
	retf
inven_hasTypeEquipped endp

; This function	returns	the slot number	of an equipped
; item that matches the	type requested
; Attributes: bp-based frame

inven_getTypeEqSlot proc far

	var_4= word ptr	-4
	counter= word ptr -2
	playerNo= word ptr  6
	itemType= word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	mov	[bp+counter], 0
	jmp	short loc_18163
loc_1815F:
	add	[bp+counter], 3
loc_18163:
	cmp	[bp+counter], inventorySize
	jge	short loc_181AD
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_4], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+itemType]
	jnz	short loc_181AB
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, itemFlag_equipped
	jnz	short loc_181AB
	mov	ax, [bp+var_4]
	jmp	short loc_181B2
loc_181AB:
	jmp	short loc_1815F
loc_181AD:
	mov	ax, 0FFFFh
	jmp	short $+2
loc_181B2:
	mov	sp, bp
	pop	bp
	retf
inven_getTypeEqSlot endp

; Attributes: bp-based frame

printCharacter proc far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	call	findEmptyRosterNum
	mov	[bp+var_2], ax
	cmp	[bp+arg_0], ax
	jl	short loc_181D1
	jmp	loc_18302
loc_181D1:
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.picIndex[bx]
	sub	ah, ah
	push	ax
	call	bigpic_drawPicNumber
	add	sp, 2
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	call	setTitle
	add	sp, 4
loc_18206:
	push	[bp+var_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printCharStats
	add	sp, 4
	mov	[bp+var_4], 0
	mov	al, gs:txt_numLines
	sub	ah, ah
	sub	ax, 2
	mov	[bp+var_8], ax
	jmp	short loc_1822D
loc_1822A:
	inc	[bp+var_8]
loc_1822D:
	mov	al, gs:txt_numLines
	sub	ah, ah
	cmp	ax, [bp+var_8]
	jb	short loc_1824F
	mov	bx, [bp+var_8]
	shl	bx, 1
	mov	ax, bitMask16bit[bx]
	or	[bp+var_4], ax
	jmp	short loc_1822A
loc_1824F:
	push	[bp+var_4]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_6], ax
	cmp	ax, 50h	
	jz	short loc_18274
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Ch
	cmp	ax, [bp+var_6]
	jnz	short loc_18284
loc_18274:
	push	[bp+var_2]
	push	[bp+arg_0]
	call	doPoolGold
	add	sp, 4
	jmp	short loc_182A9
loc_18284:
	cmp	[bp+var_6], 54h	
	jz	short loc_1829C
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Dh
	cmp	ax, [bp+var_6]
	jnz	short loc_182A9
loc_1829C:
	push	[bp+var_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr getGoldTradee
	add	sp, 4
loc_182A9:
	cmp	[bp+var_6], 1Bh
	jz	short loc_182C4
	mov	al, gs:txt_numLines
	sub	ah, ah
	add	ax, 10Eh
	cmp	ax, [bp+var_6]
	jz	short loc_182C4
	jmp	loc_18206
loc_182C4:
	call	clearTextWindow
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jnb	short loc_182EA
	push	[bp+var_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr printInventoryScreen
	add	sp, 4
loc_182EA:
	push	[bp+arg_0]
	push	cs
	call	near ptr charHasSpecialAbils
	add	sp, 2
	or	ax, ax
	jz	short loc_18302
	push	[bp+arg_0]
	push	cs
	call	near ptr printCharAbilities
	add	sp, 2
loc_18302:
	mov	sp, bp
	pop	bp
	retf
printCharacter endp

; Attributes: bp-based frame

sub_18306 proc far

	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 20h
	lfs	bx, [bp+arg_0]
	inc	word ptr [bp+arg_0]
	mov	byte ptr fs:[bx], 23h
	mov	ax, 2
	push	ax
	mov	ax, [bp+arg_4]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+arg_0+2]
	push	word ptr [bp+arg_0]
	call	_itoa
	add	sp, 0Ah
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
sub_18306 endp

; Attributes: bp-based frame
item_trade proc	far

	var_4E=	word ptr -4Eh
	var_4C=	word ptr -4Ch
	var_4A=	word ptr -4Ah
	var_48=	word ptr -48h
	var_46=	word ptr -46h
	var_44=	word ptr -44h
	var_42=	word ptr -42h
	var_40=	word ptr -40h
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 4Eh	
	call	someStackOperation
	mov	ax, offset aWhoDoes
	push	ds
	push	ax
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	push	[bp+var_42]
	push	[bp+var_44]
	call	_strcat
	add	sp, 8
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	mov	ax, offset aWantToGiveItTo
	push	ds
	push	ax
	push	dx
	push	[bp+var_44]
	call	_strcat
	add	sp, 8
	mov	[bp+var_44], ax
	mov	[bp+var_42], dx
	lea	ax, [bp+var_40]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_4E], ax
	or	ax, ax
	jge	short loc_183BD
	jmp	loc_1844C
loc_183BD:
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	[bp+var_4A], ax
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+62h]
	sub	ah, ah
	and	ax, 0FCh
	mov	[bp+var_46], ax
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+63h]
	sub	ah, ah
	mov	[bp+var_4C], ax
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4A]
	mov	al, gs:[bx+64h]
	sub	ah, ah
	mov	[bp+var_48], ax
	push	ax
	push	[bp+var_46]
	push	[bp+var_4C]
	push	[bp+var_4E]
	push	cs
	call	near ptr inven_addItem
	add	sp, 8
	or	ax, ax
	jz	short loc_18433
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	cs
	call	near ptr item_discard
	add	sp, 4
	jmp	short loc_1844C
loc_18433:
	mov	ax, offset aAllFull
	push	ds
	push	ax
	call	printStringWClear
	add	sp, 4
	wait4IO
loc_1844C:
	mov	sp, bp
	pop	bp
	retf
item_trade endp

; Attributes: bp-based frame

item_discard proc far

	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	gs:word_42416, ax
	mov	ax, [bp+arg_0]
	mov	gs:word_4244C, ax
	push	cs
	call	near ptr inven_pack
	mov	sp, bp
	pop	bp
	retf
item_discard endp

; Attributes: bp-based frame

item_equip proc	far
	itemType= word ptr -0Ah
	var_8= word ptr	-8
	counter= word ptr -6
	itemNo=	word ptr -4
	playerNo= word ptr  6
	slotNo=	word ptr  8

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	getCharIndex	ax, [bp+playerNo]
	mov	bx, [bp+slotNo]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+itemNo], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	mov	[bp+itemType], ax
	or	ax, ax
	jnz	short loc_184BB
	jmp	loc_18555
loc_184BB:
	getCharIndex	ax, [bp+playerNo]
	mov	bx, cx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	gs:roster.inventory.itemFlags[bx], 0FCh
	getCharIndex	ax, [bp+playerNo]
	mov	bx, [bp+slotNo]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	or	gs:roster.inventory.itemFlags[bx], itemFlag_equipped
	mov	[bp+counter], 0
	jmp	short loc_184F1
loc_184ED:
	add	[bp+counter], 3
loc_184F1:
	cmp	[bp+counter], 36
	jge	short loc_18555
	mov	ax, [bp+slotNo]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	cmp	ax, [bp+counter]
	jz	short loc_18553
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_8], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	ax, 0Fh
	cmp	ax, [bp+itemType]
	jnz	short loc_18553
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	mov	al, gs:roster.inventory.itemFlags[bx]
	and	al, 3
	cmp	al, 2
	jz	short loc_18553
	getCharP	[bp+playerNo], bx
	add	bx, [bp+counter]
	and	gs:roster.inventory.itemFlags[bx], 0FCh
loc_18553:
	jmp	short loc_184ED
loc_18555:
	mov	sp, bp
	pop	bp
	retf
item_equip endp

; Attributes: bp-based frame

item_unequip proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	and	gs:roster.inventory.itemFlags[bx], 0FCh
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+arg_2]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, ax
	mov	al, itemTypeList[bx]
	and	al, 0Fh
	cmp	al, 6
	jnz	short loc_185B1
	push	[bp+arg_0]
	call	song_stopPlaying
	add	sp, 2
loc_185B1:
	mov	sp, bp
	pop	bp
	retf
item_unequip endp

; Attributes: bp-based frame

item_identify proc far

	var_46=	word ptr -46h
	var_44=	word ptr -44h
	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 46h	
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	test	gs:roster.status[bx], 1Ch
	jz	short loc_185D7
	jmp	loc_18699
loc_185D7:
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_44]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	mov	ax, [bp+arg_2]
	mov	cx, ax
	shl	ax, 1
	add	ax, cx
	mov	[bp+var_46], ax
	call	_random
	mov	cx, ax
	getCharP	[bp+arg_0], bx
	cmp	gs:(roster.specAbil+1)[bx], cl
	jbe	short loc_18634
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_46]
	and	gs:roster.inventory.itemFlags[bx], 3Fh
	jmp	short loc_18645
loc_18634:
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_46]
	or	gs:roster.inventory.itemFlags[bx], 40h
loc_18645:
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_46]
	cmp	gs:roster.inventory.itemFlags[bx], 80h
	jb	short loc_1865D
	mov	ax, 1
	jmp	short loc_1865F
loc_1865D:
	sub	ax, ax
loc_1865F:
	push	ax
	push	word ptr [bp+var_4+2]
	push	word ptr [bp+var_4]
	mov	ax, offset aTriesToIdentif
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	lea	ax, [bp+var_44]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_18699:
	mov	sp, bp
	pop	bp
	retf
item_identify endp

; Attributes: bp-based frame

printInventoryScreen proc far

	var_116= word ptr -116h
	var_114= word ptr -114h
	var_112= word ptr -112h
	var_52=	word ptr -52h
	var_50=	word ptr -50h
	var_4E=	word ptr -4Eh
	var_4C=	word ptr -4Ch
	var_1C=	word ptr -1Ch
	var_1A=	word ptr -1Ah
	var_14=	word ptr -14h
	var_E= word ptr	-0Eh
	var_C= word ptr	-0Ch
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 116h
	call	someStackOperation
	push	si
loc_186A9:
	lea	ax, [bp+var_4C]
	push	ss
	push	ax
	lea	ax, [bp+var_112]
	push	ss
	push	ax
	push	[bp+arg_0]
	push	cs
	call	near ptr sub_188E8
	add	sp, 0Ah
	mov	[bp+var_50], ax
	or	ax, ax
	jnz	short loc_186E1
	mov	ax, offset aYourPocketsAreEm
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
	jmp	loc_18832
loc_186E1:
	push	[bp+var_50]
	lea	ax, [bp+var_4C]
	push	ss
	push	ax
	mov	ax, offset aInventory
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_1C], ax
	call	clearTextWindow
	cmp	[bp+var_1C], 0
	jge	short loc_18707
	jmp	loc_18832
loc_18707:
	push	[bp+var_1C]
	push	[bp+arg_0]
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	push	cs
	call	near ptr inven_getInvOptions
	add	sp, 8
	call	clearTextWindow
	lea	ax, [bp+var_C]
	push	ss
	push	ax
	lea	ax, [bp+var_1A]
	push	ss
	push	ax
	lea	ax, [bp+var_14]
	push	ss
	push	ax
	mov	ax, offset aDoYouWishTo@tr
	push	ds
	push	ax
	call	printVarString
	add	sp, 10h
	mov	[bp+var_4E], ax
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+var_1C]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:roster.inventory.itemNo[bx],	76h 
	jz	short loc_18770
	getCharIndex	ax, [bp+arg_0]
	mov	bx, cx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	cmp	gs:roster.inventory.itemNo[bx],	7Dh 
	jnz	short loc_187B8
loc_18770:
	getCharIndex	ax, [bp+arg_0]
	mov	bx, [bp+var_1C]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemFlags[bx]
	sub	ah, ah
	shr	ax, 1
	shr	ax, 1
	and	ax, 0Fh
	mov	[bp+var_116], ax
	mov	ax, offset aItSFilledWith
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	bx, [bp+var_116]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (wineskinString+2)[bx]
	push	word ptr wineskinString[bx]
	call	printString
	add	sp, 4
loc_187B8:
	push	[bp+var_4E]
	call	sub_14E41
	add	sp, 2
	mov	[bp+var_E], ax
	cmp	ax, 1Bh
	jnz	short loc_187D3
	mov	[bp+var_114], 1
	jmp	short loc_18828
loc_187D3:
	mov	[bp+var_114], 0
	mov	[bp+var_52], 0
loc_187DE:
	mov	si, [bp+var_52]
	cmp	byte ptr [bp+si+var_1A], 0
	jz	short loc_18828
	mov	al, byte ptr [bp+si+var_1A]
	cbw
	cmp	ax, [bp+var_E]
	jz	short loc_187FA
	shl	si, 1
	mov	ax, [bp+var_E]
	cmp	[bp+si+var_C], ax
	jnz	short loc_18823
loc_187FA:
	call	clearTextWindow
	push	[bp+var_1C]
	push	[bp+arg_0]
	mov	bx, [bp+var_52]
	shl	bx, 1
	shl	bx, 1
	call	off_46C1A[bx]
	add	sp, 4
	mov	byte ptr word_44166,	0
	call	printRoster
	mov	[bp+var_114], 1
loc_18823:
	inc	[bp+var_52]
	jmp	short loc_187DE
loc_18828:
	cmp	[bp+var_114], 0
	jz	short loc_187B8
	jmp	loc_186A9
loc_18832:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printInventoryScreen endp

; Attributes: bp-based frame

inven_getInvOptions proc far

	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= dword ptr  6
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	si
	getCharIndex	ax, [bp+arg_4]
	mov	bx, [bp+arg_6]
	mov	cx, bx
	shl	bx, 1
	add	bx, cx
	add	bx, ax
	mov	al, gs:roster.inventory.itemFlags[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	al, byte ptr [bp+var_2]
	and	al, 3
	cmp	al, 1
	jnz	short loc_1886F
	mov	al, 1
	jmp	short loc_18871
loc_1886F:
	sub	al, al
loc_18871:
	lfs	bx, [bp+arg_0]
	mov	fs:[bx+3], al
	mov	[bp+var_4], 0
	jmp	short loc_18882
loc_1887F:
	inc	[bp+var_4]
loc_18882:
	cmp	[bp+var_4], 3
	jge	short loc_1889F
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx+3], 1
	sbb	ax, ax
	neg	ax
	mov	bx, [bp+var_4]
	mov	si, word ptr [bp+arg_0]
	mov	fs:[bx+si], al
	jmp	short loc_1887F
loc_1889F:
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+4], 0
	lfs	bx, [bp+arg_0]
	cmp	byte ptr fs:[bx], 0
	jz	short loc_188E3
	mov	al, byte ptr [bp+var_2]
	and	al, 3
	cmp	al, 2
	jnz	short loc_188BE
	mov	byte ptr fs:[bx+2], 0
loc_188BE:
	mov	al, byte ptr [bp+var_2]
	and	al, 0C0h
	cmp	al, 80h
	jnz	short loc_188E3
	getCharP	[bp+arg_4], bx
	cmp	gs:roster.class[bx], class_rogue
	jnz	short loc_188E3
	lfs	bx, [bp+arg_0]
	mov	byte ptr fs:[bx+4], 1
loc_188E3:
	pop	si
	mov	sp, bp
	pop	bp
	retf
inven_getInvOptions endp

; Attributes: bp-based frame

sub_188E8 proc far

	var_A= word ptr	-0Ah
	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= dword ptr  8
	arg_6= dword ptr  0Ch

	push	bp
	mov	bp, sp
	mov	ax, 0Ah
	call	someStackOperation
	push	si
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_18904
loc_18900:
	add	[bp+var_4], 3
loc_18904:
	cmp	[bp+var_4], inventorySize
	jl	short loc_1890D
	jmp	loc_18A2A
loc_1890D:
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	cmp	gs:roster.inventory.itemNo[bx],	0
	jnz	short loc_18927
	jmp	loc_18A22
loc_18927:
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	al, gs:roster.inventory.itemFlags[bx]
	sub	ah, ah
	mov	[bp+var_2], ax
	mov	bx, [bp+var_6]
	inc	[bp+var_6]
	shl	bx, 1
	shl	bx, 1
	lfs	si, [bp+arg_6]
	mov	ax, word ptr [bp+arg_2]
	mov	dx, word ptr [bp+arg_2+2]
	mov	fs:[bx+si], ax
	mov	fs:[bx+si+2], dx
	cmp	[bp+var_2], itemFlag_identified
	jl	short loc_18968
	test	byte ptr [bp+var_2], 3
	jnz	short loc_18968
	mov	[bp+var_2], 3
loc_18968:
	lfs	bx, [bp+arg_2]
	inc	word ptr [bp+arg_2]
	mov	si, [bp+var_2]
	and	si, 3
	mov	al, itemCharFlags[si]
	mov	fs:[bx], al
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	al, gs:roster.inventory.itemNo[bx]
	sub	ah, ah
	mov	[bp+var_A], ax
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	al, gs:roster.inventory.itemFlags[bx]
	sub	ah, ah
	push	ax
	push	[bp+var_A]
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	push	cs
	call	near ptr item_getName
	add	sp, 8
	mov	word ptr [bp+arg_2], ax
	mov	word ptr [bp+arg_2+2], dx
	getCharP	[bp+arg_0], bx
	add	bx, [bp+var_4]
	mov	al, gs:roster.inventory.itemCount[bx]
	sub	ah, ah
	mov	[bp+var_8], ax
	cmp	ax, 0FFh
	jz	short loc_18A16
	cmp	ax, 1
	jz	short loc_189F6
	push	ax
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	push	cs
	call	near ptr sub_18306
	add	sp, 6
	mov	word ptr [bp+arg_2], ax
	mov	word ptr [bp+arg_2+2], dx
	jmp	short loc_18A16
loc_189F6:
	mov	bx, [bp+var_A]
	cmp	byte_464B8[bx],	1
	jz	short loc_18A16
	push	[bp+var_8]
	push	word ptr [bp+arg_2+2]
	push	word ptr [bp+arg_2]
	push	cs
	call	near ptr sub_18306
	add	sp, 6
	mov	word ptr [bp+arg_2], ax
	mov	word ptr [bp+arg_2+2], dx
loc_18A16:
	lfs	bx, [bp+arg_2]
	inc	word ptr [bp+arg_2]
	mov	byte ptr fs:[bx], 0
	jmp	short loc_18A27
loc_18A22:
	mov	ax, [bp+var_6]
	jmp	short loc_18A2F
loc_18A27:
	jmp	loc_18900
loc_18A2A:
	mov	ax, [bp+var_6]
	jmp	short $+2
loc_18A2F:
	pop	si
	mov	sp, bp
	pop	bp
	retf
sub_188E8 endp

; Attributes: bp-based frame

item_getName proc far

	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	itemNo=	word ptr  0Ah
	itemFlags= byte	ptr  0Ch

	push	bp
	mov	bp, sp
	mov	ax, 2
	call	someStackOperation
	test	[bp+itemFlags],	itemFlag_identified
	jz	short loc_18A74
	mov	bx, [bp+itemNo]
	mov	al, itemTypeList[bx]
	sub	ah, ah
	and	ax, 0Fh
	mov	[bp+var_2], ax
	mov	bx, ax
	shl	bx, 1
	shl	bx, 1
	push	word ptr (genericItemStr+2)[bx]
	push	word ptr genericItemStr[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcat
	add	sp, 8
	jmp	short loc_18A93
	jmp	short loc_18A93
loc_18A74:
	mov	bx, [bp+itemNo]
	shl	bx, 1
	shl	bx, 1
	push	word ptr (itemStr+2)[bx]
	push	word ptr itemStr[bx]
	push	[bp+arg_2]
	push	[bp+arg_0]
	call	_strcat
	add	sp, 8
	jmp	short $+2
loc_18A93:
	mov	sp, bp
	pop	bp
	retf
item_getName endp

; Attributes: bp-based frame

printCharStats proc far

	var_DC=	word ptr -0DCh
	var_28=	word ptr -28h
	var_26=	word ptr -26h
	var_1C=	word ptr -1Ch
	var_1A=	dword ptr -1Ah
	var_16=	dword ptr -16h
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 0DEh 
	call	someStackOperation
	push	si
	call	clearTextWindow
	getCharP	[bp+arg_0], bx
	lea	ax, roster._name[bx]
	mov	dx, seg	seg027
	push	dx
	push	ax
	lea	ax, [bp+var_DC]
	push	ss
	push	ax
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_illusion
	jz	short loc_18AE6
	mov	ax, 1
	jmp	short loc_18AE8
loc_18AE6:
	sub	ax, ax
loc_18AE8:
	push	ax
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	mov	ax, offset aIsAN
	push	ds
	push	ax
	call	str_pluralize
	add	sp, 0Ah
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	mov	byte ptr fs:[bx], 20h
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], 0Dh
	jb	short loc_18B20
	jmp	loc_18BE9
loc_18B20:
	mov	ax, offset aLevel
	push	ds
	push	ax
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	mov	ax, 3
	push	ax
	getCharP	[bp+arg_0], bx
	sub	ax, ax
	push	ax
	push	gs:roster.level[bx]
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	inc	word ptr [bp+var_1A]
	mov	byte ptr fs:[bx], 20h
	getCharP	[bp+arg_0], bx
	mov	bl, gs:roster.gender[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (genderString+2)[bx]
	push	word ptr genderString[bx]
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	inc	word ptr [bp+var_1A]
	mov	byte ptr fs:[bx], 20h
	getCharP	[bp+arg_0], bx
	mov	bl, gs:roster.race[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (raceString+2)[bx]
	push	word ptr raceString[bx]
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	lfs	bx, [bp+var_1A]
	inc	word ptr [bp+var_1A]
	mov	byte ptr fs:[bx], 20h
loc_18BE9:
	getCharP	[bp+arg_0], bx
	mov	bl, gs:roster.class[bx]
	sub	bh, bh
	shl	bx, 1
	shl	bx, 1
	push	word ptr (classString+2)[bx]
	push	word ptr classString[bx]
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_1A], ax
	mov	word ptr [bp+var_1A+2],	dx
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jnb	short loc_18C9F
	getCharIndex	ax, [bp+arg_0]
	add	ax, offset roster.strength
	mov	word ptr [bp+var_16], ax
	mov	word ptr [bp+var_16+2],	seg seg027
	mov	[bp+var_28], 0
	jmp	short loc_18C51
loc_18C4E:
	inc	[bp+var_28]
loc_18C51:
	cmp	[bp+var_28], 5
	jge	short loc_18C6B
	mov	bx, [bp+var_28]
	lfs	si, [bp+var_16]
	mov	al, fs:[bx+si]
	sub	ah, ah
	mov	si, bx
	shl	si, 1
	mov	[bp+si+var_26],	ax
	jmp	short loc_18C4E
loc_18C6B:
	getCharP	[bp+arg_0], bx
	mov	ax, gs:roster.currentHP[bx]
	mov	[bp+var_1C], ax
	lfs	bx, [bp+var_1A]
	inc	word ptr [bp+var_1A]
	mov	byte ptr fs:[bx], 0Ah
	mov	ax, 5
	push	ax
	push	word ptr [bp+var_1A+2]
	push	word ptr [bp+var_1A]
	lea	ax, [bp+var_26]
	push	ss
	push	ax
	push	cs
	call	near ptr getAttributeString
	add	sp, 0Ah
loc_18C9F:
	lea	ax, [bp+var_DC]
	push	ss
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jnb	short loc_18D0B
	lea	ax, [bp+var_DC]
	push	ss
	push	ax
	getCharP	[bp+arg_0], bx
	sub	ax, ax
	push	ax
	push	gs:roster.maxSppt[bx]
	mov	ax, offset aSpellPoints
	push	ds
	push	ax
	push	cs
	call	near ptr printNumberAndString
	add	sp, 0Ch
	lea	ax, [bp+var_DC]
	push	ss
	push	ax
	getCharP	[bp+arg_0], bx
	push	word ptr gs:(roster.experience+2)[bx]
	push	word ptr gs:roster.experience[bx]
	mov	ax, offset aExpr
	push	ds
	push	ax
	push	cs
	call	near ptr printNumberAndString
	add	sp, 0Ch
loc_18D0B:
	lea	ax, [bp+var_DC]
	push	ss
	push	ax
	getCharP	[bp+arg_0], bx
	push	word ptr gs:(roster.gold+2)[bx]
	push	word ptr gs:roster.gold[bx]
	mov	ax, offset aGold
	push	ds
	push	ax
	push	cs
	call	near ptr printNumberAndString
	add	sp, 0Ch
	mov	ax, offset aPoolGoldTradeG
	push	ds
	push	ax
	call	printString
	add	sp, 4
	mov	ax, offset aEscToContinue
	push	ds
	push	ax
	call	printString
	add	sp, 4
	pop	si
	mov	sp, bp
	pop	bp
	retf
printCharStats endp

; Attributes: bp-based frame

printNumberAndString proc far

	var_4= dword ptr -4
	arg_0= word ptr	 6
	arg_2= word ptr	 8
	arg_4= word ptr	 0Ah
	arg_6= word ptr	 0Ch
	arg_8= word ptr	 0Eh
	arg_A= word ptr	 10h

	push	bp
	mov	bp, sp
	mov	ax, 4
	call	someStackOperation
	push	[bp+arg_2]
	push	[bp+arg_0]
	push	[bp+arg_A]
	push	[bp+arg_8]
	call	_strcat
	add	sp, 8
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	sub	ax, ax
	push	ax
	push	[bp+arg_6]
	push	[bp+arg_4]
	push	dx
	push	word ptr [bp+var_4]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], dx
	lfs	bx, [bp+var_4]
	mov	byte ptr fs:[bx], 0
	push	[bp+arg_A]
	push	[bp+arg_8]
	call	printString
	add	sp, 4
	mov	sp, bp
	pop	bp
	retf
printNumberAndString endp

; Attributes: bp-based frame
getAttributeString proc	far

	var_8= word ptr	-8
	var_6= word ptr	-6
	var_4= dword ptr -4
	arg_0= dword ptr  6
	arg_4= dword ptr  0Ah
	arg_8= word ptr	 0Eh

	push	bp
	mov	bp, sp
	mov	ax, 8
	call	someStackOperation
	mov	ax, offset aStiqdxcnlkhp
	mov	word ptr [bp+var_4], ax
	mov	word ptr [bp+var_4+2], ds
	mov	[bp+var_8], 0
	jmp	short loc_18DC9
loc_18DC6:
	inc	[bp+var_8]
loc_18DC9:
	mov	ax, [bp+arg_8]
	cmp	[bp+var_8], ax
	jl	short loc_18DD4
	jmp	loc_18E54
loc_18DD4:
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	al, fs:[bx]
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	fs:[bx], al
	lfs	bx, [bp+var_4]
	inc	word ptr [bp+var_4]
	mov	al, fs:[bx]
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	fs:[bx], al
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 3Ah
	lfs	bx, [bp+arg_0]
	add	word ptr [bp+arg_0], 2
	mov	ax, fs:[bx]
	mov	[bp+var_6], ax
	cmp	ax, 63h	
	jle	short loc_18E19
	mov	[bp+var_6], 63h	
loc_18E19:
	cmp	[bp+var_6], 0Ah
	jge	short loc_18E29
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 20h ;	' '
loc_18E29:
	mov	ax, 2
	push	ax
	mov	ax, [bp+var_6]
	cwd
	push	dx
	push	ax
	push	word ptr [bp+arg_4+2]
	push	word ptr [bp+arg_4]
	call	_itoa
	add	sp, 0Ah
	mov	word ptr [bp+arg_4], ax
	mov	word ptr [bp+arg_4+2], dx
	lfs	bx, [bp+arg_4]
	inc	word ptr [bp+arg_4]
	mov	byte ptr fs:[bx], 20h
	jmp	loc_18DC6
loc_18E54:
	lfs	bx, [bp+arg_4]
	mov	byte ptr fs:[bx], 0
	mov	sp, bp
	pop	bp
	retf
getAttributeString endp

; Attributes: bp-based frame

getGoldTradee proc far

	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	mov	ax, 6
	call	someStackOperation
	push	si
	call	clearTextWindow
	mov	ax, offset aTradeGoldToWho
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	getCharNumber
	mov	[bp+var_2], ax
	or	ax, ax
	jl	short loc_18E91
	mov	ax, [bp+arg_2]
	cmp	[bp+var_2], ax
	jle	short loc_18E94
loc_18E91:
	jmp	loc_18F1E
loc_18E94:
	call	clearTextWindow
	mov	ax, offset aHowMuchGoldWil
	push	ds
	push	ax
	call	printString
	add	sp, 4
	call	sub_16001
	mov	[bp+var_6], ax
	mov	[bp+var_4], dx
	or	dx, ax
	jnz	short loc_18EB7
	jmp	short loc_18F1E
loc_18EB7:
	push	[bp+var_4]
	push	[bp+var_6]
	push	[bp+arg_0]
	call	payGold
	add	sp, 6
	or	ax, ax
	jnz	short loc_18EE0
	call	clearTextWindow
	mov	ax, offset aNotEnoughGold_
	push	ds
	push	ax
	call	printString
	add	sp, 4
	jmp	short loc_18F1E
loc_18EE0:
	mov	ax, [bp+var_6]
	mov	dx, [bp+var_4]
	mov	cx, ax
	mov	bx, dx
	getCharP	[bp+var_2], si
	add	word ptr gs:roster.gold[si], cx
	adc	word ptr gs:(roster.gold+2)[si], bx
	call	clearTextWindow
	mov	ax, offset aDone
	push	ds
	push	ax
	call	printString
	add	sp, 4
	wait4IO
loc_18F1E:
	pop	si
	mov	sp, bp
	pop	bp
	retf
getGoldTradee endp

; Attributes: bp-based frame
printCharAbilities proc	far

	var_206= word ptr -206h
	var_204= word ptr -204h
	var_6= word ptr	-6
	var_4= word ptr	-4
	var_2= word ptr	-2
	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	mov	ax, 206h
	call	someStackOperation
	push	si
	getCharP	[bp+arg_0], bx
	mov	al, gs:[bx+5Bh]
	sub	ah, ah
	jmp	loc_190D5
loc_18F45:
	mov	ax, offset aRogueAbilities
	push	ds
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.specAbil[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aDisarmTraps
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	getCharP	[bp+arg_0], bx
	mov	al, gs:(roster.specAbil+1)[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aIdentifyChest
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	getCharP	[bp+arg_0], bx
	mov	al, gs:(roster.specAbil+1)[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aIdentifyItem
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	getCharP	[bp+arg_0], bx
	mov	al, gs:(roster.specAbil+2)[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aHideInShadows
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	getCharP	[bp+arg_0], bx
	mov	al, gs:(roster.specAbil+2)[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aCriticalHit
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	jmp	loc_190F0
loc_18FFA:
	mov	ax, offset aBardAbilities
	push	ds
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.specAbil[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aNumberOfTunesL
	push	ds
	push	ax
	call	sub_161C5
	add	sp, 6
	jmp	loc_190F0
loc_1902B:
	mov	ax, offset aHunterAbilitie
	push	ds
	push	ax
	call	printString
	add	sp, 4
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.specAbil[bx]
	sub	ah, ah
	push	ax
	mov	ax, offset aCriticalHit
	push	ds
	push	ax
	call	sub_1621C
	add	sp, 6
	jmp	loc_190F0
loc_1905C:
	mov	[bp+var_6], 0
	mov	[bp+var_4], 0
	jmp	short loc_1906B
loc_19068:
	inc	[bp+var_4]
loc_1906B:
	cmp	[bp+var_4], 7Eh	
	jge	short loc_190A5
	push	[bp+var_4]
	push	[bp+arg_0]
	push	cs
	call	near ptr mage_hasLearnedSpell
	add	sp, 4
	or	ax, ax
	jz	short loc_190A3
	mov	bx, [bp+var_4]
	mov	cl, 3
	shl	bx, cl
	mov	ax, word ptr spellString.fullName[bx]
	mov	dx, word ptr (spellString.fullName+2)[bx]
	mov	si, [bp+var_6]
	inc	[bp+var_6]
	shl	si, 1
	shl	si, 1
	mov	[bp+si+var_206], ax
	mov	[bp+si+var_204], dx
loc_190A3:
	jmp	short loc_19068
loc_190A5:
	cmp	[bp+var_6], 0
	jz	short loc_190C6
	push	[bp+var_6]
	lea	ax, [bp+var_206]
	push	ss
	push	ax
	mov	ax, offset aKnownSpells
	push	ds
	push	ax
	call	text_scrollingWindow
	add	sp, 0Ah
	mov	[bp+var_2], ax
	jmp	l_printCharAbilities_exitNoKey
loc_190C6:
	mov	ax, offset aYouDonTKnowAny
	push	ds
	push	ax
	call	printString
	add	sp, 4
loc_190D3:
	jmp	short loc_190F0
loc_190D5:
	cmp	ax, class_rogue
	jnz	short loc_190DD
	jmp	loc_18F45
loc_190DD:
	cmp	ax, offset word_42676
	jnz	short loc_190E5
	jmp	loc_18FFA
loc_190E5:
	cmp	ax, 8
	jnz	short loc_190ED
	jmp	loc_1902B
loc_190ED:
	jmp	loc_1905C
loc_190F0:
	wait4IO
l_printCharAbilities_exitNoKey:
	pop	si
	mov	sp, bp
	pop	bp
	retf
printCharAbilities endp

; Attributes: bp-based frame

mage_hasLearnedSpell proc far

	charNo=	word ptr  6
	spell= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+charNo], bx
	mov	ax, [bp+spell]
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	mov	al, gs:roster.spells[bx]
	sub	ah, ah
	mov	bx, [bp+spell]
	and	bx, 7
	mov	cl, byteMaskList[bx]
	sub	ch, ch
	and	ax, cx
	jmp	short $+2
	mov	sp, bp
	pop	bp
	retf
mage_hasLearnedSpell endp

; Attributes: bp-based frame

mage_learnSpell	proc far

	charNo=	word ptr  6
	arg_2= word ptr	 8

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	mov	bx, [bp+arg_2]
	and	bx, 7
	mov	al, byteMaskList[bx]
	mov	cx, ax
	getCharP	[bp+charNo], bx
	mov	ax, [bp+arg_2]
	mov	dx, cx
	mov	cl, 3
	sar	ax, cl
	add	bx, ax
	or	gs:roster.spells[bx], dl
	mov	sp, bp
	pop	bp
	retf
mage_learnSpell	endp

; This function	returns	one if the character class
; has special abilities	that need to be	printed
; Attributes: bp-based frame

charHasSpecialAbils proc far

	arg_0= word ptr	 6

	push	bp
	mov	bp, sp
	xor	ax, ax
	call	someStackOperation
	getCharP	[bp+arg_0], bx
	cmp	gs:roster.class[bx], class_monster
	jb	short loc_1919D
	sub	ax, ax
	jmp	short loc_191C9
loc_1919D:
	getCharP	[bp+arg_0], bx
	mov	al, gs:roster.class[bx]
	sub	ah, ah
	jmp	short loc_191B9
loc_191AE:
	sub	ax, ax
	jmp	short loc_191C9
loc_191B2:
	mov	ax, 1
	jmp	short loc_191C9
	jmp	short loc_191C9
loc_191B9:
	or	ax, ax
	jz	short loc_191AE
	cmp	ax, class_paladin
	jz	short loc_191AE
	cmp	ax, class_monk
	jz	short loc_191AE
	jmp	short loc_191B2
loc_191C9:
	mov	sp, bp
	pop	bp
locret_191CC:
	retf
charHasSpecialAbils endp

seg006 ends
