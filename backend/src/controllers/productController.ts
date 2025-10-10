import { Request, Response } from "express";
import productService from "../services/productService";

class ProductController {
  async getAll(req: Request, res: Response) {
    try {
      const products = await productService.getAll();
      const formatted = products.map((p) => ({
        id: p.id,
        product_name: p.product_name,
        image: p.image,
        category: { category_id: p.category_id, name: p.category?.name },
        size: { size_id: p.size_id, name: p.size?.name },
        color: { color_id: p.color_id, name: p.color?.name },
        material: p.material,
        available: p.available,
        defective: p.defective,
        cost_price: p.cost_price,
        selling_price: p.selling_price,
        discount: p.discount,
        date: p.date,
        total_item: p.total_item,
        note: p.note,
      }));
      res.status(200).json(formatted);
    } catch (err) {
      res.status(500).json({ message: "Lỗi máy chủ", error: err });
    }
  }

  async getById(req: Request, res: Response) {
    try {
      const product = await productService.getById(Number(req.params.id));
      if (!product)
        return res.status(404).json({ message: "Không tìm thấy sản phẩm" });
      const formatted = {
        id: product.id,
        product_name: product.product_name,
        image: product.image,
        category: {
          category_id: product.category_id,
          name: product.category?.name,
        },
        size: { size_id: product.size_id, name: product.size?.name },
        color: { color_id: product.color_id, name: product.color?.name },
        material: product.material,
        available: product.available,
        defective: product.defective,
        cost_price: product.cost_price,
        selling_price: product.selling_price,
        discount: product.discount,
        date: product.date,
        total_item: product.total_item,
        note: product.note,
      };
      res.status(200).json(formatted);
    } catch (err) {
      res.status(500).json({ message: "Lỗi máy chủ", error: err });
    }
  }

  async create(req: Request, res: Response) {
    try {
      const product = await productService.create(req.body);
      res
        .status(200)
        .json({ message: "Tạo sản phẩm thành công", data: product });
    } catch (err) {
      res.status(500).json({ message: "Lỗi khi tạo sản phẩm", error: err });
    }
  }

  async update(req: Request, res: Response) {
    try {
      const product = await productService.update(
        Number(req.params.id),
        req.body
      );
      res
        .status(200)
        .json({ message: "Cập nhật sản phẩm thành công", data: product });
    } catch (err) {
      res
        .status(500)
        .json({ message: "Lỗi khi cập nhật sản phẩm", error: err });
    }
  }

  async delete(req: Request, res: Response) {
    try {
      await productService.delete(Number(req.params.id));
      res.status(200).json({ message: "Xoá sản phẩm thành công" });
    } catch (err) {
      res.status(500).json({ message: "Lỗi khi xoá sản phẩm", error: err });
    }
  }
}

export default new ProductController();
