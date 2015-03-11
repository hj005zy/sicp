;;; rand.scm

(load "random-init.scm")
(load "rand-update.scm")

(define rand
    (let ((x random-init))
        (lambda ()
	    (set! x (rand-update x))
	    x)))
