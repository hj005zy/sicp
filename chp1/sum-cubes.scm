;;; sum-cubes.scm

(load "cube.scm")
(load "inc.scm")
(load "sum.scm")

(define (sum-cubes a b)
    (sum cube a inc b))
