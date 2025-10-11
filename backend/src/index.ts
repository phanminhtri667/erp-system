import cors from 'cors';
import 'dotenv/config';
import express from 'express';
import router from './routers/authRouter';
import notificationRouter from './routers/notificationRouter';
import productRouter from './routers/productRouter';
import userRouter from './routers/userRouter';

const app = express();
app.use(
  cors({
    origin: 'http://localhost:3000',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
  }),
);

app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));

app.use('/api/auth', router);
app.use('/api/user', userRouter);
app.use('/api/notification', notificationRouter);
app.use('/api/products', productRouter);

const port = process.env.PORT || 8888;
app.listen(port, () => {
  console.log(`Server is running on the port ${port}`);
});
