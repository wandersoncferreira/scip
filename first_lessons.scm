;;; https://www.youtube.com/watch?v=4leZ1Ca4f0g

;;; simply scheme: https://people.eecs.berkeley.edu/~bh/ssch27/appendix-running.html

(sentence 'now 'here)
(first '(got to get you into my life))
(bf '(the fool on the hill))
(first (bf '(a hard days night)))
(first (first (bf '(she loves you))))

(define pi 3.141592)
(define (square x)
  (* x x))

;;; we evaluate the sub-expressions
;;; (+ 2 5)
;;; (* 5 5)
;;; 25
(square (+ 2 3))

(define (consonant? l)
  (not (member? l '(a e i o u))))

(define (plural wd)
  (if (equal? (last wd) 'y)
      (if (consonant? (last (bl wd)))
          (word (bl wd) 'ies)
          (word wd 's))
      (word wd 's)))

(plural 'fly)
(plural 'book)
(plural 'boy)

(define (pigl wd)
  (if (pl-done? wd)
      (word wd 'ay)
      (pigl (word (bf wd) (first wd)))))

(define (pl-done? wd)
  (vowel? (first wd)))

(define (vowel? letter)
  (member? letter '(a e i o u)))

(pigl 'scheme)

;;; computer science is a bad name for our field
;;;
;;; small part of CS is about science
;;;
;;; is not science because the scientists asks questions about how the world works.
;;; is not computer because the field about computers is electrical engineers
;;;
;;; the field should be called: software engineering

;;; CS is all about control of complexity:
;;; 1. more people you put in a project, the long it takes
;;; 2. think about bigger abstractions

;; * Functions
;;;
;;; with the same input we have always the same output
;;; usually is easier to make a program that works faster, than taking
;;; a faster program and make it work


(define (buzz n)
  (cond ((equal? (remainder n 7) 0) 'buzz)
        ((member? 7 n) 'buzz)
        (else n)))

(buzz 17)

;;; integral in calculus is hard because you need to wrap your head
;;; around the concept that you can have functions that receive functions
;;; and return functions


