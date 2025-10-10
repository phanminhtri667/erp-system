import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';

interface SizeAttributes {
  size_code: string;
  size_name: string;
  description?: string;
}

interface SizeCreationAttributes extends Optional<SizeAttributes, 'description'> {}

class Size extends Model<SizeAttributes, SizeCreationAttributes> implements SizeAttributes {
  public size_code!: string;
  public size_name!: string;
  public description?: string;
}

Size.init(
  {
    size_code: {
      type: DataTypes.STRING(20),
      primaryKey: true,
    },
    size_name: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: 'Size',
    tableName: 'size',
    schema: 'public',
    timestamps: false,
  },
);

export default Size;
