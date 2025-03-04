;; Timed Lab 3
;; Student Name: Matthew Kistner

;; Please read the PDF for full directions.
;; The pseudocode for the program you must implement is listed below; it is also listed in the PDF.
;; If there are any discrepancies between the PDF's pseudocode and the pseudocode below, notify a TA immediately.
;; However, in the end, the pseudocode is just an example of a program that would fulfill the requirements specified in the PDF.

;; Pseudocode:
;; // (checkpoint 1)
;; int MAX(int a, int b) {
;;   if (a > b) {
;;       return 0;
;;   } else {
;;       return 1;
;;   }
;; }
;;
;;
;;
;;
;; DIV(x, y) {
;;	   // (checkpoint 2) - Base Case
;;     if (y > x) {
;;         return 0;
;;     // (checkpoint 3) - Recursion
;;     } else {
;;         return 1 + DIV(x - y, y);
;;     }
;; }
;;
;;
;;
;; // (checkpoint 4)
;; void MAP(array, length) {
;;   int i = 0;
;;   while (i < length) {
;;      int firstElem = arr[i];
;;      int secondElem = arr[i + 1];
;;      int div = DIV(firstElem, secondElem);
;;      int offset = MAX(firstElem, secondElem);
;;      arr[i + offset] = div;
;;      i += 2;
;;   }
;; }


.orig x3000
HALT

STACK .fill xF000

; DO NOT MODIFY ABOVE


; START MAX SUBROUTINE
MAX
    ;; Build Up
    ADD R6, R6, -4 ;place stack pointer to build up first portion of the stack (a)
    STR R7, R6, 2 ;save return address
    STR R5, R6, 1 ;save old frame pointer
    ADD R5, R6, 0 ;set current frame pointer
    ADD R6, R6, -5 ;place stack pointer to save all of the registers on the stack (b)
    STR R0, R5, -1 ;save R0
    STR R1, R5, -2 ;save R1
    STR R2, R5, -3 ;save R2
    STR R3, R5, -4 ;save R3
    STR R4, R5, -5 ;save R4

    LDR R0,R5,#4 ; R0 = a
    LDR R1,R5,#5 ; R1 = b

    AND R2,R2,#0 ; Clears R2
    NOT R2,R1 ; R2 = ~R1
    ADD R2,R2,#1 ; R2 = -R1
    ADD R2,R0,R2 ; a - b
    BRnz ENDIFM ; a - b > 0

    AND R2,R2,#0 ; Clears R2
    STR R2,R5,#3 ; Stores 0 at return value

    BR SKIPELSEM
    ENDIFM

    AND R2,R2,#0 ; Clear R2
    ADD R2,R2,#1 ; R2 = 1
    STR R2,R5,#3 ; Stores 1 at return value

    SKIPELSEM

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3

RET
; END MAX SUBROUTINE




; START DIV SUBROUTINE
DIV
    ADD R6, R6, -4 ;place stack pointer to build up first portion of the stack (a)
    STR R7, R6, 2 ;save return address
    STR R5, R6, 1 ;save old frame pointer
    ADD R5, R6, 0 ;set current frame pointer
    ADD R6, R6, -5 ;place stack pointer to save all of the registers on the stack (b)
    STR R0, R5, -1 ;save R0
    STR R1, R5, -2 ;save R1
    STR R2, R5, -3 ;save R2
    STR R3, R5, -4 ;save R3
    STR R4, R5, -5 ;save R4

    LDR R0,R5,#4 ; R0 = x
    LDR R1,R5,#5 ; R1 = y

    IF AND R2,R2,#0 ; clears R2
    NOT R2,R0 ; R2 = ~R0
    ADD R2,R2,#1 ; R2 = -x
    ADD R2,R1,R2 ; y - x
    BRnz ENDIFD ; y - x > 0

    AND R2,R2,#0 ; clears R2
    STR R2,R5,#3 ; Stores R2 at return value (return 0)

    BR SKIPELSED
    ENDIFD

    NOT R2,R1 ; R2 = ~R1
    ADD R2,R2,#1 ; R2 = -y
    ADD R2,R0,R2 ; R2 = x - y

    ADD R6,R6,#-1
    STR R1,R6,0 ; Stores y at variable location for JSR call
    ADD R6,R6,#-1
    STR R2,R6,0 ; Stores x - y at variable location for JSR call

    JSR DIV ; Subroutine Call

    LDR R0,R6,#0 ; Stores returned value of DIV(x - y, y) at R0
    ADD R6,R6,#3 ; Resets R6
    ADD R0,R0,#1 ; 1 + DIV(x - y, y)
    STR R0,R5,#3 ; Stores R0 at return value 

    SKIPELSED

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
RET
; END DIV SUBROUTINE



; START MAP SUBROUTINE
MAP
    ADD R6, R6, -4 ;place stack pointer to build up first portion of the stack (a)
    STR R7, R6, 2 ;save return address
    STR R5, R6, 1 ;save old frame pointer
    ADD R5, R6, 0 ;set current frame pointer
    ADD R6, R6, -5 ;place stack pointer to save all of the registers on the stack (b)
    STR R0, R5, -1 ;save R0
    STR R1, R5, -2 ;save R1
    STR R2, R5, -3 ;save R2
    STR R3, R5, -4 ;save R3
    STR R4, R5, -5 ;save R4

    AND R2,R2,#0 ; R2 = i = 0

    WHILE LDR R1,R5,#5 ; R1 = length
    AND R3,R3,#0 ; Clear R3
    NOT R3,R1 ; R3 = ~R1
    ADD R3,R3,#1 ; R3 = -length
    ADD R3,R2,R3 ; i - length
    BRzp ENDWHILE ; while (i - length < 0)

    LDR R3,R5,#4 ; Loads array address into R3
    ADD R3,R3,R2 ; Finds address of array[i]
    LDR R3,R3,#0 ; R3 = firstElem

    LDR R0,R5,#4 ; Loads array address into R0
    ADD R0,R0,R2 ; Finds address of array[i]
    ADD R0,R0,#1 ; Finds address of array[i + 1]
    LDR R0,R0,#0 ; R0 = secondElem

    ADD R6,R6,#-1
    STR R0,R6,#0 ; Stores secondElem at variable location for JSR call
    ADD R6,R6,#-1
    STR R3,R6,#0 ; Stores firstElem at variable location for JSR call

    JSR DIV 
    LDR R1,R6,#0 ; Stores return of DIV at R1 (R1 = div)
    ADD R6,R6,#3 ; Resets R6

    ADD R6,R6,#-1
    STR R0,R6,0 ; Stores secondElem at variable location for JSR call
    ADD R6,R6,#-1
    STR R3,R6,0 ; Stores firstElem at variable location for JSR call

    JSR MAX
    LDR R4,R6,#0 ; Stores return of MAX at R4 (R4 = offset)
    ADD R6,R6,#3 ; Resets R6 position

    LDR R0,R5,#4 ; Loads array address into R0
    ADD R0,R0,R2 ; Loads array[i] address into R0
    ADD R0,R0,R4 ; Loads array[i + offset] into R0
    STR R1,R0,#0 ; array[i + offset] = div

    ADD R2,R2,#2 ; i += 2

    BR WHILE
    ENDWHILE

    LDR R0, R6, #4
    LDR R1, R6, #3
    LDR R2, R6, #2
    LDR R3, R6, #1
    LDR R4, R6, #0
    ADD R6, R5, #0
    LDR R5, R6, #1
    LDR R7, R6, #2
    ADD R6, R6, #3
RET
; END MAP SUBROUTINE


; LENGTH FOR TESTING

LENGTH .fill x12

; ARRAY FOR TESTING
ARRAY .fill x4000

.end

.orig x4000
.fill 12
.fill 3
.fill 5
.fill 7
.fill 16
.fill 2
.fill 5
.fill 5
.fill 25
.fill 7
.fill 48
.fill 60
.end
