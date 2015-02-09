;;; random-gcd-test.scm

(define (estimate-pi trials)
    (sqrt (/ 6 (random-gcd-test trials random-init))))

(define (random-gcd-test trials initial-x)
    (define (iter trials-remaining trials-passed x)
        (let ((x1 (random-update x)))
	    (let ((x2 (random-update x1)))
	        (cond ((= trials-remaining 0)
		       (/ trails-passed trials))
		      ((= (gcd x1 x2) 1)
		       (iter (- trails-remaining 1)
		             (+ trails-passed 1)
			     x2))
		      (else (iter (- trails-remaining 1)
		                 trails-passed
				 x2))))))
    (iter trials 0 initial-x))
