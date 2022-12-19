.section .rodata


.section .rodata # Read only data section
format_length:          .string     "first pstring length: %d, second pstring length: %d\n"
format_get_char:        .string     "%c"
format_replace:         .string     "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_scanf_number:    .string     "%d"
format_cpy:             .string     "length: %d, string: %s\n"
format_swp:             .string     "length: %d, string: %s\n"

.data
newChar:    .byte 0
oldChar:    .byte 0
trash:      .byte 0
i:          .double 0
j:          .double 0

.text
.globl run_func
.type run_func, @function
run_func:
        # option in %edi, first pstring in %rsi, second pstring in %rdx
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        push    %r13        # because it is callee
        push    %r14        # because it is callee
        movq    %rsi, %r13  # save the first pstring
        movq    %rdx, %r14  # save the second pstring

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
        movq    %r13, %rdi  # contains the pointer to the first pstring
        call    pstrlen     # return the length of the first pstring. Saved in %rax
        movq    %rax, %rsi  # Save the length of the first pstring in %rsi.

        movq    %r14, %rdi  # contains the pointer to the second pstring
        call    pstrlen     # return the length of the second pstring. Saved in %rax
        movq    %rax, %rdx  # Save the length of the second pstring in %rdx.

        movq	$format_length, %rdi	# load format for printf
        movq	$0, %rax
        call	printf

        jmp END

REPLACE:
        movq    $format_get_char, %rdi   # load format for scanf for char.
        movq    $trash, %rsi    # define that the value from scanf will be saved in trash.
        movq    $0, %rax        # clear AL (zero FP args in XMM registers).
        call    scanf           # get the \n from the previous scanf.

        movq    $format_get_char, %rdi   # load format for scanf for char.
        movq    $oldChar, %rsi      # define that the value from scanf will be saved in oldChar.
        movq    $0, %rax            # clear AL (zero FP args in XMM registers).
        call    scanf               # get the old char.

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $trash, %rsi    # define that the value from scanf will be saved in trash
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        call    scanf           # get the space from the previous scanf

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $newChar, %rsi      # define that the value from scanf will be saved in n1
        movq    $0, %rax            # clear AL (zero FP args in XMM registers)
        call    scanf               # get the new char.

        movq    $0, %rsi
        movb    (newChar), %sil # move the new char to be in smaller register.
        movq    $0, %rdx
        movb    (oldChar), %dl  # move the old char to be in smaller register.
        movq    %r13, %rdi      # saved the pointer to the first pstring.
        call    replaceChar     # %rax contains the pstring after the switch.
        movq    %rax, %r13      # contains the first pstring after the switch.

        movq    $0, %rsi
        movb    (newChar), %sil # move the new char to be in smaller register.
        movq    $0, %rdx
        movb    (oldChar), %dl  # move the old char to be in smaller register.
        movq    %r14, %rdi      # saved the pointer to the second pstring in %rdi.
        call    replaceChar     # %rax contains the pstring after the switch.
        movq    %rax, %r14      # contains the second pstring after the switch.

        movq	$format_replace, %rdi	# load format for printf
        movq    (oldChar), %rsi
        movq    (newChar), %rdx
        movq    %r13, %rcx      # save the address of the fisrt pstring
        addq    $1, %rcx        # because we want the string of the pstring
        movq    %r14, %r8       # save the address of the second pstring
        addq    $1, %r8         # because we want the string of the pstring
        movq	$0, %rax
        call	printf

        jmp END

COPY:
        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $i, %rsi        # define that the value from scanf will be saved in i
        call    scanf           # get the second length

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $j, %rsi        # define that the value from scanf will be saved in j
        call    scanf           # get the second length

        movq    %r13, %rdi      # the address of the first pstring
        movq    %r14, %rsi      # the address of the second pstring
        movb    (i), %dl        # move the i to be in smaller register.
        movb    (j), %cl        # move the j to be in smaller register.
        call    pstrijcpy       # %rax contains the first pstring after the copy
        movq    %rax, %r8       # contains the first pstring after the copy

        movq	$format_cpy, %rdi   # load format for printf
        movq    $0, %rsi
        movb    (%r8), %sil     # saved the length of the first pstring.
        addq    $1, %r8         # because we want the string of the pstring
        movq    %r8, %rdx       # save the address of the first pstring
        movq	$0, %rax
        call	printf

        movq	$format_cpy, %rdi   # load format for printf
        movq    $0, %rsi
        movb    (%r14), %sil    # saved the length of the second pstring.
        movq    %r14, %r8       # contains the address of the second pstring
        addq    $1, %r8         # because we want the string of the pstring
        movq    %r8, %rdx       # save the address of the second pstring
        movq	$0, %rax
        call	printf

        jmp END

SWAP:
        movq    %r13, %rdi      # contains the address of the first pstring
        call    swapCase
        movq    %rax, %r8       # save the pstring after the swap

        movq	$format_swp, %rdi   # load format for printf
        movq    $0, %rsi
        movb    (%r8), %sil    # saved the length of the pstring.
        movq    %r8, %r9       # contains the address of the pstring
        addq    $1, %r9        # because we want the string of the pstring
        movq    %r9, %rdx      # save the address of the pstring
        movq	$0, %rax
        call	printf

        movq    %r14, %rdi      # contains the address of the first pstring
        call    swapCase
        movq    %rax, %r8       # save the pstring after the swap

        movq	$format_swp, %rdi   # load format for printf
        movq    $0, %rsi
        movb    (%r8), %sil    # saved the length of the pstring.
        movq    %r8, %r9       # contains the address of the pstring
        addq    $1, %r9        # because we want the string of the pstring
        movq    %r9, %rdx      # save the address of the pstring
        movq	$0, %rax
        call	printf

        jmp END

COMPARE:
        jmp END


END:


        popq    %r14    # because it is a callee
        popq    %r13    # because it is a callee

        movq    %rbp, %rsp
        popq    %rbp
        ret

