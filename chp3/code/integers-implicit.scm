;;; integers-implicit.scm

(load "add-streams.scm")

(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))
