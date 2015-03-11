;;; random-numbers.scm

(load "random-init.scm")
(load "rand-update.scm")

(define random-numbers
    (cons-stream random-init
                 (stream-map rand-update random-numbers)))
