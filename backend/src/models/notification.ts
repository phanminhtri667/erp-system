// backend/src/models/notification.ts

export interface Notification {
  id: number;
  message: string;
  created_at: Date;
}

// Dữ liệu mẫu (mock)
export const mockNotifications: Notification[] = [
  { id: 1, message: 'Welcome to ERP System 🎉', created_at: new Date() },
  { id: 2, message: 'New payroll cycle has started.', created_at: new Date() },
  { id: 3, message: '3 employees have submitted new reports.', created_at: new Date() },
];
