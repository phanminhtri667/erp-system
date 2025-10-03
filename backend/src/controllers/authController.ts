// backend/src/controllers/authController.ts
import { Request, Response } from 'express';
import AuthService from '../services/authService';

class AuthController {
  public async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body;
      const user = await AuthService.login({ email, password });

      res.json({
        success: true,
        message: 'Login successful',
        data: user,
      });
    } catch (error: any) {
      res.status(401).json({
        success: false,
        message: error.message,
      });
    }
  }

    public async register(req: Request, res: Response) {
    try {
        const { full_name, email, phone, password, role_id } = req.body;
        const user = await AuthService.register({ full_name, email, phone, password, role_id });
        res.json({
        success: true,
        message: 'User registered successfully',
        data: user,
        });
    } catch (error: any) {
        console.error('Error during registration:', error);  // Thêm log chi tiết lỗi
        res.status(400).json({
        success: false,
        message: error.message,
        });
    }
    }
}

// export một instance
export default new AuthController();
