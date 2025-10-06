// backend/src/services/notificationService.ts
import { mockNotifications, Notification } from '../models/notification';

export const getAllNotifications = async (): Promise<Notification[]> => {
  // Giả lập xử lý logic (sau này có thể kết nối DB)
  return mockNotifications;
};
