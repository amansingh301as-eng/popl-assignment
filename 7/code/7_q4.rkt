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

; ---------- Task S2.c: Higher-Order Inserter ----------

; make-inserter : atom (integer -> boolean) -> (list -> list)
; Returns a function of one argument (a list) that inserts atom x at the
; front of every list (at all nesting levels) whose length satisfies len-ok?.
; The length is measured on the original list before any insertion.
(define (make-inserter x len-ok?)
  (letrec ((process
             (lambda (lst)
               (let ((result
                      (my-map (lambda (item)
                                (if (or (pair? item) (null? item))
                                    (process item)
                                    item))
                              lst)))
                 (if (len-ok? (my-length lst))
                     (cons x result)
                     result)))))
    (lambda (lst) (process lst))))

; ---------- Task S2.b: Conditional Insert ----------

; insert-if-short : atom list integer -> list
; Inserts atom x at the front of every list whose original length is less than n,
; at all nesting levels, defined via make-inserter.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

; ---------- Task S2.a: Read and Print Result ----------

; print-insert-result : -> void
; Reads x, lst, n from standard input and prints the result of insert-if-short.
; Prints no prompt or extra text, ending with a newline.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
