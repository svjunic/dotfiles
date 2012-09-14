" Last Change: 14-Sep-2012."
" Maintaner: sv.junic

vimでコーディングするときの環境を
vundleを使って簡単に用意できる.gvimrcなどを作ることを目標としています。


1. 準備
必要なもの：
Git
→windowsは環境設定でパスを通すこと。
  C:\Program Files\Git\cmd など。
→macはdmgダウンロードしたらコマンド使えるのでインストールするだけ。

cmd/
| curl.cmd

上記のファイルは、windowsの場合にGitのcmdディレクトリに移動する必要があります。
これは、プラグインを管理するvundleが使うコマンドです。

windows意外は必要ないです。


2. 入れる
下記からダウンロード。
香り屋
http://www.kaoriya.net/

香り屋さんのWindows版の使い勝手に近いMacVim
http://code.google.com/p/macvim-kaoriya/

win版は解凍する。
mac晩は普通のアプリと一緒です。


3. Pluginをインストールする

4. まとめ

適応した場合は下記のディレクトリになります。

※macの場合
/Users/ユーザ名/
| .vim/
| | bundle/
| | colors/
| | vundle.git/
| | vim_local.vim
| .gvimrc

※windowsの場合
/Users/ユーザ名/
| .vim/
| | bundle/
| | colors/
| | vundle.git/
| | vim_local.vim
| .gvimrc

.unite
とか、そういうディレクトリがホームディレクトリにできますが、それはそれぞれのプラグインが使ってるものです。
