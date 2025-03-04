;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - octalStringToInt
;;=============================================================
;; Name: Matthew Kistner
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  String octalString = "2110";
;;  int length = 4;
;;  int value = 0;
;;  int i = 0;
;;  while (i < length) {
;;      int leftShifts = 3;
;;      while (leftShifts > 0) {
;;          value += value;
;;          leftShifts--;
;;      }
;;      int digit = octalString[i] - 48;
;;      value += digit;
;;      i++;
;;  }
;;  mem[mem[RESULTADDR]] = value;

.orig x3000
    LD R0,OCTALSTRING ; R0 = OCTALSTRING
    LD R1,LENGTH ; R1 = LENGTH
    AND R2,R2,#0 ; Clears R2 for the value of value
    AND R4,R4,#0 ; Clears R4 to be the value of i

    NOT R1,R1 ; Negate LENGTH
    ADD R1,R1,#1 ; R3 = -LENGTH

    WHILE ADD R7,R4,R1 ; while (i - length < 0)
    BRzp ENDWHILE

    ADD R2,R2,R2 ; R2 * 2
    ADD R2,R2,R2 ; R2 * 4
    ADD R2,R2,R2 ; R2 * 8

    AND R3,R3,#0 ; clears R3
    ADD R3,R0,R4 ; address of octalString[i]
    LDR R3,R3,#0 ; R3 = octalString[i]

    LD R5,ASCII ; R5 = ASCII
    ADD R3,R3,R5 ; R3 = octalString[i] - ASCII

    ADD R2,R2,R3 ; R2 = value + digit

    ADD R4,R4,#1 ; i++

    BR WHILE
    ENDWHILE

    STI R2, RESULTADDR
    HALT
    
;; Do not change these values! 
;; Notice we wrote some values in hex this time. Maybe those values should be treated as addresses?
ASCII           .fill -48
OCTALSTRING     .fill x5000
LENGTH          .fill 4
RESULTADDR      .fill x4000
.end

.orig x5000                    ;;  Don't change the .orig statement
    .stringz "2110"            ;;  You can change this string for debugging!
.end
