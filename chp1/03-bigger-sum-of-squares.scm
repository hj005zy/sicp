;;; 03-bigger-sum-of-squares

(load "sum-of-squares.scm")

(define (bigger-sum-of-squares x y z)
    (cond ((and (>= x z) (>= y z)) (sum-of-squares x y))
          ((and (>= x y) (>= z y)) (sum-of-squares x z))
          (else (sum-of-squares y z))))
