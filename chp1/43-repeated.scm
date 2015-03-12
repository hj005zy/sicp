;;; 43-repeated.scm

(load "42-compose.scm")
(load "identity.scm")

(define (repeated f n)
    (define (iter f n result)
        (cond ((= n 0) result)
              ((even? n)
               (iter (compose f f)
                     (/ n 2)
                     result))
              (else (iter f
                          (- n 1)
                          (compose f result)))))
    (lambda (x)
        ((iter f n identity) x)))
