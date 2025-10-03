import { Router } from 'express';
import employeeController from '../controllers/employeeController';

const router = Router();

// Định nghĩa route: GET /employees -> gọi hàm getAll trong controller
router.get('/', employeeController.getAll);

export default router;