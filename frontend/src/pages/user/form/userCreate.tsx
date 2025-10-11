import { useState, useRef } from 'react';
import { Toast } from 'primereact/toast';
import InputField from '../../../components/forms/input/InputField';
import Button from '../../../components/forms/button/Button';
import AxiosInstance from '../../../services/axios';
import apiUrl from '../../../constant/apiUrl';
import { createUser } from '../../../services/userService';

// ✅ Kiểu dữ liệu form
interface UserForm {
  user_name: string;
  user_phone: string;
  user_email: string;
  role_code: string;
  password: string;
}

// ✅ Biến khởi tạo ban đầu cho form
const initialForm: UserForm = {
  user_name: '',
  user_phone: '',
  user_email: '',
  role_code: '',
  password: '',
};

const UserCreate = ({ onSuccess }: { onSuccess?: () => void }) => {
  const toast = useRef<Toast | null>(null);
  const [form, setForm] = useState<UserForm>(initialForm);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async () => {
    try {
      const payload = {
        user_name: form.user_name,
        user_phone: form.user_phone,
        user_email: form.user_email,
        role_code: form.role_code,
        password: form.password,
      };

      await createUser(payload);

      toast.current?.show({
        severity: 'success',
        summary: 'Success',
        detail: 'Employee created successfully',
        life: 1500,
      });

      setForm(initialForm);
      onSuccess?.();
    } catch {
      toast.current?.show({
        severity: 'error',
        summary: 'Error',
        detail: 'Failed to create employee',
        life: 1500,
      });
    }
  };

  return (
    <div className="form">
      <Toast ref={toast} />

      {/* Full name */}
      <div className="form-item">
        <InputField
          name="user_name"
          placeholder="Full name"
          value={form.user_name}
          onChange={handleChange}
        />
      </div>

      {/* Phone */}
      <div className="form-item">
        <InputField
          name="user_phone"
          placeholder="Phone"
          value={form.user_phone}
          onChange={handleChange}
        />
      </div>

      {/* Email */}
      <div className="form-item">
        <InputField
          type="email"
          name="user_email"
          placeholder="Email"
          value={form.user_email}
          onChange={handleChange}
        />
      </div>

      {/* Role code */}
      <div className="form-item">
        <InputField
          name="role_code"
          placeholder="Role code (e.g., role_1)"
          value={form.role_code}
          onChange={handleChange}
        />
      </div>

      {/* Password */}
      <div className="form-item">
        <InputField
          type="password"
          name="password"
          placeholder="Password"
          value={form.password}
          onChange={handleChange}
        />
      </div>

      {/* Buttons */}
      <div className="form-footer">
        <Button label="Submit" onClick={handleSubmit} />
        <Button
          label="Cancel"
          className="ml-2"
          action="cancel"
          onClick={() => setForm(initialForm)}
        />
      </div>
    </div>
  );
};

export default UserCreate;
