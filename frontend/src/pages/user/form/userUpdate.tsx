import { useState, useEffect, useRef } from 'react';
import { Toast } from 'primereact/toast';
import InputField from '../../../components/forms/input/InputField';
import Button from '../../../components/forms/button/Button';
import { updateUser } from '../../../services/userService';

const UserUpdate = ({ data, closeModal, getUser }: any) => {
  const toast = useRef<Toast | null>(null);
  const [form, setForm] = useState<any>(data || {});

  useEffect(() => {
    setForm(data);
  }, [data]);

  const handleChange = (e: any) => {
    setForm({ ...form, [e.target.name]: e.target.value });
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

      await updateUser(form.user_code, payload);

      toast.current?.show({
        severity: 'success',
        summary: 'Success',
        detail: 'User updated successfully',
        life: 1500,
      });

      getUser?.(); // reload lại danh sách user
      closeModal(); // đóng modal
    } catch (err) {
      console.error('Error updating user:', err);
      toast.current?.show({
        severity: 'error',
        summary: 'Error',
        detail: 'Update failed',
        life: 1500,
      });
    }
  };

  if (!form) return null;

  return (
    <div className="form">
      <Toast ref={toast} />

      {/* Full name */}
      <div className="form-item">
        <InputField
          name="user_name"
          placeholder="Full name"
          value={form.user_name || ''}
          onChange={handleChange}
        />
      </div>

      {/* Phone */}
      <div className="form-item">
        <InputField
          name="user_phone"
          placeholder="Phone"
          value={form.user_phone || ''}
          onChange={handleChange}
        />
      </div>

      {/* Email */}
      <div className="form-item">
        <InputField
          type="email"
          name="user_email"
          placeholder="Email"
          value={form.user_email || ''}
          onChange={handleChange}
        />
      </div>

      {/* Role Code */}
      <div className="form-item">
        <InputField
          name="role_code"
          placeholder="Role code"
          value={form.role_code || ''}
          onChange={handleChange}
        />
      </div>

      {/* Password (optional) */}
      <div className="form-item">
        <InputField
          type="password"
          name="password"
          placeholder="New password (leave blank if unchanged)"
          value={form.password || ''}
          onChange={handleChange}
        />
      </div>

      {/* Buttons */}
      <div className="form-footer float-right">
        <Button label="Submit" onClick={handleSubmit} />
        <Button label="Cancel" className="ml-2" action="cancel" onClick={closeModal} />
      </div>
    </div>
  );
};

export default UserUpdate;
