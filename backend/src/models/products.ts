import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../config/database';
import Category from './category';
import Size from './size';
import Color from './color';

// ------------------
// Attributes chính của Product
// ------------------
interface ProductAttributes {
  id: number;
  product_name: string;
  image: string[];
  category_id: number;
  size_id: number;
  color_id: number;
  material: string;
  available: number;
  defective: number;
  cost_price: number;
  selling_price: number;
  discount: number;
  date: Date;
  total_item: number;
  note?: string;
}

// ------------------
// Optional khi tạo mới
// ------------------
interface ProductCreationAttributes extends Optional<ProductAttributes, 'id'> {}

// ------------------
// Associations để TS nhận biết
// ------------------
interface ProductAssociations {
  category?: Category;
  size?: Size;
  color?: Color;
}

// ------------------
// Model chính
// ------------------
class Product
  extends Model<ProductAttributes, ProductCreationAttributes>
  implements ProductAttributes, ProductAssociations
{
  // Attributes
  public id!: number;
  public product_name!: string;
  public image!: string[];
  public category_id!: number;
  public size_id!: number;
  public color_id!: number;
  public material!: string;
  public available!: number;
  public defective!: number;
  public cost_price!: number;
  public selling_price!: number;
  public discount!: number;
  public date!: Date;
  public total_item!: number;
  public note?: string;

  // Associations
  public category?: Category;
  public size?: Size;
  public color?: Color;
}

// ------------------
// Sequelize init
// ------------------
Product.init(
  {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    product_name: { type: DataTypes.STRING, allowNull: false },
    image: { type: DataTypes.ARRAY(DataTypes.TEXT), allowNull: true },
    category_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: { model: Category, key: 'id' },
    },
    size_id: { type: DataTypes.INTEGER, allowNull: false, references: { model: Size, key: 'id' } },
    color_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: { model: Color, key: 'id' },
    },
    material: { type: DataTypes.STRING, allowNull: true },
    available: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    defective: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    cost_price: { type: DataTypes.FLOAT, allowNull: false },
    selling_price: { type: DataTypes.FLOAT, allowNull: false },
    discount: { type: DataTypes.FLOAT, allowNull: true, defaultValue: 0 },
    date: { type: DataTypes.DATE, allowNull: true },
    total_item: { type: DataTypes.INTEGER, allowNull: true },
    note: { type: DataTypes.TEXT, allowNull: true },
  },
  {
    sequelize,
    modelName: 'Product',
    tableName: 'products',
    schema: 'public',
    timestamps: false,
  },
);

// ------------------
// Associations
// ------------------
Product.belongsTo(Category, { foreignKey: 'category_id', as: 'category' });
Product.belongsTo(Size, { foreignKey: 'size_id', as: 'size' });
Product.belongsTo(Color, { foreignKey: 'color_id', as: 'color' });

export default Product;
