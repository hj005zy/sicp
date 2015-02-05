;;; complex-numbers-rectangular-form.scm

(define (make-from-real-imag-rectangular x y ) (cons x y))

(define (make-from-mag-ang-rectangular r a)
    (cons (* r (cons a)) (* r (sin a))))

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
    (sqrt (+ (square (real-part-rectangular z))
             (square (imag-part-rectangular z)))))

(define (angle-rectangular z)
    (atan (imag-part-rectangular z)
          (real-part-rectangular z)))
