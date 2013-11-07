#!/bin/bash
NAME="ShutoMORII"
JNAME="森井 崇斗"
NUMBER="1029-25-2723"
PDFFILENAME="report.pdf"
mv $1/${PDFFILENAME} $1/${NUMBER}-${NAME}-$1.pdf
open "mailto:sicp-$1@kuis.kyoto-u.ac.jp?subject=アルゴリズムとデータ構造入門 第$1回 課題提出&body=所属：工学部 情報学科
氏名：${JNAME}
学籍番号：${NUMBER}

アルゴリズムとデータ構造入門 第$1回のレポートを提出いたします。
よろしくお願いします。"
