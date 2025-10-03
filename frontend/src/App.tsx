// frontend/src/App.tsx
import './App.scss';
import { Navigate, BrowserRouter as Router, useRoutes } from 'react-router-dom';
import { useEffect } from 'react';
import Emty from './pages/emty/emty';
import Login from './pages/login/login';  // Trang đăng nhập
import ProductCustomerLayout from './layouts/productCustomerLayout';  // Layout cho trang chủ
import DefaultLayout from './layouts/DefaultLayout';  // Layout cho trang sau khi login
import Dashboard from './pages/dashboard/dashboard';
import { useDispatch, useSelector } from 'react-redux';

const AppRoutes = () => {
  const isAuthenticated = useSelector((state: any) => state.auth.isAuthenticated);
 
  const routes = useRoutes(
    [
      { path: "/", element: <ProductCustomerLayout><h2>Chào mừng đến với ERP System</h2></ProductCustomerLayout> },  // Trang chủ
      { path: '/login', element: <Login /> },  // Trang login
      { path: "/dashboard", element: isAuthenticated ? <DefaultLayout><Dashboard /></DefaultLayout> : <Navigate to="/login" /> },
      { path: "/test1", element: <Emty/> },
      { path: "/test2", element: <Emty/> },
      { path: "/test3", element: <Emty/> },
      { path: "/test4", element: <Emty/> },
      { path: "/test5", element: <Emty/> },
      { path: "/test6", element: <Emty/> },
    ]
  )

  return routes;
}


const App = () => {

  return (
    <>
      <Router>
        <AppRoutes/>
      </Router>
    </>
  );
}

export default App;
