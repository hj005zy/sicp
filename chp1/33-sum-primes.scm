;;; 33-sum-primes.scm

(load "prime.scm")
(load "identity.scm")
(load "inc.scm")
(load "33-filtered-accumulate.scm")

(define (sum-primes a b)
    (filtered-accumulate + prime? 0 identity a inc b))
