import { DataTypes, Model, Optional } from 'sequelize';
import sequelize from '../../config/database';
import { Product } from './products';

interface ProductSupplierMapAttributes {
  id: number;
  product_id: number;
  supplier_id: number;
  default_cost: number;
  currency: string;
  lead_time_days: number;
}

interface ProductSupplierMapCreationAttributes
  extends Optional<ProductSupplierMapAttributes, 'id'> {}

class ProductSupplierMap
  extends Model<ProductSupplierMapAttributes, ProductSupplierMapCreationAttributes>
  implements ProductSupplierMapAttributes
{
  public id!: number;
  public product_id!: number;
  public supplier_id!: number;
  public default_cost!: number;
  public currency!: string;
  public lead_time_days!: number;
}

ProductSupplierMap.init(
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
    },
    supplier_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    default_cost: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    currency: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    lead_time_days: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
  },
  {
    sequelize,
    modelName: 'ProductSupplierMap',
    tableName: 'product_supplier_map',
    schema: 'san_pham',
    timestamps: false,
  },
);

export { ProductSupplierMap };
