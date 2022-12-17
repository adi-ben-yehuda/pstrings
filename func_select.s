.section .rodata


.section .rodata # Read only data section
format_length:  .string    "first pstring length: %d, second pstring length: %d\n"
format_get_char:    .string     "%c"
format_replace: .string    "old char: %c, new char: %c, first string: %s, second string: %s\n"



.data
newChar:    .byte
oldChar:    .byte

.text
.globl run_func
.type run_func, @function
run_func:
        # option in %edi, first pstring in %rsi, second pstring in %rdx

        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        cmpl    $31, (%edi)       # check if option = 31
        je      LENGTH
        cmpl    $32, (%edi)       # check if option = 31
        je      REPLACE
        cmpl    $33, (%edi)       # check if option = 31
        je      REPLACE
        cmpl    $35, (%edi)       # check if option = 31
        je      COPY
        cmpl    $36, (%edi)       # check if option = 31
        je      SWAP
        cmpl    $37, (%edi)       # check if option = 31
        je      COMPARE
        jmp END

LENGTH:
        movq    %rsi, %rdi  # %rdi contains the pointer to the first pstring
        call    pstrlen     # return the length of the first pstring. Saved in %rax
        movq    %rax, %rsi   # Save the length of the first pstring in %rsi.

        movq    %rdx, %rdi  # %rdx contains the pointer to the second pstring
        call    pstrlen     # return the length of the second pstring. Saved in %rax
        movq    %rax, %rdx   # Save the length of the second pstring in %rdx.

        movq	$format_length, %rdi	# load format for printf
        movq	$0, %rax
        call	printf

        jmp END

REPLACE:
        movq    %rsi, %r9  # %r9 contains the pointer to the first pstring.
        movq    %rdx, %r10  # %r9 contains the pointer to the second pstring.

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $oldChar, %rsi       # define that the value from scanf will be saved in n1
        call    scanf           # get the old char
        movq    $oldChar, %rdx      # %rdx contains the old char

        movq    $format_get_char, %rdi   # load format for scanf for char
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $newChar, %rsi       # define that the value from scanf will be saved in n1
        call    scanf           # get the new char. Saved in %rsi

        movq    %r9, %rdi       # saved the pointer to the first pstring in %rdi.
        call    replaceChar     # %rax contains the pstring after the switch.
        movq    %rax, %r9       # %r9 contains the first pstring after the switch.

        movq    $oldChar, %rdx      # %rdx contains the old char
        movq    $newChar, %rsi       # define that the value from scanf will be saved in n1
        movq    %r10, %rdi       # saved the pointer to the first pstring in %rdi.
        call    replaceChar     # %rax contains the pstring after the switch.
        movq    %rax, %r10       # %r9 contains the first pstring after the switch.

        movq	$format_replace, %rdi	# load format for printf
        movq    $oldChar, %rsi      # %rdx contains the old char
        movq    $newChar, %rdx       # define that the value from scanf will be saved in n1
        movq    8(%r9), %rcx
        movq    8(%r10), %r8
        movq	$0, %rax
        call	printf




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

