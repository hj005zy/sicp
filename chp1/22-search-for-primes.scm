;;; 22-search-for-primes.scm

(load "prime.scm")

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (real-time-clock)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (real-time-clock) start-time))
        false))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
    true)

(define (next-odd n)
    (if (odd? n)
        (+ n 2)
        (+ n 1)))

(define (search-for-primes n)
    (define (search-for-primes-iter n counter)
        (cond ((= counter 3)
               (newline)
               (display "ok"))
              ((timed-prime-test (next-odd n))
               (search-for-primes-iter (next-odd n) (+ counter 1)))
              (else (search-for-primes-iter (next-odd n) counter))))
    (search-for-primes-iter n 0))
