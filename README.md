# Functions on pstrings

## Introduction
In this program, the user enters two pstrings containing length and text and its option. According to the option, the actions will occur, and the result will be printed on the console.

## Table of contents
* [General Information](#general-information)
* [Installation](#installation)
* [Contact](#Contact)

## General Information
The main_run function receives from the user two strings, their lengths, and an option in the menu. Builds two pstrings according to the received strings and lengths and sends to func_run the option in the menu and the addresses of the pstrings.

The options are:
* 31 - Using the pstrlen function, calculate the length of the two pstrings and print their lengths.
<img width="203" alt="image" src="https://user-images.githubusercontent.com/75027826/225344855-2b44facc-8869-4a17-9145-bb65bb153761.png">

* 32/33 - Two characters must be received from the user, the first character will be the character that needs to be replaced (oldChar) and the second character will be a new character (newChar). Using the replaceChar function, replace in both pstrings each instance of oldChar with newChar. After the replacement, print both pstrings to the console.
<img width="266" alt="image" src="https://user-images.githubusercontent.com/75027826/225345160-f9a22cd6-925b-412f-aafc-816b44c43c8d.png">
<img width="265" alt="image" src="https://user-images.githubusercontent.com/75027826/225345366-163b5a19-8946-4d64-899b-53de06f5c059.png">

* 35 - Two numbers must be received from the user - the first number will be a start index and the second number will be an end index. Next, call the pstrijcpy function, where j is the end index, i is the start index, src is the pointer to the second pstring, and dst is the pointer to the first pstring. After copying, print the first and second pstring.
<img width="103" alt="image" src="https://user-images.githubusercontent.com/75027826/225345603-00774eb9-74f6-4d44-a7e5-2a5045c1874d.png">

* 36 - Using the swapCase function, replace each uppercase English letter (Z-A) with a lowercase letter (z-a) in each pstring, and replace each English letter with an uppercase English letter. After replacing, print the pstrings.
<img width="104" alt="image" src="https://user-images.githubusercontent.com/75027826/225345904-7bcbfc8c-a6c0-4e19-8bc9-a0ce08ac7fbe.png">

* 37 - Two numbers must be received from the user - the first number will be the start index and the second number will be the end index. Next, call the pstrijcmp function, where j is the end index, i index is the start, pstr1 is the pointer to the first pstring, and pstr2 is the pointer to the second pstring. After the comparison, print the comparison result.

<img width="80" alt="image" src="https://user-images.githubusercontent.com/75027826/225346711-b0bb12a3-4909-4c37-9287-da4727bbb9fa.png"> <img width="82" alt="image" src="https://user-images.githubusercontent.com/75027826/225346156-8b813584-4812-4522-a161-0da1124bf026.png">

In any case, after performing the operation, the program must be finished in an orderly manner.
If func_run received a different number, print the following to the user: invalid option!

<img width="70" alt="image" src="https://user-images.githubusercontent.com/75027826/225346909-58caf5d5-02a9-4d0e-a442-bf988a523ba8.png">

## Installation
Before installing this project, you need to install on your computer:
* Git

After it, run the following commands in the terminal:

```
git clone https://github.com/adi-ben-yehuda/pstrings.git
make clean
make
./a.out
```

## Contact
Created by @adi-ben-yehuda - feel free to contact me!
