import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import './productCustomerLayout.scss';  // Đảm bảo rằng bạn tạo tệp SCSS cho style

const ProductCustomerLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className="product-customer-layout">
      <header>
        <div className="logo">
          <h1>ERP System</h1>
        </div>
        <div className="auth">
          <Link to="/login">
            <button className="login-btn">Đăng Nhập</button>
          </Link>
        </div>
      </header>

      <main>
        {children}
      </main>

      <footer>
        <p>© 2025 ERP System. Tất cả các quyền được bảo vệ.</p>
      </footer>
    </div>
  );
};

export default ProductCustomerLayout;
