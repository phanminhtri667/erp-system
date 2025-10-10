import { Request, Response } from 'express';
import productService from '../services/productService';
import { handleSuccess, handleError, handleNotFound, EActionType } from '../utils/responseHandler';

class ProductController {
  async getAll(req: Request, res: Response) {
    try {
      const products = await productService.getAll();
      return handleSuccess(res, EActionType.Get, products);
    } catch (err) {
      return handleError(res, EActionType.Get, err);
    }
  }

  async getByCode(req: Request, res: Response) {
    try {
      const { product_code } = req.params;
      const product = await productService.getByCode(product_code);

      if (!product) return handleNotFound(res);
      return handleSuccess(res, EActionType.Get, product);
    } catch (err) {
      return handleError(res, EActionType.Get, err);
    }
  }

  async create(req: Request, res: Response) {
    try {
      const product = await productService.create(req.body);
      return handleSuccess(res, EActionType.Create, product);
    } catch (err) {
      return handleError(res, EActionType.Create, err);
    }
  }

  async update(req: Request, res: Response) {
    try {
      const { product_code } = req.params;
      const product = await productService.update(product_code, req.body);

      if (!product) return handleNotFound(res, 'Sản phẩm');
      return handleSuccess(res, EActionType.Update, product);
    } catch (err) {
      return handleError(res, EActionType.Update, err);
    }
  }

  async delete(req: Request, res: Response) {
    try {
      const { product_code } = req.params;
      const deleted = await productService.delete(product_code);

      if (!deleted) return handleNotFound(res, 'Sản phẩm');
      return handleSuccess(res, EActionType.Delete);
    } catch (err) {
      return handleError(res, EActionType.Delete, err);
    }
  }
}

export default new ProductController();
