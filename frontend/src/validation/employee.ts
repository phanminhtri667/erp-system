// frontend/src/validation/employee.ts

/**
 * Tính tuổi từ chuỗi ngày sinh YYYY-MM-DD
 */
export const getAge = (dateStr: string): number => {
  const d = new Date(dateStr);
  if (Number.isNaN(d.getTime())) return -1;
  const today = new Date();
  let age = today.getFullYear() - d.getFullYear();
  const m = today.getMonth() - d.getMonth();
  if (m < 0 || (m === 0 && today.getDate() < d.getDate())) age--;
  return age;
};

/**
 * Kiểm tra định dạng ngày sinh
 */
export const isValidDate = (value: string): boolean => {
  const date = new Date(value);
  return !Number.isNaN(date.getTime());
};

/**
 * Validation cơ bản cho form nhân viên
 */
export const validateEmployee = (form: Record<string, any>): Record<string, string> => {
  const errors: Record<string, string> = {};

  if (!form.name?.trim()) {
    errors.name = "Employee name is required";
  } else if (form.name.length < 2) {
    errors.name = "Name must be at least 2 characters";
  } else if (!/^[\p{L}\s'.-]+$/u.test(form.name)) {
    errors.name = "Name must only contain letters and spaces";
  }

  if (!form.dob) {
    errors.dob = "Date of birth is required";
  } else if (!isValidDate(form.dob)) {
    errors.dob = "Invalid date format";
  } else if (getAge(form.dob) < 18) {
    errors.dob = "Employee must be at least 18 years old";
  }

  if (!form.phone?.trim()) {
    errors.phone = "Phone number is required";
  } else if (!/^0\d{9}$/.test(form.phone)) {
    errors.phone = "Phone must start with 0 and have 10 digits";
  }

  if (!form.address?.trim()) {
    errors.address = "Address is required";
  }

  if (!form.bank_name?.trim()) {
    errors.bank_name = "Bank name is required";
  }

  if (!form.account_no?.trim()) {
    errors.account_no = "Account number is required";
  }

  return errors;
};
