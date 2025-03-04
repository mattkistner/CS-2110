;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - buildMaxArray
;;=============================================================
;; Name: Matthew Kistner
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;	int A[] = {-2, 2, 1};
;;	int B[] = {1, 0, 3};
;;	int C[3];
;;	int length = 3;
;;
;;	int i = 0;
;;	while (i < length) {
;;		if (A[i] >= B[length - i - 1]) {
;;			C[i] = 1;
;;		}
;;		else {
;;			C[i] = 0;
;;		}
;;		i++;
;;	}

.orig x3000
	LD R0,A ; R0 = A
	LD R1,B ; R1 = B
	LD R2,C ; R2 = C
	AND R3,R3,#0 ; R3 = 0 aka i
	LD R4,LENGTH ; R4 = LENGTH
	
	NOT R7,R4 ; R7 = ~R4
	ADD R7,R7,#1 ; R7 = -R4

	WHILE ADD R5,R3,R7 ; while (i - length < 0)
	BRzp ENDW

	LD R0,A ; Reloading A to R0 to fix loop issues
	ADD R0,R0,R3 ; Finds address of A[i]
	LDR R5,R0,#0 ; R5 = A[i]
	
	NOT R6,R3 ; R6 = ~R3
	ADD R6,R6,#1 ; R6 = -R3 or -i
	ADD R6,R4,R6 ; R6 = LENGTH - i
	ADD R6,R6,#-1 ; R6 = LENGTH - i - 1
	LD R1,B ; Reloading B to R1 to fix loop issues
	ADD R1,R1,R6 ; R1 =  address of B[LENGTH - i - 1]
	LDR R6,R1,#0 ; R6 = B[LENGTH - i - 1]
	
	NOT R6,R6 ; R6 = ~R6
	ADD R6,R6,#1 ; R6 = -R6

	ADD R5,R5,R6 ; if (A[i] - B[LENGTH - i - 1] >= 0)
	BRn ELSE

	LD R2,C ; Reloading C to R2 to fix loop issues
	ADD R2,R2,R3 ; Address of C[i]
	AND R6,R6,#0 ; Clears R6
	ADD R6,R6,#1 ; R6 = 1
	STR R6,R2,#0 ; C[i] = 1

	BR ENDIF
	
	ELSE 
	LD R2,C ; Reloading C to R2 to fix loop issues
	ADD R2,R2,R3 ; Address of C[i]
	AND R6,R6,#0 ; Clears R6, now R6 = 0
	STR R6,R2,#0 ; C[i] = 1

	ENDIF

	ADD R3,R3,#1 ; increments i by 1

	BR WHILE
	ENDW
	HALT
;; Do not change these addresses! 
;; We populate A and B and reserve space for C at these specific addresses in the orig statements below.
A 		.fill x3200		
B 		.fill x3300		
C 		.fill x3400		
LENGTH 	.fill 3			;; Change this value if you decide to increase the size of the arrays below.
.end

;; Do not change any of the .orig lines!
;; If you decide to add more values for debugging, make sure to adjust LENGTH and .blkw 3 accordingly.
.orig x3200				;; Array A : Feel free to change or add values for debugging.
	.fill -2
	.fill 2
	.fill 1
.end

.orig x3300				;; Array B : Feel free change or add values for debugging.
	.fill 1
	.fill 0
	.fill 3
.end

.orig x3400
	.blkw 3				;; Array C: Make sure to increase block size if you've added more values to Arrays A and B!
.end