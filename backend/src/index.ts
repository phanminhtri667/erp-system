import express from 'express'
import 'dotenv/config'
import cors from 'cors';
import  testRouter from './routers/test'
import employeeRouter from './routers/employeeRouter'; 
import router from './routers/authRouter';
import notificationRouter from './routers/notificationRouter';

const app = express()
app.use(cors({
  origin: 'http://localhost:3000',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
}));
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use('/api/test',testRouter);
app.use('/api/auth', router);
app.use('/api/employees', employeeRouter);
app.use('/api/notification', notificationRouter);

const port = process.env.PORT || 8888
app.listen(port, () => {
    console.log(`Server is running on the port ${port}`)
})  