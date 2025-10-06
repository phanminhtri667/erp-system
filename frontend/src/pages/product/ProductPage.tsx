import React, { useState } from "react";
import "./productPage.scss";
import logo from "../../assets/images/icons8-logo.svg";
import Login from "../login/login";

const ProductPage = () => {
  const [showLogin, setShowLogin] = useState(false);

  const products = [
    {
      id: 1,
      name: "Áo khoác bomber phối túi sọc vải dù",
      price: 670000,
      image_url: "https://tamanh.net/wp-content/uploads/2022/08/vai-len-la-gi.jpg",
    },
    {
      id: 2,
      name: "Áo khoác cổ đứng phối 2 màu, vải dù",
      price: 560000,
      image_url: "https://kenh14cdn.com/2020/7/17/brvn-15950048783381206275371.jpg",
    },
    {
      id: 3,
      name: "Áo khoác cổ đứng phối túi dù, vải nhung",
      price: 540000,
      image_url: "https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg",
    },
    {
      id: 4,
      name: "Áo khoác cổ đứng phối túi hộp, vải ni phối dù",
      price: 580000,
      image_url: "https://vaiphelieu.com/wp-content/uploads/2023/05/vai-len-2.jpeg",
    },
  ];

  return (
    <div className="product-page">
      {/* ===== HEADER ===== */}
      <header className="product-header">
        <div className="header-inner">
          {/* Cột trái: Logo */}
          <div className="logo">
            <img src={logo} alt="ERP Logo" />
          </div>

          {/* Cột giữa: Menu */}
          <nav className="menu">
            <ul>
              <li>Sản phẩm</li>
              <li>Sỉ Len</li>
              <li>Phụ kiện</li>
              <li>Khuyến mãi</li>
            </ul>
          </nav>

          {/* Cột phải: Icon và Login */}
          <div className="header-right">
            <button className="icon-btn">
              <i className="fas fa-search"></i>
            </button>
            <button
              className="login-btn"
              onClick={() => setShowLogin(true)}
            >
              Đăng nhập
            </button>
          </div>
        </div>
      </header>

      {/* ===== MAIN PRODUCT GRID ===== */}
      <main className="product-content">
        {products.map((product) => (
          <div key={product.id} className="product-card">
            <div className="product-image">
              <img src={product.image_url} alt={product.name} />
            </div>
            <div className="product-info">
              <h3>{product.name}</h3>
              <p className="price">{product.price.toLocaleString("vi-VN")}₫</p>
            </div>
          </div>
        ))}
      </main>

      {/* ===== FOOTER ===== */}
      <footer className="footer">
        <p>📞 0987 654 321 | 📍 211B Vườn Lài, Tân Bình, TP.HCM</p>
      </footer>

      {/* ===== LOGIN POPUP ===== */}
      {showLogin && (
        <div className="login-modal">
          <div className="login-overlay" onClick={() => setShowLogin(false)}></div>
          <div className="login-popup">
            <button className="close-btn" onClick={() => setShowLogin(false)}>
              ✕
            </button>
            <Login />
          </div>
        </div>
      )}
    </div>
  );
};

export default ProductPage;
