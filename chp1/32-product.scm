;;; 32-product.scm

(load "32-accumulate-iter.scm")

(define (product term a next b)
    (accumulate * 1 term a next b))
