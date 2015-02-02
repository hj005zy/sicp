;;; 42-queens.scm

(load "map.scm")
(load "filter.scm")
(load "flatmap.scm")

(define empty-board '())

(define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))

(define (check-placed-queen-iter row-of-new-queen rest-of-queens distance)
    (if (null? rest-of-queens)
        #t
        (let ((row-of-current-queen (car rest-of-queens)))
            (if (or (= row-of-new-queen row-of-current-queen)
                    (= row-of-new-queen (+ row-of-current-queen distance))
                    (= row-of-new-queen (- row-of-current-queen distance)))
                #f
                (check-placed-queen-iter row-of-new-queen (cdr rest-of-queens) (+ distance 1))))))

(define (safe? k position)
    (check-placed-queen-iter (car position) (cdr position) 1))

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter (lambda (positions) (safe? k positions))
                    (flatmap (lambda (rest-of-queens)
                                 (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                                      (enumerate-interval 1 board-size)))
                             (queen-cols (- k 1))))))
    (queen-cols board-size))