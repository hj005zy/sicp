;;; prime-sum-pair.scm

(define (prime-sum-pair list1 list2)
    (let ((a (an-elment-of list1))
          (b (an-element-of list2)))
        (require (prime? (+ a b)))
        (list a b)))
