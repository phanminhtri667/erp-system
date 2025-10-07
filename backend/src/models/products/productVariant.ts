import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../../config/database';
import { Product } from './products';

interface ProductVariantAttributes {
  id: number;
  product_id: number;
  sku: string;
  size: string;
  color: string;
  barcode?: string;
}

interface ProductVariantCreationAttributes extends Optional<ProductVariantAttributes, 'id'> {}

class ProductVariant extends Model<ProductVariantAttributes, ProductVariantCreationAttributes>
  implements ProductVariantAttributes {
  public id!: number;
  public product_id!: number;
  public sku!: string;
  public size!: string;
  public color!: string;
  public barcode?: string;
}

ProductVariant.init(
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    product_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: Product,
        key: 'id',
      },
      onDelete: 'CASCADE',
    },
    sku: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    size: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    color: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    barcode: {
      type: DataTypes.STRING,
      allowNull: true,
    },
  },
  {
    sequelize,
    modelName: 'ProductVariant',
    tableName: 'product_variants',
    schema: 'san_pham',
    timestamps: false,
  }
);

export { ProductVariant };
