import { DataTypes, Model } from 'sequelize';
import sequelize from '../config/database';

interface CategoryAttributes {
  category_code: string;
  category_name: string;
}

interface CategoryCreationAttributes extends CategoryAttributes {}

class Category
  extends Model<CategoryAttributes, CategoryCreationAttributes>
  implements CategoryAttributes
{
  public category_code!: string;
  public category_name!: string;
}

Category.init(
  {
    category_code: {
      type: DataTypes.STRING(100),
      primaryKey: true,
    },
    category_name: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
  },
  {
    sequelize,
    modelName: 'Category',
    tableName: 'category',
    schema: 'public',
    timestamps: false,
  },
);

export default Category;
