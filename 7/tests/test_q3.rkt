; Tests for S1 (Binary Tree Traversals)
; Run: cat code/7_q3.rkt tests/test_q3.rkt > /tmp/q3.rkt && racket /tmp/q3.rkt
; Prints PASS or FAIL for each check, and exits with status 1 if any check fails.

;; ---------- Test Helpers ----------

; capture-output : (-> void) -> string
; Returns the exact text printed by thunk.
(define (capture-output thunk)
  (let ((port (open-output-string)))
    (parameterize ((current-output-port port))
      (thunk))
    (get-output-string port)))

; check-output : string (-> void) string -> boolean
; Prints PASS when thunk prints exactly expected. Otherwise prints FAIL
; with the expected and actual text.
(define (check-output name thunk expected)
  (let ((actual (capture-output thunk)))
    (if (equal? actual expected)
        (begin (display "PASS: ") (display name) (newline) #t)
        (begin (display "FAIL: ") (display name) (newline)
               (display "  expected: ") (write expected) (newline)
               (display "  actual:   ") (write actual) (newline)
               #f))))

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

;; ---------- Checks ----------

(define s1-results
  (list
   ;; t1: balanced tree
   (check-output "t1 inorder"
                 (lambda () (print-inorder t1))
                 "(1 2 3 4 5 6 7)\n")
   (check-output "t1 all traversals"
                 (lambda () (print-all-traversals t1))
                 "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n")
   (check-output "t1 height and leaves"
                 (lambda () (print-height-and-leaves t1))
                 "(3 4)\n")
   ;; t2: right-skewed tree
   (check-output "t2 all traversals"
                 (lambda () (print-all-traversals t2))
                 "(1 2 3)\n(1 2 3)\n(3 2 1)\n")
   (check-output "t2 height and leaves"
                 (lambda () (print-height-and-leaves t2))
                 "(3 1)\n")
   ;; t3: symbol values
   (check-output "t3 all traversals"
                 (lambda () (print-all-traversals t3))
                 "(b a c)\n(a b c)\n(b c a)\n")
   (check-output "t3 height and leaves"
                 (lambda () (print-height-and-leaves t3))
                 "(2 2)\n")
   ;; Empty tree
   (check-output "empty inorder"
                 (lambda () (print-inorder t-empty))
                 "()\n")
   (check-output "empty all traversals"
                 (lambda () (print-all-traversals t-empty))
                 "()\n()\n()\n")
   (check-output "empty height and leaves"
                 (lambda () (print-height-and-leaves t-empty))
                 "(0 0)\n")
   ;; Single node
   (check-output "single inorder"
                 (lambda () (print-inorder t-single))
                 "(99)\n")
   (check-output "single all traversals"
                 (lambda () (print-all-traversals t-single))
                 "(99)\n(99)\n(99)\n")
   (check-output "single height and leaves"
                 (lambda () (print-height-and-leaves t-single))
                 "(1 1)\n")
   ;; Left-skewed tree
   (check-output "left-skewed all traversals"
                 (lambda () (print-all-traversals t-left-skew))
                 "(1 2 3)\n(3 2 1)\n(1 2 3)\n")
   (check-output "left-skewed height and leaves"
                 (lambda () (print-height-and-leaves t-left-skew))
                 "(3 1)\n")))

(report-results "S1" s1-results)
