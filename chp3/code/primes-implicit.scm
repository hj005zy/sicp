;;; primes-implicit.scm

(load "divisible.scm")
(load "integers.scm")

(define (prime? n)
    (define (iter ps)
        (cond ((> (square (stream-car ps)) n) true)
              ((divisible? n (stream-car ps)) false)
              (else (iter (stream-cdr ps)))))
    (iter primes))

(define primes
    (cons-stream 2 (stream-filter prime? (integers-starting-from 3))))
