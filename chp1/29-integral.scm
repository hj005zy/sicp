;;; 29-integral.scm

(load "sum.scm")    

(define (integral f a b n)
    (define h (/ (- b a) n))
    (define (add-double-h x)
        (+ x h h))
    (if (odd? n)
        (error "n must be even")
        (* (/ h 3)
           (+ (f a)
              (* 2 (sum f (+ a h h) add-double-h (- b h h)))
              (* 4 (sum f (+ a h) add-double-h (- b h)))
              (f b)))))
