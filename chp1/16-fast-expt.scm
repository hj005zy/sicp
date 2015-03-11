;;; 16-fast-expt.scm

(define (fast-expt-iter b n product)
    (cond ((= n 0) product)
          ((even? n) (fast-expt-iter (square b) (/ n 2) product))
          (else (fast-expt-iter b (- n 1) (* b product)))))

(define (fast-expt b n)
    (fast-expt-iter b n 1))
