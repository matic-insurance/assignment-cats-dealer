import { h, render, Component } from 'preact';

import Form from '../Form';
import { redirectToResult } from '../helpers';
import { catImage, mainTitle } from './styles.module.scss';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

export default class WelcomeForm extends Component {
  render({ onError }) {
    return (
      <div>
        <img className={catImage} src="images/cat-logo.png" />
        <h1 className={mainTitle}>Please choose expected breed and location</h1>
        <Form onSubmit={(data) => redirectToResult(data.location, data.name)} onError={onError} />
      </div>
    );
  }
}
