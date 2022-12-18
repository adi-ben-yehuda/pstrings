.section .rodata


.section .rodata # Read only data section
format_invalid_cpy:  .string    "invalid input!\n"

.text
.globl pstrlen
.type pstrlen, @function
pstrlen:
        # pointer to pstring in %rdi
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movb    (%rdi), %al    # saved the length of the first pstring.

        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl replaceChar
.type replaceChar, @function
replaceChar:
        # %rdi = pointer to first pstring, %sil = new char, %dl = old char.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movq    %rdi, %rax      # because we return the pointer to the first pstring
        movq    $0, %r11
        movb    (%rdi), %r11b   # save the length of the string
        movq    $0, %r8         # Counting how many letters we have run so far.

LOOP:
        addq    $1, %rdi        # look at the next letter
        movb    %dl, %r10b      # save the old char
        cmpb    (%rdi), %r10b   # check if the letter in the text equals to the old char.
        jne     CONTINUE        # jump if the letter in the text doesn't equal to the old char.
        movb    %sil, (%rdi)    # switch the letter in the pstring with the new char

CONTINUE:
        incq    %r8             # count++
        movq    %r8, %r9        # move the count
        cmp     %r11, %r9       # check if count == length
        je      END             # jump if we run on all the letters in the text.
        jmp     LOOP

END:
        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl pstrijcpy
.type pstrijcpy, @function
pstrijcpy:
        # %rdi = pointer to first pstring, %rsi = pointer to second pstring, %dl = i, %cl = j.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging
        movq    %rdi, %rax      # because we return the pointer to the first pstring

        # check validation
        movq    $0, %r10
        movq    $0, %r11
        movb    %dl, %r10b      # move the i
        movb    %cl, %r11b      # move the j
        cmpb    %r10b, %r11b      # compare between i and j
        jl      INVALID          # jump if i>j
        movq    $0, %r9
        cmpb    %r10b, %r9b       # compare between i and 0
        jg      INVALID          # jump if i<0
        movq    $0, %r9
        movb    (%rdi), %r9b    # save the length of the first string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the first pstring and j
        jge     INVALID         # jump if j >= length
        movq    $0, %r9
        movb    (%rsi), %r9b    # save the length of the second string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the second pstring and j
        jge     INVALID         # jump if j >= length


        movb    $0, %r8b         # Counting how many letters we have run so far.


LOOP_CPY:
        movb    %r8b, %r9b
        cmpb    %dl, %r9b       # compare between i and count
        jge     LOOP_CPY         # jump if count>=i


        jmp     CONTINUE_CPY



INVALID:
        movq	$format_invalid_cpy, %rdi	# load format for printf
        movq	$0, %rax
        call	printf

CONTINUE_CPY:
        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl swapCase
.type swapCase, @function
swapCase:



.globl pstrijcmp
.type pstrijcmp, @function
pstrijcmp:
