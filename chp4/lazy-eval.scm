;;; eval-lazy.scm
;;; load "apply-in-underlying-scheme.scm" manually first

(load "eval-syntax.scm")
(load "thunk.scm")

(define (eval exp env)
    (cond ((self-evaluating? exp) exp)
          ((variable? exp) (lookup-variable-value exp env))
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
           (apply (actual-value (operator exp) env)
                  (operands exp)
                  env))
          (else (error "Unknown expression type -- EVAL" exp))))

(define (apply procedure arguments env)
    (cond ((primitive-procedure? procedure)
           (apply-primitive-procedure
               procedure
               (list-of-arg-values arguments env)))   ; changed
          ((compound-procedure? procedure)
           (eval-sequence
               (procedure-body procedure)
               (extend-environment
                   (procedure-parameters procedure)
                   (list-of-delayed-args arguments env)   ; changed
                   (procedure-environment procedure))))
          (else (error "Unknown procedure type -- APPLY" procedure))))

(define (actual-value exp env)
    (force-it (eval exp env)))

(define (list-of-arg-values exps env)
    (if (no-operands? exps)
        '()
        (cons (actual-value (first-operand exps) env)
              (list-of-arg-values (rest-operands exps)
                                  env))))

(define (list-of-delayed-args exps env)
    (if (no-operands? exps)
        '()
        (cons (delay-it (first-operand exps) env)
              (list-of-delayed-args (rest-operands exps)
                                    env))))

(define (eval-sequence exps env)
    (cond ((last-exp? exps) (eval (first-exp exps) env))
          (else (eval (first-exp exps) env)
                (eval-sequence (rest-exps exps) env))))

(define (eval-if exp env)
    (if (true? (actual-value (if-predicate exp) env))
        (eval (if-consequent exp) env)
        (eval (if-alternative exp) env)))
