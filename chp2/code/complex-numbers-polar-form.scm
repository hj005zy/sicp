;;; complex-numbers-polar-form.scm

(define (make-from-real-imag-polar x y )
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

(define (make-from-mag-ang-polar r a) (cons r a))

(define (real-part-polar z)
    (* (magnitude-polar z) (cos (angle-polar z))))

(define (imag-part-polar z)
    (* (magnitude-polar z) (sin (angle-polar z))))

(define (magnitude-polar z) (car z))

(define (angle-polar z) (cdr z))

