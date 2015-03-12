;;; fixed-point-of-transform.scm

(load "fixed-point.scm")

(define (fixed-point-of-transform g transform guess)
    (fixed-point (transform g) guess))
