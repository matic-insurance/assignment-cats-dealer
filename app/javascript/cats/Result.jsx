import { h, render, Component } from 'preact';

import { getThings, generateUrlParams, redirectToResult } from './helpers';

import Form from './Form';
import Loading from './Loading';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

const CAT_PLACEHOLDER = '/images/placeholder.jpg';

const CatImage = ({ url }) => (url ? (
  <img style={{width: '100%'}} src={url} onError={(e)=>{
    e.target.src = CAT_PLACEHOLDER;
  }} />
) : <img src={CAT_PLACEHOLDER} />);

export default class Result extends Component {
  state = {
    cats: [],
    loading: true,
  }

  constructor(props) {
    super(props);

    this.getCats = this.getCats.bind(this);
  }

  componentDidMount() {
    this.getCats(this.props);
  }

  componentWillReceiveProps(nextProps, nextState) {
    if ((nextProps.location !== this.props.location) || (nextProps.name !== this.props.name)) {
      this.getCats(nextProps);
    }
  }

  getCats({ location, name }) {
    const queryParams = {};

    if (location) {
      queryParams.location = location;
    }

    if (name) {
      queryParams.name = name;
    }

    this.setState({
      loading: true,
    })

    getThings(generateUrlParams('/api/cats', queryParams)).then((data) => {
      this.setState({
        cats: data,
        loading: false,
      });
    }).catch(error => {
      this.props.onError(error);
    });
  }

  render({ location, name }, { cats, loading }) {
    return (
      <div>
        <h1>List of pussycats</h1>
        <Form
          compact
          noReset
          formState={{
            location,
            name,
          }}
          onSubmit={(data) => redirectToResult(data.location, data.name) }
        />
        <Loading active={loading}>
          {(cats.length > 0) ? (
            <div>
              <h2>Best price {(location || name) ?
                `by your${location ? ' location' : ''}${(location && name) ? ' and' : ''}${name ? ' name' : ''} ` : ''}is <b>{cats[0].price}</b></h2>
              <table>
                <thead>
                  <tr>
                    <th style={{width: '20%'}}>image</th>
                    <th>name</th>
                    <th>price</th>
                    <th>location</th>
                  </tr>
                </thead>
                <tbody>
                  {cats.map(cat => (
                    <tr>
                      <td style={{width: '20%'}}>
                        <CatImage url={cat.image} />
                      </td>
                      <td>{cat.name}</td>
                      <td>{cat.price}</td>
                      <td>{cat.location}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : <div>Cats not found</div>}
        </Loading>
      </div>
    )
  }
}
