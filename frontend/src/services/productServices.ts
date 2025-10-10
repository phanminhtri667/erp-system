import apiUrl from '../constant/apiUrl';
import AxiosInstance from './axios';

export interface ICreateProductPayload {
  supplier_item_code: string;
  our_code: string;
  category: string;
  name: string;
  images: Base64URLString[] | null;
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
