// backend/src/routers/authRouter.ts
import { Router } from 'express';
import AuthController from '../controllers/authController';

const router = Router();

router.post('/login', (req, res) => AuthController.login(req, res));
router.post('/register', (req, res) => AuthController.register(req, res));

export default router;
