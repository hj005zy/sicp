;;; 37-cont-frac-iter.scm

(define (cont-frac n d k)
    (define (iter result i)
        (if (= i 0)
            result
            (iter (/ (n i)
                     (+ (d i) result))
                  (- i 1))))
    (iter 0 k))
