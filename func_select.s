.section .rodata


.section .rodata # Read only data section
format_length:  .string    "first pstring length: %d, second pstring length: %d\n"
format_get_char:    .string     "%c"
format_replace: .string    "old char: %c, new char: %c, first string: %s, second string: %s\n"



.data
newChar:    .byte 0
oldChar:    .byte 0
trash:      .byte 0

.text
.globl run_func
.type run_func, @function
run_func:
        # option in %edi, first pstring in %rsi, second pstring in %rdx

        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging


     #   push    %rdx

        cmpl    $31, %edi     # check if option = 31
        je      LENGTH
        cmpl    $32, %edi     # check if option = 32
        je      REPLACE
        cmpl    $33, %edi     # check if option = 33
        je      REPLACE
        cmpl    $35, %edi     # check if option = 35
        je      COPY
        cmpl    $36, %edi     # check if option = 36
        je      SWAP
        cmpl    $37, %edi     # check if option = 37
        je      COMPARE
        jmp END

LENGTH:
        movq    %r12, %rdi  # contains the pointer to the first pstring
        call    pstrlen     # return the length of the first pstring. Saved in %rax
        movq    %rax, %rsi   # Save the length of the first pstring in %rsi.

        movq    %r13, %rdi  # contains the pointer to the second pstring
        call    pstrlen     # return the length of the second pstring. Saved in %rax
        movq    %rax, %rdx   # Save the length of the second pstring in %rdx.

        movq	$format_length, %rdi	# load format for printf
        movq	$0, %rax
        call	printf

        jmp END

REPLACE:
        push    %r13        # because it is callee
        push    %r14        # because it is callee
        movq    %rsi, %r13  # save the first pstring
        movq    %rdx, %r14  # save the second pstring

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $trash, %rsi      # define that the value from scanf will be saved in trash
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        call    scanf           # get the \n from the previous scanf

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $0, %rax            # clear AL (zero FP args in XMM registers)
        movq    $oldChar, %rsi      # define that the value from scanf will be saved in oldChar
        call    scanf               # get the old char

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $trash, %rsi      # define that the value from scanf will be saved in trash
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        call    scanf           # get the space from the previous scanf

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $0, %rax            # clear AL (zero FP args in XMM registers)
        movq    $newChar, %rsi      # define that the value from scanf will be saved in n1
        call    scanf               # get the new char. Saved in %rsi

        movq    $0, %rsi
        movb    (newChar), %sil     # define that the value from scanf will be saved in n1
        movq    $0, %rdx
        movb    (oldChar), %dl      # %rdx contains the old char
        movq    %r13, %rdi      # saved the pointer to the first pstring.
        call    replaceChar     # %rax contains the pstring after the switch.
        movq    %rax, %r13      # contains the first pstring after the switch.

     #   movq    $oldChar, %rdx      # %rdx contains the old char
     #   movq    $newChar, %rsi       # define that the value from scanf will be saved in n1
     #   movq    %rbp, %rdi       # saved the pointer to the first pstring in %rdi.
      #  call    replaceChar     # %rax contains the pstring after the switch.
      #  movq    %rax, %rbp       # %r9 contains the first pstring after the switch.

        movq	$format_replace, %rdi	# load format for printf
        movq    (oldChar), %rsi      # %rdx contains the old char
        movq    (newChar), %rdx       # define that the value from scanf will be saved in n1
        movq    %r13, %rcx
        movq    %r14, %r8
        movq	$0, %rax
        call	printf

        popq    %r13    # because it is a callee
        popq    %r14    # because it is a callee

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

