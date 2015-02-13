;;; apply.scm

(define (apply procedure arguments)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure procedure arguments))
          ((compound-procedure? procedure)
           (eval-sequence
               (procedure-body procedure)
               (extend-environment
                   (procedure-parameters procedure)
                   arguments
                   (procedure-environment procedure))))
          (else (error "Unknown procedure type -- APPLY" procedure))))

(define (make-procedure parameters body env)
    (list 'procedure parameters body env))

(define (compound-procedure? p)
    (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))

(define (procedure-body p) (caddr p))

(define (procedure-enviroment p) (cadddr p))
