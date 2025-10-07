import OrderPage from "../pages/order/order";

const apiUrl = {
  employee: {
    index: "api/employees",   // Lấy danh sách nhân viên
  },
  auth: {
    login: "auth/login",
  },
  notification: {
    index: `notification`,
  },
  OrderPage: {
    index: `order`,
  },
  
};

export default apiUrl;
