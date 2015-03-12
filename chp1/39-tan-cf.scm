;;; 39-tan-cf.scm

(load "37-cont-frac-iter.scm")

(define (tan-cf x k)
    (define (n i)
        (if (= i 1)
            x
            (- (square x))))
    (define (d i)
        (- (* i 2) 1.0))
    (cont-frac n d k))
