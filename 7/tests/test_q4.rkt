; Tests for S2 (Conditionally Insert into a Nested List)
; Run: cat code/7_q4.rkt tests/test_q4.rkt > /tmp/q4.rkt && racket /tmp/q4.rkt
; Prints PASS or FAIL for each check, and exits with status 1 if any check fails.

;; ---------- Test Helpers ----------

; check-value : string any any -> boolean
; Prints PASS when actual equals expected. Otherwise prints FAIL. Large
; values are not printed, so a failure stays readable.
(define (check-value name actual expected)
  (if (equal? actual expected)
      (begin (display "PASS: ") (display name) (newline) #t)
      (begin (display "FAIL: ") (display name) (newline) #f)))

; run-with-input : string -> string
; Runs print-insert-result on the given standard input and returns its
; exact printed output.
(define (run-with-input input)
  (let ((port (open-output-string)))
    (parameterize ((current-input-port (open-input-string input))
                   (current-output-port port))
      (print-insert-result))
    (get-output-string port)))

; report-results : string list -> void
; Prints the summary, and exits with status 1 if any result is #f.
(define (report-results label results)
  (let loop ((remaining results) (passed 0) (total 0))
    (cond ((null? remaining)
           (display label) (display ": ")
           (display passed) (display "/") (display total)
           (display " tests passed") (newline)
           (if (= passed total) (void) (exit 1)))
          ((car remaining) (loop (cdr remaining) (+ passed 1) (+ total 1)))
          (else (loop (cdr remaining) passed (+ total 1))))))

;; ---------- Large Test Data ----------

; make-deep : integer any -> list
; A list nested depth levels deep, with val in the innermost list.
(define (make-deep depth val)
  (let loop ((d depth) (cur (list val)))
    (if (<= d 1)
        cur
        (loop (- d 1) (list cur)))))

; make-deep-inserted : integer any any -> list
; The expected result when x is inserted into every level of make-deep.
(define (make-deep-inserted depth val x)
  (let loop ((d depth) (cur (list x val)))
    (if (<= d 1)
        cur
        (loop (- d 1) (list x cur)))))

; make-repeated : integer any -> list
; A list containing item n times.
(define (make-repeated n item)
  (let loop ((count n) (acc '()))
    (if (<= count 0)
        acc
        (loop (- count 1) (cons item acc)))))

(define deep-100 (make-deep 100 1))
(define big-10k (make-repeated 10000 0))
(define big-sublists (make-repeated 10000 '(0)))

;; ---------- Checks ----------

(define s2-results
  (list
   ;; Assignment examples through standard input
   (check-value "stdin example 1"
                (run-with-input "42 ((1 2) (3 4 5) (6) ()) 3")
                "((42 1 2) (3 4 5) (42 6) (42))\n")
   (check-value "stdin example 2"
                (run-with-input "0 (((1) 2) (3) ((4 5 6) ())) 3")
                "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n")
   (check-value "stdin example 3"
                (run-with-input "7 () 3")
                "(7)\n")
   (check-value "stdin example 4"
                (run-with-input "7 () 0")
                "()\n")
   ;; Assignment examples through insert-if-short
   (check-value "insert-if-short example 1"
                (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
                '((42 1 2) (3 4 5) (42 6) (42)))
   (check-value "insert-if-short example 2"
                (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
                '((0 (0 1) 2) (0 3) (0 (4 5 6) (0))))
   (check-value "insert-if-short example 3"
                (insert-if-short 7 '() 3)
                '(7))
   (check-value "insert-if-short example 4"
                (insert-if-short 7 '() 0)
                '())
   ;; Helpers
   (check-value "my-length of empty list" (my-length '()) 0)
   (check-value "my-length counts top-level elements"
                (my-length '(1 (2 3) ()))
                3)
   (check-value "my-map preserves order"
                (my-map (lambda (v) (+ v 1)) '(1 2 3))
                '(2 3 4))
   ;; make-inserter with custom predicates
   (check-value "make-inserter with length = 1"
                ((make-inserter 9 (lambda (k) (= k 1))) '((a) (b c) ()))
                '((9 a) (b c) ()))
   (check-value "make-inserter with length >= 2"
                ((make-inserter 'y (lambda (k) (>= k 2))) '((1 2) (3) ()))
                '(y (y 1 2) (3) ()))
   ;; Length boundaries and empty lists
   (check-value "flat list shorter than n"
                (insert-if-short 'x '(1 2) 3)
                '(x 1 2))
   (check-value "flat list equal to n"
                (insert-if-short 'x '(1 2 3) 3)
                '(1 2 3))
   (check-value "flat list longer than n"
                (insert-if-short 'x '(1 2 3 4) 3)
                '(1 2 3 4))
   (check-value "nested empty lists"
                (insert-if-short 'x '(() (())) 2)
                '((x) (x (x))))
   (check-value "n = 0 changes nothing"
                (insert-if-short 'x '(1 (2) ()) 0)
                '(1 (2) ()))
   ;; Nesting depth 100
   (check-value "depth 100 inserts at every level"
                (insert-if-short 'z deep-100 2)
                (make-deep-inserted 100 1 'z))
   (check-value "depth 100 unchanged when n = 1"
                (insert-if-short 'z deep-100 1)
                deep-100)
   ;; Lists of 10,000 elements
   (check-value "my-length of 10,000 elements" (my-length big-10k) 10000)
   (check-value "10,000 elements with insertion"
                (insert-if-short 'head big-10k 10001)
                (cons 'head big-10k))
   (check-value "10,000 elements equal to n"
                (insert-if-short 'head big-10k 10000)
                big-10k)
   (check-value "10,000 sublists with insertion"
                (insert-if-short 'q big-sublists 2)
                (make-repeated 10000 '(q 0)))))

(report-results "S2" s2-results)
