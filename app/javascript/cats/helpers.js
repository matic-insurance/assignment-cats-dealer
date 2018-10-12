import { route } from 'preact-router';

export function getThings(url) {
  return fetch(url)
    .then(response => response.json())
    .catch(error => console.error(error));
}

export function generateUrlParams(url, params = {}) {
  const esc = encodeURIComponent;
  const generatedParams = Object.keys(params)
    .map(k => `${esc(k)}=${esc(params[k])}`)
    .join('&');
  return (generatedParams.length > 0) ? `${url}?${generatedParams}` : url;
}

export function redirectToResult(location, name) {
  route(`/result${location ? `/${location}` : ''}${name ? `/${name}` : ''}`);
}
