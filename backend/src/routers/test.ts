import { Router,Request, Response, NextFunction } from 'express';
import GetTestControler from '../controllers/test'
const router = Router();
console.log('test router');

router.get('/',GetTestControler.getTest);
export default router;