.section .rodata


.text
.globl run_func
.type run_func, @function
run_func:
        # option in %eax, first pstring in %rsi, second pstring in %rdi

        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        cmpl    $31, (%eax)       # check if option = 31
        je      LENGTH
        cmpl    $32, (%eax)       # check if option = 31
        je      REPLACE
        cmpl    $33, (%eax)       # check if option = 31
        je      REPLACE
        cmpl    $35, (%eax)       # check if option = 31
        je      COPY
        cmpl    $36, (%eax)       # check if option = 31
        je      SWAP
        cmpl    $37, (%eax)       # check if option = 31
        je      COMPARE
        jmp END

LENGTH:
        jmp END

REPLACE:
    jmp END

COPY:
    jmp END

SWAP:
    jmp END

COMPARE:
    jmp END


END:



        movq    %rbp, %rsp
        popq    %rbp
        ret

