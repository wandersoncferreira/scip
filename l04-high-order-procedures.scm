;; first class data type
;; can be:
;; - the value of a variable
;; - an argument to a procedure
;; - the value returned by a procedure
;; - a member of an aggregate
;; - anonymous

(define (square x) (* x x))

(define (make-added num)
  (lambda (x) (+ x num)))

(define add-3-fn (make-added 3))

(add-3-fn 30)

(define (compose f g)
  (lambda (x)
    (f (g x))))

((compose first bf) '(she loves you))
(define second (compose first bf))

(second '(i want to hold))

(define (twice f) (compose f f))

((twice square) 3)

;;; easy to consider functions as parameters
;;; but relatively hard to allow them be passed as return values

(define (roots a b c)
  (se (/ (+ (- b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))
      (/ (- (- b) (sqrt (- (* b b) (* 4 a c)))) (* 2 a))))

(roots 1 -5 6)

(define (roots a b c)
  (let ((d (sqrt (- (* b b) (* 4 a c))))
        (e (* 2 a)))
    (se (/ (+ (- b) d) e)
        (/ (- (- b) d) e))))

(roots 1 -5 6)
