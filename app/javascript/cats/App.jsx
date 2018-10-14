import { h, render, Component } from 'preact';
import { Router } from 'preact-router';

import ErrorHandler from './ErrorHandler';
import WelcomeForm from './WelcomeForm';
import Result from './Result';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

export default class App extends Component {
  render() {
    return (
      <ErrorHandler>
        {({ onError }) => (
          <div style={{ margin: '0 auto', maxWidth: 1000 }}>
            <Router>
              <WelcomeForm path="/" onError={onError} />
              <Result path="/result/:location?/:name?" onError={onError} />
            </Router>
          </div>
        )}
      </ErrorHandler>
    );
  }
}
