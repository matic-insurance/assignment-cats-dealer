import { h, render, Component } from 'preact';

import App from './App';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

const rootNode = document.getElementById('root');

rootNode.innerHTML = '';

render((
  <App />
), rootNode);
