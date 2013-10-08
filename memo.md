# アルゴリズムとデータ構造入門授業メモ

## 第２回資料

### 階上のプログラムを書いてみよう

- 数学の記法で書くと
    - n! = 

1. fact(n) = 1 * 2 * 3 * ... * n

2. 
```scheme
(define (fact n)
    (if (<= n 0 )
        1
        (* n (fact (- n 1)))
    )
    )
```
[2/factrial.scm](2/factrial.scm)

3. 
```scheme
(fact 3)
```

`(define (square x) (* x x))`  
 to square something, multiply it by itself  

1. (cube x) => x^3
    - [2/cube.scm](2/cube.scm)
2. (foo x) = > 3x^2 + 2x + 1
    - [2/foo.scm](2/foo.scm)
