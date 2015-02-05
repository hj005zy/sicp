;;; 69-generate-huffman-tree.scm

(load "huffman-tree.scm")

(define (generate-huffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define (successive-merge pairs)
    (cond ((= (length pairs) 0) '())
          ((= (length pairs) 1) (car pairs))
          (else (successive-merge (adjoin-set (make-code-tree (car pairs) (cadr pairs))
                                              (cddr pairs))))))
