;;=============================================================
;; CS 2110 - Spring 2023
;; Homework 5 - modulus
;;=============================================================
;; Name: Matthew Kistner
;;=============================================================

;;  Pseudocode (see PDF for explanation)
;;  Pseudocode values are based on the labels' default values.
;;
;;  int x = 17;
;;  int mod = 5;
;;  while (x >= mod) {
;;      x -= mod;
;;  }
;;  mem[ANSWER] = x;

.orig x3000

    LD R1,X ; R1 = X
    LD R2,MOD ; R2 = MOD

    NOT R2,R2 ; flips the bits of R2
    ADD R2,R2,#1 ; adds 1 to R2 so now R2 = -R2

    WHILE ADD R3,R1,R2 ; while (R1 >= R2)
    BRn ENDW1

    ADD R1,R1,R2; R1 = R1 + (-R2)

    BR WHILE
    ENDW1

    LEA R3,ANSWER ; R3 = ANSWER

    STR R1,R3,#0 ; mem[ANSWER] = R1

    HALT

    ;; Feel free to change the below values for debugging. We will vary these values when testing your code.
    X      .fill 17
    MOD    .fill 5     
    ANSWER .blkw 1
.end