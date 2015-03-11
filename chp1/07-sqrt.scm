;;; 07-sqrt.scm

(load "sqrt.scm")

(define (good-enough? old-guess new-guess)
    (< (/ (abs (- old-guess new-guess)) old-guess) 0.001))

(define (sqrt-iter guess x)
    (if (good-enough? guess (improve guess x))
        (improve guess x)
        (sqrt-iter (improve guess x) x)))
