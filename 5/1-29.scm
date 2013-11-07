(define (simpson-iter f a b n)
(let* ((h (/ (- b a) n)) 
       (y (lambda (k) (f (+ a (* k h)))))
      )
  (define (iter count sum)
   (if (= count n) 
    (+ sum (y n))
    (iter (+ count 1) (+ sum (* (+ 2 (* 2(remainder count 2))) (y count))))
   )
  )
  (* (/ h 3) (iter 1 0) )
 )
 )

# Simpsonの公式の実行
(simpson-iter (lambda (x) (* x x x)) 0 1 100)
(simpson-iter (lambda (x) (* x x x)) 0 1 1000)

# integral手続きの実装
(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

# integral手続きの実行
(integral cube 0 1 0.01)
(integral cube 0 1 0.001)
