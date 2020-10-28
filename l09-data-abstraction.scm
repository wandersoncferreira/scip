(define (total-hand hand)
  (if (empty? hand)
      0
      (+ (butlast (last hand))
         (total-hand (butlast hand)))))

(total-hand '(3n 10c))

(define (new-total-hand hand)
  (if (empty? hand)
      0
      (+ (card-rank (one-card hand))
         (new-total-hand (remaining-cards hand)))))

;;; selectors...
(define card-rank butlast)
(define card-suit last)
(define one-card last)
(define remaining-cards butlast)

(new-total-hand '(3n 10c))

;;; create constructors
(define (make-card rank suit)
  (word rank (first suit)))

(define make-hand se)

(total-hand (make-hand (make-card 3 'heart)
                       (make-card 10 'club)
                       (make-card 4 'diamond)))

;;; changing the implementation of cards
(define (make-card rank suit)
  (cond ((equal? suit 'heart) rank)
        ((equal? suit 'diamond) (+ rank 26))
        ((equal? suit 'club) (+ rank 39))
        (else (error "say what?"))))

(define (card-rank card)
  (remainder card 13))

;;; a list if a pair, which the cdr is a pair or a empty list the
;;; constructor and selectors are the only functions allowed to know
;;; the implementation of the actual data structure

(car (cdr (cons 3 (cons 4 (cons 5 '())))))

(cons 5 '(3 4))
(car (list '(3 4) '(5 4)))
