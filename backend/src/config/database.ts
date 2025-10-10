import { Sequelize } from 'sequelize';
import 'dotenv/config';

// Kết nối đến cơ sở dữ liệu PostgreSQL
const sequelize = new Sequelize({
  dialect: 'postgres',
  host: process.env.DB_HOST,
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  port: parseInt(process.env.DB_PORT || '5432'),
});

export default sequelize;
