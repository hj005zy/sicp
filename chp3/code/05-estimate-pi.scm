;;; 05-estimate-pi.scm

(load "monte-carlo.scm")
(load "random-in-range.scm")

(define (estimate-integral P x1 x2 y1 y2 trials)
    (let ((rectangle-square (* (abs (- x1 x2)) (abs (- y1 y2)))))
         (* rectangle-square
            (monte-carlo trials
                         (lambda ()
                             (P (random-in-range x1 x2)
                                (random-in-range y1 y2)))))))

(define (estimate-pi trials)
    (let ((x1 (* 1.0 (random-in-range 0 100)))
          (y1 (* 1.0 (random-in-range 0 100)))
          (r (* 1.0 (random-in-range 1 50))))
        (let ((x2 (+ x1 (* r 2)))
              (y2 (+ y1 (* r 2))))
             (define (P x y)
                (< (+ (square (- x x1 r))
                      (square (- y y1 r)))
                   (square r)))
             (/ (estimate-integral P x1 x2 y1 y2 trials) (square r)))))
