;;; estimate-pi-3.scm

(load "monte-carlo-stream.scm")

(define (map-successive-pairs f s)
    (cons-stream
        (f (stream-car s) (stream-car (stream-cdr s)))
        (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
    (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                          random-numbers))

(define pi
    (stream-map (lambda (p) (sqrt (/ 6 p)))
                (monte-carlo cesaro-stream 0 0)))
