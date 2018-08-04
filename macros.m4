divert(`-1')
include(`functionTable.m4')

# Function entry code
#
define(`FUNC_ENTER', `push	bp
	mov	bp, sp
ifelse(`$1', `', `dnl', `	mov	ax, $1
	call	someStackOperation')')

# Function exit code
#
define(`FUNC_EXIT', `ifelse(`$#', `0', `mov	sp, bp
	pop	bp', `pop	bp')')


# PUSH(value)
#
define(`PUSH', `push	$1')

# STACKVAR(stackVariableName)
#
define(`STACKVAR', `[bp+$1]')dnl

# SEGMENT(segmentName)
#
define(`SEGMENT', `seg $1')

# CHARINDEX(scratchRegister, multiplier, [destination])
#
define(`CHARINDEX', `mov	$1, charSize
	imul	$2
ifelse(`$3', `', `dnl', `	mov	$3, ax')')dnl

# MONINDEX(scratchRegister, multiplier, [destination])
#
define(`MONINDEX', `mov	$1, monStruSize
	imul	$2
ifelse(`$3', `', `dnl', `	mov	$3, ax')')dnl

# PUSH_IMM(value)
#
define(`PUSH_IMM', `ifelse(`$1', `', `errprint(`No value passed to PUSH_IMM')', `mov	ax, $1
	push	ax')')

# PUSH_OFFSET(offset)
#
define(`PUSH_OFFSET', `mov	ax, offset $1
ifelse(`$2', `', `	push	ds', `	mov	dx, $2
	push	dx')
	push	ax')dnl

# PUSH_STACK_DWORD(var)
#
define(`PUSH_STACK_DWORD', `push	word ptr [bp+$1+2]
	push	word ptr [bp+$1]')

# PUSH_STACK_ADDRESS(variable)
#
define(`PUSH_STACK_ADDRESS', `lea	ax, [bp+$1]
	push	ss
	push	ax')dnl

# SAVE_STACK_DWORD(segment, offset, variable)
#
define(`SAVE_STACK_DWORD', `mov	word ptr [bp+$3], $2
	mov	word ptr [bp+$3+2], $1')

# IOWAIT
#
define(`IOWAIT', `mov	ax, 4000h
	push	ax
	CALL(getKey)')

# PRINTSTRING([clear])
#
define(`PRINTSTRING', `ifelse(`$1', `true', `CALL(printStringWClear)', `ifelse(`$1', `wait', `CALL(printStringWithWait)', `ifelse(`$1', `clear', `CALL(printStringWClear)', `CALL(printString)')')')')

# PRINTOFFSET(offset, [clear|wait])
#
define(`PRINTOFFSET', `ifelse(`$1', `', `errprint(`No argument passed to PRINTOFFSET
')', `')PUSH_OFFSET(`$1')
	PRINTSTRING(`$2')')')

# DELAY([count])
#
define(`DELAY', `ifelse(`$1', `', `CALL(text_delayWithTable)', `PUSH_IMM($1)
	CALL(text_delayNoTable)')')

# STRCAT([destination])
#
define(`STRCAT', `CALL(strcat)
ifelse(`$1', `', `dnl', `	SAVE_STACK_DWORD(dx,ax,$1)')')

# STRCMP
#
define(`STRCMP', `CALL(strcmp)')

# APPEND_CHAR(address, char)
#
define(`APPEND_CHAR', `lfs	bx, dword ptr $1
	inc	word ptr $1
	mov	byte ptr fs:[bx], $2')

# NULL_TERMINATE(stringP)
#
define(`NULL_TERMINATE', `ifelse(`$1', `', `errprint(`No argument passed to NULL_TERMINATE
')', `')lfs	bx, dword ptr $1
	inc	word ptr $1
	mov	byte ptr fs:[bx], 0')

# ITOA([destination])
#
define(`ITOA', `CALL(itoa)
ifelse(`$1', `', `dnl', `	SAVE_STACK_DWORD(dx,ax,$1)')')

# PLURALIZE([destination])
#
define(`PLURALIZE', `CALL(str_pluralize)
ifelse(`$1', `', `dnl',	`	SAVE_STACK_DWORD(dx,ax,$1)')')

# RANGE_WITH_MAX(maximum, srcreg, tmpreg)
#
define(`RANGE_WITH_MAX', `sub	$2, $1
	sbb	$3, $3
	and	$2, $3
	add	$2, $1')

# REGISTER_TRIPLE(srcReg, tmpReg)
#
# Multiply srcReg by 3 without using mul/imul
#
define(`REGISTER_TRIPLE', `mov	$2, $1
	shl	$1, 1
	add	$1, $2')

# REGISTER_MULTIPLY_FIVE(srcReg, destReg)
#
# Multiply srcReg by 5 without using mul/imul
#
define(`REGISTER_MULTIPLY_FIVE', `mov	$2, $1
	shl	$1, 1
	shl	$1, 1
	add	$1, $2
	mov	$2, $1')


# BITMASK(flag, ...)
#   ORs all arguments into one number. Intel style hex numbers are converted
# to base 10 numbers. The end result is converted back to an Intel style hex
# string
#
define(`BITMASK', `toIntel(_bitmask(`0', $@))')dnl
define(`_bitmask', `ifelse(`$#', `1', fromIntel($1), `ifelse(`$2', `', `$0($1)', `$0(`eval($1 | fromIntel($2))', shift(shift($@)))')')')

# DICE_XDY(number_of_dice, dice_value)
#   e.g. DICE_XDY(10, dice_d4)
#
define(`DICE_XDY', `BITMASK(eval($2 << 5), eval($1 - 1))')

# QUESTFLAG(bit, byte)
#   e.g. QUESTFLAG(questBit_2, questByte_7)
#
define(`QUESTFLAG', `BITMASK(eval($2 << 3), $1)')


# Convert a base 10 number to an Intel style hexadecimal number
#
define(`toIntel', `ifelse(regexp(`$1', `^[0-9]$'), `0', `$1', ifelse(regexp(format(`%X', `$1'), `^[A-F]'), `-1', format(`%Xh', `$1'), format(`0%Xh', `$1')))')

# Convert an Intel style hexadecimal number to a base 10 number
#
define(`fromIntel', `ifelse(regexp(`$1', `h$'), `-1', `$1', format(`%d', eval(`0x'patsubst(`$1', `h$', `'))))')

divert`'dnl
