(define (product term a next b)
 (if (> a b) 1
  (* (term a) (product term (next a) next b))))

(define (product-iter term a next b)
 (define (iter a result)
  (if (> a b) result
   (iter (next a) (*result (term a)))))
 (iter a 1))

(define (factrial n)
 (product (lambda (x) x) 1 (lambda (x)(+ 1 x)) n))

(define (numerator n)
 (if (= (remainder n 2) 0) (+ n 2) (+ n 1)))
(define (denominator n)
 (if (= (remainder n 2) 0) (+ n 1) (+ n 2)))
(define (approxmate-pi n)
 (* 4 (/ (product numerator 1 (lambda(x)(+ x 1)) n)
         (product denominator 1 (lambda(x)(+ x 1) n)))))
