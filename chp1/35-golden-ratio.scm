;;; 35-golden-ratio.scm

(load "fixed-point.scm")

(define golden-ratio
    (fixed-point (lambda (y) (+ 1 (/ 1 y)))
                 1.0))
