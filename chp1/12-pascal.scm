;;; 12-pascal.scm

(define (pascal row col)
    (cond ((> col row)
           (error "invalid col value"))
          ((or (= col 1) (= col row)) 1)
          (else (+ (pascal (- row 1) col)
                   (pascal (- row 1) (- col 1))))))
