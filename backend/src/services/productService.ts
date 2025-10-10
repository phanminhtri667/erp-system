import Product from '../models/product';
import Category from '../models/category';
import Size from '../models/size';
import Color from '../models/color';
import Material from '../models/material';

class ProductService {
  async getAll() {
    return await Product.findAll({
      include: [
        { model: Category, as: 'category', attributes: ['category_code', 'category_name'] },
        { model: Size, as: 'size', attributes: ['size_code', 'size_name'] },
        { model: Color, as: 'color', attributes: ['color_code', 'color_name'] },
        { model: Material, as: 'material', attributes: ['material_code', 'material_name'] },
      ],
    });
  }

  async getByCode(product_code: string) {
    return await Product.findByPk(product_code, {
      include: [
        { model: Category, as: 'category', attributes: ['category_code', 'category_name'] },
        { model: Size, as: 'size', attributes: ['size_code', 'size_name'] },
        { model: Color, as: 'color', attributes: ['color_code', 'color_name'] },
        { model: Material, as: 'material', attributes: ['material_code', 'material_name'] },
      ],
    });
  }

  async create(data: any) {
    return await Product.create(data);
  }

  async update(product_code: string, data: any) {
    const product = await Product.findByPk(product_code);
    if (!product) throw new Error('Product not found');
    return await product.update(data);
  }

  async delete(product_code: string) {
    const product = await Product.findByPk(product_code);
    if (!product) throw new Error('Product not found');
    await product.destroy();
    return true;
  }
}

export default new ProductService();
