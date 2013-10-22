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

|     |     |     |
| --- | --- | --- |
| 　 | `(cons 1 2)` | `(cons 1 nil)` |
| ドット記法 | `(1 . 2)` | `(1 . nil )` or `(1)` |
| 　 | `[1,2]` | `[1,null]` or `[1]` |


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

## 第3回

**2013/10/22**

## 合成式

### 評価法

1. 部分式を評価し値を得る
2. 演算子に引数を適用
3. 合成式を評価し値を得る

## Abstruction of combination

- square

```scheme
(define (square x)
    (* x x)
    )
```

- 正書法は下記

```scheme
(define
    lambda (x) (* x x)
)
```
**(expression)は評価されると値を返す**

## 置き換えモデル例による説明
```scheme
(define (square x) (* x x))
(define (sum-of-squares x y)
 (+ (square x) (square y))
 )
(define (f a) (sum-of-squares (+ a 1) (* a 2)))
```
これは`f(a) = (a+1)^2 + (2a)^2`を表す

- `(f 5)`を実行
- fの本体に5を適用
    - a を 5 に置換
    - `(sum-of-squares (+ a 1) (* a 2))`→`(sum-of-squares (+ 5 1) (* 5 2))`
- `(sum-of-squares x y)`を`x = 6`、`y = 10`で置換
    - `(+ (square x) (square y))`→ `(+ (square 6) (square 10))` 
- `(* x x)`の`x`に6と10を置換し計算し結果を戻す
    - `(+ 36 100)`
- この値を結果として返却 => `136`

### 前回の`factrial`でもやってみる

- `(fact 5)`
- `(* 5 (fact 4))`
- `(* 5 (*4 (fact 3)))`
- `(* 5 (*4 (* 3(fact 2))))`
- `(* 5 (*4 (* 3(* 2 (fact 1)))))`
- `(* 5 (*4 (* 3(* 2 (* 1 (fact 0))))))`
- `(* 5 (*4 (* 3(* 2 (* 1 1)))))`
- `(* 5 (*4 (* 3(* 2 1))))`
- `(* 5 (*4 (* 3 2)))`
- `(* 5 (*4 6))`
- `(* 5 24)`
- `120`

- 計算量：O(n)
    - 時間計算量：2n+1
        - 縦軸
    - 空間計算量：n+1
        - 横軸
- keywords
    - 再帰呼出
    - 再帰定義

## 末尾再帰の効率実行

`factrial`の例のように再帰呼出が末尾で発生するものを**末尾再帰 ( tail recursion )**と呼ぶ  
→これは効率化が可能

### 考え方

- `n! = 1*2*3...*n`
- 「１かける２、２かける３、６かける４」と普段は考える。こっちの方が効率が良い

### 擬似コード

```
counter = 1,2,...,n
product = counter * product
```
(ただし、初期値は`counter`、`product`ともに`1`)

### scheme

```scheme
(define (fact-i n)
 (fact-iter (1 1 n))
 )
 (define (fact-iter product counter max-count)
  (if (> counter max-count)
   product ;counterがmax-countを超えたらproductを結果として返す。
   (fact-iter (* counter product)
              (+ counter 1)
              max-count
    )
   )
  )
```

- `(fact 5)`
- `(fact-iter 1 1 5)`
- `(fact-iter 1 2 5)`
- `(fact-iter 2 3 5)`
- `(fact-iter 6 4 5)`
- `(fact-iter 24 5 5)`
- `(fact-iter 120 6 5)`

このようなものを**線形反復プロセス**と呼ぶ。  
末尾再帰が反復になり、空間量が減少。  

## ブロック構造

```scheme
(define (fact n)
 (define (iter product counter)
  (if (> counter n)
   product
   (iter (* counter product)
         (+count 1))))
 (iter 1 1)
)
```
- 手続き`iter`は`fact`の中で有効。
- 仮パラメータ`counter`,`product`は`iter`内のみ有効
- 仮パラメータ`n`は`fact`の中で有効→`iter`内でも利用可能
- `iter`のパラメータ`counter`,`product`は外部からは**情報を隠匿**
    - オブジェクト指向言語の１つの特徴へと発展

末尾再帰でないプログラムは、反復に置換しづらい。  
**処理系にやさしいプログラムを心がけよう。**  

## 末尾再帰の高速化
- `(fact 5000)`
    - 末尾再帰と線形反復では約2倍の高速化
- コンパイラーが最適化を行うので、末尾再帰のコードをコンパイルすると線形反復に最適化されるので、同じコードが生成される。


