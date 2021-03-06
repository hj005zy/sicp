;;; 22-queue.scm

(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))
        (define (insert-queue! item)
            (let ((new-pair (cons item '())))
                (cond ((empty-queue?)
                       (set! front-ptr new-pair)
                       (set! rear-ptr new-pair)
                       front-ptr)
                      (else (set-cdr! rear-ptr new-pair)
                            (set! rear-ptr new-pair)
                            front-ptr))))
        (define (delete-queue!)
            (cond ((empty-queue?)
                   (erro "DELETE! called with an empty queue"))
                  (else (set! front-ptr (cdr front-ptr))
                   front-ptr)))
        (define (empty-queue?)
            (null? front-ptr))
        (define (dispatch m)
            (cond ((eq? m 'insert-queue!) insert-queue!)
                  ((eq? m 'delete-queue!) (delete-queue!))
                  ((eq? m 'empty-queue?) (empty-queue?))
                  (else (error "Unknow operation -- DISPATH" m))))
        dispatch))
