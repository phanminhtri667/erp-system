import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';
import Category from './category';
import Size from './size';
import Color from './color';
import Material from './material';

interface ProductAttributes {
  product_code: string;
  product_name: string;
  images?: string[];
  category_code?: string;
  size_code?: string;
  color_code?: string;
  material_code?: string;
  available?: number;
  defective?: number;
  cost_price?: number;
  selling_price?: number;
  date?: Date;
  total_item?: number;
  note?: string;
}

interface ProductCreationAttributes
  extends Optional<
    ProductAttributes,
    | 'images'
    | 'available'
    | 'defective'
    | 'cost_price'
    | 'selling_price'
    | 'date'
    | 'total_item'
    | 'note'
  > {}

class Product
  extends Model<ProductAttributes, ProductCreationAttributes>
  implements ProductAttributes
{
  public product_code!: string;
  public product_name!: string;
  public image?: string;
  public category_code?: string;
  public size_code?: string;
  public color_code?: string;
  public material_code?: string;
  public available?: number;
  public defective?: number;
  public cost_price?: number;
  public selling_price?: number;
  public date?: Date;
  public total_item?: number;
  public note?: string;
}

Product.init(
  {
    product_code: {
      type: DataTypes.STRING,
      primaryKey: true,
    },
    product_name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    images: {
      type: DataTypes.ARRAY(DataTypes.TEXT),
      allowNull: true,
    },
    category_code: {
      type: DataTypes.STRING,
      references: {
        model: 'category',
        key: 'category_code',
      },
    },
    size_code: {
      type: DataTypes.STRING,
      references: {
        model: 'size',
        key: 'size_code',
      },
    },
    color_code: {
      type: DataTypes.STRING,
      references: {
        model: 'color',
        key: 'color_code',
      },
    },
    material_code: {
      type: DataTypes.STRING,
      references: {
        model: 'material',
        key: 'material_code',
      },
    },
    available: {
      type: DataTypes.INTEGER,
    },
    defective: {
      type: DataTypes.INTEGER,
    },
    cost_price: {
      type: DataTypes.FLOAT,
    },
    selling_price: {
      type: DataTypes.FLOAT,
    },
    date: {
      type: DataTypes.DATE,
    },
    total_item: {
      type: DataTypes.INTEGER,
    },
    note: {
      type: DataTypes.TEXT,
    },
  },
  {
    sequelize,
    modelName: 'Product',
    tableName: 'product',
    timestamps: false,
  },
);

// 🧩 Associations
Product.belongsTo(Category, { foreignKey: 'category_code', as: 'category' });
Product.belongsTo(Size, { foreignKey: 'size_code', as: 'size' });
Product.belongsTo(Color, { foreignKey: 'color_code', as: 'color' });
Product.belongsTo(Material, { foreignKey: 'material_code', as: 'material' });

export default Product;
