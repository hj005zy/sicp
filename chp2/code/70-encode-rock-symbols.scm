;;; 70-encode-rock-symbols.scm

(load "68-encode.scm")
(load "69-generate-huffman-tree.scm")

(define tree (generate-huffman-tree '((A 1) (NA 16) (BOOM 1) (SHA 3) (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define message-1 '(Get a job))
(define message-2 '(Sha na na na na na na na na))
(define message-3 '(Wah yip yip yip yip yip yip yip yip yip))
(define message-4 '(Sha boom))
