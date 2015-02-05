;;; complex-numbers-rectangular-form.scm

(define (real-part-rectangular z) (car z))

(define (imag-part-rectangular z) (cdr z))

(define (magnitude-rectangular z)
    (sqrt (+ (square (real-part-rectangular z))
             (square (imag-part-rectangular z)))))

(define (angle-rectangular z)
    (atan (imag-part-rectangular z)
          (real-part-rectangular z)))

(define (make-from-real-imag-rectangular x y )
    (attach-tag 'rectangular (cons x y)))

(define (make-from-mag-ang-rectangular r a)
    (attach-tag 'rectangular
                (cons (* r (cons a)) (* r (sin a)))))
