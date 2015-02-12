;;; rand-update.scm

(define (rand-update x)
    (let ((a 1461169)
          (b 643919)
          (m 2757917))
        (modulo (+ (* a x) b) m)))
