import { h } from 'preact';

import { shallow, deep } from 'preact-render-spy';
import WelcomeForm from '../index';
import { redirectToResult } from '../../helpers';
import Form from '../../Form';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

jest.mock('../../Form', () => ({ onSubmit }) => {
  onSubmit({ location: 'location', name: 'name' });
  return (<div></div>);
})

jest.mock('../../helpers');

describe("<WelcomeForm />", () => {
  it('executes redirect to /result route with correct params', () => {
    const wrapper = deep(<WelcomeForm />, { depth: 2 });
    expect(redirectToResult).toBeCalledWith('location', 'name');
  });
});
