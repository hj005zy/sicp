;;; 31-factorial.scm

(load "identity.scm")
(load "inc.scm")
(load "31-product-iter.scm")

(define (factorial a b)
    (product identity a inc b))
