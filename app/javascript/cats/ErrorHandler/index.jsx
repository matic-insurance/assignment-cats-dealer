import { h, Component } from 'preact';

import { errorBlock } from './styles.module.scss';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

export default class ErrorHandler extends Component {
  constructor(props) {
    super(props);

    this.state = {
      errorMessage: null
    }

    this.onError = this.onError.bind(this);
  }

  onError(error) {
    this.setState({
      errorMessage: error.message,
    });
  }

  render({ children }, { errorMessage }) {
    Object.prototype.toString.call(children);
    return (
      <div>
        {errorMessage ? (
          <div className={errorBlock}>{errorMessage}</div>
        ) : null}
        {children[0]({ onError: this.onError })}
      </div>
    )
  }
}
