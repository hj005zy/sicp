;;; estimate-pi-3.scm

(load "monte-carlo-stream.scm")

(define pi
    (stream-map (lambda (p) (sqrt (/ 6 p)))
                (monte-carlo cesaro-stream 0 0)))
