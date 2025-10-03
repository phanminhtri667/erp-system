// src/layouts/productCustomerLayout.tsx
import React from 'react';
import Header from '../components/header/Header';
import Footer from '../components/footer/Footer';
import './productCustomerLayout.scss';  // Sử dụng SCSS cho sản phẩm khách hàng

const ProductCustomerLayout = ({ children }: { children: React.ReactNode }) => {
  return (
    <div className="product-customer-layout">
      <Header />
      
      {/* Nếu có Sidebar, bạn có thể dùng hoặc loại bỏ tùy theo yêu cầu */}
      <div className="layout-container">
        
        
        <main className="content">
          {children}
        </main>
      </div>

      <Footer />
    </div>
  );
};

export default ProductCustomerLayout;
