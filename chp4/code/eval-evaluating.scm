;;; eval-evaluating.scm

(define (self-evaluating? exp)
    (cond ((number? exp) true)
          ((string? exp) true)
          (else false)))
