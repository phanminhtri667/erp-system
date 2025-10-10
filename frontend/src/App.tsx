import './App.scss';
import { BrowserRouter as Router, useRoutes, Navigate } from 'react-router-dom';
import { useSelector } from 'react-redux';
import LandingPage from './pages/landing/landingPage';
import DefaultLayout from './layouts/DefaultLayout';
import Dashboard from './pages/dashboard/dashboard';
import Employee from './pages/employee/employee';
import Order from './pages/order/order';
import Product from './pages/product/product';

const AppRoutes = () => {
  const isAuthenticated = useSelector((state: any) => state.auth.isAuthenticated);

  return useRoutes([
    { path: '/', element: <LandingPage /> },

    //  Private routes
    {
      path: '/',
      element: isAuthenticated ? <DefaultLayout /> : <Navigate to="/" />,
      children: [
        { path: 'dashboard', element: <Dashboard /> },
        { path: 'employee', element: <Employee /> },
        { path: 'order', element: <Order /> },
        { path: 'product', element: <Product /> },
      ],
    },

    //  Fallback
    { path: '*', element: <Navigate to="/" /> },
  ]);
};

export default function App() {
  return (
    <Router>
      <AppRoutes />
    </Router>
  );
}
