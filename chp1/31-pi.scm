;;; 31-pi.scm

(load "inc.scm")
(load "31-product-iter.scm")

(define (next-odd n)
    (if (odd? n)
        (+ n 2)
        (+ n 1)))

(define (next-even n)
    (if (even? n)
        (+ n 2)
        (+ n 1)))

(define (pi n)
    (define (term x)
        (- 1 (/ 1 (square x))))
    (define (next x) (+ x 2))
    (* 4.0
       (product term 3 next n)))
