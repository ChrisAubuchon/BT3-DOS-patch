include(`foreachq4.m4')dnl
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
define(`FUNC_EXIT', `mov	sp, bp
	pop	bp')

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

# PUSH_STACK_PTR(var)
#
define(`PUSH_STACK_PTR', `push	word ptr [bp+$1+2]
	push	word ptr [bp+$1]')

# PUSH_STACK_ADDRESS(variable)
#
define(`PUSH_STACK_ADDRESS', `lea	ax, [bp+$1]
	push	ss
	push	ax')dnl

# SAVE_PTR_STACK(segment, offset, destination)
#
define(`SAVE_PTR_STACK', `mov	word ptr [bp+$3], $2
	mov	word ptr [bp+$3+2], $1')

# IOWAIT
#
define(`IOWAIT', `mov	ax, 4000h
	push	ax
	CALL(getKey)')

# PRINTSTRING([clear])
#
define(`PRINTSTRING', `ifelse(`$1', `true', `CALL(printStringWClear)', `CALL(printString)')')

# DELAY([count]
#
define(`DELAY', `ifelse(`$1', `', `CALL(text_delayWithTable)', `PUSH_IMM($1)
	CALL(text_delayNoTable)')')

# STRCAT([destination])
#
define(`STRCAT', `CALL(strcat)
ifelse(`$1', `', `dnl', `	SAVE_PTR_STACK(dx,ax,$1)')')

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
ifelse(`$1', `', `dnl', `	SAVE_PTR_STACK(dx,ax,$1)')')

# PLURALIZE([destination])
#
define(`PLURALIZE', `CALL(str_pluralize)
ifelse(`$1', `', `dnl',	`	SAVE_PTR_STACK(dx,ax,$1)')')

# RANGE_WITH_MAX(maximum, srcreg, tmpreg)
#
define(`RANGE_WITH_MAX', `sub	$2, $1
	sbb	$3, $3
	and	$2, $3
	add	$2, $1')

divert`'dnl
