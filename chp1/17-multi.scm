;;; 17-multi.scm

(define (double n)
    (+ n n))

(define (halve n)
    (/ n 2))

(define (multi a b)
    (cond ((= b 0) 0)
          ((even? b) (multi (double a)
                            (halve b)))
          (else (+ a (multi a
                            (- b 1))))))
