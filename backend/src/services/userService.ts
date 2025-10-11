import User from '../models/user';

class UserService {
  public async getAllUser(): Promise<User[]> {
    try {
      const users = await User.findAll(); 
      return users;
    } catch (error) {
      console.error('Lỗi khi truy vấn nhân viên:', error);
      throw error;
    }
  }
}

export default new UserService();
