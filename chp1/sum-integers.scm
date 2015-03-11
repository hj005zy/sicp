;;; sum-integers.scm

(load "identity.scm")
(load "inc.scm")
(load "sum.scm")

(define (sum-integers a b)
    (sum identity a inc b))
