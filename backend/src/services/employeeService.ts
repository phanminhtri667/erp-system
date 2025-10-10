import { Employee } from '../models/employee';

class EmployeeService {
  /**
   * Lấy tất cả nhân viên từ cơ sở dữ liệu
   */
  public async getAllEmployees(): Promise<Employee[]> {
    try {
      const employees = await Employee.findAll(); // Sử dụng Sequelize để lấy tất cả nhân viên
      return employees;
    } catch (error) {
      console.error('Lỗi khi truy vấn nhân viên:', error);
      throw error;
    }
  }
}

export default new EmployeeService();
