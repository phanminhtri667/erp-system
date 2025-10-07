import AxiosInstance from './axios';
import apiUrl from '../constant/apiUrl';

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
};