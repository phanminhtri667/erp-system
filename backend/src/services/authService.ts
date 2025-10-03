// backend/src/services/authService.ts
import bcrypt from 'bcrypt';
import User from '../models/user';

interface LoginPayload {
  email: string;
  password: string;
}
interface RegisterPayload {
  full_name: string;
  email: string;
  phone: string;
  password: string;
  role_id: number;
}

class AuthService {
  // login
  public async login({ email, password }: LoginPayload) {
    const user = await User.findOne({ where: { email } });

    if (!user) {
      throw new Error('User not found');
    }

    // So sánh password hash
    const isMatch = await bcrypt.compare(password, user.password_hash);
    if (!isMatch) {
      throw new Error('Invalid password');
    }

    if (!user.status) {
      throw new Error('User is inactive');
    }

    return {
      id: user.id,
      full_name: user.full_name,
      email: user.email,
      role_id: user.role_id,
    };
  }

  // register
  public async register(payload: RegisterPayload) {
    const { full_name, email, phone, password, role_id } = payload;

    // Kiểm tra nếu email đã tồn tại
    const existingUser = await User.findOne({ where: { email } });
    if (existingUser) {
      throw new Error('Email already exists');
    }

    // Hash mật khẩu
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    console.log('Hashed password:', hashedPassword); // Đảm bảo mật khẩu đã được mã hóa

    // Tạo người dùng mới
    const newUser = await User.create({
      full_name,
      email,
      phone,
      role_id,
      status: true,
      password_hash: hashedPassword,
    });

    // Trả về thông tin người dùng mới
    return {
      id: newUser.id,
      full_name: newUser.full_name,
      email: newUser.email,
      role_id: newUser.role_id,
    };
  }
}

// export một instance để dùng
export default new AuthService();
