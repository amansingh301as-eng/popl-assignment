#lang racket/base

; S1 - group 7
; Binary Tree Traversals in Scheme
; Binary tree is either () or (value left right).
; Only allowed built-ins from racket/base are used; append/length are forbidden.

; ---------- Traversal Accumulator Helpers ----------

; inorder-acc : tree list -> list
; Returns the list of tree node values in inorder (left, node, right)
; prepended onto acc, without using append.
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree)
                         (inorder-acc (caddr tree) acc)))))

; preorder-acc : tree list -> list
; Returns the list of tree node values in preorder (node, left, right)
; prepended onto acc, without using append.
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree)
                          (preorder-acc (caddr tree) acc)))))
