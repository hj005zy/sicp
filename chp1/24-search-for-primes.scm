;;; 24-search-for-primes.scm

(load "22-search-for-primes.scm")
(load "fast-prime.scm")

(define (start-prime-test n start-time)
    (if (fast-prime? n 3)
        (report-prime (- (real-time-clock) start-time))
        false))
