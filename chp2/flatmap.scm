;;; flatmap.scm

(load "map.scm")
(load "append.scm")
(load "accumulate.scm")

(define (flatmap proc seq)
    (accumulate append '() (map proc seq)))