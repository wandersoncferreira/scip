;;; the count generate a recursive process to
;;; calculate count.
(define (count sent)
  (if (empty? sent)
      0
      (+ 1 (count (bf sent)))))

;;; the count-tc generate an iterative process to
;;; calculate count.
(define (count-tc sent)
  (define (iter wds result)
    (if (empty? wds)
        result
        (iter (bf wds) (+ 1 result))))
  (iter sent 0))


;;; 1
;;; 1 1
;;; 1 2 1
;;; 1 3 3 1
;;; 1 4 6 4 1
(define (pascal row col)
  (cond ((= col 0) 1)
        ((= col row) 1)
        (else (+ (pascal (- row 1) (- col 1))
                 (pascal (- row 1) col)))))
;;; this algorithm is 2^n
(pascal 25 8)

(define (nth num sent)
  (define (iter sent counter)
    (cond
     ((empty? sent) #f)
     ((= counter num) (first sent))
     (else (iter (bf sent) (+ 1 counter)))))
  (iter sent 0))

(define (new-pascal row col)
  (nth col (pascal-row row)))

(define (pascal-row row-num)
  (define (iter in out)
    (if (empty? (bf in))
        out
        (iter (bf in) (se (+ (first in)
                             (first (bf in)))
                          out))))
  (define (next-row old-row num)
    (if (= num 0)
        old-row
        (next-row (se 1 (iter old-row '(1)))
                  (- num 1))))
  (next-row '(1) row-num))

(new-pascal 25 8)
(pascal 25 8)
