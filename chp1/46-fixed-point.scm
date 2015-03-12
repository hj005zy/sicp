;;; 46-fixed-point.scm

(load "07-good-enough.scm")
(load "46-iterative-improve.scm")

(define (fixed-point f first-guess)
    ((iterative-improve good-enough? f) 1.0))
