import { Product } from '../models/products/products';

class ProductService {
  async getAllProducts() {
    return await Product.findAll();
  }

  async createProduct(data: any) {
    return await Product.create(data);
  }

  async getProductById(id: number) {
    return await Product.findByPk(id);
  }

  async updateProduct(id: number, data: any) {
    const product = await Product.findByPk(id);
    if (!product) throw new Error('Product not found');
    return await product.update(data);
  }

  async deleteProduct(id: number) {
    const product = await Product.findByPk(id);
    if (!product) throw new Error('Product not found');
    await product.destroy();
    return true;
  }
}

export default new ProductService();
