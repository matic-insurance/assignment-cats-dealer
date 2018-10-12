import { h, render, Component } from 'preact';
import { Router } from 'preact-router';

import WelcomeForm from './WelcomeForm';
import Result from './Result';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

export default class App extends Component {
  render() {
    return (
      <div style={{ margin: '0 auto', maxWidth: 1000 }}>
        <Router>
          <WelcomeForm path="/" />
          <Result path="/result/:location?/:name?" />
        </Router>
      </div>
    );
  }
}
