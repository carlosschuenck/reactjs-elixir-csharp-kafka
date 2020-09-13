import React from 'react';
import 'fontsource-poppins';
import './App.css';
import Routes from './routes'
import { BrowserRouter } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <Routes />
    </BrowserRouter>
  );
}

export default App;
