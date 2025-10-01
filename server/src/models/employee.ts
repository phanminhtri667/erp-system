import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

// Định nghĩa mô hình Employee
class Employee extends Model {
    public id!: number;
    public name!: string;
    public dob!: Date;
    public phone!: string;
    public address!: string;
    public tax_no!: string;
    public bank_info!: object;
    public joined_date!: Date;
    public seniority_years!: number;
    public cv_file_id!: number;
    public total_salary_paid!: number;
}

Employee.init(
    {
        id: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        name: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        dob: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        phone: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        address: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        tax_no: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        bank_info: {
            type: DataTypes.JSONB, // Lưu thông tin ngân hàng dưới dạng JSON
            allowNull: false,
        },
        joined_date: {
            type: DataTypes.DATE,
            allowNull: false,
        },
        seniority_years: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        cv_file_id: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        total_salary_paid: {
            type: DataTypes.FLOAT,
            allowNull: false,
        },
    },
    {
        sequelize, // Cấu hình kết nối
        modelName: 'Employee',
        tableName: 'employees',
        schema: 'nhan_su', // Chỉ rõ schema nếu cần
        timestamps: false, // Không sử dụng timestamps nếu không có trường created_at/updated_at
    }
);

export { Employee };
