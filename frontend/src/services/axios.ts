// frontend/src/services/axios.ts
import axios from 'axios';

const instance = axios.create({
  baseURL: 'http://localhost:8888/api/', // Đặt URL gốc của API backend
  timeout: 10000, // Timeout 10 giây cho mỗi request
  headers: {
    'Content-Type': 'application/json',
  },
});

export default instance;
