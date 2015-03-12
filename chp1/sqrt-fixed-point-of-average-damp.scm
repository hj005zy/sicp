;;; sqrt-fixed-point-of-average-damp.scm

(load "fixed-point-of-transform.scm")
(load "average-damp.scm")

(define (sqrt x)
    (fixed-point-of-transform (lambda (y) (/ x y))
                              average-damp
                              1.0))
