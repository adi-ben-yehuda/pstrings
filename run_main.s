# 211769757 Adi Ben Yehuda

.section .rodata # Read only data section
format_scanf_number:   .string     "%d"
format_scanf_string:   .string     "%s"

.data
text1:  .space 255
n1:     .double 0
text2:  .space 255
n2:     .double 0
option: .double 0

    .text	# The beginnig of the code
.globl  run_main
.type   run_main, @function
run_main:
        push    %rbp            # Save the old frame pointer
        movq    %rsp, %rbp      # for correct debugging

        subq    $512, %rsp      # move the %rsp so that there is space to save the four values

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $n1, %rsi       # define that the value from scanf will be saved in n1
        call    scanf           # get the first length
        movq    (n1), %rsi
        movq    %rsi, -256(%rbp)   # save the first length in the stack

        movq    $format_scanf_string, %rdi  # load format for scanf for strings
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $text1, %rsi    # define that the value from scanf will be saved in text1
        call    scanf           # get the first text
        movq    (text1), %rsi
        movq    %rsi, -255(%rbp) # save the first text in the stack

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $n2, %rsi       # define that the value from scanf will be saved in n2
        call    scanf           # get the second length
        movq    (n2), %rsi
        movq    %rsi, -512(%rbp)   # save the first length in the stack

        movq    $format_scanf_string, %rdi  # load format for scanf for strings
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $text2, %rsi    # define that the value from scanf will be saved in text2
        call    scanf           # get the second text
        movq    (text2), %rsi
        movq    %rsi, -511(%rbp) # save the first text in the stack

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $option, %rsi   # define that the value from scanf will be saved in option
        call    scanf           # get the option of the user

        movl	(option), %edi
        movq    %rbp, %r11
        subq    $256, %r11
        movq    %r11, %rsi      # save the address of the first pstring in %rsi
        movq    %rbp, %r11
        subq    $512, %r11
        movq    %r11, %rdx      # save the address of the second pstring in %rsi
        call    run_func

        movq    %rbp, %rsp
        popq    %rbp
        ret
        