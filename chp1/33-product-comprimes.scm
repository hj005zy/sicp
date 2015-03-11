;;; 33-product-comprimes.scm

(load "gcd.scm")
(load "identity.scm")
(load "inc.scm")
(load "33-filtered-accumulate.scm")

(define (product-comprimes n)
    (define (comprime? i)
        (= (gcd i n) 1))
    (filtered-accumulate * comprime? 1 identity 2 inc n))
