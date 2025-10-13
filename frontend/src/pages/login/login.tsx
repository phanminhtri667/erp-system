import React, { ChangeEvent, useState } from 'react';
import AxiosInstance from '../../services/axios';
import { useDispatch } from 'react-redux';
import { setUser } from '../../redux/features/authSlice';
import { useNavigate } from 'react-router-dom';
import './login.scss';
import Button from '../../components/forms/button/Button';
import { Card } from 'primereact/card';
import InputField from '../../components/forms/input/InputField';

const Login = () => {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage('');
    dispatch(setUser({ id: 1, email: 'string', full_name: 'string' }));
    navigate('/dashboard');
    // try {
    //   const response = await AxiosInstance.post('/api/auth/login', { user_email: email, password });
    //   const { success, message, data } = response.data;

    //   if (success) {
    //     localStorage.setItem('user', JSON.stringify(data));
    //     localStorage.setItem('token', data.token);
    //     dispatch(setUser(data));
    //     navigate('/dashboard');
    //   } else {
    //     setErrorMessage(message || 'Đăng nhập thất bại!');
    //   }
    // } catch (error) {
    //   console.error('Login error:', error);
    //   setErrorMessage('Đăng nhập thất bại, vui lòng thử lại!');
    // }
  };

  return (
    <div className="login">
      <Card>
        <div className="login-card">
          <div className="login-content">
            {/* --- Logo --- */}
            <div className="card-logo">
              <img
                src="/static/media/icons8-logo.a946c11612681281646f5888f196edaa.svg"
                alt="Logo"
              />
            </div>

            {/* --- Form --- */}
            <div className="card-form">
              <form className="login-form" onSubmit={handleLogin}>
                <div className="form-item">
                  <div className="form-title">LOGIN TO YOUR ACCOUNT</div>

                  <div className="mb-3">
                    <InputField
                      className="form-input"
                      type="email"
                      name="email"
                      placeholder="Enter email"
                      value={email}
                      onChange={(e: ChangeEvent<HTMLInputElement>) => {
                        setEmail(e.target.value);
                        setErrorMessage('');
                      }}
                      required
                    />
                  </div>

                  <div className="mb-3">
                    <InputField
                      className="form-input"
                      type="password"
                      name="password"
                      placeholder="Enter password"
                      value={password}
                      onChange={(e: ChangeEvent<HTMLInputElement>) => {
                        setPassword(e.target.value);
                        setErrorMessage('');
                      }}
                      required
                    />
                  </div>

                  {errorMessage && <p className="text-error">{errorMessage}</p>}
                </div>

                <div className="form-footer">
                  <Button className="btn-login" type="submit" label="Submit" />
                </div>
              </form>
            </div>
          </div>
        </div>
      </Card>
    </div>
  );
};

export default Login;
