;;; 45-nth-root.scm

(load "fixed-point-of-transform.scm")
(load "average-damp.scm")
(load "43-repeated.scm")

(define (nth-root x n)
    (define (log2 n) (/ (log n) (log 2)))
    (fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1))))
                              (repeated average-damp (floor (log2 n)))
                              1.0))
