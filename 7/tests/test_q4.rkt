; Tests for S2 (Conditionally Insert into a Nested List)
; Run: cat code/7_q4.rkt tests/test_q4.rkt > /tmp/q4.rkt && racket /tmp/q4.rkt

;; ---------- Assignment Examples ----------

(display "=== Example 1 ===\n")
(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3))
(newline)

(display "=== Example 2 ===\n")
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3))
(newline)

(display "=== Example 3 ===\n")
(display (insert-if-short 7 '() 3))
(newline)

(display "=== Example 4 ===\n")
(display (insert-if-short 7 '() 0))
(newline)

(display "=== Example 5 (make-inserter with len=1) ===\n")
(display ((make-inserter 9 (lambda (n) (= n 1))) '((a) (b c) ())))
(newline)

;; ---------- Edge Cases ----------

(display "=== Edge Case: Flat list with length < n ===\n")
(display (insert-if-short 'x '(1 2) 3))
(newline)

(display "=== Edge Case: Flat list with length = n ===\n")
(display (insert-if-short 'x '(1 2 3) 3))
(newline)

;; ---------- Hidden Tests: Nesting Depth 100 ----------

(display "=== Hidden Test: Nesting Depth 100 ===\n")
(define (make-deep depth val)
  (let loop ((d depth) (cur (list val)))
    (if (<= d 1)
        cur
        (loop (- d 1) (list cur)))))

(define deep-100 (make-deep 100 1))
(define res-deep (insert-if-short 'z deep-100 2))
(display "Depth 100 processed successfully; head is: ")
(display (car res-deep))
(newline)

;; ---------- Hidden Tests: 10,000 Element List ----------

(display "=== Hidden Test: 10,000 Elements List ===\n")
(define (make-big n)
  (let loop ((count n) (acc '()))
    (if (<= count 0)
        acc
        (loop (- count 1) (cons 0 acc)))))

(define big-10k (make-big 10000))
(display "my-length of 10k list: ")
(display (my-length big-10k))
(newline)

(define res-big (insert-if-short 'head big-10k 10001))
(display "10k list after insertion length: ")
(display (my-length res-big))
(newline)
(display "First element is: ")
(display (car res-big))
(newline)

(display "All S2 test calls completed.\n")
