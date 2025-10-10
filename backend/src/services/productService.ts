import Product from '../models/product';
import Category from '../models/category';
import Size from '../models/size';
import Color from '../models/color';
import Material from '../models/material';

class ProductService {
  async getAll() {
    const products = await Product.findAll({
      include: [
        { model: Category, as: 'category', attributes: ['category_name'] },
        { model: Size, as: 'size', attributes: ['size_name'] },
        { model: Color, as: 'color', attributes: ['color_name'] },
        { model: Material, as: 'material', attributes: ['material_name'] },
      ],
    });

    return products.map((p: any) => ({
      product_code: p.product_code,
      product_name: p.product_name,
      images: p.images || [],
      category: p.category?.category_name || '',
      size: p.size?.size_name || '',
      color: p.color?.color_name || '',
      material: p.material?.material_name || '',
      available: p.available ?? 0,
      defective: p.defective ?? 0,
      cost_price: p.cost_price ?? 0,
      selling_price: p.selling_price ?? 0,
      date: p.date ?? null,
      total_item: p.total_item ?? 0,
      note: p.note || '',
    }));
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
