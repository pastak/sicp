#sicp

exercise!!!!!  
to get 単位!!!!!!!!!!!!

# Contents

- [memo.md](memo.md): 授業メモ
- ディレクトリの数字 = 各課題番号
- [2lambda.txt](2lambda.txt): 関数宣言をlambda式を使ったものに書き換える(vim用)
    - from [https://github.com/tyage/algds](https://github.com/tyage/algds)
- [submit.sh](submit.sh): 提出用にpdfをリネームして、ついでにメーラーも呼び出すシェルスクリプト。
    - 引数にディレクトリの数字(= 課題番号)を与えるとリネームしてくれる。便利。変数は以下の通り。メール本文もそれなりに生成してくれる。
        - NAME : 英字綴りの名前
        - JNAME : 漢字綴りの名前
        - NUMBER : 学生番号
        - PDFFILENAME : TeXで生成されるpdfのファイル名。自分の場合は毎回`report.tex`から`report.pdf`を生成してるからそういうの。

# Links

設定とかのメモ代わり。

- [Schemeを実行するChrome拡張「chroscheme」を作った - Pastalablog in はてな](http://pastak.hatenablog.com/entry/2013/10/26/222617)
    - 便利Chrome拡張作った
- [Introduction to Algorithms and Data Structures (SICP, 計算機プログラムの構造と解釈), 2013](http://winnie.kuis.kyoto-u.ac.jp/members/okuno/Lecture/13/IntroAlgDs/)
    - 授業ページ。便利情報満載。
- レポート書く自分用LaTeXテンプレートサンプル[https://gist.github.com/pastak/6865243](https://gist.github.com/pastak/6865243)
- [Vim-LaTeX - TeX Wiki](http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Vim-LaTeX)
    - VimでLaTexを良しなに使えるようにするプラグイン。便利。
- [Scheme - SICPを読むためにやっておくと便利かもしれないこと - Qiita [キータ]](http://qiita.com/da1@github/items/02f7d2f157c7145d58f2)
    - VimでScheme処理系gaucheのインタプリタを呼び出すプラグインの設定とか。
