// eslint.config.js
/** @type {import('eslint').Linter.Config} */
const config = [
    {
      languageOptions: {
        ecmaVersion: 12, // ECMAScript 2021
        sourceType: 'module',
      },
      plugins: {
        node: require('eslint-plugin-node'),
      },
      rules: {
        // Desactivar la regla que causa el error
        'node/no-unsupported-features/es-syntax': 'off',
      },
    },
  ];
  
  module.exports = config;
  