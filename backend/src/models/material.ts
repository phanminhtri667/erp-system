import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

interface MaterialAttributes {
  material_code: string;
  material_name: string;
  description?: string;
}

interface MaterialCreationAttributes extends MaterialAttributes {}

class Material
  extends Model<MaterialAttributes, MaterialCreationAttributes>
  implements MaterialAttributes
{
  public material_code!: string;
  public material_name!: string;
  public description?: string;
}

Material.init(
  {
    material_code: {
      type: DataTypes.STRING(10),
      primaryKey: true,
    },
    material_name: {
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
    modelName: 'Material',
    tableName: 'material',
    schema: 'public',
    timestamps: false,
  },
);

export default Material;
