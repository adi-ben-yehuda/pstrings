.section .rodata

.data
endText:     .string  "\0"

.text
.globl pstrlen
.type pstrlen, @function
pstrlen:
        # pointer to pstring in %rdi
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movq    (%rdi), %rax    # saved the length of the first pstring in %rax.

        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl replaceChar
.type replaceChar, @function
replaceChar:
        # %rdi = pointer to first pstring, %rsi = new char, %rdx = old char.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movq    %rdi, %rax      # because we return the pointer to the first pstring
        movq    8(%rdi), %rdi   # look only at the text
        movq    $endText, %r10

LOOP:
        movq    (%rdx), %r11
        cmpq    %r11, (%rdi)  # check if the letter in the text equals to the old char.
        jne     CONTINUE

        movq    (%rsi), %r11
        movq    %r11, (%rdi)
        jmp     LOOP

CONTINUE:
        movq    1(%rdi), %rdi   # look at the next letter.
        cmpq    (%rdi), %r10    # check if the letter is \0
        je      END
        jmp     LOOP
END:
        movq    %rbp, %rsp
        popq    %rbp
        ret



.globl pstrijcpy
.type pstrijcpy, @function
pstrijcpy:


.globl swapCase
.type swapCase, @function
swapCase:



.globl pstrijcmp
.type pstrijcmp, @function
pstrijcmp:
