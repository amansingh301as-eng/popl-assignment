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

; postorder-acc : tree list -> list
; Returns the list of tree node values in postorder (left, right, node)
; prepended onto acc, without using append.
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree)
                                    (cons (car tree) acc)))))

; ---------- Tree Metrics Helpers ----------

; tree-height : tree -> integer
; The height of () is 0. A node's height is 1 + max(height(left), height(right)).
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                (tree-height (caddr tree))))))
