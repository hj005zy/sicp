;;; sqrt-newtons-method.scm

(load "newtons-method.scm")

(define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x))
                    1.0))
