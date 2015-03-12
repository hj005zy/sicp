;;; sqrt-fixed-point-of-newton-transform.scm

(load "fixed-point-of-transform.scm")
(load "newton-transform.scm")

(define (sqrt x)
    (fixed-point-of-transform (lambda (y) (- (square y) x))
                              newton-transform
                              1.0))
