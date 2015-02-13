;;; eval.scm

(load "eval-variable.scm")
(load "eval-quote.scm")
(load "eval-assignment.scm")
(load "eval-definition.scm")
(load "eval-if.scm")
(load "eval-lambda.scm")
(load "eval-begin.scm")
(load "eval-cond.scm")
(load "eval-application.scm")

(define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (look-variable-value exp env))
          ((quoted? exp) (text-of-quotation exp))
          ((assignment? exp) (eval-assignment exp env))
          ((definition? exp) (eval-definition exp env))
          ((if? exp) (eval-if exp env))
          ((lambda? exp)
           (make-procedure (lambda-parameters exp)
                           (lambda-body exp)
                           env))
          ((begin? exp)
           (eval-sequence (begin-actions exp) env))
          ((cond? exp) (eval (cond->if exp) env))
          ((application? exp)
           (apply (eval (operator exp) env)
                  (list-of-values (operands exp) env)))
          (else (error "Unknown expression type -- EVAL" exp))))

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

(define (list-of-values exps env)
    (if (no-operands? exps)
        '()
        (cons (eval (first-operand exps) env)
              (list-of-values (rest-operands exps) env))))

(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps) env))))

(define (self-evaluating? exp)
    (cond ((number? exp) true)
          ((string? exp) true)
          (else false)))

(define (tagged-list? exp tag)
    (if (pair? exp)
        (eq? (car exp) tag)
        false))

(define (true? x)
    (not (eq? x false)))

(define (false? x)
    (eq? x false))

