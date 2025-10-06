// backend/src/controllers/notificationController.ts
import { Request, Response } from 'express';
import { getAllNotifications } from '../services/notificationService';

export const getNotifications = async (req: Request, res: Response) => {
  try {
    const notifications = await getAllNotifications();
    res.status(200).json({
      success: true,
      data: notifications,
    });
  } catch (error) {
    console.error('Error fetching notifications:', error);
    res.status(500).json({
      success: false,
      message: 'Server error while fetching notifications.',
    });
  }
};
