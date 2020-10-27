;;; notes on the L03 higher order procedure class CS 61A
(define pi 3.141592)

(define (square-area r)
  (* r r))

(define (circle-area r)
  (* pi r r))

(define (sphere-area r)
  (* 4 pi r r))

(define (hexagon-area r)
  (* (sqrt 3) 1.5 r r))

;;; more general definition
(define (area shape r)
  (* shape r r))

(define square 1)
(define circle pi)
(define sphere (* 4 pi))
(define hexagon (* (sqrt 3) 1.5))


;;; a little more complicated pattern
;;; sum square value from a to b
(define (sumsquare a b)
  (if (> a b)
      0
      (+ (* a a) (sumsquare (+ a 1) b))))

(define (sumscube a b)
  (if (> a b)
      0
      (+ (* a a a) (sumscube (+ a 1) b))))


;; generalizing this second pattern
(define (sums shape-fn a b)
  (if (> a b)
      0
      (+ (shape-fn a) (sums shape-fn (+ a 1) b))))

(define (square-fn x) (* x x))

(sums square-fn 3 6)

(define (evens nums)
  (cond ((empty? nums) '())
        ((= (remainder (first nums) 2) 0)
         (se (first nums) (evens (bf nums))))
        (else (evens (bf nums)))))

;; se -- sentence
;; bf -- butfirst

(evens '(1 2 3 4 5 6 7 8 11))

;;; functions has to return 1 value.

(define (ewords sent)
  (cond ((empty? sent) '())
        ((member? 'e (first sent))
         (se (first sent) (ewords (bf sent))))
        (else (ewords (bf sent)))))

(ewords '(got to get you into my life))

(define (pronouns sent)
  (cond ((empty? sent) '())
        ((member? (first sent) '(i me you he she it him her we us they them))
         (se (first sent) (pronouns (bf sent))))
        (else (pronouns (bf sent)))))

(pronouns '(i only want to dance with you))

(define (keep PRED sent)
  (cond ((empty? sent) '())
        ((PRED (first sent))
         (se (first sent) (keep PRED (bf sent))))
        (else (keep PRED (bf sent)))))

;;; a test is an action! A thing to do! so we can encode it in a function
(keep even? '(1 2 3 4 5 6 7))

(define (eword? wd) (member? 'e wd))

(keep eword? '(got to get you into my life))

(keep (lambda (wd) (member? 'e wd)) '(being for the benefit of mister kite))

