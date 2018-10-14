import { h, render, Component } from 'preact';

// Tell Babel to transform JSX into h() calls:
/** @jsx h */

const Loading = ({ active, children }) => active ? (
  <div style={{ position: 'relative', minHeight: 200 }}>
    <div className="spinner">
      <div className="spinner-unit-1" />
      <div className="spinner-unit-2" />
      <div className="spinner-unit-3" />
    </div>
  </div>
) : <div>{children}</div>;

export default Loading;
