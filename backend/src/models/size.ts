import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';

interface SizeAttributes {
  id: number;
  name: string;
}

interface SizeCreationAttributes extends Optional<SizeAttributes, 'id'> {}

class Size extends Model<SizeAttributes, SizeCreationAttributes> implements SizeAttributes {
  public id!: number;
  public name!: string;
}

Size.init(
  {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING, allowNull: false },
  },
  { sequelize, modelName: 'Size', tableName: 'sizes', schema: 'public', timestamps: false },
);

export default Size;
