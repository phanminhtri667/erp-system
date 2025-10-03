// frontend/src/pages/login/login.tsx
import React, { useState } from 'react';
import AxiosInstance from '../../services/axios';
import { useDispatch } from 'react-redux';
import { setUser } from '../../redux/features/authSlice'; // Import action setUser từ authSlice
import { useNavigate } from 'react-router-dom';
import './login.scss';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const response = await AxiosInstance.post('/api/auth/login', { email, password });
      const { success, message, data } = response.data;
      
      if (success) {
        // Nếu đăng nhập thành công, lưu thông tin vào localStorage và chuyển hướng tới trang dashboard
        localStorage.setItem('user', JSON.stringify(data));
        localStorage.setItem('token', data.token);  // Lưu token nếu cần
        dispatch(setUser(data));  // Lưu user vào Redux
        navigate('/dashboard'); // Chuyển hướng tới dashboard
      } else {
        setErrorMessage(message);
      }
    } catch (error) {
      console.error("Login error:", error);
      setErrorMessage("Đăng nhập thất bại, vui lòng thử lại!");
    }
  };

  return (
    <div className="login-page">
      <h2>Đăng Nhập</h2>
      <form onSubmit={handleLogin}>
        <div className="form-group">
          <input
            type="email"
            placeholder="Enter email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>
        <div className="form-group">
          <input
            type="password"
            placeholder="Enter password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
        </div>
        {errorMessage && <div className="error-message">{errorMessage}</div>}
        <button type="submit">Login</button>
      </form>
    </div>
  );
};

export default Login;
