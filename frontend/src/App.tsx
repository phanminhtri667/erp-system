// frontend/src/App.tsx
import './App.scss';
import { BrowserRouter as Router, useRoutes, Navigate } from 'react-router-dom';
import { useSelector } from 'react-redux';
import ProductPage from './pages/product/ProductPage';
import DefaultLayout from './layouts/DefaultLayout';
import Dashboard from './pages/dashboard/dashboard';
import Employee from './pages/employee/employee';
import Emty from './pages/emty/emty';
import OrderPage from './pages/order/order';

const AppRoutes = () => {
  const isAuthenticated = useSelector((state: any) => state.auth.isAuthenticated);

  const routes = useRoutes([
    // ✅ Trang chủ (cho khách hàng hoặc nhân viên chưa login)
    { path: '/', element: <ProductPage /> },

    // ✅ Trang nội bộ sau khi đăng nhập
    {
      path: '/dashboard',
      element: isAuthenticated ? (
        <DefaultLayout>
          <Dashboard />
        </DefaultLayout>
      ) : (
        <Navigate to="/" /> // chưa login thì quay lại trang chủ
      ),
    },
    {
      path: '/employee',
      element: isAuthenticated ? (
        <Employee />
      ) : (
        <Navigate to="/" />
      ),
    },
    {
      path: '/order',
      element: isAuthenticated ? (
        <OrderPage />
      ) : (
        <Navigate to="/" />
      ),
    },

    // ✅ Các trang test tạm thời
    { path: '/test1', element: <Emty /> },

    // ✅ Bất kỳ route nào sai → quay về trang chủ
    { path: '*', element: <Navigate to="/" /> },
  ]);

  return routes;
};

const App = () => {
  return (
    <Router>
      <AppRoutes />
    </Router>
  );
};

export default App;
