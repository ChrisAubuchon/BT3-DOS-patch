huf_dataSize		dd 0
huf_nodeListTail	dw 0
huf_fileHandle		dw 0
huf_fileBuffer		db 200h dup(0)
huf_fileBufferIndex	dw 0
huf_bitMask		db 0
huf_currentByte		db 0
huf_treeData		db 0F05h dup(0)
huf_bufferP		dw 0
huf_flateSize		dw 0
huf_flateByteCount	dw 0
