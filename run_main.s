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

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $n1, %rsi       # define that the value from scanf will be saved in n1
        call    scanf           # get the first length

        movq    $format_scanf_string, %rdi  # load format for scanf for strings
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $text1, %rsi    # define that the value from scanf will be saved in text1
        call    scanf           # get the first text
        # TODO: add \0 in the end

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $n2, %rsi       # define that the value from scanf will be saved in n2
        call    scanf           # get the second length

        movq    $format_scanf_string, %rdi  # load format for scanf for strings
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $text2, %rsi    # define that the value from scanf will be saved in text2
        call    scanf           # get the second text
        # TODO: add \0 in the end

        movq    $format_scanf_number, %rdi   # load format for scanf for numbers
        movq    $0, %rax        # clear AL (zero FP args in XMM registers)
        movq    $option, %rsi   # define that the value from scanf will be saved in option
        call    scanf           # get the option of the user

        subq    $528, %rsp      # move the %rsp so that there is space to save the four values
        movq    $text1, -255(%rbp) # save the first text in the stack
        movq    $n1, -263(%rbp)   # save the first length in the stack
        movq    $text2, -518(%rbp) # save the second text in the stack
        movq    $n2, -526(%rbp)   # save the second length in the stack

        movl	$option, %edi
        movq    -263(%rbp), %rsi
        movq    -526(%rbp), %rdx
        call    run_func

        movq    %rbp, %rsp
        popq    %rbp
        ret
        