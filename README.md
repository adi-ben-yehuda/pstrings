# computer_systems_ex_3

## Introduction
This Arkanoid game contains four levels. The player will win the game if he breaks all the blocks in each level and he will lose if all the balls fall.

## Table of contents
* [General Information](#general-information)
* [Installation](#installation)
* [Contact](#Contact)

## General Information
The main_run function receives from the user two strings, their lengths, and an option in the menu. Builds two pstrings according to the received strings and lengths and sends to func_run the option in the menu and the addresses of the pstrings.

The options are:
* 31 - Using the pstrlen function, calculate the length of the two pstrings and print their lengths.
* 32/33 - Two characters must be received from the user, the first character will be the character that needs to be replaced (oldChar) and the second character will be a new character (newChar). Using the replaceChar function, replace in both pstrings each instance of oldChar with newChar. After the replacement, print both pstrings to the console.
* 35 - Two numbers must be received from the user - the first number will be a start index and the second number will be an end index. Next, call the pstrijcpy function, where j is the end index, i is the start index, src is the pointer to the second pstring, and dst is the pointer to the first pstring. After copying, print the first and second pstring.
* 36 - Using the swapCase function, replace each uppercase English letter (Z-A) with a lowercase letter (z-a) in each pstring, and replace each English letter with an uppercase English letter. After replacing, print the pstrings.
* 37 - Two numbers must be received from the user - the first number will be the start index and the second number will be the end index. Next, call the pstrijcmp function, where j is the end index, i index is the start, pstr1 is the pointer to the first pstring, and pstr2 is the pointer to the second pstring.
After the comparison, print the comparison result.

In any case, after performing the operation, the program must be finished in an orderly manner.
If func_run received a different number, print the following to the user: invalid option!
