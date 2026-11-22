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

; tree-leaves : tree -> integer
; Returns the number of leaf nodes in tree. An empty tree has 0 leaves.
; A leaf has both left and right subtrees empty.
(define (tree-leaves tree)
  (cond ((null? tree) 0)
        ((and (null? (cadr tree)) (null? (caddr tree))) 1)
        (else (+ (tree-leaves (cadr tree))
                 (tree-leaves (caddr tree))))))

; ---------- Task S1.a: Print Inorder ----------

; print-inorder : tree -> void
; Prints the list of tree node values in inorder on one line, ending with a newline.
(define (print-inorder tree)
  (display (inorder-acc tree '()))
  (newline))

; ---------- Task S1.b: Print All Traversals ----------

; print-all-traversals : tree -> void
; Prints the inorder, preorder, and postorder traversal lists on three separate lines.
(define (print-all-traversals tree)
  (display (inorder-acc tree '()))
  (newline)
  (display (preorder-acc tree '()))
  (newline)
  (display (postorder-acc tree '()))
  (newline))
