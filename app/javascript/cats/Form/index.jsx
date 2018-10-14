import { h, render, Component } from 'preact';
import classNames from 'classnames';

import { getThings } from '../helpers';
import Loading from '../Loading';
import { compactForm } from './styles.module.scss';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

const initialFormState = {
  name: '',
  location: '',
}

export default class Form extends Component {
  constructor(props) {
    super(props);

    const formState = initialFormState;

    this.state = {
      names: [],
      locations: [],
      loading: true,
      form: {
        ...initialFormState,
        ...props.formState,
      },
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  componentWillReceiveProps(nextProps, nextState) {
    this.setState({
      form: {
        ...nextState.form,
        ...nextProps.formState,
      }
    })
  }

  componentDidMount() {
    Promise.all([
      getThings('/api/names'),
      getThings('/api/locations'),
    ]).then(data => {
      const names = data[0];
      const locations = data[1];

      this.setState({
        names,
        locations,
        loading: false,
      });
    }).catch(error => {
      this.props.onError(error);
    })
  }

  handleSubmit(e) {
    e.preventDefault();

    this.props.onSubmit && this.props.onSubmit(this.state.form);

    if (!this.props.noReset) {
      this.setState({
        form: initialFormState,
      })
    }
  }

  handleChange(e) {
    const newFormValueState = {
      [e.target.name]: e.target.value,
    }

    this.setState(({ form }) => ({
      form: {
        ...form,
        ...newFormValueState,
      }
    }));
  }

  render({ compact } = { compact: false }, { form: { name, location }, loading }) {
    return (
      <Loading active={loading}>
        <form onSubmit={this.handleSubmit} className={classNames({
          [compactForm]: compact,
        })}>
          <select name="name" value={name} onChange={this.handleChange} required>
            <option value="" disabled selected>Select breed name</option>
            {this.state.names.map(name => <option key={name} value={name}>{name}</option>)}
          </select>

          <select name="location" value={location} onChange={this.handleChange} required>
            <option value="" disabled selected>Select your location</option>
            {this.state.locations.map(location => <option key={location} value={location}>{location}</option>)}
          </select>

          <button type="submit">Submit</button>
        </form>
      </Loading>
    );
  }
}
