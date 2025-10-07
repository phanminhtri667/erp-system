import { Request, Response } from 'express';
import productService from '../services/productService';

class ProductController {
  async getAll(req: Request, res: Response) {
    try {
      const products = await productService.getAllProducts();
      return res.status(200).json({ message: 'Lấy danh sách sản phẩm thành công', data: products });
    } catch (err) {
      return res.status(500).json({ message: 'Lỗi máy chủ', error: err });
    }
  }

  async create(req: Request, res: Response) {
    try {
      const product = await productService.createProduct(req.body);
      return res.status(201).json({ message: 'Tạo sản phẩm thành công', data: product });
    } catch (err) {
      return res.status(500).json({ message: 'Lỗi khi tạo sản phẩm', error: err });
    }
  }

  async getById(req: Request, res: Response) {
    try {
      const product = await productService.getProductById(Number(req.params.id));
      if (!product) return res.status(404).json({ message: 'Không tìm thấy sản phẩm' });
      return res.status(200).json({ data: product });
    } catch (err) {
      return res.status(500).json({ message: 'Lỗi máy chủ', error: err });
    }
  }

  async update(req: Request, res: Response) {
    try {
      const product = await productService.updateProduct(Number(req.params.id), req.body);
      return res.status(200).json({ message: 'Cập nhật sản phẩm thành công', data: product });
    } catch (err) {
      return res.status(500).json({ message: 'Lỗi khi cập nhật sản phẩm', error: err });
    }
  }

  async delete(req: Request, res: Response) {
    try {
      await productService.deleteProduct(Number(req.params.id));
      return res.status(200).json({ message: 'Xoá sản phẩm thành công' });
    } catch (err) {
      return res.status(500).json({ message: 'Lỗi khi xoá sản phẩm', error: err });
    }
  }
}

export default new ProductController();
