;;; query-driver-loop.scm

(load "display-stream.scm")
(load "query-eval.scm")

(define input-prompt ";;; Query input;")
(define output-prompt ";;; Query results:")

(define (query-driver-loop)
    (prompt-for-input input-prompt)
    (let ((q (query-syntax-process (read))))
        (cond ((assertion-to-be-added? q)
               (add-rule-or-assertion! (add-assertion-body q))
               (newline)
               (display "Assertion added to data base.")
               (query-driver-loop))
              (else
                  (newline)
                  (display output-prompt)
                  (display-stream
                      (stream-map
                          (lambda (frame)
                              (instantiate q
                                           frame
                                           (lambda (v f)
                                               (contract-question-mark v))))
                          (qeval q (singleton-stream '()))))
                  (query-driver-loop)))))

(define (prompt-for-input string)
    (newline) (newline) (display string) (newline))

(define (instantiate exp frame unbound-var-huandler)
    (define (copy exp)
        (cond ((var? exp)
               (let ((binding (binding-in-frame exp frame)))
                   (if binding
                       (copy (binding-value binding))
                       (unbound-var-handler exp frame))))
              ((pair? exp)
               (cons (copy (car exp)) (copy (cdr exp))))
              (else exp)))
    (copy exp))

(define (query-syntax-process exp)
    (map-over-symbols expand-question-mark exp))

(define (map-over-symbols proc exp)
    (cond ((pair? exp)
           (cons (map-over-symbols proc (car exp))
                 (map-over-symbols proc (cdr exp))))
          ((symbol? exp) (proc exp))
          (else exp)))

(define (expand-question-mark symbol)
    (let ((chars (symbol->string symbol)))
        (if (string=? (substring chars 0 1) "?")
            (list '?
                  (string->symbol
                      (substring chars 1 (string-length chars))))
            symbol)))

(define (contract-question-mark variable)
    (string->symbol
        (string-append "?"
            (if (number? (cadr variable))
                (string-append (symbol->string (caddr variable))
                               "="
                               (number->string (cadr variable)))
                (symbol->string (cadr variable))))))
