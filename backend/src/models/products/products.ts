import { DataTypes, Model, Optional } from "sequelize";
import sequelize from "../../config/database";

interface ProductAttributes {
  id: number;
  supplier_item_code: string;
  our_code: string;
  name: string;
  category: string;
  fiber_spec: object;
  min_price: number;
  images: number[];
  status: boolean;
}

interface ProductCreationAttributes extends Optional<ProductAttributes, "id"> {}

class Product
  extends Model<ProductAttributes, ProductCreationAttributes>
  implements ProductAttributes
{
  public id!: number;
  public supplier_item_code!: string;
  public our_code!: string;
  public name!: string;
  public category!: string;
  public fiber_spec!: object;
  public min_price!: number;
  public images!: number[];
  public status!: boolean;
}

Product.init(
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    supplier_item_code: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    our_code: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    category: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    fiber_spec: {
      type: DataTypes.JSONB,
      allowNull: true,
    },
    min_price: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    images: {
      type: DataTypes.ARRAY(DataTypes.TEXT),
      allowNull: true,
    },
    status: {
      type: DataTypes.BOOLEAN,
      allowNull: false,
      defaultValue: true,
    },
  },
  {
    sequelize,
    modelName: "Product",
    tableName: "products",
    schema: "san_pham",
    timestamps: false,
  }
);

export { Product };
