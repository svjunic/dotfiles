" Last Change: 28-Feb-2013."
" Maintaner: sv.junic

vimでコーディングするときの環境を
NeoBundleを使って簡単に用意できる.gvimrcなどを作ることを目標としています。
慣れたら勝手にカスタマイズしてね。


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


3. このリポジトリのファイルを設置する。

○macの場合
/Users/ユーザ名/
| .vim/
| | colors/
| | vundle.git/
| | template/
| .gvimrc
/Applications/MacVim.app/Contents/Resources/vim/
| | vim_local.vim

○windowsの場合
vimのディレクトリ/
| | vim73
| | | colors
| | template/
| | vimfiles/
| vim_local.vim
| _gvimrc
※.gvimrcのファイル名を_gvimrcに変更します。



4. Plugin管理用のプラグインをインストールする
vundleをインストールします。

windows
git clone http://github.com/gmarik/vundle.git vimのディレクトリ/bundle/

mac
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/



5.Pluginをインストールする
下記を入力してください。
:BundleInstall

↓vimrc_local.vim で標準インストールしているプラグイン
Bundle 'Shougo/neocomplcache'
Bundle 'unite.vim'
Bundle 'surround.vim'
Bundle 'mattn/zencoding-vim'
Bundle 'SQLUtilities'

その他いろいろ入れています。
WindowsはTwitVim（Twitterを使うためのプラグイン）を使用するために色々しないといけないので、コメントアウトにして
しまったほうがいいかも。

※Bundle の値を変えてBundlInstallすることで他のプラグインもインストールできます

↓標準で入れたプラグインの紹介
neocomplcache
→補完を実装するプラグイン。
有名でオプションも豊富。

unite.vim
→ファイラーみたいな機能を実装するプラグイン。
ヤンクの履歴みれたり他にもいろいろ機能があるよ！

surround.vim
→text-objectsを拡張したようなもの。
タグで囲んだり()で囲んだり()中だけ消したりするのが一瞬でできるようになる。

zencoding-vim
→zencodingのvim版
初期段階からコーディングする場合に威力を発揮。

SQLUtilities
→
使ってみようかなと思って入れてみた。まだ使ってない！


オプション等の記述はvimrc_local.vimに書くと上書きされる可能性もあるので、.gvimrc に書くほうがいいです。

※準備で失敗してるとwindows版は動かないので1を確認！


5. まとめ

適応した場合は下記のディレクトリになります。

※macの場合
/Users/ユーザ名/
| .vim/
| | colors/
| | bundle/
| .gvimrc
/Applications/MacVim.app/Contents/Resources/vim/
| | vim_local.vim

※windowsの場合
vimのディレクトリ/
| | template/
| | vim73
| | | colors
| | vimfiles/
| |  | bundle/
| |  | vundle/
| vim_local.vim
| _gvimrc

.unite
とか、そういうディレクトリがホームディレクトリにできますが、それはそれぞれのプラグインが使ってるものです。


※プラグイン作成者に感謝！


メモ：
zencoding-vim の画像の高さ幅を自動で入力するImageSizeを絶対パスでも動くように
hokaccha 様のfix absolute image pathを参考にしました。

↓htmlのみ
/zencoding-vim/autoload/zencoding/lang/html.vim 
before:
402   if fn =~ '^\s*$'
403     return
404   elseif fn !~ '^\(/\|http\)'
405     let fn = simplify(expand('%:h') . '/' . fn)
406   endif

after:
402   if fn =~ '^\s*$'
403     return
404   elseif fn =~ '^/'                                                                                                                               
405     let fn = findfile(substitute(fn, '/', '', ''), '.;')
406   elseif fn !~ '^\(/\|http\)'
407     let fn = simplify(expand('%:h') . '/' . fn)
408   endif 


slim.vim,haml.vimもあるけど、一先ず必要なのはhtmlなのでこれだけメモ残しておき
ます。
