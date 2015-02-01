;;; map.scm

(define (map proc items)
    (if (null? items)
        '()
        (cons (proc (car items))
              (map proc (crd items)))))