;;; 36-formula-root-average-damp.scm

(load "average.scm")
(load "36-fixed-point.scm")
(load "36-formula.scm")

(define formula-root
    (fixed-point (lambda (x) (average x (formula x))) 2))
