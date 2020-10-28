;;; talk about trees
;;; trees represent hierarchy ...

;; what is the difference between a *node* and a *tree*? there is no difference.
;; there is no difference between node and tree
;; but some books think so, therefore they build very complicated data structures to represent trees....
;; avoid such complexities.

(define make-tree cons)
(define datum car)
(define children cdr)

(define (leaf? node)
  (null? (children node)))

;;; list of trees... forest.
;;; make-tree takes 2 arguments: a datum and the children.
(define (treemap fn tree)
  (make-tree (fn (datum tree))
             (map (lambda (child) (treemap fn child))
                  (children tree))))

(treemap square t1)
(car (cdr t1))

;;; sample
(define (square x) (* x x))

(define (leaves . seq)
  (map (lambda (x) (make-tree x '())) seq))

(define t1
  (make-tree 1
             (list (make-tree 2 (leaves 3 4))
                   (make-tree 5 (leaves 6 7 8)))))

(define (treemap fn tree)
  (make-tree (fn (datum tree))
             (forest-map fn (children tree))))

(define (forest-map fn forest)
  (if (null? forest)
      '()
      (cons (treemap fn (car forest))
            (forest-map fn (cdr forest)))))

(treemap square t1)

;;; search more about mutual recursion

;;; abstract data types mistakes
;;; 1. ignore data abstractions
;;; 2. abuse data abstractions where they don't make sense
;;
;; we should take care with violations of data abstractions



(define (deep-map fn lol)
  (if (list? lol)
      (map (lambda (element)
             (deep-map fn element))
           lol)
      (fn lol)))

(define lol '((john lennon) (paul mccartney) (george harrison) (ringo starr)))

(map (lambda (v) (apply + v)) (deep-map count lol))

(deep-map count lol)
