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
 (fact-iter 1 1 n)
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
         (+ counter 1))))
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

# 第4回

**2013/10/29**

## improveの設計

```
(define (improve guess x)
 (average guess (/ x guess)))
```

- √を求めるには、面積が√の中になる正方形の辺の長さを求めれば良い。
- 適当な値から中央値を取って近似させていく

## Square Root By Newton's Method

```
(define (sqrt-iter guess x)
 (if (good-enough? guess x)
  guess
  (sqrt-iter (improve guess x) x) ))
(define (improve guess x)
 (average guess (/ x guess)))
(define (average x y)
 (/ (+ x y) 2))
(define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
(define (sqrt x) (sqrt-iter 1.0 x))
```

### 手続き分解
```
`sqrt` -- `sqrt-iter`  
                |  
                -- good-enough?  
                |   |  
                |   -- `square`  
                |   -- `abs`  
                -- improve  
                    |  
                    -- `average`  
```
### 手続き抽象化の効用　`square`の定義

1. 内部実装の隠蔽

- 
```scheme
(define (square x) (* x x))
``` 
- 
```scheme
(define (square x)
        (exp (double (log x))))
    (define (double x) (+ x x))
```
    - `e^(2log(x)) = e^(log(x^2)) = x^2`
    - 計算機内では2進数で扱われるので、`double`などを用いるほうが高速

2. 局所名の隠蔽 

- `(define (square x) (* x x))`
- `(define (square y) (* y y))`


## 束縛変数と自由変数

- 束縛変数
    - 仮パラメータは手続きで束縛
- 自由変数
    - 束縛(capture)されていない
- 有効範囲(scope)
    - 変数の束縛されている式の範囲

## ブロック構造：xの有効範囲は？
```scheme
(define (sqrt x)
     (define (sqrt-iter guess x)
      (if (good-enough? guess x)
       guess
       (sqrt-iter (improve guess x) x) ))
     (define (improve guess x)
      (average guess (/ x guess)))
     (define (average x y)
      (/ (+ x y) 2))
     (define (good-enough? guess x)
      (< (abs (- (square guess) x)) 0.001))
(sqrt-iter 1.0 x))
```
    - それぞれの`x`の有効範囲は？

- 静的有効範囲

## ハノイの塔問題

1. 一度には１枚の円盤しか動かせない
2. 小さい円盤の上には大きな円盤は置けない

```
    |   |   |
    |   |   |
    1   2   3
```
```scheme
(define (move-tower size from to extra)
 (cond ((= size 0) #true)
  (else
   (move-tower (- size 1) from extra to)
   (print-move from to)
   (move-tower (- size 1) extra to from))
 ))
(define (print-move from to)
    (newline)
    (display "move top disk from")
    (display from)
    (display "to")
    (display to))
(define (solbe-tower-of-hanoi size from to)
 (move-tower size from to (- 6 from to)))
```
```
     |           |        |
    |||          |       |||
   |||||       |||||    |||||
     1 from      2 to     3 extra
```
- `form`から`extra`に一度移してから`to`に戻す

## アッカーマン関数
- 擬似コード(javascript)で

```javascript
function Ack(m,n){
    if(m = 0) n+1
    elseif(n = 0) Ack(m-1, 1)
    else Ack(m-1, Ack(m,n-1)
}
```

### `Ack(1,2)`

- `Ack(1,2)`
- `Ack(0, Ack(1,1))`
- `Ack(1,1)+1`
- `Ack(0, Ack(1,0))+1`
- `Ack(1,0)+2`
- `Ack(0,1)+2`
- `1+1+2`
- `4`

## 宿題１

### 練習問題

- `(ack 0 2)`
- `(ack 1 2)`
- `(ack 2 2)`
- `(ack 3 2)`

計算過程を書くこと

### 随意課題

それぞれ理由も記せ

1. `(ack 0 n) ≡ n+1`
2. `(ack 1 n) ≡  ?`
3. `(ack 2 n) ≡ ?`
4. `(ack 3 n) ≡  ?`
5. `(ack 4 n) ≡  ?`

## 練習問題

1. １ドルの両替方法は何通り？

```scheme
(define (count-change amount)
         (cc amount 5))
(define (cc amound kinds-of-coins)
 (cond ((= amount 0) 1)
  ((or (< amount 0) (= kinds-of-coins 0)) 0)
  (else 
   (+ (cc amount (- kinds-of-coins 1))
      (cc (- amount
           (first-denomination
                kinds-of-coins))
       kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
      ((= kinds-of-coins 2) 5)
      ((= kinds-of-coins 3) 10)
      ((= kinds-of-coins 4) 20)
      ((= kinds-of-coins 5) 50)
      )
)
```

## Order of Growth

### R(n)はステップ数あるいはスペース量

- R(n)がΘ(f(n))
    - 上下限
- R(n)がO(n)
    - 上限
- R(n)がΩ(n)
    - 下限

### 例

- Θ(1)
    - constant growth
- Θ(n)
    - linear growth
- Θ(b^n)
    - exponential growth
- Θ(log(n))
    - logarithmic growth
- Θ(n^m)
    - power law growth

## フィボナッチ数列

- うさぎのつがい
- 内部反射回数

### 定義
```javascript
function fib(n){
    if (n = 0) 0
    elseif (n = 1) 1
    else fib(n-1) + fib(n-2) 
}
```

```scheme
(define (fib n)
 (cond ((= n 0) 0)
       ((= n 1) 1)
       (else (+ (fib (- n 1))
                (fib (- n 2)))))
)
```

### fibonacci function (iteration)

```scheme
(define (fib-i n)
 (define (iter a b count)
  (if (= count 0)
   b
   (iter (+ a b) a (- count 1))))
 (iter 1 0 n)
)
```

# 第５回

**2013/11/5**

## `Fib`の呼ばれる回数 `C(n) = F(n) - 1`

- `n >= 2` に対して、`C(n) = C(n-1)+C(n-2)+1`
- `F(n) = C(n)+1` とおくと
- `F(n)-F(n-1)+F(n-2)` for `n>=2`
- `F(0)=2`, `F(1)=2`

### 練習問題

|手続き|ステップ数|スペース|
|再帰型|2/√5 O(Φ^n)|O(Φ^n)|
|繰返型|n+1 O(n)|O(1)|
|テーブル参照型|1 O(1)|O(n)|

## べき乗を計算する

```scheme
(define (fast-expt b n)
 (cond ((= n 0) 1)
       ((even? n)
        (square (fast-expt b (/ n 2))))
       (else
        (* b (fast-expt b (- n 1))) )))
(define (even? n)
 (= (remainder n 2) 0) )
```

### べき乗を計算するアルゴリズム

- X^16
- 16=10000(2)より２進数を４回左シフト
1. まず,1を`SX`,0を`S`で置換
2. 先頭の`SX`を除く
3. 得られた`S`と`X`を`Square`、`xをかける`と読む

#### 例 X^23

- 23= 10111(2)
1. SX S SX SX SX
2. S SX SX SX

## 最大公約数を求める

### ユーグリッドの互除法

- a mod b = r
- GCD(a, b) = GCD(b, r)

が成立する。

```scheme
(define (gcd a b)
 (if (= b 0)
  a
  (gcd b (remainder a b)) ))
```
## 合同式

- `a≡b mod n` (congruent modulo n)
    - 「a mod n と b mod n が等しい」
- x modulo nは剰余
- a+b mod n ≡  (a mod n + b mod n) mod n
- a*b mod n ≡  (a mod n * b mod n) mod n

## 第６回

**2013/11/12**


- `∑i = a + ∑(a→b)i`

```scheme
(define (sum-integers a b)
 (if (> a b)
  0
  (+ a (sum-integers (+ a 1) b))))
```

- `∑i = f(a) + ∑f(i)`

```scheme
(define (sum-f a b)
 (if (> a b)
  0
  (+ (f a) (sum-f (sum-f (+ a 1) b)))))
```

- `∑(i=a,next(i)→b) {f(i)}`
    - fの関数の中身: term
    - 値の増え方: next

```scheme
(define (sum term a next b)
 (if (> a b)
  0
  (+ (term a)
     (sum term (next a) next b))))
```
↓
```scheme
(define (sum-integers a b)
 (define (inc x) (+ x 1))
 (sum f a inc b))
```

- `Π(a -> b)(i) = a * Π(a+1 -> b)(i)`

```scheme
(define (product-integers a b)
 (if (> a b)
  1
  (* a (product-integers (+ a 1) b)))
 )
```

- `Π(a -> b)f(i) = f(a) * Π(a+1 -> b)f(i)`

```scheme
(define (product-f a b)
 (if (> a b)
  1
  (* (f a) (product-f (+ a 1) b))))
```

```scheme
(define (product term a next b)
 (if (> a b)
  1
  (* (term a)
     (product term (next a) next b))))
```

## `sum`と`product`を統合する

```scheme
(define (accumulate combiner null-value term a next b)
    (if (> a b)
      null-value
      (combiner (term a)
       (accumulate combiner null-value term (next a) b))))
```

- `combiner`は`sum`を再現するなら`+`、`product`を再現するなら`*`を与える

### `factrial`を書いてみる

```scheme 
(define (factrial n)
 (accumulate * 1 identity 1 inc n))
```

## `lambda`: 無名（匿名）手続き

`(define (plus4 x) (+ x 4))`は`(define (plus4 (lambda (x) (+ x 4))))`と等価。

### ラムダ式の適用

- `((lambda (x y z)(+ x y (square z))) 1 2 3)`
    - x=1, y=2, z=3 を代入して実行
- `(+ 1 2 (square 3))`

## `let`: to create local variables

- `f(x,y) = x(1+xy)^2 + y(1-y) + (1+xy)(1-y)`を解くのに補助変数を使いたい

```scheme
(define (f x y)
 (define (f-helper a b)
  (+ (* x (square a)
      (* y b)
      (* a b) )))
  (f-helper
   (+ 1 (* x Y)
    (- 1 y)))
 )
```

```scheme
(define (f x y)
 (let ((a (+ 1 (* x y)))
       (b (- 1 y)))
    (+ (* x (aquare a))
     (* y b)
     (* a b) )))
```

##変数スコープ

```scheme
(let ((x 7))
 (+ (let ((x 3))
     (+ x (* x 10)) )
  x) )
```

```scheme
(let ((x 3))
     (+ x (* x 10)) )
=> 33
```

```scheme
(let ((x 7))
 (+ 33  x) )
=> 40
```

### `let*`は変数を順番に評価

```scheme
(let ((x 5))
 (let* ((x 3)
        (y (+ x 2)) )
  (* x y) ))
```

## 自己参照

![http://1.bp.blogspot.com/_pYQtk7V1m4I/S5TRrK9GJeI/AAAAAAAABQ4/za4QnJQ69BU/s400/What+is+the+Name+of+this+Book+Raymond+Smullyan.jpg](http://1.bp.blogspot.com/_pYQtk7V1m4I/S5TRrK9GJeI/AAAAAAAABQ4/za4QnJQ69BU/s400/What+is+the+Name+of+this+Book+Raymond+Smullyan.jpg)



# 第2章

- 第1章は**手続き抽象化**
- 第2章は**データ抽象化**
    - 基本データ構造
    - 合成データオブジェクト
- データ抽象化で手続きの意味を拡張

__「具体から抽象へは行けるが、抽象から具体へは行けない」__

## データ抽象化

1. 構成子(constructor)
2. 選択子(selector)
3. 述語(predicate)
4. 入出力(input-output)

次回は有理数から

