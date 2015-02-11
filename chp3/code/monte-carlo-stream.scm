;;; monte-carlo-stream.scm

(load "random-numbers.scm")

(define (map-successive-pairs f s)
    (cons-stream
        (f (stream-car s) (stream-car (stream-cdr s)))
        (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
    (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                          random-numbers))

(define (monte-carlo experiment-stream passed failed)
    (define (next passed failed)
        (cons-stream (/ passed (+ passed failed))
                     (monte-carlo
                         (stream-cdr experiment-stream) passed failed)))
    (if (stream-car experiment-stream)
        (next (+ passed 1) failed)
        (next passed (+ failed 1))))
