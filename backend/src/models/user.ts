// backend/src/models/user.ts
import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

class User extends Model {
  public user_code!: string;
  public user_name!: string;
  public user_phone!: string;
  public user_email!: string;
  public role_code!: string | null;
  public password!: string;
  public deleted!: boolean;
  public created_at!: Date;
  public updated_at!: Date;
}

User.init(
  {
    user_code: {
      type: DataTypes.STRING(50),
      primaryKey: true,
      allowNull: false,
    },
    user_name: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    user_phone: {
      type: DataTypes.STRING(20),
      allowNull: true,
    },
    user_email: {
      type: DataTypes.STRING(100),
      allowNull: true,
      unique: true,
    },
    role_code: {
      type: DataTypes.STRING(50),
      allowNull: true,
      references: {
        model: 'role',
        key: 'role_code',
      },
      onDelete: 'SET NULL',
    },
    password: {
      type: DataTypes.STRING(255),
      allowNull: false,
    },
    deleted: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    sequelize,
    modelName: 'User',
    tableName: 'users',
    schema: 'public', 
    timestamps: false,
  }
);

export default User;
