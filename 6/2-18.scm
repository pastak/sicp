(define (reverse ilist)
 (define (iter-reverse li tmpli)
  (if (null? (cdr li))
  (append (list (car li)) tmpli )
  (iter-reverse (cdr li) (append (list (car li)) tmpli )))
 ) 
 (iter-reverse ilist (list ))
)

