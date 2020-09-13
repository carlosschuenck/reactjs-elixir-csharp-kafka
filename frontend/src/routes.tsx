import React, { FunctionComponent, lazy, Suspense } from 'react';
import { Switch, Route } from 'react-router-dom';

const UserList = lazy(() => import('./pages/user/user-list'))
const UserForm = lazy(() => import('./pages/user/user-form'))
 
const Routes: FunctionComponent = () => { 
  return  (
    <Suspense fallback="loading...">
      <Switch>
        <Route path="/" exact component={UserList} />
        <Route path="/usuario" component={UserForm} />
        <Route path="/" component={() => <h1>NOT FOUND</h1>} />
      </Switch>
    </Suspense>
  )
}

export default Routes;