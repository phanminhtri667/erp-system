import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';

interface ColorAttributes {
  id: number;
  name: string;
}

interface ColorCreationAttributes extends Optional<ColorAttributes, 'id'> {}

class Color extends Model<ColorAttributes, ColorCreationAttributes> implements ColorAttributes {
  public id!: number;
  public name!: string;
}

Color.init(
  {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING, allowNull: false },
  },
  { sequelize, modelName: 'Color', tableName: 'colors', schema: 'public', timestamps: false },
);

export default Color;
