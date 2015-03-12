;;; sqrt-improve.scm

(load "average.scm")

(define (improve guess x)
    (average guess (/ x guess)))
