import Product from '../models/products';
import Category from '../models/category';
import Size from '../models/size';
import Color from '../models/color';

class ProductService {
  async getAll() {
    return await Product.findAll({
      include: [
        { model: Category, as: 'category', attributes: ['id', 'name'] },
        { model: Size, as: 'size', attributes: ['id', 'name'] },
        { model: Color, as: 'color', attributes: ['id', 'name'] },
      ],
    });
  }

  async getById(id: number) {
    return await Product.findByPk(id, {
      include: [
        { model: Category, as: 'category', attributes: ['id', 'name'] },
        { model: Size, as: 'size', attributes: ['id', 'name'] },
        { model: Color, as: 'color', attributes: ['id', 'name'] },
      ],
    });
  }

  async create(data: any) {
    return await Product.create(data);
  }

  async update(id: number, data: any) {
    const product = await Product.findByPk(id);
    if (!product) throw new Error('Product not found');
    return await product.update(data);
  }

  async delete(id: number) {
    const product = await Product.findByPk(id);
    if (!product) throw new Error('Product not found');
    await product.destroy();
    return true;
  }
}

export default new ProductService();
