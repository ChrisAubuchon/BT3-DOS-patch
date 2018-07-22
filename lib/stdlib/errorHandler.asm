errorHandler	proc far
                push    ds
                push    es
                push    bx
                push    cx
                push    dx
                push    si
                push    di
                push    bp
                mov     ds, cs:g_savedDsRegister
                pop     bp
                pop     di
                pop     si
                pop     dx
                pop     cx
                pop     bx
                pop     es
                pop     ds
                iret
errorHandler       endp
