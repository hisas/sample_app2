# encoding: utf-8
# language: ja

機能: ログイン
  シナリオ: トップページにアクセスしてログインする
    前提 ユーザーがログインページにアクセスする
    もし 有効なメールアドレスとパスワードを入力する
    かつ ログインボタンをクリックする
    ならば 画面にログインURLが表示されないこと
    ならば 画面にログアウトURLが表示されること
    ならば 画面に自分のタイムラインURLが表示されること

  シナリオ: 有効ではないメールアドレスとパスワードではログインできない
    前提 ユーザーがログインページにアクセスする
    もし 有効ではないメールアドレスとパスワードを入力する
    かつ ログインボタンをクリックする
    ならば 画面にエラーメッセージが表示されること
    もし トップページにアクセスする
    ならば 画面にエラーメッセージが表示されないこと
