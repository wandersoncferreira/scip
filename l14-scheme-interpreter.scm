;;; learn what an interpreter looks like
(define (tiny-scheme)
  (display "tiny-scheme: ")
  (flush)
  (print (tiny-eval (read)))
  (tiny-scheme))

(define (look-up-global-value exp)
  ;; use underlying Scheme's EVAL
  (eval exp))

(define (self-evaluating? exp)
  (or (number? exp)
      (boolean? exp)
      (string? exp)
      (procedure? exp)))

(define (exp-checker type)
  (lambda (exp) (and (pair? exp) (eq? (car exp) type))))

(define quote-exp? (exp-checker 'quote))
(define if-exp? (exp-checker 'if))
(define lambda-exp? (exp-checker 'lambda))

(define (tiny-eval exp)
  (cond ((self-evaluating? exp) exp)
        ((symbol? exp) (look-up-global-value exp))
        ((quote-exp? exp) (cadr exp))
        ((if-exp? exp) (if (tiny-eval (cadr exp))
                           (tiny-eval (caddr exp))
                           (tiny-eval (cadddr exp))))
        ((lambda-exp? exp) exp)
        ((pair? exp) (tiny-apply (tiny-eval (car exp))
                                 (map tiny-eval (cdr exp))))
        (else (error "bad expr: " exp))))

(define (body proc)
  (caddr proc))

(define (formals proc)
  (cadr proc))

(define (primitive? proc)
  ;; every primitive in STK will be used as primitive in TINY-SCHEME
  (procedure? proc))

(define (do-magic proc args)
  ;; use underlying Scheme's APPLY..
  ;; as this is a STK procedure, then STK knows how to compute them.
  (apply proc args))

(define (substitute exp params args bound)
  (cond ((self-evaluating? exp) exp)
        ((symbol? exp)
         (if (memq exp bound)
             exp
             (lookup exp params args)))
        ((quote-exp? exp) exp)
        ((lambda-exp? exp)
         (list 'lambda (cadr exp)
               (substitute (caddr exp) params args (append bound (cadr exp)))))
        (else (map (lambda (subexp)
                     (substitute subexp params args bound)) exp))))

(define (lookup name params args)
  (cond ((null? params) name)
        ((eq? name (car params)) (maybe-quote (car args)))
        (else (lookup name (cdr params) (cdr args)))))

(define (maybe-quote value)
  (cond ((lambda-exp? value) value)
        ((self-evaluating? value) value)
        ((primitive? value) value)
        (else (list 'quote value))))

(define (tiny-apply proc args)
  (cond ((primitive? proc)
         (do-magic proc args))
        ((lambda-exp? proc)
         (tiny-eval (substitute (body proc) (formals proc) args '())))
        (else (error "bad proc: " proc))))

;;;                exprs
;;;      atomic ---------------- list
;;; self-evaluating          procedure-calls       
;;; variables (symbols)      special-forms
;;; 
;;; the special-forms does not follow the rules for the applicative
;;; order therefore, each special-form has its own procedure to be
;;; evaluated


;; the central piece: how do we evaluate a procedure call.
