import { useState, useRef } from "react";
import { Toast } from "primereact/toast";
import InputField from "../../../components/forms/input/InputField";
import Button from "../../../components/forms/button/Button";
import AxiosInstance from "../../../services/axios";
import apiUrl from "../../../constant/apiUrl";

// ✅ Kiểu dữ liệu form
interface EmployeeForm {
  name: string;
  dob: string;
  phone: string;
  address: string;
  tax_no: string;
  bank_name: string;
  account_no: string;
  joined_date: string;
  seniority_years: string;
  total_salary_paid: string;
}

// ✅ Biến khởi tạo ban đầu cho form
const initialForm: EmployeeForm = {
  name: "",
  dob: "",
  phone: "",
  address: "",
  tax_no: "",
  bank_name: "",
  account_no: "",
  joined_date: "",
  seniority_years: "",
  total_salary_paid: "",
};

const EmployeeCreate = ({ onSuccess }: { onSuccess?: () => void }) => {
  const toast = useRef<Toast | null>(null);
  const [form, setForm] = useState<EmployeeForm>(initialForm);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
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

      await AxiosInstance.post(apiUrl.employee.index, payload);

      toast.current?.show({
        severity: "success",
        summary: "Success",
        detail: "Employee created successfully",
        life: 1500,
      });

      setForm(initialForm); // ✅ Reset form đúng cách
      onSuccess?.(); // ✅ Gọi callback nếu có
    } catch {
      toast.current?.show({
        severity: "error",
        summary: "Error",
        detail: "Failed to create employee",
        life: 1500,
      });
    }
  };

  return (
    <div className="form">
      <Toast ref={toast} />

      <div className="form-item">
        <InputField name="name" placeholder="Full name" value={form.name} onChange={handleChange} />
      </div>

      <div className="form-item">
        <InputField
          type="date"
          name="dob"
          placeholder="Date of birth"
          value={form.dob}
          onChange={handleChange}
        />
      </div>

      <div className="form-item">
        <InputField name="phone" placeholder="Phone" value={form.phone} onChange={handleChange} />
      </div>

      <div className="form-item">
        <InputField name="address" placeholder="Address" value={form.address} onChange={handleChange} />
      </div>

      <div className="form-item">
        <InputField name="tax_no" placeholder="Tax number" value={form.tax_no} onChange={handleChange} />
      </div>

      <div className="form-item">
        <InputField
          name="bank_name"
          placeholder="Bank name"
          value={form.bank_name}
          onChange={handleChange}
        />
      </div>

      <div className="form-item">
        <InputField
          name="account_no"
          placeholder="Account number"
          value={form.account_no}
          onChange={handleChange}
        />
      </div>

      <div className="form-item">
        <InputField
          type="date"
          name="joined_date"
          placeholder="Joined date"
          value={form.joined_date}
          onChange={handleChange}
        />
      </div>

      <div className="form-item">
        <InputField
          name="seniority_years"
          placeholder="Seniority (years)"
          value={form.seniority_years}
          onChange={handleChange}
        />
      </div>

      <div className="form-item">
        <InputField
          name="total_salary_paid"
          placeholder="Total salary paid"
          value={form.total_salary_paid}
          onChange={handleChange}
        />
      </div>

      <div className="form-footer">
        <Button label="Submit" onClick={handleSubmit} />
        <Button
          label="Cancel"
          className="ml-2"
          action="cancel"
          onClick={() => setForm(initialForm)} // ✅ Đúng cú pháp TypeScript
        />
      </div>
    </div>
  );
};

export default EmployeeCreate;
