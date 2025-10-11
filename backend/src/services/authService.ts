// backend/src/services/authService.ts
import bcrypt from 'bcrypt';
import User from '../models/user';

interface LoginPayload {
  user_email: string;
  password: string;
}
interface RegisterPayload {
  user_name: string;
  user_email: string;
  user_phone: string;
  password: string;
  role_code: string;
}

class AuthService {
  public async login({ user_email, password }: LoginPayload) {
    const user = await User.findOne({ where: { user_email } });

    if (!user) {
      throw new Error('User not found');
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      throw new Error('Invalid password');
    }

    return {
      user_code: user.user_code,
      user_name: user.user_name,
      user_email: user.user_email,
      user_phone: user.user_phone,
      role_code: user.role_code,
    };
  }

  public async register(payload: RegisterPayload) {
    const { user_name, user_email, user_phone, password, role_code } = payload;

    const existingUser = await User.findOne({ where: { user_name } });
    if (existingUser) {
      throw new Error('Email already exists');
    }

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    console.log('Hashed password:', hashedPassword);

    
    const lastUser = await User.findOne({
      order: [['user_code', 'DESC']],
    });
    let newUserCode = 'U001';
    if (lastUser && lastUser.user_code) {
      const currentNum = parseInt(lastUser.user_code.replace('U', ''), 10);
      const nextNum = currentNum + 1;
      newUserCode = `U${String(nextNum).padStart(3, '0')}`;
    }

    const newUser = await User.create({
      user_code: newUserCode,
      user_name,
      user_email,
      user_phone,
      role_code,
      password: hashedPassword, 
      deleted: false,
    });

 
    return {
      user_code: newUser.user_code,
      user_name: newUser.user_name,
      user_email: newUser.user_email,
      user_phone: newUser.user_phone,
      role_code: newUser.role_code,
    };
  }
}

export default new AuthService();
