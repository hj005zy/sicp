;;; divisible.scm

(define (divisible? x y)
    (= (remainder x y) 0))
