func_enter	macro
	push	bp
	mov	bp, sp
	endm

func_exit	macro
	mov	sp, bp
	pop	bp
	endm

func_return	macro	_rval
	mov	ax, _rval
	endm

null_terminate	macro inString
	lfs	bx, dword ptr inString
	inc 	word ptr inString
	mov	byte ptr fs:[bx], 0
	endm

dword_appendChar	macro _dword,_char
	lfs	bx, [bp+_dword]
	inc	word ptr [bp+_dword]
	mov	byte ptr fs:[bx], _char
	endm

getCharIndex	macro srcreg, mult
	mov	srcreg, charSize
	imul	mult
	endm

getCharP	macro mult, dest
	getCharIndex ax, mult
	mov	dest, ax
	endm

getMonIndex	macro srcreg, mult
	mov	srcreg, monStruSize
	imul	mult
	endm

getMonP		macro mult, dest
	getMonIndex ax, mult
	mov	dest, ax
	endm

wait4IO		macro
	mov	ax, 4000h
	push	ax
	call	far ptr sub_14E41
	add	sp, 2
	endm

delayNoTable	macro _count
	push_imm	_count
	std_call	getIOwithDelay, 2
	endm

do_strcat	macro _dest
	std_call	_strcat, 8
	save_ptr_stack	dx,ax,_dest
	endm

strcat_offset	macro src,dest
	mov	ax, offset src
	push	ds
	push	ax
	push	word ptr [bp+dest+2]
	push	word ptr [bp+dest]
	do_strcat	dest
	endm

save_ptr_stack	macro _segment,_off,_dest
	mov	word ptr [bp+_dest], _off
	mov	word ptr [bp+_dest+2], _segment
	endm

push_imm	macro _imm
	mov	ax, _imm
	push	ax
	endm

push_var_stack	macro _src
	push	[bp+_src]
	endm

push_reg	macro _reg
	push _reg
	endm

push_ptr_stack	macro _src
	push	word ptr [bp+_src+2]
	push	word ptr [bp+_src]
	endm

push_ptr_stringList	macro _src,_reg
	push	word ptr (_src+2)[_reg]
	push	word ptr _src[_reg]
	endm

push_ds_string	macro _str
	mov	ax, offset _str
	push	ds
	push	ax
	endm

push_ss_string	macro _str
	lea	ax, [bp+_str]
	push	ss
	push	ax
	endm

push_seg_ptr	macro _seg, _off
	mov	ax, offset _off
	mov	dx, seg _seg
	push	dx
	push	ax
	endm

far_call	macro _func,_sp_add
	push	cs
	call	near ptr _func
	add	sp, _sp_add
	endm

std_call	macro _func,_sp_add
	call	_func
	add	sp, _sp_add
	endm

_chkstk		macro _size
	mov	ax, _size
	call	someStackOperation
	endm

; Function calls
func_printString	macro
	std_call	printString, 4
	endm

func_readString		macro
	std_call	_readString, 6
	endm

func_strcat		macro
	std_call	_strcat, 8
	endm

func_strncpy	macro
	std_call	_strncpy, 0Ah
	endm

func_dun_maskSquare	macro
	std_call	dun_maskSquare, 8
	endm

func_read		macro
	std_call	_read, 8
	endm

func_lseek		macro
	std_call	_lseek, 8
	endm

func_close		macro
	std_call	_close, 2
	endm

func_readLevelData	macro
	std_call	readLevelData, 6
	endm

func_readGraphicsMaybe	macro
	std_call	readGraphicsMaybe, 2
	endm

func_readMonsterFile	macro
	std_call	readMonsterFile, 2
	endm
