#lang racket/base

(define (my-length lst)
  (let loop ((rest lst) (count 0))
    (if (null? rest)
        count
        (loop (cdr rest) (+ count 1)))))

(define (my-reverse lst)
  (let loop ((rest lst) (acc '()))
    (if (null? rest)
        acc
        (loop (cdr rest) (cons (car rest) acc)))))

(define (my-map fn lst)
  (let loop ((rest lst) (acc '()))
    (if (null? rest)
        (my-reverse acc)
        (loop (cdr rest) (cons (fn (car rest)) acc)))))

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

(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))
