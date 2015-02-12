;;; pi-stream.scm

(load "55-partial-sums.scm")
(load "scale-stream.scm")

(define (pi-summands n)
    (cons-stream (/ 1.0 n)
                 (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
    (scale-stream (partial-sums (pi-summands 1)) 4))
