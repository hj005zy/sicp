;;; 33-filtered-accumulate.scm

(define (filtered-accumulate combiner filter-test null-value term a next b)
    (cond ((> a b) null-value)
          ((filter-test a)
           (combiner (term a)
                     (filtered-accumulate
                         combiner
                         filter-test
                         null-value
                         term
                         (next a)
                         next
                         b)))
          (else (filtered-accumulate combiner
                                     filter-test
                                     null-value
                                     term
                                     (next a)
                                     next
                                     b))))
