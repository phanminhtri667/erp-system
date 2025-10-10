import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

interface ColorAttributes {
  color_code: string;
  color_name: string;
}

interface ColorCreationAttributes extends ColorAttributes {}

class Color extends Model<ColorAttributes, ColorCreationAttributes> implements ColorAttributes {
  public color_code!: string;
  public color_name!: string;
}

Color.init(
  {
    color_code: {
      type: DataTypes.STRING(10),
      primaryKey: true,
    },
    color_name: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
  },
  {
    sequelize,
    modelName: 'Color',
    tableName: 'color',
    schema: 'public',
    timestamps: false,
  },
);

export default Color;
