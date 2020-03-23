echo "installing neovim-client"
npm i -g neovim

echo "npm install"
npm i -g eslint@5
npm i -g eslint-plugin-vue
npm i -g babel-eslint@8
npm i -g htmlhint
npm i -g prettier
npm i -g prettier-eslint-cli
#npm i -g prettier/plugin-php
#npm i -g eslint-plugin-prettier
#npm i -g eslint-config-prettier
npm i -g vue-language-server
npm i -g fx

echo "npm install(Automatic Version Switching for Node)"
npm install -g avn avn-nvm avn-n
avn setup

