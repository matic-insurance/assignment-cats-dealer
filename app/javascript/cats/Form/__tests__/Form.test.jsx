import { h } from 'preact';

import { shallow } from 'preact-render-spy';
import Form from '../index';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

describe('<Form />', () => {
  beforeEach(() => {
    fetch.mockResponseOnce(JSON.stringify(['name1', 'name2']));
    fetch.mockResponseOnce(JSON.stringify(['location1', 'location2']));
  });

  afterEach(() => {
    fetch.resetMocks();
  });

  it('renders correct input fields', (done) => {
    const wrapper = shallow(<Form />);

    setTimeout(() => {
      const nameOptions = wrapper.find(<select name="name" />).children();

      expect(nameOptions.at(0).text()).toEqual('Select breed name');
      expect(nameOptions.at(1).text()).toEqual('name1');
      expect(nameOptions.at(2).text()).toEqual('name2');

      const locationOptions = wrapper.find(<select name="location" />).children();

      expect(locationOptions.at(0).text()).toEqual('Select your location');
      expect(locationOptions.at(1).text()).toEqual('location1');
      expect(locationOptions.at(2).text()).toEqual('location2');
      done();
    }, 0)
  });

  it('renders form with correct form initial values', (done) => {
    const wrapper = shallow(<Form />);

    setTimeout(() => {
      expect(wrapper.find(<select name="name" />).attr('value')).toEqual('');
      expect(wrapper.find(<select name="location" />).attr('value')).toEqual('');
      done();
    }, 0);
  });

  it('executes onSubmit function with correct params after submit form', () => {
    const onSubmitMock = jest.fn();

    const wrapper = shallow(<Form onSubmit={onSubmitMock} />);
    wrapper.find(<select name="name" />).simulate('change', ({ target: {
      name: 'name',
      value: 'name1',
    } }));

    wrapper.find(<select name="location" />).simulate('change', ({ target: {
      name: 'location',
      value: 'location2',
    } }));

    wrapper.find('form').simulate('submit', { preventDefault: () => {} });

    expect(onSubmitMock).toBeCalledWith({ location: 'location2', name: 'name1' });
  });

  describe('with formState prop', () => {
    it('renders form depending of formState object', (done) => {
      const wrapper = shallow(<Form formState={{ location: 'location1', name: 'name2' }} />);

      setTimeout(() => {
        expect(wrapper.find(<select name="name" />).attr('value')).toEqual('name2');
        expect(wrapper.find(<select name="location" />).attr('value')).toEqual('location1');
        done();
      }, 0);
    });

    it('renders form depending of formState object but without all props', (done) => {
      const wrapper = shallow(<Form formState={{ name: 'name2' }} />);

      setTimeout(() => {
        expect(wrapper.find(<select name="name" />).attr('value')).toEqual('name2');
        expect(wrapper.find(<select name="location" />).attr('value')).toEqual('');
        done();
      }, 0);
    });
  })

  describe('with compact prop', () => {
    describe('false', () => {
      it('renders form without any css classes', () => {
        const wrapper = shallow(<Form />);

        expect(wrapper.find('form').attr('className')).toEqual('');
      });
    });

    describe('true', () => {
      it('renders form with css classes', () => {
        const wrapper = shallow(<Form compact />);

        expect(wrapper.find('form').attr('className')).toEqual('compactForm');
      });
    });
  });
});
