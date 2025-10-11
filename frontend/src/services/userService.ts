// src/services/userService.ts
import AxiosInstance from './axios';
import apiUrl from '../constant/apiUrl';

export interface User {
  user_code: string;
  user_name: string;
  user_phone?: string;
  user_email?: string;
  role_code?: string;
  password?: string;
  deleted?: boolean;
  created_at?: string;
  updated_at?: string;
}

export const getAllUsers = async (): Promise<User[]> => {
  const res = await AxiosInstance.get(`${apiUrl.user.index}`);
  return res.data.data || [];
};

export const getUserByCode = async (user_code: string): Promise<User> => {
  const res = await AxiosInstance.get(`${apiUrl.user.index}/${user_code}`);
  return res.data.data;
};

export const createUser = async (payload: Partial<User>): Promise<User> => {
  const res = await AxiosInstance.post(`${apiUrl.user.index}`, payload);
  return res.data.data;
};

export const updateUser = async (user_code: string, payload: Partial<User>): Promise<User> => {
  const res = await AxiosInstance.put(`${apiUrl.user.index}/${user_code}`, payload);
  return res.data.data;
};

export const deleteUser = async (user_code: string): Promise<{ message: string }> => {
  const res = await AxiosInstance.delete(`${apiUrl.user.index}/${user_code}`);
  return res.data;
};
