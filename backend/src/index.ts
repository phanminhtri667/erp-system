import express from 'express'
import 'dotenv/config'
import  testRouter from './routers/test'
import employeeRouter from './routers/employeeRouter'; 
import router from './routers/authRouter';
router
const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.use('/api/test',testRouter);
app.use('/api/auth', router);
app.use('/api/employees', employeeRouter);

const port = process.env.PORT || 8888
app.listen(port, () => {
    console.log(`Server is running on the port ${port}`)
})  