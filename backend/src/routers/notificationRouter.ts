    // backend/src/routers/notificationRouter.ts
    import express from 'express';
    import { getNotifications } from '../controllers/notificationController';

    const router = express.Router();

    // GET /api/notification
    router.get('/', getNotifications);

    export default router;
