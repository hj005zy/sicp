;;; 27-carmichael-test.scm

(define (congruent? a n)
    (= (expmod a n n) a))

(define (carmichael-test n)
    (define (carmichael-test-iter a n)
        (cond ((= a n) true)
              ((congruent? a n)
               (carmichael-test-iter (+ a 1) n))
              (else false)))
    (carmichael-test-iter 1 n))
