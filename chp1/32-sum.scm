;;; 32-sum.scm

(load "32-accumulate-iter.scm")

(define (sum term a next b)
    (accumulate + 0 term a next b))
