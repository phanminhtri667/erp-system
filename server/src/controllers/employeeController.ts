import { Request, Response } from "express";
import employeeService from "../services/employeeService";

class EmployeeController {
    /**
     * Xử lý request GET để lấy tất cả nhân viên
     */
    public async getAll(req: Request, res: Response): Promise<Response> {
        try {
            const employees = await employeeService.getAllEmployees();

            return res.status(200).json({
                message: "Lấy danh sách nhân viên thành công!",
                data: employees
            });

        } catch (error) {
            return res.status(500).json({
                message: "Lỗi máy chủ nội bộ",
            });
        }
    }
}

export default new EmployeeController();