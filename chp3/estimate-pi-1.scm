;;; estimate-pi-1.scm

(load "rand.scm")
(load "monte-carlo.scm")

(define (cesaro-test)
    (= (gcd (rand) (rand)) 1))

(define (estimate-pi trials)
    (sqrt (/ 6 (monte-carlo trials cesaro-test))))
