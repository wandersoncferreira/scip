(define (square x) (* x x))


(define (squares sent)
  (if (empty? sent)
      '()
      (se (square (first sent))
          (squares (bf sent)))))

(squares '(1 2 3 4))

;;; the complexity time of this program is of order 6N + 2 where
;;; N is the number of items in the initial list

(define (sort sent)
  (if (empty? sent)
      '()
      (insert (first sent)
              (sort (bf sent)))))

(define (insert num sent)
  (cond ((empty? sent) (se num))
        ((<= num (first sent)) (se num sent))
        (else (se (first sent) (insert num (bf sent))))))

;;; insert takes 7N + 5 calls
;;; sort will be N*(4 + 7N + 5) + 2 calls
;;; 7N²/2 + 9N + 2

(sort '(2 3 9 3 1 0 -1))
