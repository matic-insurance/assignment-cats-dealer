import { route } from 'preact-router';

import { redirectToResult, generateUrlParams } from '../helpers';

jest.mock('preact-router');

describe('redirectToResult()', () => {
  it('calls route with correct url when args is absent', () => {
    redirectToResult();
    expect(route).toBeCalledWith('/result/');
  });

  it('calls route with correct url when args are exists', () => {
    redirectToResult('Lviv', 'name 1');
    expect(route).toBeCalledWith('/result/Lviv/name 1');
  });

  it('calls route with correct url when args are exists, but first argument is null', () => {
    redirectToResult(null, 'name 1');
    expect(route).toBeCalledWith('/result//name 1');
  });

  it('calls route with correct url when only first argument is defined', () => {
    redirectToResult('Lviv');
    expect(route).toBeCalledWith('/result/Lviv');
  });
});

describe('generateUrlParams()', () => {
  it('returns correct url with params', () => {
    expect(generateUrlParams('https://google.com', { param1: 'test', param2: 'test2' })).toEqual('https://google.com?param1=test&param2=test2');

    expect(generateUrlParams('https://google.com', { param1: 'test' })).toEqual('https://google.com?param1=test');

    expect(generateUrlParams('https://google.com', { param1: null })).toEqual('https://google.com?param1=null');

    expect(generateUrlParams('https://google.com', { param1: undefined })).toEqual('https://google.com?param1=undefined');

    expect(generateUrlParams('https://google.com')).toEqual('https://google.com');
  });
});
