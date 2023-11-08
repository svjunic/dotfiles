//
//eslint
//eslint-plugin-react-app
//eslint-plugin-react-hooks
//
module.exports = {
  root: true,
  //extends: ["eslint:recommended", "google"],
  extends: "eslint:recommended",
  env: {
    "browser": true,
    "node": true,
    "es6": true
  },
  // {{{ globals
  globals: {
    "$" : true,
    "jQuery" : true,
    "YT" : true,
    "FB" : true,
    "twttr" : true
  },
  // }}}
  rules: {
    "no-console": 0,
    "no-alert": 0,
    "no-debugger": 1,
    "no-var": 1,
    "no-eq-null": 1,
    "no-implicit-coercion": 1,
    "no-implied-eval": 1,
    "linebreak-style": ["error", "unix"],
    "space-before-function-paren": 0,
    "curly": 1,
    quotes: ["error", "single", { avoidEscape: true }],
    indent: [
      "error",
      2,
      {
        SwitchCase: 1,
      },
    ],
  },
  //{{{ プロジェクトに影響することがあったのでルールは一旦除外
  //}}}
};
