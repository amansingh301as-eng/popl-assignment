#lang racket/base

; Tests for S1 (Binary Tree Traversals)
; Run with: racket tests/test_q3.rkt

(require racket/include)
(include "../code/7_q3.rkt")

;; ---------- Test Trees ----------

;; t1: Balanced tree from assignment
(define t1 '(4 (2 (1 () ()) (3 () ()))
               (6 (5 () ()) (7 () ()))))

;; t2: Right-skewed tree from assignment
(define t2 '(1 () (2 () (3 () ()))))

;; t3: Tree with symbol values from assignment
(define t3 '(a (b () ()) (c () ())))

;; Empty tree
(define t-empty '())

;; Single node tree
(define t-single '(99 () ()))

;; Left-skewed tree
(define t-left-skew '(3 (2 (1 () ()) ()) ()))

;; ---------- Test Executions ----------

(display "=== S1 Test: t1 (balanced tree) ===\n")
(print-inorder t1)
(print-all-traversals t1)
(print-height-and-leaves t1)

(display "=== S1 Test: t2 (right-skewed) ===\n")
(print-all-traversals t2)
(print-height-and-leaves t2)

(display "=== S1 Test: t3 (symbols) ===\n")
(print-all-traversals t3)
(print-height-and-leaves t3)

(display "=== S1 Test: empty tree ===\n")
(print-inorder t-empty)
(print-all-traversals t-empty)
(print-height-and-leaves t-empty)

(display "=== S1 Test: single node ===\n")
(print-inorder t-single)
(print-all-traversals t-single)
(print-height-and-leaves t-single)

(display "=== S1 Test: left-skewed ===\n")
(print-all-traversals t-left-skew)
(print-height-and-leaves t-left-skew)

(display "All S1 test calls completed.\n")
