import { Request, Response } from 'express';
import UserService from '../services/userService';

class UserController {
  public async getAll(req: Request, res: Response): Promise<Response> {
    try {
      const users = await UserService.getAllUser();

      return res.status(200).json({
        message: 'Lấy danh sách nhân viên thành công!',
        data: users,
      });
    } catch (error) {
      return res.status(500).json({
        message: 'Lỗi máy chủ nội bộ',
      });
    }
  }
}

export default new UserController();
