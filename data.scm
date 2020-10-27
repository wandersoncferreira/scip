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

(define (flatten l)
  (cond
   ((empty? l) '())
   ((list? (car l)) (append (flatten (car l)) (flatten (bf l))))
   (else (cons (car l) (flatten (bf l))))))

(flatten (list '(3 4 8) '(5 10 29) '(1 1 1 1)))

(define (se a b)
  (cond ((word? a) (se (list a) b))
        ((word? b) (se a (list b)))
        (else (append a b))))

(define (word? x)
  (or (symbol? x) (number? x)))

(define (reverse-list l)
  (if (empty? l) '()
      (cons (olast l) (reverse-list (btlast l)))))

(define (new-reverse-list seq)
  (if (null? seq)
      '()
      (cons (new-reverse-list (cdr seq)) (car seq))))

(new-reverse-list (list 1 2 3 4))

(define (btlast list)
  (if (empty? (cdr list)) '()
      (cons (car list) (btlast (cdr list)))))

(define (olast list)
  (if (empty? (cdr list))
      (car list)
      (olast (cdr list))))

(reverse-list (list 1 2 3))
(btlast (list 1 2 3 4))
(cons 3 (cons 2 (cons 1 '())))


(define (reverse-sent sent)
  (if (empty? sent)
      '()
      (se (reverse-sent (butfirst sent)) (first sent))))

(reverse-sent '(i want to know))


(define (reverse-list seq)
  (if (null? seq)
      '()
      (append (reverse-list (cdr seq)) (list (car seq)))))

(reverse-list (list 1 2 3 4))

(define (reverse-iter seq)
  (define (iter seq result)
    (if (null? seq)
        result
        (iter (cdr seq) (cons (car seq) result))))
  (iter seq '()))

(reverse-iter (list 1 2 3 4 5 6))
