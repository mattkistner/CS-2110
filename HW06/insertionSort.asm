;;=============================================================
;;  CS 2110 - Spring 2023
;;  Homework 6 - Insertion Sort
;;=============================================================
;;  Name: Matthew Kistner
;;============================================================

;;  In this file, you must implement the 'INSERTION_SORT' subroutine.

;;  Little reminder from your friendly neighborhood 2110 TA staff: don't run
;;  this directly by pressing 'Run' in complx, since there is nothing put at
;;  address x3000. Instead, call the subroutine by doing the following steps:
;;      * 'Debug' -> 'Simulate Subroutine Call'
;;      * Call the subroutine at the 'INSERTION_SORT' label
;;      * Add the [arr (addr), length] params separated by a comma (,) 
;;        (e.g. x4000, 5)
;;      * Proceed to run, step, add breakpoints, etc.
;;      * INSERTION_SORT is an in-place algorithm, so if you go to the address
;;        of the array by going to 'View' -> 'Goto Address' -> 'Address of
;;        the Array', you should see the array (at x4000) successfully 
;;        sorted after running the program (e.g [2,3,1,1,6] -> [1,1,2,3,6])

;;  If you would like to setup a replay string (trace an autograder error),
;;  go to 'Test' -> 'Setup Replay String' -> paste the string (everything
;;  between the apostrophes (')) excluding the initial " b' ". If you are 
;;  using the Docker container, you may need to use the clipboard (found
;;  on the left panel) first to transfer your local copied string over.

.orig x3000
    ;; You do not need to write anything here
    HALT

;;  INSERTION_SORT **RESURSIVE** Pseudocode (see PDF for explanation and examples)
;; 
;;  INSERTION_SORT(int[] arr (addr), int length) {
;;      if (length <= 1) {
;;        return;
;;      }
;;  
;;      INSERTION_SORT(arr, length - 1);
;;  
;;      int last_element = arr[length - 1];
;;      int n = length - 2;
;;  
;;      while (n >= 0 && arr[n] > last_element) {
;;          arr[n + 1] = arr[n];
;;          n--;
;;      }
;;  
;;      arr[n + 1] = last_element;
;;  }

INSERTION_SORT ;; Do not change this label! Treat this as like the name of the function in a function header
    ;; Code your implementation for the INSERTION_SORT subroutine here!
    ;; NOTE: Your implementation MUST be done recursively
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

    LDR R0,R5,#4 ; R0 = arr
    LDR R1,R5,#5 ; R1 = length

    IF ADD R2,R1,#-1 ; LENGTH - 1 
    BRnz EXIT ; if (LENGTH - 1 <= 0) exit recursive call

    ADD R6,R6,#-1 ; Making a spot for LENGTH
    ADD R1,R1,#-1 ; R1 = Length - 1
    STR R1,R6,0

    ADD R6,R6,#-1 ; Doing the same for ARR
    STR R0,R6,0

    JSR INSERTION_SORT ; Recursive Call
    ADD R6,R6,#3 ; Moving the Stack Pointer back into place

;;    ADD R4,R1,#-1 ; R4 = LENGTH - 1
;;    LDR R3,R0,R4 ; R3 = ARR[LENGTH - 1] = LAST_ELEMENT

    AND R2,R2,#0 ; Clear R2 
    ADD R2,R1,#-2 ; R2 = Length - 2 = n

    WHILE ADD R2,R2,#0 ; (n >= 0)
    BRn ENDWHILE
    AND R4,R4,0 ; Clears R4
    ADD R4,R1,#-1 ; R4 = LENGTH - 1
    AND R3,R3,#0 ; Clear R3
    ADD R3,R0,R4 ; Create Address
    LDR R3,R3,#0 ; R3 = ARR[LENGTH - 1] = LAST_ELEMENT

    AND R4,R4,0 ; Clears R4
    ADD R4,R0,R2 ; Create Address
    LDR R4,R4,#0 ; R4 = ARR[n]

    NOT R3,R3 
    ADD R3,R3,#1 ; R3 = - LAST_ELEMENT

    IF2 ADD R3,R4,R3 ; (ARR[n] - LAST_ELEMENT > 0)
    BRnz ENDWHILE

    ADD R2,R2,#1 ; n++
    AND R3,R3,#0 ; Clear R3
    ADD R3,R0,R2 ; Create Address
;;   LDR R3,R3,#0 ; R3 = arr[n + 1] ; DELETED as it should not be the value
    STR R4,R3,#0 ; Arr[n + 1] = Arr[n]

    ADD R2,R2,#-2 ; n (pre increment) - 1

    BR WHILE

    ENDWHILE

    ADD R2,R2,#1 ; n + 1
    AND R3,R3,#0 ; Clear R3
    ADD R3,R0,R2 ; Create Address
    LDR R3,R3,#0 ; R3 = arr[n + 1]
    AND R4,R4,#0 ; Clears R4
    ADD R4,R1,#-1 ; R4 = LENGTH - 1
    ADD R4,R0,R4 ; Create Address
    LDR R4,R4,#0 ; R4 = ARR[LENGTH - 1] = LAST_ELEMENT
    STR R4,R3,#0 ; Arr[n + 1] = LAST_ELEMENT

    EXIT

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

;; Needed to Simulate Subroutine Call in Complx
STACK .fill xF000
.end

.orig x4000	;; Array : You can change these values for debugging!
    .fill 2
    .fill 3
    .fill 1
    .fill 1
    .fill 6
.end