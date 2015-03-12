;;; 46-iterative-improve.scm

(define (iterative-improve good-enough? improve)
    (define (try guess)
        (let ((new-guess (improve guess)))
            (if (good-enough? guess new-guess)
                new-guess
                (try new-guess))))
    try)
