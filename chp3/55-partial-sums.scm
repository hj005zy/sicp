;;; 55-partial-sums.scm

(load "add-streams.scm")

(define (partial-sums s)
    (cons-stream (stream-car s)
                 (add-streams (stream-cdr s)
                              (partial-sums s))))
