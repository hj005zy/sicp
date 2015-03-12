;;; 46-sqrt.scm

(load "sqrt-improve.scm")
(load "07-good-enough.scm")
(load "46-iterative-improve.scm")

(define (sqrt x)
    ((iterative-improve good-enough?
                        (lambda (guess)
                            (improve guess x))) 1.0))
