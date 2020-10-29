(define (deep-map fn lol)
  (if (list? lol)
      (map (lambda (element) (deep-map fn element)) lol)
      (fn lol)))

(define lol '((john lennon) (paul mccartney) (george harrison) (ringo starr)))

;;; more general version of deep-map...
(define (deep-map fn xmas)
  (cond ((null? xmas) '())
        ((pair? xmas)
         (cons (deep-map fn (car xmas))
               (deep-map fn (cdr xmas))))
        (else (fn xmas))))

(deep-map (lambda (el) (print el ": " (count el) " letters")) lol)

;;; if you see two recursive calls, you are looking into a tree-like
;;; data structure but the two recursive calls must be called
;;; together...

(define (filter pred seq)
  (cond ((null? seq) '())
        ((pred (car seq))
         (cons (car seq) (filter pred (cdr seq))))
        (else (filter pred (cdr seq)))))

(define make-tree cons)
(define datum car)
(define children cdr)

(define (leaves . seq)
  (map (lambda (x) (make-tree x '())) seq))

(define (depth-first-search tree)
  (print (datum tree))
  (for-each depth-first-search (children tree)))

(define (breadth-first-search tree)
  (bfs-iter (list tree)))

(define (bfs-iter queue)
  (if (null? queue)
      'done
      (let ((task (car queue)))
        (print (datum task))
        (bfs-iter (append (cdr queue) (children task))))))

(define t1
  (make-tree 'music
             (list (make-tree 'beattles (leaves 'p 'r))
                   (make-tree 'who (leaves 'w 'v)))))

(depth-first-search t1)
(breadth-first-search t1)


(define t2
  (make-tree '+
             (list (make-tree 3 '())
                   (make-tree '*
                              (list (make-tree 4 '())
                                    (make-tree 5 '()))))))
;;; inorder
;;; left
;;; datum
;;; right
;;; (3 + (4 * 5))

;;; pre-order
;;; datum
;;; left
;;; right
;;; (+ 3 (* 4 5))

;;; postorder
;;; left
;;; right
;;; datum
;;; 3 4 5 * +
