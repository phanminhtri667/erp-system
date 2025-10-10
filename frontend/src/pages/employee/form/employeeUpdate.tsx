import { useState, useEffect, useRef } from 'react';
import { Toast } from 'primereact/toast';
import InputField from '../../../components/forms/input/InputField';
import Button from '../../../components/forms/button/Button';
import AxiosInstance from '../../../services/axios';
import apiUrl from '../../../constant/apiUrl';

const EmployeeUpdate = ({ data, closeModal, getEmployee }: any) => {
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
        ...form,
        bank_info: {
          bank_name: form.bank_name,
          account_no: form.account_no,
        },
      };
      await AxiosInstance.put(`${apiUrl.employee.index}/${form.id}`, payload);
      toast.current?.show({
        severity: 'success',
        summary: 'Success',
        detail: 'Employee updated successfully',
        life: 1500,
      });
      getEmployee?.();
      closeModal();
    } catch {
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
      <div className="form-item">
        <InputField
          name="name"
          placeholder="Full name"
          value={form.name || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          type="date"
          name="dob"
          placeholder="Date of birth"
          value={form.dob || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          name="phone"
          placeholder="Phone"
          value={form.phone || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          name="address"
          placeholder="Address"
          value={form.address || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          name="tax_no"
          placeholder="Tax number"
          value={form.tax_no || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          name="bank_name"
          placeholder="Bank name"
          value={form.bank_info?.bank_name || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-item">
        <InputField
          name="account_no"
          placeholder="Account number"
          value={form.bank_info?.account_no || ''}
          onChange={handleChange}
        />
      </div>
      <div className="form-footer float-right">
        <Button label="Submit" onClick={handleSubmit} />
        <Button label="Cancel" className="ml-2" action="cancel" onClick={closeModal} />
      </div>
    </div>
  );
};

export default EmployeeUpdate;
