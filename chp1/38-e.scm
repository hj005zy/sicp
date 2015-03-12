;;; 38-e.scm

(load "37-cont-frac-iter.scm")

(define (e k)
    (define (n i) 1.0)
    (define (d i)
        (if (= (remainder (+ i 1) 3) 0)
            (* 2 (/ (+ i 1) 3))
            1))
    (+ 2 (cont-frac n d k)))
