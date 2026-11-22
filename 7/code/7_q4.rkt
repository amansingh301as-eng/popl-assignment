#lang racket/base

; S2 - group 7
; Conditionally Insert into a Nested List in Scheme
; Inserts atom x at the front of every list whose original length is < n,
; at all nesting levels.

; ---------- Helper Functions ----------

; my-length : list -> integer
; Returns the number of top-level elements in lst using tail recursion.
(define (my-length lst)
  (let loop ((rest lst) (count 0))
    (if (null? rest)
        count
        (loop (cdr rest) (+ count 1)))))

; my-reverse : list -> list
; Reverses a list using a tail-recursive accumulator.
(define (my-reverse lst)
  (let loop ((rest lst) (acc '()))
    (if (null? rest)
        acc
        (loop (cdr rest) (cons (car rest) acc)))))

; my-map : (any -> any) list -> list
; Maps fn over each element of lst, preserving order using tail recursion.
(define (my-map fn lst)
  (let loop ((rest lst) (acc '()))
    (if (null? rest)
        (my-reverse acc)
        (loop (cdr rest) (cons (fn (car rest)) acc)))))
