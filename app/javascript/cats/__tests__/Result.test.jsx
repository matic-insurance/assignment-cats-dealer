import { h } from 'preact';

import { shallow, deep } from 'preact-render-spy';
import Result from '../Result';
import Form from '../Form';
import Loading from '../Loading';
import * as helpers from '../helpers';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

const responseData = [
  {
    name: 'breed 1',
    location: 'Lviv',
    price: 20,
    image: 'https://some-url.com/image1.png',
  },
  {
    name: 'breed 2',
    location: 'Kiev',
    price: 100,
    image: 'https://some-url.com/image2.png',
  }
]

describe('<Result />', () => {
  beforeEach(() => {
    fetch.mockResponseOnce(JSON.stringify(responseData));
  });

  afterEach(() => {
    fetch.resetMocks();
  });

  describe('without location and name props', () => {
    it('renders Form component with compact and noReset props', () => {
      const wrapper = shallow(<Result />);

      expect(wrapper.find(<Form />).attr('compact')).toEqual(true);
      expect(wrapper.find(<Form />).attr('noReset')).toEqual(true);
    });

    it('renders correct "best price" title', (done) => {
      const wrapper = shallow(<Result />);

      setTimeout(() => {
        expect(wrapper.find(<Loading />).childAt(0).children().at(0).text()).toEqual('Best price is 20')
        done();
      }, 0)
    });

    it('renders all pussycats at the table', (done) => {
      const wrapper = shallow(<Result />);

      setTimeout(() => {
        const tableTbody = wrapper.find(<Loading />).childAt(0).find('table').find('tbody');

        expect(tableTbody.children().length).toEqual(2);
        expect(tableTbody.childAt(0).childAt(0).childAt(0).at(0).attr('url')).toEqual(responseData[0].image);
        expect(tableTbody.childAt(0).childAt(1).text()).toEqual(responseData[0].name);
        expect(tableTbody.childAt(0).childAt(2).text()).toEqual(`${responseData[0].price}`);
        expect(tableTbody.childAt(0).childAt(3).text()).toEqual(responseData[0].location);

        expect(tableTbody.childAt(1).childAt(0).childAt(0).at(0).attr('url')).toEqual(responseData[1].image);
        expect(tableTbody.childAt(1).childAt(1).text()).toEqual(responseData[1].name);
        expect(tableTbody.childAt(1).childAt(2).text()).toEqual(`${responseData[1].price}`);
        expect(tableTbody.childAt(1).childAt(3).text()).toEqual(responseData[1].location);

        done();
      }, 0)
    })
  });

  describe('with location and name props', () => {
    it('renders correct "best price" title', (done) => {
      const wrapper = shallow(<Result location="Lviv" name="breed 1" />);

      setTimeout(() => {
        expect(wrapper.find(<Loading />).childAt(0).children().at(0).text()).toEqual('Best price by your location and name is 20')
        done();
      }, 0)
    });

    it('calls generateUrlParams helper function with correct arguments', () => {
      const originalGenerateUrlParams = helpers.generateUrlParams;
      helpers.generateUrlParams = jest.fn(() => '/api/cats');
      const wrapper = shallow(<Result location="Lviv" name="breed 1" />);

      expect(helpers.generateUrlParams).toBeCalledWith('/api/cats', { location: 'Lviv', name: 'breed 1' });

      helpers.generateUrlParams = originalGenerateUrlParams;
    })

    it('calls fetch with correct url', () => {
      const wrapper = shallow(<Result location="Lviv" name="breed 1" />);

      expect(fetch.mock.calls[0][0]).toEqual('/api/cats?location=Lviv&name=breed%201')
    })
  });

  describe('with location prop only', () => {
    it('renders correct "best price" title', (done) => {
      const wrapper = shallow(<Result location="Lviv" />);

      setTimeout(() => {
        expect(wrapper.find(<Loading />).childAt(0).children().at(0).text()).toEqual('Best price by your location is 20')
        done();
      }, 0)
    });

    it('calls generateUrlParams helper function with correct arguments', () => {
      const originalGenerateUrlParams = helpers.generateUrlParams;
      helpers.generateUrlParams = jest.fn(() => '/api/cats');
      const wrapper = shallow(<Result location="Lviv" />);

      expect(helpers.generateUrlParams).toBeCalledWith('/api/cats', { location: 'Lviv' });

      helpers.generateUrlParams = originalGenerateUrlParams;
    })

    it('calls fetch with correct url', () => {
      const wrapper = shallow(<Result location="Lviv" />);

      expect(fetch.mock.calls[0][0]).toEqual('/api/cats?location=Lviv')
    })
  })

  describe('with name prop only', () => {
    it('renders correct "best price" title', (done) => {
      const wrapper = shallow(<Result name="breed 1" />);

      setTimeout(() => {
        expect(wrapper.find(<Loading />).childAt(0).children().at(0).text()).toEqual('Best price by your name is 20')
        done();
      }, 0)
    });

    it('calls generateUrlParams helper function with correct arguments', () => {
      const originalGenerateUrlParams = helpers.generateUrlParams;
      helpers.generateUrlParams = jest.fn(() => '/api/cats');
      const wrapper = shallow(<Result name="breed 1" />);

      expect(helpers.generateUrlParams).toBeCalledWith('/api/cats', { name: 'breed 1' });

      helpers.generateUrlParams = originalGenerateUrlParams;
    })

    it('calls fetch with correct url', (done) => {
      const wrapper = shallow(<Result name="breed 1" />);

      setTimeout(() => {
        expect(fetch.mock.calls[0][0]).toEqual('/api/cats?name=breed%201')
        done();
      }, 0)
    })
  });

  describe('when response data is blank array', () => {
    beforeEach(() => {
      fetch.resetMocks();
      fetch.mockResponseOnce(JSON.stringify([]));
    });

    afterEach(() => {
      fetch.resetMocks();
    });

    it('renders no cats message instead table', (done) => {
      const wrapper = shallow(<Result />);

      setTimeout(() => {
        expect(wrapper.find(<Loading />).childAt(0).text()).toEqual('Cats not found');
        expect(wrapper.find(<Loading />).find(<table />).exists()).toEqual(false);
        done();
      }, 0)
    })
  })
});
