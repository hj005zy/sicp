;;; 44-repeat-smooth.scm

(load "44-smooth.scm")
(load "43-repeated.scm")

(define (repeat-smooth f n)
    ((repeated smooth n) f))
