# 211769757 Adi Ben Yehuda

.section .rodata # Read only data section
format_invalid:  .string    "invalid input!\n"

.text
.globl pstrlen
.type pstrlen, @function
pstrlen:
        # pointer to pstring in %rdi
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movb    (%rdi), %al     # saved the length of the first pstring.

        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl replaceChar
.type replaceChar, @function
replaceChar:
        # %rdi = pointer to first pstring, %sil = old char, %dl = new char.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        movq    %rdi, %rax      # because we return the pointer to the first pstring
        movq    $0, %r11
        movb    (%rdi), %r11b   # save the length of the string
        cmp     $0, %r11        # check if 0 == length
        je      END_RPLC        # jump if the length is 0.

        movq    $0, %r8         # Counting how many letters we have run so far.

LOOP_RPLC:
        addq    $1, %rdi        # look at the next letter
        movb    %sil, %r10b      # save the old char
        cmpb    (%rdi), %r10b   # check if the letter in the text equals to the old char.
        jne     CONTINUE_RPLC   # jump if the letter in the text doesn't equal to the old char.
        movb    %dl, (%rdi)    # switch the letter in the pstring with the new char

CONTINUE_RPLC:
        incq    %r8             # count++
        movq    %r8, %r9        # move the count
        cmp     %r11, %r9       # check if count == length
        je      END_RPLC        # jump if we run on all the letters in the text.
        jmp     LOOP_RPLC

END_RPLC:
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
        cmpb    %r10b, %r11b    # compare between i and j
        jl      INVALID_CPY     # jump if i>j
        movq    $0, %r9
        cmpb    %r10b, %r9b     # compare between i and 0
        jg      INVALID_CPY     # jump if i<0
        movq    $0, %r9
        movb    (%rdi), %r9b    # save the length of the first string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the first pstring and j
        jge     INVALID_CPY     # jump if j >= length
        movq    $0, %r9
        movb    (%rsi), %r9b    # save the length of the second string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the second pstring and j
        jge     INVALID_CPY     # jump if j >= length

        movq    $0, %r8         # Counting how many letters we have run so far.
        addq    $1, %rdi        # look at the next letter in the first pstring
        addq    $1, %rsi        # look at the next letter in the second pstring

LOOP_CPY:
        movb    %r8b, %r9b      # save the counter
        cmpb    %dl, %r9b       # compare between i and counter
        jl      COUNTINUE_CPY   # jump if counter<i
        movb    %r8b, %r9b      # save the counter
        cmpb    %cl, %r9b       # compare between j and counter
        jg      END_CPY         # jump if counter>j
        ## that is, i<=conter<=j
        movb    (%rsi), %r10b   # save the letter of the second pstring
        movb    %r10b, (%rdi)   # switch the letter in the first pstring with the letter of the second pstring.

COUNTINUE_CPY:
        incb    %r8b            # counter++
        addq    $1, %rdi        # look at the next letter in the first pstring
        addq    $1, %rsi        # look at the next letter in the second pstring
        jmp     LOOP_CPY

INVALID_CPY:
        push    %rbx        # because it is a callee
        push    $0          # we need the stack addresses to be multiples of 16 for printf
        movq    %rax, %rbx  # save the first pstring
        movq	$format_invalid, %rdi	# load format for printf
        movq	$0, %rax
        call	printf      # print error message
        popq    %r8         # pop out the 0
        movq    %rbx, %rax  # save the first pstring
        popq    %rbx        # because it is a callee

END_CPY:
        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl swapCase
.type swapCase, @function
swapCase:
        # %rdi = pointer to first pstring
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging
        movq    %rdi, %rax      # because we return the pointer to the pstring
        movq    $0, %r8         # Counting how many letters we have run so far.
        movq    $0, %r11
        movb    (%rdi), %r11b   # save the length of the string
        addq    $1, %rdi        # look at the first letter in the pstring

LOOP_SWP:
        movb    %r8b, %r9b          # save the counter
        movq    $0, %r10
        movb    %r11b, %r10b        # save the length of the string
        cmpb    %r9b, %r10b         # compare between counter and length
        jle     END_SWP             # jump if counter>=length

        movb    (%rdi), %r9b        # save the letter
        cmp     $65, %r9b           # compare between 65 and the letter
        jl      CONTINUE_SWP        # jump if 65>letter, because it's not a capital letter.
        ## letter >= 65
        cmp     $90, %r9b           # compare between 90 and the letter
        jle     CAPITAL             # jump if 90>=letter
        ## letter > 90
        cmp     $96, %r9b           # compare between 96 and the letter
        jle     CONTINUE_SWP        # jump if 96>=letter, because it's not a letter.
        ## letter >= 97
        cmp     $122, %r9b          # compare between 122 and the letter
        jg     CONTINUE_SWP         # jump if 122<letter, because it's not a letter.
        ## the letter is a lower case letter
        addq    $-32, %r9           # change the lower case letter to be a capital letter.
        movb    %r9b, (%rdi)        # save the letter after the change in the string.
        jmp     CONTINUE_SWP

CAPITAL:
        addq    $32, %r9        # change the capital letter to be a lower case letter.
        movb    %r9b, (%rdi)    # save the letter after the change in the string.

CONTINUE_SWP:
        incb    %r8b            # counter++
        addq    $1, %rdi        # look at the next letter in the first pstring
        jmp     LOOP_SWP

END_SWP:
        movq    %rbp, %rsp
        popq    %rbp
        ret

.globl pstrijcmp
.type pstrijcmp, @function
pstrijcmp:
        # %rdi = pointer to first pstring, %rsi = pointer to second pstring, %dl = i, %cl = j.
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        # check validation
        movq    $0, %r10
        movq    $0, %r11
        movb    %dl, %r10b      # move the i
        movb    %cl, %r11b      # move the j
        cmpb    %r10b, %r11b    # compare between i and j
        jl      INVALID_CMP     # jump if i>j
        movq    $0, %r9
        cmpb    %r10b, %r9b     # compare between i and 0
        jg      INVALID_CMP     # jump if i<0
        movq    $0, %r9
        movb    (%rdi), %r9b    # save the length of the first string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the first pstring and j
        jge     INVALID_CMP     # jump if j >= length
        movq    $0, %r9
        movb    (%rsi), %r9b    # save the length of the second string
        movb    %cl, %r10b      # save the j
        cmpb    %r9b, %r10b     # compare between length of the second pstring and j
        jge     INVALID_CMP     # jump if j >= length

        movq    $0, %r8         # Counting how many letters we have run so far.
        addq    $1, %rdi        # look at the next letter in the first pstring
        addq    $1, %rsi        # look at the next letter in the second pstring
LOOP_CMP:
        movb    %r8b, %r9b      # save the counter
        cmpb    %cl, %r9b       # compare between j and counter
        jg      EQUAL           # jump if counter>j
        movb    %r8b, %r9b      # save the counter
        cmpb    %dl, %r9b       # compare between i and counter
        jl      COUNTINUE_CMP   # jump if counter<i
        ## counter >= i
        movb    (%rdi), %r10b   # save the letter of the first pstring
        movb    (%rsi), %r11b   # save the letter of the second pstring
        cmpb    %r10b, %r11b    # compare between letter of the first pstring and letter of the second pstring.
        jg      SECOND_BIGGER   # jump if second > letter
        cmpb    %r10b, %r11b    # compare between letter of the first pstring and letter of the second pstring.
        jl      FIRST_BIGGER   # jump if second < letter

COUNTINUE_CMP:
        incb    %r8b            # counter++
        addq    $1, %rdi        # look at the next letter in the first pstring
        addq    $1, %rsi        # look at the next letter in the second pstring
        jmp     LOOP_CMP

INVALID_CMP:
        movq	$format_invalid, %rdi	# load format for printf
        movq	$0, %rax
        call	printf          # print error message
        movq    $-2, %rax
        jmp     END_CMP

EQUAL:
        movq    $0, %rax        # the first pstring and the second pstring is the same.
        jmp     END_CMP

SECOND_BIGGER:
        movq    $-1, %rax       # the second pstring is bigger than the first pstring.
        jmp     END_CMP

FIRST_BIGGER:
        movq    $1, %rax        # the first pstring is bigger than the second pstring.
        jmp     END_CMP

END_CMP:
        movq    %rbp, %rsp
        popq    %rbp
        ret
