# アルゴリズムとデータ構造入門授業メモ

## 第２回

**2013/10/8**

### 階乗のプログラムを書いてみよう

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

### practice

1. (cube x) => x^3
    - [2/cube.scm](2/cube.scm)
2. (foo x) = > 3x^2 + 2x + 1
    - [2/foo.scm](2/foo.scm)

### 対(pair)とシーケンス(sequences)

||(cons 1 2)|(cons 1 nil)|
|ドット記法|(1 . 2)|(1 . nil ) or (1)|
||[1,2]|[1,null] or [1]|

`(list 1 2 3 4)`
`(cons 1 (cons 2 (cons 3 (cons 4))))`

```scheme
(define bar (list 1 2 3 4)) => bar
 (car bar) => 1
 (cdr bar) => (2 3 4)
 (cadr bar) => 2
```

```scheme
(cadr bar) => 2
(caddr bar) => 3
(cddr bar) => (3 4)
(cdr (cddr bar)) => (4)
(cddr (cddr bar)) => ()
```


