;;; 01-make-accumulator.scm

(define (make-accumulator value)
    (lambda (value-to-add)
        (set! value (+ value value-to-add))
        value))
