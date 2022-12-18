.section .rodata

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
        # %rdi = pointer to first pstring, %rsi = new char, %rdx = old char.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movq    %rdi, %rax      # because we return the pointer to the first pstring
        movq    $0, %r11
        movb    (%rdi), %r11b
        movq    1(%rdi), %rdi   # look only at the text
        movq    $0, %r8

LOOP:
        movb    %dil, %r10b     # insert a letter to the register.
        cmp     %dl, %r10b      # check if the letter in the text equals to the old char.
        jne     CONTINUE        # if the letter in the text doesn't equal to the old char.

        movb    %sil, %dil      # switch the letter in the pstring with the new char
        incq    %r8
        movq    %r8, %r9
        cmp     %r11, %r9
        je      END
        jmp     LOOP

CONTINUE:
      #  movb    1(%dil), %dil   # look at the next letter.


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
