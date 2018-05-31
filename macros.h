func_enter	macro
	push	bp
	mov	bp, sp
	endm

func_exit	macro
	mov	sp, bp
	pop	bp
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
	call	far ptr getKey
	add	sp, 2
	endm

delayWithTable	macro
	call	text_delayWithTable
	endm

delayNoTable	macro _count
	push_imm	_count
	std_call	text_delayNoTable, 2
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

near_call	macro _func,_sp_add
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
