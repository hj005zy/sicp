;;; complex-numbers.scm

(load "types.scm")
(load "complex-numbers-rectangular-form.scm")
(load "complex-numbers-polar-form.scm")

(define (real-part z)
    (cond ((rectangular? z)
           (real-part-rectangular (contents z)))
          ((polar? z)
           (real-part-polar (contents z)))
          (else (error "Unknown type -- REAL-PART" z))))

(define (imag-part z)
    (cond ((rectangular? z)
           (imag-part-rectangular (contents z)))
          ((polar? z)
           (imag-part-polar (contents z)))
          (else (error "Unknown type -- IMAG-PART" z))))

(define (magnitude z)
    (cond ((rectangular? z)
           (magnitude-rectangular (contents z)))
          ((polar? z)
           (magnitude-polar (contents z)))
          (else (error "Unknown type -- MAGNITUDE" z))))

(define (angle z)
    (cond ((rectangular? z)
           (angle-rectangular (contents z)))
          ((polar? z)
           (angle-polar (contents z)))
          (else (error "Unknown type -- ANGLE" z))))

(define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

(define (make-from-real-imag x y)
    (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
    (make-from-mag-ang-polar r a))

(define (rectangular? z)
    (eq? (type-tag z) 'rectangular))

(define (polar? z)
    (eq? (type-tag z) 'polar))
