;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - palindrome
;;=============================================================
;; Name: Matthew Kistner
;;=============================================================

;;  NOTE: Let's decide to represent "true" as a 1 in memory and "false" as a 0 in memory.
;;
;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String str = "aibohphobia";
;;  boolean isPalindrome = true
;;  int length = 0;
;;  while (str[length] != '\0') {
;;		length++;
;;	}
;; 	
;;	int left = 0
;;  int right = length - 1
;;  while(left < right) {
;;		if (str[left] != str[right]) {
;;			isPalindrome = false;
;;			break;
;;		}
;;		left++;
;;		right--;
;;	}
;;	mem[mem[ANSWERADDR]] = isPalindrome;

.orig x3000

LD R0, STRING ;R0 = STRING for the right
LD R1, STRING ;R1 = STRING for the left

AND R5, R5, #0 ;answer holder
ADD R5, R5, #1

AND R2, R2, #0 ;length

WHILE LDR R3, R0, #0
BRz ENDW
ADD R2, R2, #1
ADD R0, R0, #1
BR WHILE
ENDW

ADD RO, R0, #-1 ;string + length - 1

WHILEMAIN ADD R2, R2, #0
BRnz ENDWM
LDR R3, R0, #0
LDR R4, R1, #0
NOT R4, R4
ADD R4, R4, #1


IF ADD R3, R3, R4
BRnp ELSE
	BR ENDIF

ELSE AND R5, R5, #0
	BR ENDWM
ENDIF

ADD R0, R0, #-1
ADD R1, R1, #1
ADD R2, R2, #-2
BR WHILEMAIN
ENDWM
STI R5, ANDWERADDR

	HALT

;; Do not change these values!
STRING	.fill x4004
ANSWERADDR 	.fill x5005
.end

;; Do not change any of the .orig lines!
.orig x4004				   
	.stringz "aibohphobia" ;; Feel free to change this string for debugging.
.end

.orig x5005
	ANSWER  .blkw 1
.end