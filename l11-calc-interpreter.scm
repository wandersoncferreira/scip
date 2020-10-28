;;; Scheme calculator -- evaluate simple expressions

(define (calc)
  (display "calc: ")
  (flush)
  (print (calc-eval (read)))
  (calc))

;;; evaluate an expression

(define (calc-eval exp)
  (cond ((number? exp) exp)
        ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
        (else (error "Calc: bad expression:" exp))))

;;; apply a function to arguments

(define (calc-apply fn args)
  (cond ((eq? fn '+) (accumulate + args))
        ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
                           ((= (length args) 1) (- (car args)))
                           (else (- (car args) (accumulate + (cdr args))))))
        ((eq? fn '*) (accumulate * args))
        ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
                           ((= (length args) 1) (/ (car args)))
                           (else (/ (car args) (accumulate * (cdr args))))))
        (else (error "Calc: bad operator:" fn))))

;;; syntax is how the structure of the program looks like syntax for
;;; scheme for example "open (, expressions, arg, arg, arg, close)"

;;; in real scheme interpreter, we will see that eval calls apply, and
;;; apply calls eval. :O mutual recursion is necessary to this kind of
;;; operation!

;;; (+ 3 4)
;;; 3 + 4
;;; (f 3 4)
;;; f(3,4)
;;; apply does not know which one of these you typed!
;;; apply only needs a function and arguments to be applied
;;; the work to transform these string of characters into the parameters
;;; required by apply is *eval*'s job.!!
;;; these things typed are syntax... eval removes this syntactical differences
