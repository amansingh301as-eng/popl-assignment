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
