;;; permutations.scm

(load "flatmap.scm")

(define (remove item sequence)
    (filter (lambda(x) (not (= x item)))
            sequence))

(define (permutations s)
    (if (null? s)
        (list '())
        (flatmap (lambda (x)
                     (map (lambda (p) (cons x p))
                          (permutations (remove x s))))
                 s)))