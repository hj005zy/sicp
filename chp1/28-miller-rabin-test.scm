;;; 28-miller-rabin-test.scm

(define (trivial-square-root-test a n)
    (if (and (not (= a 1))
             (not (= a (- n 1)))
             (= (remainder (square a) n) 1))
        0
        a))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (trivial-square-root-test
                                  (expmod base (/ exp 2) m)
                                  m))
                      m))
          (else (remainder (* base (expmod base (- exp 1) m))
                           m))))

(define (miller-rabin-test n)
    (define (try-it a)
        (= (expmod a (- n 1) n) 1))
    (try-it (+ 1 (random (- n 1)))))
