import { route } from 'preact-router';

export function getThings(url) {
  return fetch(url).then(response => new Promise((resolve, reject) => {
    if (response.status >= 200 && response.status < 300) {
      response.json()
        .then(json => resolve(json))
        .catch(error => reject(error));
    } else {
      reject(new Error(`${response.status} ${response.statusText}`));
    }
  }));
}

export function generateUrlParams(url, params = {}) {
  const esc = encodeURIComponent;
  const generatedParams = Object.keys(params)
    .map(k => `${esc(k)}=${esc(params[k])}`)
    .join('&');
  return (generatedParams.length > 0) ? `${url}?${generatedParams}` : url;
}

export function redirectToResult(location, name) {
  route(`/result/${location || ''}${name ? `/${name}` : ''}`);
}
