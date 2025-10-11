// backend/src/controllers/authController.ts
import { Request, Response } from 'express';
import AuthService from '../services/authService';

class AuthController {
  public async login(req: Request, res: Response) {
    try {
      const { user_email, password } = req.body;
      const user = await AuthService.login({ user_email, password });

      res.json({
        success: true,
        message: 'Login successful',
        data: user,
      });
    } catch (error: any) {
      res.status(401).json({
        success: false,
        message: error.message || 'Đăng nhập thất bại',
      });
    }
  }

  public async register(req: Request, res: Response) {
    try {
      const { user_name, user_email, user_phone, password, role_code } = req.body;
      const user = await AuthService.register({
        user_name,
        user_email,
        user_phone,
        password,
        role_code,
      });

      res.status(201).json({
        success: true,
        message: 'User registered successfully',
        data: user,
      });
    } catch (error: any) {
      console.error('Error during registration:', error); // Thêm log chi tiết lỗi
      res.status(400).json({
        success: false,
        message: error.message,
      });
    }
  }
}

// export một instance
export default new AuthController();
