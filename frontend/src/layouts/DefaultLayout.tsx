import { Outlet } from "react-router-dom";
import Sidebar from "../components/sidebar/Sidebar";
import Header from "../components/header/Header";
import "./DefaultLayout.scss";
import Footer from "../components/footer/Footer";
import Breadcrumb from "../components/breadcrumb/Breadcrumb";

const DefaultLayout = () => {
  return (
    <div className="layout-container">
      <div className="sidebar">
        <Sidebar />
      </div>
      <div className="header">
        <Header />
      </div>
      <div className="content">
        <div className="breadcrumb">
          <Breadcrumb />
        </div>
        <Outlet />
      </div>
      <div className="footer">
        <Footer />
      </div>
    </div>
  );
};

export default DefaultLayout;
