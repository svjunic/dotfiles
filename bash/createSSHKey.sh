#!/bin/bash

HOME_DIR="/home/vagrant/"
SSH_DIR="${HOME_DIR}.ssh/"
PRIVATE_KEY_NAME="github.com"
PUBLIC_KEY_NAME="${PRIVATE_KEY_NAME}.pub"


echo "Github用のSSHキー発行用のシェルスクリプトです。"
echo -n "メールアドレスを入力してください。（メールアドレスは公開鍵のコメントに追記されます。） => "
read EMAIL



echo -n "パスフレーズ（パスワード）を入力してください。 => "
read PASSWORD



cat << EOS
下記で作成します。
メールアドレス : $EMAIL
パスフレーズ   : $PASSWORD
EOS

echo -n "問題無いですか[y/n] => "
read ANS

if [ $ANS = "y" -o $ANS = "yes" ]; then
  ssh-keygen -t rsa -b 4096  -f $PRIVATE_KEY_NAME -N $PASSWORD -C $EMAIL
  echo "秘密鍵・公開鍵の作成を完了しました。\n"
 
  # よく使うので文字列化
  HOME_PRIVATE_KEY_PATH=$HOME_DIR$PRIVATE_KEY_NAME
  HOME_PUBLIC_KEY_PATH=$HOME_DIR$PUBLIC_KEY_NAME
  PRIVATE_KEY_PATH=$SSH_DIR$PRIVATE_KEY_NAME

  # 公開鍵を取得
  PUBLIC_KEY=`cat $PUBLIC_KEY_NAME`

  cp $PRIVATE_KEY_NAME $PRIVATE_KEY_PATH
  echo "${HOME_PRIVATE_KEY_PATH}を${SSH_DIR}ディレクトリにコピーしました。"

  chmod 0600 $PRIVATE_KEY_PATH
  echo "${PRIVATE_KEY_PATH}の権限を変更0600に変更しました。"

  mkdir "${HOME_DIR}/sshkeys/"
  cp "$PRIVATE_KEY_PATH" "${HOME_DIR}/sshkeys/"
  cp "$PRIVATE_KEY_PATH.pub" "${HOME_DIR}/sshkeys/"
  echo "ホストマシン側のconfig/sshkeysディレクトリに作成したキーを出力しました。"
  

  rm $HOME_PRIVATE_KEY_PATH
  rm $HOME_PUBLIC_KEY_PATH
  echo "ゴミファイルを削除しました。"

  eval `ssh-agent`
  echo "ssh-agentの再起動を行いました。"

  cat << EOS

Vagrant側の設定を完了しました。
残りはブラウザでGithub.comの設定をする必要があります。


1. 下記をブラウザで開いてください。

https://github.com/settings/ssh


2. ボタンの「Add SSH Key」をクリックしてください。

3. Titleを入力してください。（Githubの中で管理するためのタイトルです。）

4. Keyに下記をコピーして貼り付けてください。

$PUBLIC_KEY

5. 全て完了です！
git clone等ができるようになりました。
おつかれさまでした。
EOS

else
  echo "SSHキーの作成を中止しました。"
fi
