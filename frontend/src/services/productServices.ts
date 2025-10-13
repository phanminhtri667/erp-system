import apiUrl from '../constant/apiUrl';
import AxiosInstance from './axios';

export interface ICreateProductPayload {
  product_code: string;
  product_name: string;
  cost_price: number;
  selling_price: number;
  size_code: string;
  color_code: string;
  material: string | null;
  category: string | null;
  images: string[];
}

export const productService = {
  async getAll() {
    try {
      const res = await AxiosInstance.get(apiUrl.product.index);
      return res.data.data || [];
    } catch (err) {
      console.error('Error fetching products:', err);
      return [];
    }
  },

  async createProduct(postData: ICreateProductPayload) {
    try {
      console.log('postData', postData);

      const res = await AxiosInstance.post(apiUrl.product.index, postData);
      return res.data.data;
    } catch (err) {
      console.error('Error fetching products:', err);
      return;
    }
  },
};
