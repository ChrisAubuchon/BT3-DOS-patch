include(`foreachq4.m4')dnl
divert(`-1')

# Function entry code
#
define(`FUNC_ENTER', `push	bp
	mov	bp, sp')

# Function exit code
#
define(`FUNC_EXIT', `mov	sp, bp
	pop	bp')

# CHKSTK([stack space used])
#
define(`CHKSTK', `ifelse(`$1', `', `xor	ax, ax', `mov	ax, $1')
	call	someStackOperation')dnl

# PUSH(value)
#
define(`PUSH', `push	$1')

# CALL(function_name, [stack fixup value])
#
define(`CALL', `call	$1
ifelse(`$2', `', `dnl', `	add	sp, $2')')

# NEAR_CALL(function_name, [stack fixup value])
#
define(`NEAR_CALL', `PUSH(`cs')
	call	near ptr $1
ifelse(`$2', `', `dnl', `	add	sp, $2')')dnl

# STACKVAR(stackVariableName)
#
define(`STACKVAR', `[bp+$1]')dnl

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

# PUSHE
define(`PUSHE', `foreachq(`x', `$@', `push	x
	')')dnl
#define(`PUSHE', `forloop(`x', `1', `$#', `ifelse(`x', `1', `dnl', `
#	')push	``$x''')')

# PUSH_IMM(value)
#
define(`PUSH_IMM', `ifelse(`$1', `', `errprint(`No value passed to PUSH_IMM')', `mov	ax, $1
	push	ax')')

# PUSH_OFFSET(offset)
#
define(`PUSH_OFFSET', `mov	ax, offset $1
	push	ds
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
	CALL(getKey, 2)')

# GETKEY
#
define(`GETKEY', `CALL(getKey, 2)')

# OPEN([destination])
#
define(`OPEN', `CALL(_open, 6)
ifelse(`$1', `', `dnl', `	mov	$1, ax')')

# WRITE
#
define(`WRITE', `CALL(_write, 8)')

# READ
#
define(`READ', `CALL(_read, 8)')

# CLOSE
#
define(`CLOSE', `CALL(_close, 2)')

# PRINTSTRING([clear])
#
define(`PRINTSTRING', `ifelse(`$1', `true', `CALL(printStringWClear, 4)', `CALL(printString,4)')')

# DELAY([count]
#
define(`DELAY', `ifelse(`$1', `', `CALL(text_delayWithTable)', `PUSH_IMM($1)
	CALL(text_delayNoTable, 2)')')

# STRCAT([destination])
#
define(`STRCAT', `CALL(_strcat, 8)
ifelse(`$1', `', `dnl', `	SAVE_PTR_STACK(dx,ax,$1)')')

# STRCMP
#
define(`STRCMP', `CALL(_strcmp, 8)')

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
define(`ITOA', `CALL(_itoa, 0Ah)
ifelse(`$1', `', `dnl', `	SAVE_PTR_STACK(dx,ax,$1)')')

# PLURALIZE([destination])
#
define(`PLURALIZE', `CALL(str_pluralize, 0Ah)
ifelse(`$1', `', `dnl',	`	SAVE_PTR_STACK(dx,ax,$1)')')

# RANGE_WITH_MAX(maximum, srcreg, tmpreg)
#
define(`RANGE_WITH_MAX', `sub	$2, $1
	sbb	$3, $3
	and	$2, $3
	add	$2, $1')

divert`'dnl
